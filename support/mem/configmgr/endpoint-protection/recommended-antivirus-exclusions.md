---
title: Recommended antivirus exclusions for Configuration Manager
description: Lists the recommended antivirus exclusions for Configuration Manager site servers, site systems, and clients.
ms.date: 03/25/2022
ms.reviewer: kaushika, jarrettr, jrosse, keiththo
---
# Recommended antivirus exclusions for Configuration Manager site servers, site systems, and clients

This article contains recommendations that may help an administrator determine the cause of potential instability on a computer that's running a supported version of Configuration Manager site servers, site systems, and clients when it's used together with antivirus software.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager, Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 327453

## Summary

We recommend you temporarily apply these procedures to evaluate a system. If your system performance or stability is improved by the recommendations that are made in this article, contact your vendor for instructions or an updated version of the antivirus software.

> [!IMPORTANT]
> This article contains information that shows how to help lower security settings or how to temporarily turn off security features on a computer. You can make these changes to understand the nature of a specific problem. Before you make these changes, we recommend that you evaluate the risks that are associated with implementing this workaround in your particular environment.

Antivirus real-time protection can cause many problems on Configuration Manager site servers, site systems, and clients.

Possible symptoms include:

- Remote site system components aren't installed. SiteComp.log, Distmgr.log, hman.log, or other Configuration Manager log files may contain errors such as error 80070005.
- The Configuration Manager client cannot be installed through client push.
- Client inventory information is inaccurate, missing, or out-of-date.
- Backlogs occur in the *Install_Directory*\Inboxes folders on site servers.
- Backlogs occur in the *Install_Directory*\MP\Outboxes subfolders on management points (MP).
- Software Center isn't populated by deployed software on client systems, or doesn't start. Also, the CCMRepair.log file may contain an error similar to the following example:

  ```output
  Database verification failed with result: 0x80004005 but DB: C:\Windows\CCM\filename.sdf could be opened, skipping DB repair.
  ```

- Software that is deployed to clients cannot be installed.
- Compliance data for software deployments is inaccurate.

## Default installation folders

Use the following installation folder paths as variables for the recommended exclusions that are provided in this article.

> [!NOTE]
> The following paths are the default installation paths and may vary depending on the environment. We recommend that you review the environment and configuration to ensure you have the correct paths in place.

| Folder | Path |
| --- | --- |
| *ConfigMgr installation folder* | %ProgramFiles%\Microsoft Configuration Manager |
| *MP installation folder* | %ProgramFiles%\SMS_CCM |
| *Client installation folder* | %Windir%\CCM |
| *ContentLib_drive* | The path will vary. The default path is the C:\ drive. |

## Exclusions

We recommend that you add the following real-time protection exclusions to prevent these problems.

### Folder exclusions for site servers

- *ConfigMgr installation folder*\Inboxes
- *ConfigMgr installation folder*\Logs
- *ConfigMgr installation folder*\EasySetupPayload
- *ContentLib_drive*\SCCMContentLib

  > [!NOTE]
  > If you have a remote content library, this folder isn't on the site server. For more information, see [Configure a remote content library for the site server](/mem/configmgr/core/plan-design/hierarchy/the-content-library#bkmk_remote).

### Folder exclusions for site systems

- Management points
  - *MP installation folder*\ServiceData
  - Either of the following folders:
    - *ConfigMgr installation folder*\MP\OUTBOXES
    - *Installation drive*\SMS\MP\OUTBOXES
- Distribution points
  - *Client installation folder*\ServiceData
  - *ContentLib_drive*\SCCMContentLib
  - *ContentLib_drive*\SMS_DP$
  - *ContentLib_drive*\SMSPKGDrive_Letter$
  - *ContentLib_drive*\SMSPKG
  - *ContentLib_drive*\SMSPKGSIG
  - *ContentLib_drive*\SMSSIG$
- Site database servers
  - [How to choose antivirus software to run on computers that are running SQL Server](../../../sql/database-engine/security/antivirus-and-sql-server.md)  

### Folder exclusions for clients

- *Client installation folder*\\*.sdf
- *Client installation folder*\ServiceData
- *Client installation folder*\ScriptStore
- C:\Windows\CCMCache
- C:\Windows\CCMSetup
- *Client installation folder*\Logs
- C:\Windows\Setup\Scripts
- C:\Windows\SMSTSPostUpgrade
- C:\Program Files\Microsoft Policy Platform\authorityDb\\*.sdf
- *Client installation folder*\temp

### File exclusions for MPs

- POL00000.pol in *MP installation folder*\PolReqStaging

### Don't scan outgoing files on MPs

- Most antivirus software has an option to scan files that are copied to a remote location (outgoing files). This option should be disabled on management points.
- For Windows Defender, the policy name is **Configure monitoring for incoming and outgoing file and program activity**. And it should be set to **Scan only incoming files**.

    For more information, see [Enable and configure Windows Defender Antivirus always-on protection in Group Policy](/windows/security/threat-protection/windows-defender-antivirus/configure-real-time-protection-windows-defender-antivirus).

### Process exclusions

Process exclusions are necessary only if aggressive antivirus programs consider Configuration Manager executables (.exe) to be high-risk processes.

Site and site systems:

- *ConfigMgr installation folder*\bin\x64\Smsexec.exe
- *ConfigMgr installation folder*\bin\x64\Sitecomp.exe
- *ConfigMgr installation folder*\bin\x64\Smswriter.exe (site server only)
- *ConfigMgr installation folder*\bin\x64\Cmupdate.exe (site server only)
- *ConfigMgr installation folder*\bin\x64\Smssqlbkup.exe, or *SQLFQDN*\bin\x64\Smssqlbkup.exe (site database server only)
- *MP installation folder*\Ccmexec.exe

Client:

- *Client installation folder*\Ccmexec.exe
- *Client installation folder*\Ccmrepair.exe
- *Client installation folder*\ScClient.exe
- *Client installation folder*\CcmAADBroker.exe
- *Client installation folder*\RemCtrl\CmRcService.exe 
- *%windir%*\CCMSetup\Ccmsetup.exe
- *%windir%*\CCMSetup\autoupgrade\Ccmsetup*.exe 

> [!NOTE]
> Starting in Configuration Manager current branch version 1910, this file name has been changed to *Ccmsetup.\<Packageid>.\<PackageVersion>.exe*.

## References

- [Configuration Manager Current Branch Antivirus Exclusions](https://techcommunity.microsoft.com/t5/Core-Infrastructure-and-Security/Configuration-Manager-Current-Branch-Antivirus-Exclusions/ba-p/884831)
- [Updated System Center 2012 Configuration Manager Antivirus Exclusions with more details on OSD and Boot Images](https://techcommunity.microsoft.com/t5/Core-Infrastructure-and-Security/Updated-System-Center-2012-Configuration-Manager-Antivirus/ba-p/884371)
- [How to choose antivirus software to run on computers that are running SQL Server](../../../sql/database-engine/security/antivirus-and-sql-server.md)
- [Virus scanning recommendations for Enterprise computers that are running currently supported versions of Windows](https://support.microsoft.com/help/822158/virus-scanning-recommendations-for-enterprise-computers-that-are-running-currently-supported-versions-of-windows)
