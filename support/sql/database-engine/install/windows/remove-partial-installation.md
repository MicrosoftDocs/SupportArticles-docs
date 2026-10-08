---
title: Remove a partial installation of SQL Server
description: This article describes the procedure to remove a partial installation of SQL Server.
ms.date: 10/08/2026
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.reviewer: prmadhes
ms.topic: how-to
---

# Remove a partial installation of SQL Server

This article describes the procedure to remove a partial installation of SQL Server.

_Original product version:_ &nbsp; SQL Server

_Original KB number:_ &nbsp; 955404

## Symptoms

After a SQL Server installation or upgrade fails, a subsequent attempt to install or upgrade the same SQL Server version on the same computer might also fail.
You might see one or more of the following symptoms:

- An instance appears as `<instance name>.INACTIVE` in the Installed SQL Server features discovery report.
- Setup reports that the instance ID is already in use by an inactive SQL Server instance.
- Setup returns error 1639 and the component log contains “MSINEWINSTANCE requires a new instance that is not installed.”
- Summary.txt instructs you to uninstall one or more features before you rerun Setup.
- A feature fails because a dependency failed, and the first failure in the logs points to an incomplete instance or unavailable installation source.


## Cause

If SQL Server Setup fails during installation, a partially installed instance can remain on the computer. SQL Server Setup doesn't always roll back all of the changes made before the failure. When you run Setup again, Setup can detect the partially installed instance. This can prevent Setup from determining or creating the instance configuration required for the new installation.
The original installation failure can have many causes. For example, a prerequisite, installation source, Windows Installer package, or another setup component might have failed. Removing the partial installation does not resolve the original cause of the failure. You must correct the original failure before you retry Setup.

## Before you begin

- Back up all user and system databases for every working SQL Server instance on the computer. Verify that the backups are usable.
- Identify all working instances and record their instance names, instance IDs, editions, versions, and installed features IDs so that you can distinguish them from the inactive instance.
- Copy the latest SQL Server Setup log folder to a safe location. The default path is %ProgramFiles%\Microsoft SQL Server\<nnn>\Setup Bootstrap\Log\<timestamp>.
- Use installation media for the same SQL Server major version that created the inactive instance, unless Summary.txt explicitly directs you to different media.
- Run commands from an elevated Command Prompt. On a multi-instance server, validate the instance name, instance ID, and feature list before every removal command.
- For a failover cluster instance, do not treat a cluster node as a stand-alone instance. Use the SQL Server failover cluster maintenance workflow and review the logs from the affected node.

> **Important:** Do not delete SQL Server registry keys, services, folders, or files as a general cleanup method. Manual registry or file-system cleanup can remove shared components or damage working instances. If supported removal methods fail, collect logs and contact Microsoft Support.


## Resolution

1. **Review the setup result and identify the inactive instance**

   Open `Summary.txt` from the most recent failed setup attempt. Record the suggested uninstall command, instance name or instance ID, and the features listed in the command. Review `Detail.txt` and the first failing component log to confirm that the failure belongs to the inactive instance.

   `%ProgramFiles%\Microsoft SQL Server\<nnn>\Setup Bootstrap\Log\<timestamp>\Summary.txt`

1. **Run the uninstall command suggested by Setup**

   If Summary.txt provides an uninstall command, use that command to remove the partial installation.

   Open an elevated Command Prompt and change to the directory that contains `setup.exe` on the appropriate SQL Server installation media.

   **For example:**

   ```cmd
   cd /d <drive>:\<SQL Server installation media>
   ```

   Then run the exact command provided by Summary.txt.

   **For example:**

   ```cmd
   setup.exe /Q /ACTION=UNINSTALL /INSTANCEID=<instance ID> /FEATURES=<feature list>
   ```

   The command above is an example only. **Do not substitute the instance ID or feature list with values from another installation or another computer.** Use the values provided by Summary.txt for the failed installation.

   > [!IMPORTANT]
   > Verify the instance ID before running the command. On a computer with multiple SQL Server instances, running the command against the wrong instance can remove a working instance.

   For more information, see [Uninstall an Existing Instance of SQL Server (Setup)](/sql/sql-server/install/uninstall-an-existing-instance-of-sql-server-setup).

1. **Generate the installed features discovery report**

   Start SQL Server Installation Center from the matching media. Select Tools > Installed SQL Server features discovery report. Review the report and determine whether the partial installation is still listed as: `<instance name>.INACTIVE`

   **For example:**

   ```output
   MSSQLSERVER.INACTIVE
   ```

   If the inactive instance is no longer listed, verify that the working SQL Server instances and their expected features are still present. You can then proceed to the troubleshooting steps for the original Setup failure before retrying the installation.

   If the inactive instance is still listed, continue to the next step.

