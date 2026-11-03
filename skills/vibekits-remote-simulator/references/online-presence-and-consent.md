# Online presence and pending-consent diagnosis

When asked whether a device is online, call `vibekits.simulator.peer_presence` with `{"routingId":"<ID>"}` if the current controller exposes it. It does not require granting a new simulation session. Do not add it as a mandatory extra query before every ordinary connection, and do not poll continuously.

Read `status` and `observedAt`: `online` is the observed online reply; `offline` is a valid offline reply; timeout, unavailable registration, malformed reply or transport failure means `unknown`, not offline. A protocol-valid reply is not cryptographic proof of the server's identity.

`queryServer`, `queryNode`, `queryRegion` and `respondingAddress` describe the controller's query route. They do not identify the target's registered/home node, physical location or successful connection route. Keep `targetRegisteredNode`/`targetRegisteredServer` unknown unless an authoritative target/registry observation provides them. An overseas Linux host may be queried through the controller's domestic node; do not infer its A/B/C/D assignment from that query alone.

`authorization: not_checked` means exactly that. Presence does not prove consent, tool access, delivery of a request to the target's UI, or successful simulation. For an actual connection use the ordinary connect/status/catalog workflow and require the verified target identity and `connected: true`.

## A pending request without a visible target record

Record the exact controller/target IDs, request ID/revision, target build/platform, and bounded native consent-ledger state. `consent_pending` alone does not prove a popup appeared. Reconcile an existing request before retrying; do not repeatedly allocate new requests or claim a target is offline because approval is pending.

For Linux, distinguish a graphical desktop from a headless server. Check the build's default consent-host subscription and target-runtime consent reader, not only an explicitly enabled test path. A demonstrated omission in shared desktop policy excluded Linux despite Linux native consent being present in qualified release inputs; source fix9c25a3875 added Linux and a default-path regression. Host registration/probe failure must not erase a separately verified pending ledger (fix62fd50a5c). These are known failure modes, not automatic diagnoses of every Linux target.

Before declaring this fixed on a device, verify that its actual installed build includes the source fix and its qualified Linux native simulator consent adapter. Unit tests or a newer controller do not update the target. Do not replace an existing qualified native backend with an ordinary runner snapshot missing its channel registration. Verify real allow/deny behavior through authorized target management access; do not auto-grant access or bypass OS/security controls.

Current production implementation and focused tests are in `harness_peer_presence.dart`, `harness_peer_presence_test.dart` and `harness_tool_bridge_peer_presence_test.dart`; the maintained CLI is `tool/probe_harness_peer_presence.dart`. Prefer the registered MCP tool. Do not copy incident-specific scripts containing fixed caller IDs/server addresses into a general workflow, install another SDK just to query, or edit a signed application's bundled skills in place.
