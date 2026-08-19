---
title: Troubleshoot DRS Service Broker certificate and endpoint errors
description: Helps you to diagnose and fix SQL Server Service Broker certificate, endpoint permission, route, and transmission errors that affect Configuration Manager database replication.
ms.manager: dcscontentpm
audience: itpro
ms.date: 07/30/2026
ms.reviewer: umaikhan
ms.subservice: core-infra
ms.service: configuration-manager
ms.topic: troubleshooting
ms.collection: tier3
ms.custom: sap:Configuration Manager Database\Database Replication Links
ai-usage: ai-assisted
---

<!-- markdownlint-disable-next-line MD025 -->
# Troubleshoot DRS Service Broker certificate and endpoint errors

## Summary

Configuration Manager Database Replication Service (DRS) uses SQL Server Service Broker (SSB) routes, services, and a certificate-authenticated TCP endpoint between adjacent hierarchy sites. When the endpoint trust chain breaks—due to a missing certificate mapping, revoked permission, or inaccessible private key—messages accumulate in sys.transmission_queue instead of being delivered, even when the SQL Server instances are otherwise reachable.

This article helps you identify which layer of the SSB authentication model is failing by using read-only queries and built-in diagnostics. It covers the local endpoint, peer certificate mappings, service routes, and transmission queue errors that commonly appear in DRS incidents.

> [!IMPORTANT]
> Use the procedures and queries in this article only for read-only diagnosis. Don't create or drop endpoints, credentials, users, certificates, master keys, routes, or conversations manually. Don't enable the ConfigMgr endpoint credential. Run Replication Link Analyzer (RLA) first and use its supported remediation. Contact Microsoft Support when product-managed SSB objects must be repaired.

## Understand the authentication model

Each site database uses three layers of SSB configuration:

1. **Local endpoint identity** - The SQL Server instance hosts the `ConfigMgrEndpoint` Service Broker endpoint and presents the local `ConfigMgrEndpointCert` certificate.
1. **Peer identity mapping** - For each adjacent site, setup creates `ConfigMgrEndpointLogin<SITECODE>` and `ConfigMgrEndpointUser<SITECODE>`, imports the peer endpoint certificate, and grants the mapped credential `CONNECT` permission on `ConfigMgrEndpoint`.
1. **Service routing** - The site database contains routes for the peer's DRS, DRS-site, and RCM services. Their conventional names include `ConfigMgrDRSRoute_Site<SITECODE>`, `ConfigMgrDRSSiteRoute_Site<SITECODE>`, and `ConfigMgrRCMRoute_Site<SITECODE>`.

The endpoint credential is deliberately disabled for ordinary SQL authentication. Certificate authentication maps the incoming peer to that principal, and the principal's endpoint permission authorizes the connection. Enabling the credential isn't a valid repair.

:::image type="content" source="media/drs-ssb-certificate-errors/ssb-trust-flow.png" alt-text="Flowchart showing a DRS or RCM message using a route, local endpoint, encrypted transport, peer certificate mapping, endpoint permission, and destination queue, with failures retained in the sender transmission queue.":::

## Understand the message path and failure boundary

An outgoing DRS or RCM message follows this path:

1. The site database resolves the destination SSB service through a route.
1. SQL Server opens a TCP connection to the remote `ConfigMgrEndpoint`.
1. The remote endpoint presents its certificate.
1. Each side validates the peer certificate mapping.
1. The incoming peer principal is checked for `CONNECT` permission on the endpoint.
1. SSB delivers the message to the destination service and queue.

If route resolution, endpoint availability, private-key access, peer-certificate mapping, or endpoint permission fails, the message remains in `sys.transmission_queue`. `transmission_status` records the current SQL Server error.

## Run built-in DRS diagnostics

Run the built-in read-only diagnostic in the site database:

```sql
EXEC dbo.spDiagDRS;
```

Its general output includes:

