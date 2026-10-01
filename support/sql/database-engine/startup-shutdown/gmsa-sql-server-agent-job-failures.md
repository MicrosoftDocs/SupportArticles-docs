---
title: SQL Server Agent Jobs Fail After Switching to a gMSA
description: Resolve SQL Server Agent job step failures after the Agent service account changes to a gMSA. Check proxies, share and NTFS permissions, and SSIS package access.
ms.reviewer: prmadhes, jopilov
ms.date: 09/29/2026
ms.custom: sap:Startup, shutdown, restart issues (instance or database)
ai-usage: ai-assisted
---

# Troubleshoot SQL Server Agent job failures with gMSAs

_Applies to:_ &nbsp; SQL Server on Windows

## Summary

This article helps you troubleshoot SQL Server Agent job-step failures that start after you change the SQL Server Agent service account to a group managed service account (gMSA). It covers SQL Server Integration Services (SSIS), maintenance plan, backup, PowerShell, and CmdExec job steps that fail because the new execution identity doesn't have the required share, NTFS, proxy, credential, or package permissions.

Before you start, review the prerequisites and run the quick validation checklist in [Troubleshoot SQL Server setup, startup, and authentication failures with gMSAs](sql-server-setup-startup-authentication-issues-with-gmsas.md).

## Symptoms

- SQL Server Agent starts, but SSIS, maintenance plan, backup, PowerShell, or CmdExec job steps fail.
- Job steps started failing after the SQL Server Agent service account was changed to a gMSA.
- Errors identify a missing component, file, proxy, credential, share, or NTFS permission.

## Cause

A job-step failure that follows a service-account change is usually an access problem for the new identity, not a gMSA password-management problem. Job steps that don't use a proxy run as the SQL Server Agent service account, so grant the gMSA every share, NTFS, and destination permission that the previous account had.

## Diagnose SQL Server Agent job failures

1. Identify the failing job-step subsystem and the first actionable error in the job history.
1. Confirm which identity actually runs the step: the SQL Server Agent service account, or a proxy account. For more information, see [Create a SQL Server Agent proxy](/ssms/agent/create-a-sql-server-agent-proxy).
1. For network paths and destination resources, confirm that share and NTFS permissions are granted to the gMSA in the `<DomainName>\<GmsaName>$` form, including the trailing dollar sign. Replace `<DomainName>` and `<GmsaName>` with the domain and account names.
1. Confirm that the gMSA has the required permissions on the destination service, such as a backup target, linked server, or file share.

_**Expected result:**_ the execution identity has explicit permission on every resource the job step uses.

## Resolve SQL Server Agent job failures

Use the solution that matches the first actionable error in the job history.

### Grant destination-resource permissions to the execution identity

1. Determine the account under which the failed job step runs:

    - A CmdExec job step that doesn't specify a proxy runs under the SQL Server Agent service account.
    - A job step that specifies a SQL Server Agent proxy runs under the Windows account stored in the proxy credential.
    - A Transact-SQL job step doesn't use a SQL Server Agent proxy. It runs in the job owner's security context. If the job owner is a member of the `sysadmin` fixed server role, the step runs under the SQL Server Agent service account unless another database user is specified.

1. Grant the required permissions to the execution identity:

    - If the job step runs under the SQL Server Agent service account and that account is a gMSA, specify the gMSA computer-account form of the identity, which includes a trailing dollar sign (`$`). For example, `CONTOSO\SQLAgentSvc$`.
    - If the job step uses a proxy, grant permissions to the Windows account associated with the proxy credential, not automatically to the SQL Server Agent service account or gMSA.
    - For a file share, grant only the required permissions to the execution identity on both the SMB share and the underlying NTFS folder.

1. To verify the identity and share access, temporarily run the following commands in a CmdExec job step that uses the same **Run as** configuration as the failing step.

    ```cmd
    whoami
    dir "\\FileServer\BackupShare"
    ```

    _**Expected result:**_ the `whoami` command returns the expected execution identity, and the `dir` command lists the contents of the share.

1. Remove the temporary diagnostic step after testing.

### Correct the SQL Server Agent proxy, credential, or job-step execution context

Review the failed job step and verify its subsystem and **Run as** setting. For a subsystem that supports proxies, create or use a proxy that meets the following conditions:

- References a credential for the required Windows account.
- Is enabled for the job-step subsystem.
- Is available to the login or SQL Server Agent role that owns or runs the job.
- Uses an account that has the permissions required by the job step.

Assign the proxy to the job step. Creating a proxy doesn't grant resource permissions to the account stored in its credential. Grant those permissions separately and follow the principle of least privilege. For more information, see [Create a SQL Server Agent proxy](/ssms/agent/create-a-sql-server-agent-proxy).

### Resolve SSIS permission or package-access errors

If an SSIS job step fails with permission or package-access errors, verify that the account running the SSIS job step can access the following resources:

- The SSIS package location.
- Configuration files and command files, if used.
- Files and folders referenced by the package.
- Network shares.
- Databases and other data sources.
- Other external resources required by the package.

If the package uses sensitive information protected by the SSIS `ProtectionLevel` setting, verify that the execution account can decrypt the required information. A change to the SQL Server Agent execution account can cause an SSIS package to fail when the new account can't decrypt package secrets or doesn't have permission to access an external resource. For more information, see [SSIS package does not run when called from a SQL Server Agent job step](../../integration-services/ssis-package-doesnt-run-when-called-job-step.md).

### Install or repair confirmed missing components

Install or repair only confirmed missing components, and correct SSIS deployment or runtime compatibility separately from the account change. If the job history identifies a missing component, verify that the component is installed and available to the execution identity before you change permissions. Examples include:

- SSIS components.
- PowerShell modules required by the job.
- Custom executables or scripts referenced by CmdExec job steps.
- Required providers or other runtime components.

Resolve missing-component or runtime errors separately from permission errors. After the component is installed or repaired, rerun the job. If it still fails, review the first actionable error in the job history.

## Collect diagnostic data

If the job step still fails after you complete these steps, collect the failed job history and other diagnostic data for the same failure interval. For the gMSA-specific evidence and standard SQL Server logs to gather, see [Collect diagnostic data](sql-server-setup-startup-authentication-issues-with-gmsas.md#collect-diagnostic-data) in the gMSA troubleshooting overview. Use that data to continue the investigation or to open a support case.

## Related content

- [Troubleshoot SQL Server setup, startup, and authentication failures with gMSAs](sql-server-setup-startup-authentication-issues-with-gmsas.md)
- [Create a SQL Server Agent proxy](/ssms/agent/create-a-sql-server-agent-proxy)
- [SSIS package does not run when called from a SQL Server Agent job step](../../integration-services/ssis-package-doesnt-run-when-called-job-step.md)
- [Configure Windows service accounts and permissions](/sql/database-engine/configure-windows/configure-windows-service-accounts-and-permissions)