1. **Remove remaining Windows Installer products for the inactive instance**

   If the discovery report still lists the inactive instance, open the XML report associated with it. For each entry that belongs to the inactive instance, record the ProductCode. Verify that each product is mapped to the inactive instance and not to a working instance or shared component.

   `ProductCode="{XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX}"`

   Run the following command from an elevated Command Prompt for each verified product code:

   ```cmd
   msiexec.exe /x {PRODUCT-CODE-GUID}
   ```

   > [!CAUTION]
   > Remove only the ProductCode entries associated with the inactive instance. Don't bulk-uninstall products simply because their display name contains SQL Server. A computer can contain products and shared components that are required by working SQL Server instances.

   Microsoft documents this procedure as part of removing a partial SQL Server installation.

1. **Verify removal before retrying Setup**

   - Regenerate the Installed SQL Server features discovery report.
   - Confirm that the inactive instance is no longer listed.
   - Confirm that all working instances and their expected features are still listed.
   - Review Programs and Features only as a secondary check; do not use product names alone to decide what to remove.
   - Restart the computer if the removal operation requests it. Then rerun the original installation or upgrade from valid local or reliably accessible media.

## Troubleshooting scenarios

| Scenario | What you might see | Recommended action |
|---|---|---|
| Inactive instance blocks setup | The discovery report shows `<instance>.INACTIVE`, or Setup says the instance ID is already in use. | Follow the Resolution section. Use the uninstall command from `Summary.txt`, then remove only verified `ProductCode` entries that belong to the inactive instance. |
| Error 1639 / MSINEWINSTANCE | A component log says that a specified instance is already installed and `MSINEWINSTANCE` requires a new instance. | Correlate the product or transform with the inactive instance. Do not treat "invalid command line" as proof that user-entered setup syntax is the only cause. |
| Dependency fails with error 53 or network path not found | `Summary.txt` reports a dependency failure, and a component log reports that a source or network path is unavailable. | Restore access to the required source or use valid local media. Then remove the inactive instance if Setup created one. Retry only after the source problem is corrected. |
| Missing MSI or MSP in Windows Installer cache | Repair, patch, upgrade, or uninstall requests an MSI/MSP that cannot be found, or a feature is unavailable for selection. | Use the Microsoft Learn procedure to restore missing Windows Installer cache files. Do not copy a file from another computer unless the documented validation confirms it is the exact required package. |
| Driver or runtime package is the first failure | The first failing package is an ODBC driver, OLE DB driver, or Visual C++ runtime package. | Repair or uninstall the affected dependency through its supported installer workflow, based on its MSI log and installed version. Do not remove all drivers by default. |
| Failover cluster instance | The failed operation involves an FCI node or clustered instance. | Use SQL Server Setup cluster maintenance actions, such as `Remove node` when applicable. Preserve cluster configuration and collect logs from each affected node. |
| Supported removal still fails | The `Summary.txt` uninstall command and verified `ProductCode` removal both fail, or the inactive entry remains. | Stop manual cleanup. Preserve Setup logs, discovery reports, MSI logs, and a system configuration snapshot, and contact Microsoft Support. |

### When to stop and collect logs

Stop the removal attempt and collect evidence if any of these conditions apply:

- You cannot confidently map a ProductCode to the inactive instance.
- The computer hosts other working SQL Server instances or shared features and the proposed removal could affect them.
- The inactive instance belongs to a failover cluster and the normal cluster maintenance action fails.
- The uninstall command fails repeatedly, Windows Installer reports missing source files, or msiexec removal fails.
- The remaining option would require deleting registry keys, services, installer-cache files, or SQL Server folders manually.

Collect at minimum: the complete Setup Bootstrap Log folder, Summary.txt, Detail.txt, the first failing component log, relevant MSI logs, the installed-features discovery report in HTML and XML format, and the exact commands and return codes from attempted removals.

## Collect the following information

Collect the following information before making additional changes to the computer:

- The complete SQL Server Setup Bootstrap Log folder.
- Summary.txt.
- Detail.txt.
- The feature specific MSI log is associated with the failure.
- Any other relevant MSI logs.
- The Installed SQL Server features discovery report in HTML and XML format.
- The exact commands that were run during the removal attempt.
- The return codes reported by SQL Server Setup or Windows Installer.
- Information about the SQL Server versions, instance names, instance IDs, editions, and installed features on the computer.

> [!NOTE]
> SQL LogScout is a diagnostic collection tool. For more information, see [Troubleshooting and diagnostic tools for on-premises and hybrid scenarios](/troubleshoot/sql/tools/sql-support-troubleshooting-diagnostic-tools).

## See also

- [View and read SQL Server Setup log files](/sql/database-engine/install-windows/view-and-read-sql-server-setup-log-files)
- [Repair a failed SQL Server installation](/sql/database-engine/install-windows/repair-a-failed-sql-server-installation)
- [Restore missing Windows Installer cache files](/troubleshoot/sql/database-engine/install/windows/restore-missing-windows-installer-cache-files)
- [Uninstall an Existing Instance of SQL Server (Setup)](/sql/sql-server/install/uninstall-an-existing-instance-of-sql-server-setup)