- The local `ConfigMgrEndPointCert` thumbprint.
- DRS queue state and incoming/outgoing message counts.
- Replication link and initialization state.
- Peer SSB certificate, credentials, user, and DRS/DRS-site/RCM route information.

To return only adjacent-site SSB identity and route information, run:

```sql
EXEC dbo.spDiagDRSCertInfo;
```

The procedure reports `Not found` when an expected peer credential, user, certificate, or route isn't present. Compare both sites because each side has its own local endpoint identity and its own imported copy of the peer certificate.

## Inspect the local endpoint

Run this read-only query in `master` on both SQL Server instances:

```sql
USE master;

SELECT
    e.name,
    e.state_desc,
    te.port,
    sbe.connection_auth_desc,
    sbe.encryption_algorithm_desc,
    c.name AS certificate_name,
    c.thumbprint,
    c.expiry_date,
    c.pvt_key_encryption_type_desc
FROM sys.endpoints AS e
LEFT JOIN sys.tcp_endpoints AS te
    ON te.endpoint_id = e.endpoint_id
LEFT JOIN sys.service_broker_endpoints AS sbe
    ON sbe.endpoint_id = e.endpoint_id
LEFT JOIN sys.certificates AS c
    ON c.certificate_id = sbe.certificate_id
WHERE e.name = N'ConfigMgrEndpoint';
```

Confirm that the endpoint exists, is started, has the expected TCP port, and references the local certificate. A certificate row alone doesn't prove that SQL Server can decrypt its private key.

## Inspect peer certificate mappings

Run this read-only query in `master`:

```sql
USE master;

SELECT
    dp.name AS endpoint_user,
    c.name AS peer_certificate,
    c.thumbprint,
    c.start_date,
    c.expiry_date,
    c.pvt_key_encryption_type_desc
FROM sys.database_principals AS dp
LEFT JOIN sys.certificates AS c
    ON c.principal_id = dp.principal_id
WHERE dp.name LIKE N'ConfigMgrEndpointUser%'
ORDER BY dp.name, c.name;
```

Each adjacent site should have a mapped user and peer certificate. Certificate names can include a destination SQL Server hash in current builds, so correlate by owner, thumbprint, and adjacent site rather than assuming only the legacy certificate name.

Inspect the mapped credentials and endpoint permission:

```sql
USE master;

SELECT
    sp.name AS endpoint_login,
    sp.is_disabled,
    e.name AS endpoint_name,
    perm.state_desc,
    perm.permission_name
FROM sys.server_principals AS sp
LEFT JOIN sys.server_permissions AS perm
    ON perm.grantee_principal_id = sp.principal_id
    AND perm.class_desc = N'ENDPOINT'
    AND perm.permission_name = N'CONNECT'
LEFT JOIN sys.endpoints AS e
    ON e.endpoint_id = perm.major_id
WHERE sp.name LIKE N'ConfigMgrEndpointLogin%'
ORDER BY sp.name;
```

`is_disabled = 1` is expected. The important condition is a `GRANT CONNECT` row for `ConfigMgrEndpoint`.

## Inspect routes

Run this read-only query in the Configuration Manager site database:

```sql
SELECT
    name,
    remote_service_name,
    broker_instance,
    address,
    mirror_address,
    lifetime
FROM sys.routes
WHERE name LIKE N'ConfigMgrDRSRoute_Site%'
    OR name LIKE N'ConfigMgrDRSSiteRoute_Site%'
    OR name LIKE N'ConfigMgrRCMRoute_Site%'
ORDER BY name;
```

Confirm that the adjacent site's three service routes resolve to its current SQL Server address and SSB port. In an availability group or after a SQL Server move, use the topology expected by the current Configuration Manager configuration rather than editing routes directly.

## Inspect transmission errors

Run this read-only query in the site database:

```sql
SELECT
    enqueue_time,
    message_type_name,
    to_service_name,
    transmission_status,
    conversation_handle
FROM sys.transmission_queue
ORDER BY enqueue_time;
```

