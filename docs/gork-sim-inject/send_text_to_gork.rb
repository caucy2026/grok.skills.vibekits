#!/usr/bin/env ruby
# frozen_string_literal: true

# Thin wrapper: orchestrate vibekits.device.ui_action for Grok Bot on a sim machine.
# Does NOT register a new vibekits tool. Calls invoke.rb → simulator.call → ui_action.
#
# Default: dry-run (print planned steps only). Real typeText/enter requires --execute
# AND (for enter) --confirm-send. Never use SendToAgent or ssh+osascript.

require 'json'
require 'optparse'
require 'pathname'

SCRIPT_DIR = Pathname.new(__FILE__).realpath.dirname
DEFAULT_CALIB = SCRIPT_DIR.join('calib.json')
DEFAULT_INVOKE = Pathname.new(Dir.home).join(
  '.codex', 'skills', 'vibekits-remote-simulator', 'scripts', 'invoke.rb'
)

BUNDLE_DEFAULT = 'com.anysphere.sand'
APP_DEFAULT = 'Grok Bot'
ROUTING_DEFAULT = '5298938227'
UI_ACTION = 'vibekits.device.ui_action'
SIM_CALL = 'vibekits.simulator.call'

opts = {
  calib: DEFAULT_CALIB.to_s,
  invoke: DEFAULT_INVOKE.to_s,
  text: nil,
  confirm_send: false,
  execute: false,
  connect: false,
  routing_id: nil,
  x: nil,
  y: nil,
  bundle_id: nil,
  app_name: nil
}

parser = OptionParser.new do |o|
  o.banner = "usage: #{$PROGRAM_NAME} --text TEXT [options]\n" \
             "  Default is dry-run. Pass --execute only after user send authorization."
  o.on('--text TEXT', 'Message body to type') { |v| opts[:text] = v }
  o.on('--calib PATH', "calib.json path (default: #{DEFAULT_CALIB})") { |v| opts[:calib] = v }
  o.on('--invoke PATH', "invoke.rb path (default: skill scripts/invoke.rb)") { |v| opts[:invoke] = v }
  o.on('--routing-id ID', 'Override calib routingId') { |v| opts[:routing_id] = v }
  o.on('--x N', Integer, 'Override calib click x') { |v| opts[:x] = v }
  o.on('--y N', Integer, 'Override calib click y') { |v| opts[:y] = v }
  o.on('--bundle-id ID', 'Override bundleId') { |v| opts[:bundle_id] = v }
  o.on('--app-name NAME', 'Override appName') { |v| opts[:app_name] = v }
  o.on('--confirm-send', 'After typeText, also key=enter') { opts[:confirm_send] = true }
  o.on('--execute', 'Actually call invoke.rb (default: dry-run print only)') { opts[:execute] = true }
  o.on('--connect', 'Before steps, call vibekits.simulator.connect') { opts[:connect] = true }
  o.on('-h', '--help', 'Show help') { puts o; exit 0 }
end
parser.parse!
abort(parser.to_s) if opts[:text].nil? || opts[:text].empty?

unless File.file?(opts[:calib])
  abort("calib.json not found: #{opts[:calib]}")
end
calib = JSON.parse(File.read(opts[:calib]))
abort('calib.json must be a JSON object') unless calib.is_a?(Hash)

routing_id = (opts[:routing_id] || calib['routingId'] || ROUTING_DEFAULT).to_s
bundle_id = (opts[:bundle_id] || calib['bundleId'] || BUNDLE_DEFAULT).to_s
app_name = (opts[:app_name] || calib['appName'] || APP_DEFAULT).to_s
x = opts[:x]
y = opts[:y]
if x.nil? && !calib['x'].nil?
  x = Integer(calib['x'])
end
if y.nil? && !calib['y'].nil?
  y = Integer(calib['y'])
end

if x.nil? || y.nil?
  probe = calib['lastSuccessfulProbe']
  hint = if probe.is_a?(Hash) && probe['x'] && probe['y']
           " lastSuccessfulProbe=#{probe['x']},#{probe['y']} (reference only, not used)."
         else
           ''
         end
  abort("calib x/y missing (须当次标定). Fill calib.json or pass --x/--y.#{hint}")
end

unless File.file?(opts[:invoke])
  abort("invoke.rb not found: #{opts[:invoke]}")
end

def ui_args(action, bundle_id, extra = {})
  { 'action' => action, 'bundleId' => bundle_id }.merge(extra)
end

steps = []
steps << {
  name: 'activate',
  tool: SIM_CALL,
  arguments: {
    'routingId' => routing_id,
    'toolId' => UI_ACTION,
    'arguments' => ui_args('activate', bundle_id, 'appName' => app_name)
  }
}
steps << {
  name: 'click',
  tool: SIM_CALL,
  arguments: {
    'routingId' => routing_id,
    'toolId' => UI_ACTION,
    'arguments' => ui_args('click', bundle_id, 'x' => x, 'y' => y)
  }
}
steps << {
  name: 'typeText',
  tool: SIM_CALL,
  arguments: {
    'routingId' => routing_id,
    'toolId' => UI_ACTION,
    'arguments' => ui_args('typeText', bundle_id, 'value' => opts[:text])
  }
}
if opts[:confirm_send]
  steps << {
    name: 'key_enter',
    tool: SIM_CALL,
    arguments: {
      'routingId' => routing_id,
      'toolId' => UI_ACTION,
      'arguments' => ui_args('key', bundle_id, 'key' => 'enter')
    }
  }
end

pre = []
if opts[:connect]
  pre << {
    name: 'connect',
    tool: 'vibekits.simulator.connect',
    arguments: { 'routingId' => routing_id }
  }
end

mode = opts[:execute] ? 'EXECUTE' : 'DRY-RUN'
puts "mode=#{mode}"
puts "routingId=#{routing_id} bundleId=#{bundle_id} appName=#{app_name} click=(#{x},#{y}) confirm_send=#{opts[:confirm_send]}"
puts "calib=#{opts[:calib]}"
puts "invoke=#{opts[:invoke]}"
puts '--- planned invoke.rb calls ---'

def run_or_print(invoke_path, tool, arguments, execute:)
  json = JSON.generate(arguments)
  cmdline = ['ruby', invoke_path, tool, json]
  puts "ruby #{invoke_path} #{tool} #{json}"
  return { 'dryRun' => true, 'tool' => tool, 'arguments' => arguments } unless execute

  # Real call: stream stdout/stderr; exit non-zero aborts wrapper.
  require 'open3'
  out, err, st = Open3.capture3(*cmdline)
  $stdout.print out
  $stderr.print err unless err.empty?
  abort("invoke.rb failed (exit #{st.exitstatus}) for #{tool}") unless st.success?
  begin
    JSON.parse(out)
  rescue JSON::ParserError
    { 'raw' => out }
  end
end

results = []
(pre + steps).each do |step|
  puts "[#{step[:name]}]"
  results << {
    'step' => step[:name],
    'result' => run_or_print(opts[:invoke], step[:tool], step[:arguments], execute: opts[:execute])
  }
end

summary = {
  'ok' => true,
  'mode' => mode.downcase,
  'routingId' => routing_id,
  'confirm_send' => opts[:confirm_send],
  'steps' => results.map { |r| r['step'] },
  'note' => opts[:execute] ? 'executed via invoke.rb' : 'no network/ui_action performed'
}
puts '--- summary ---'
puts JSON.pretty_generate(summary)
exit 0
