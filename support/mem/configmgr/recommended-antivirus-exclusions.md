---
title: Recommended antivirus exclusions for Configuration Manager
description: Lists the recommended antivirus exclusions for Configuration Manager site servers, site systems, and clients.
ms.date: 01/12/2021
ms.prod-support-area-path:
ms.reviewer: jarrettr, jrosse, keiththo
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

  > Database verification failed with result: 0x80004005 but DB: C:\Windows\CCM\filename.sdf could be opened, skipping DB repair.

- Software that is deployed to clients cannot be installed.
- Compliance data for software deployments is inaccurate.

## Exclusions

We recommend that you add the following real-time protection exclusions to prevent these problems.

### Default installation folders

| Folder | Path |
| --- | --- |
| Configuration Manager installation folder | %ProgramFiles%\Microsoft Configuration Manager |
| MP installation folder | %ProgramFiles%\SMS_CCM |
| Client installation folder | %Windir%\CCM |

### Folder exclusions for site servers

- *ConfigMgr installation folder*\Inboxes
- *ConfigMgr installation folder*\Logs
- *ConfigMgr installation folder*\EasySetupPayload

### Folder exclusions for site systems

- Management points
  - *MP installation folder*\ServiceData
  - Either of the following folders:
    - *ConfigMgr installation folder*\MP\OUTBOXES
    - *Installation drive*\SMS\MP\OUTBOXES
- Distribution points
  - *Client installation folder*\ServiceData
  - *ContentLib_drive*\SMS_DP$
  - *ContentLib_drive*\SMSPKGDrive_Letter$
  - *ContentLib_drive*\SMSPKG
  - *ContentLib_drive*\SMSPKGSIG
  - *ContentLib_drive*\SMSSIG$
- Site database servers
  - [How to choose antivirus software to run on computers that are running SQL Server](https://support.microsoft.com/help/309422)  

### Folder exclusions for clients

- *Client installation folder*\\*.sdf
- *Client installation folder*\ServiceData
- C:\Windows\CCMCache
- C:\Windows\CCMSetup
- *Client installation folder*\Logs
- C:\Windows\Setup\Scripts
- C:\Windows\SMSTSPostUpgrade

### File exclusions for MPs

- POL00000.pol in *MP installation folder*\PolReqStaging

### Don't scan outgoing files on MPs

- Most antivirus software has an option to scan files that are copied to a remote location (outgoing files). This option should be disabled on management points.
- For Windows Defender, the policy name is **Configure monitoring for incoming and outgoing file and program activity**. And it should be set to **Scan only incoming files**.

    For more information, see [Enable and configure Windows Defender Antivirus always-on protection in Group Policy](/windows/security/threat-protection/windows-defender-antivirus/configure-real-time-protection-windows-defender-antivirus).

### Process exclusions

Process exclusions are necessary only if aggressive antivirus programs consider Configuration Manager executables (.exe) to be high-risk processes.

- *ConfigMgr installation folder*\bin\x64\Smsexec.exe
- Either of the following executables:
  - *Client installation folder*\Ccmexec.exe
  - *MP installation folder*\Ccmexec.exe
- *Client installation folder*\RemCtrl\CmRcService.exe (client-side)
- *ConfigMgr installation folder*\bin\x64\Sitecomp.exe
- *ConfigMgr installation folder*\bin\x64\Smswriter.exe
- *ConfigMgr installation folder*\bin\x64\Smssqlbkup.exe, or SMS_*SQLFQDN*\bin\x64\ Smssqlbkup.exe
- *ConfigMgr installation folder*\bin\x64\Cmupdate.exe
- *Client installation folder*\Ccmrepair.exe (client-side)
- *%windir%*\CCMSetup\Ccmsetup.exe (client-side)

## References

- [Configuration Manager Current Branch Antivirus Exclusions](https://techcommunity.microsoft.com/t5/Core-Infrastructure-and-Security/Configuration-Manager-Current-Branch-Antivirus-Exclusions/ba-p/884831)
- [Updated System Center 2012 Configuration Manager Antivirus Exclusions with more details on OSD and Boot Images](https://techcommunity.microsoft.com/t5/Core-Infrastructure-and-Security/Updated-System-Center-2012-Configuration-Manager-Antivirus/ba-p/884371)
- [How to choose antivirus software to run on computers that are running SQL Server](https://support.microsoft.com/help/309422/how-to-choose-antivirus-software-to-run-on-computers-that-are-running-sql-server)
- [Virus scanning recommendations for Enterprise computers that are running currently supported versions of Windows](https://support.microsoft.com/help/822158/virus-scanning-recommendations-for-enterprise-computers-that-are-running-currently-supported-versions-of-windows)