Group repeated statuses to separate one old conversation from a link-wide failure:

```sql
SELECT
    transmission_status,
    COUNT(*) AS queued_messages,
    MIN(enqueue_time) AS oldest_message,
    MAX(enqueue_time) AS newest_message
FROM sys.transmission_queue
GROUP BY transmission_status
ORDER BY oldest_message;
```

An empty status can be transient while SSB retries. A persistent status, growing count, and old enqueue time indicate a transport failure. Don't delete the rows or end the conversations; doing so discards evidence and doesn't repair authentication.

## Interpret common certificate states

The SQL Server error number and wording can vary by SQL Server version, but these states commonly identify a specific endpoint trust boundary in DRS incidents.

### State 88: local private key or master-key access

State 88 commonly indicates that SQL Server can't access the private key needed for endpoint authentication. It can occur after the SQL Server service account changes and the new account can't automatically open the service master key or decrypt the endpoint certificate private key.

Check:

- The local endpoint and certificate association.
- `pvt_key_encryption_type_desc` for the local certificate.
- SQL Server error log entries at the first failed connection.
- Recent SQL Server service-account, restore, migration, or encryption-key changes.

Don't create or replace the database master key, service master key, or endpoint certificate as a self-service repair. These operations can make other encrypted data inaccessible.

### State 84: endpoint connection permission

State 84 commonly indicates that the authenticated peer principal doesn't have `CONNECT` permission on the remote `ConfigMgrEndpoint`, or that the expected endpoint isn't available in its configured state.

Check on the receiving SQL Server:

- `ConfigMgrEndpoint` exists and is started.
- The peer `ConfigMgrEndpointLogin<SITECODE>` exists.
- The credential has `GRANT CONNECT` on `ConfigMgrEndpoint`.
- The imported peer certificate is owned by the corresponding endpoint user.

Don't enable the disabled credential or issue a manual grant. A missing permission can be one symptom of an incomplete certificate exchange or site/SQL topology change that requires product-aware repair.

### State 89: peer certificate mapping

State 89 commonly indicates that the receiving SQL Server can't find or use the certificate that identifies the remote peer.

Check:

- The endpoint user for the adjacent site exists.
- A peer certificate is owned by that user.
- The thumbprint agrees with the certificate currently exported by the peer.
- The object names and certificate dates aren't stale after a SQL Server move, restore, or certificate renewal.
- `spDiagDRSCertInfo` doesn't report `Not found` for the affected site.

Don't export or import certificates or recreate endpoint users manually. Current builds manage certificate names, SQL Server identity hashes, dialog-pool refresh, routes, and availability-group topology together.

## Correlate the direction of failure

SSB authentication is directional. If messages queue at site A for site B:

- Inspect the route and local endpoint at site A.
- Inspect the endpoint state, peer authentication permission, endpoint user, and imported certificate for site A at site B.
- Compare site B's presented local certificate with site A's imported peer certificate.
- Repeat in the reverse direction only if site B also has queued messages for site A.

Normal DRS synchronization and initialization both depend on these paths. For initialization, a broken RCM route can stop control messages before or after package transfer. For the complete initialization sequence, see [Understand Database Replication Service reinitialization internals](drs-reinitialization-internals.md).

## Supported recovery path

1. Run RLA and `spDiagDRS` at both adjacent sites.
1. Preserve `sys.transmission_queue` output and the first matching SQL Server error log entries.
1. Identify the failing direction and state.
1. Compare endpoint, local certificate, peer credential, user, and certificate mapping, permission, and route at the two sites.
1. Verify recent SQL service-account, SQL Server move, restore, availability-group, or certificate-renewal changes.
1. Correct network, DNS, firewall, or SQL service-account configuration when those changes are the root cause.
1. Use RLA-supported repair when offered.
1. Contact Microsoft Support before changing product-managed SSB security or routing objects.
