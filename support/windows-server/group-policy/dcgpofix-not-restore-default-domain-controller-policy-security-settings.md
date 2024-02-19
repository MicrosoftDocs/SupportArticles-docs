---
title: The Dcgpofix tool doesn't restore security settings in the Default Domain Controller Policy to their original state
description: Explains that the Dcgpofix tool doesn't restore security settings in the Default Domain Controller Policy to the same state that they were in after successfully completing Dcpromo and that it's best to use this tool only in disaster recovery scenario.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: timtho, kaushika
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
---
# The Dcgpofix tool doesn't restore security settings in the Default Domain Controller Policy to their original state

This article explains that the Dcgpofix tool doesn't restore security settings in the Default Domain Controller Policy to the same state that they were in after successfully completing Dcpromo and that it's best to use this tool only in disaster recovery scenario.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 833783

## Symptoms

The documentation for the Dcgpofix.exe tool incorrectly indicates that the Dcgpofix tool will restore security settings in the Default Domain Controller Policy to the same state that they were in immediately after Dcpromo successfully completed. This isn't the case.

It's best to use the Dcgpofix tool only in disaster recovery scenarios. The Dcpromo operation modifies the security of the domain in an incremental manner, based on the existing security settings on that server. Therefore, after you run Dcpromo, the final set of security settings in the Default Domain Controller Policy depends on both the Dcpromo operation and the security state of the system that existed before you ran Dcpromo. Before you run Dcpromo, the security state of the system can be modified by a number of mechanisms. For example, when you install some server applications, changes may be made to user rights that are granted to local user accounts, such as the SUPPORT_388945a0 account.

## Cause

The Dcgpofix tool can't know what state the security settings were in before you run Dcpromo. Therefore, the Dcgpofix tool can't return the security settings to precisely the original state. Instead, the Dcgpofix tool recreates the two default Group Policy objects (GPOs) and creates the settings based on the operations that are performed only during Dcpromo.

If you have a new installation of Windows Server and no security changes are made to the operating system before you run Dcpromo, the recreated Default Domain Controller Policy that is created by Dcgpofix will be almost the same as the Default Domain Controller Policy just after you run Dcpromo. However, there will be some differences in the settings in the Default Domain Controller Policy in this case.

## Resolution

For general backup and restore of the Default Domain Policy and Default Domain Controller Policy, and also for other GPOs, Microsoft recommends that you use the Group Policy Management Console (GPMC) to create regular backups of these GPOs. You can then use GPMC in conjunction with these backups to restore the exact security settings that are contained in these GPOs.

If you're in a disaster recovery scenario and you don't have any backed-up versions of the Default Domain Policy or the Default Domain Controller Policy, you may consider using the Dcgpofix tool. If you use the Dcgpofix tool, Microsoft recommends that as soon as you run it, you review the security settings in these GPOs and manually adjust the security settings to suit your requirements. A fix isn't scheduled to be released because Microsoft recommends you use GPMC to back up and restore all GPOs in your environment. The Dcgpofix tool is a disaster-recovery tool that will restore your environment to a functional state only. It is best not to use it as a replacement for a backup strategy using GPMC. It is best to use the Dcgpofix tool only when a GPO backup for the Default Domain Policy and Default Domain Controller Policy doesn't exist.

## More information

The following table lists differences in security settings in the Default Domain Controller Policy after you run the Dcgpofix tool and the settings on a new installation of Windows Server after you run Dcpromo. Microsoft recommends that you adjust these security settings to match the requirements in your environment after you run the Dcgpofix tool.

|Setting in Default Domain Controller Policy|Value after running DCPromo on cleanly installed Windows Server|Value after running DCGPOFIX|
|---|---|---|
| Audit Settings|||
|Audit Account Management|Success|No Auditing|
|Audit Directory Service Access|Success|No Auditing|
|Audit Policy Change|Success|No Auditing|
|Audit System Events|Success|No Auditing|
| User Rights|||
|Create Global Objects|Not defined|SERVICE, Administrators|
|Deny access to computer from network|SUPPORT_388945a0|(Empty)|
|Deny logon locally|SUPPORT_388945a0|(Empty)|
|Impersonate a client after authentication|Not defined|SERVICE, Administrators|
|Load and unload device drivers|Administrators, Print Operators|Administrators|
|Log on as a batch job|LOCAL SERVICE, SUPPORT_388945a0|(Empty)|
|Log on as a service|NETWORK SERVICE|(Empty)|
|Shut down the system|Administrators, Backup Operators, Server Operators, Print Operators|Account Operators, Administrators, Backup Operators, Server Operators, Print Operators|
  
The following settings will change after you run the Dcgpofix tool:

- AuditAccountManage
- AuditDSAccess
- AuditPolicyChange
- AuditSystemEvents
- SeCreateGlobalPrivilege
- SeImpersonatePrivilege
- SeLoadDriverPrivilege
- SeShutdownPrivilege

Based on configuration options, the following settings may also change the following:

- SeBatchLogonRight (only LOCAL SERVICE, not the SUPPORT_388945a0 account)
- SeServiceLogonRight
