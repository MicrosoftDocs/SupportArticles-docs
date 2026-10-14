---
title: SQL Server Service Fails to Start Under a gMSA
description: Resolve error 1069, Event ID 7041, or Event ID 7038 when SQL Server or SQL Server Agent fails to start under a group managed service account (gMSA).
ms.reviewer: prmadhes, jopilov
ms.date: 09/29/2026
ms.custom: sap:Startup, shutdown, restart issues (instance or database)
ai-usage: ai-assisted
---

# Troubleshoot SQL Server service startup failures with gMSAs

_Applies to:_ &nbsp; SQL Server on Windows

## Summary

This article helps you troubleshoot SQL Server and SQL Server Agent service startup failures, such as error 1069, Event ID 7041, and Event ID 7038, when the service runs under a group managed service account (gMSA). It covers managed password retrieval, the `IsManagedAccount` flag, domain connectivity, and failures that occur only during boot.

Before you start, review the prerequisites and run the quick validation checklist in [Troubleshoot SQL Server setup, startup, and authentication failures with gMSAs](sql-server-setup-startup-authentication-issues-with-gmsas.md).

## Symptoms

- SQL Server or SQL Server Agent fails to start and reports error 1069, "The service did not start due to a logon failure."
- The System log contains Service Control Manager Event ID 7041 or Event ID 7038.
- The service fails to start automatically after the host restarts, but it starts manually later.

## Cause

Error 1069 with Event ID 7041 or Event ID 7038 isn't specific to gMSAs. Event ID 7041 indicates a missing logon right, and Event ID 7038 indicates an account, password, or domain-contact problem. When the service account is a gMSA, Event ID 7038 can also mean that the host can't retrieve the managed password, or that Service Control Manager isn't treating the account as managed.

## Diagnose service startup failures

For the complete set of causes and resolutions for error 1069, including user-rights assignment, deny assignments, disabled or locked accounts, and services that can't contact the domain at boot, see [Error 1069 occurs when you start SQL Server Service](error-1069-service-cannot-start.md).

When the service account is a gMSA, check these conditions first:

1. Confirm the configured service identity with `sc.exe qc`.
1. Confirm that `Test-ADServiceAccount` returns `True` on the affected host, and on every possible owner node for a failover cluster instance (FCI).
1. Confirm that the host computer account, or a group that contains it, is listed in `PrincipalsAllowedToRetrieveManagedPassword`.
1. Confirm that `sc.exe qmanagedaccount` reports `TRUE` for the affected service. If it reports `FALSE`, follow the steps in [gMSA IsManagedAccount flag is set improperly](error-1069-service-cannot-start.md#scenario-2-gmsa-ismanagedaccount-flag-is-set-improperly).
1. Confirm domain-controller discovery, secure-channel health, and time synchronization with `nltest` and `w32tm`.

### Correlate a boot-time-only failure

If the service fails to start automatically after the host restarts but starts manually later, compare the server boot, DNS, Netlogon, domain-discovery, and SQL Server startup timestamps against the failure time. A check that fails at boot and succeeds after the host is fully online confirms a startup-order problem rather than a gMSA configuration problem. For resolutions, including delayed start and the Netlogon service dependency, see [The specified domain either does not exist or could not be contacted](error-1069-service-cannot-start.md#the-specified-domain-either-does-not-exist-or-could-not-be-contacted).

## Resolve service startup failures

- Correct the specific account, password retrieval, managed account, or domain condition identified by the evidence.
- Use SQL Server Configuration Manager for all supported service-account changes. For more information, see [Change the service startup account](/sql/database-engine/configure-windows/scm-services-change-the-service-startup-account).
- Restart the service and verify that Event ID 7038 or Event ID 7041 doesn't recur, including after a controlled restart of the host.

> [!NOTE]
> For an FCI, retain cluster-managed startup instead of changing the Windows service start mode. See [Troubleshoot SQL Server failover cluster instance failures with gMSAs](gmsa-failover-cluster-instance-failures.md).

## Collect diagnostic data

If the service still doesn't start after you complete these steps, collect diagnostic data from the affected host for the same failure interval. For the gMSA-specific evidence and standard SQL Server logs to gather, see [Collect diagnostic data](sql-server-setup-startup-authentication-issues-with-gmsas.md#collect-diagnostic-data) in the gMSA troubleshooting overview. Use that data to continue the investigation or to open a support case.

## Related content

- [Troubleshoot SQL Server setup, startup, and authentication failures with gMSAs](sql-server-setup-startup-authentication-issues-with-gmsas.md)
- [Error 1069 occurs when you start SQL Server Service](error-1069-service-cannot-start.md)
- [SQL Server startup errors on a standalone server](sql-server-startup-errors.md)
- [Change the service startup account](/sql/database-engine/configure-windows/scm-services-change-the-service-startup-account)
