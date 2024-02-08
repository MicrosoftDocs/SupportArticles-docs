---
title: User GPP Scheduled Task item fails to apply
description: Provides a solution to an issue where User GPP Scheduled Task item fails to apply.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, akhleshs
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
---
# User GPP Scheduled Task item fails to apply and logs event ID: 4098 with 0x80070005 Access is denied

This article provides a solution to an issue where User Group Policy Preference (GPP) Scheduled Task item fails to apply.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2447414

## Symptoms

You configure the following User Group Policy Preference (GPP) item in a Windows 2008/2008 R2 based Active Directory Domain.

- `User Configuration\Preferences\Control Panel Settings\Scheduled Tasks\New\"Scheduled Task (Windows Vista and later)"`
- Under the **Common Settings** tab, select option **Run in logged-on user's security context (user policy option)**. After the Group Policy is applied to a user, you find that the preference item doesn't take effect.

Additionally, you see the following event log in the Application log:

Additionally if you enable Group Policy tracing for GPP Scheduled Tasks Client Side Extension, you'll see the following messages logged in the GPP User log file:

> *\<DateTime>* [pid=0x3a0,tid=0x8c8] Starting class \<TaskV2> - \<GPP item name>.  
*\<DateTime>* [pid=0x3a0,tid=0x8c8] Set user security context.  
*\<DateTime>* [pid=0x3a0,tid=0x8c8] Adding child elements to RSOP.  
*\<DateTime>* [pid=0x3a0,tid=0x8c8] WorkItem.Init [hr = 0x80070005 "Access is denied."]  
*\<DateTime>* [pid=0x3a0,tid=0x8c8] Properties handled. [hr = 0x80070005 "Access is denied."]
*\<DateTime>* [pid=0x3a0,tid=0x8c8] Set system security context.  
*\<DateTime>* [pid=0x3a0,tid=0x8c8] EVENT : The user '\<GPP item name>' preference item in the '\<GPO name> {GPO GUID}' Group Policy object did not apply because it failed with error code '0x80070005 Access is denied.'%100790273  
*\<DateTime>* [pid=0x3a0,tid=0x8c8] Error suppressed. [hr = 0x80070005 "Access is denied."]  
*\<DateTime>* [pid=0x3a0,tid=0x8c8] Completed class \<TaskV2> - \<GPP item name>.  
*\<DateTime>* [pid=0x3a0,tid=0x8c8] Completed class \<ScheduledTasks>.

You can enable GPP tracing through group policy:  
    `Computer Configuration\Policies\Administrative Templates\System\Group Policy\Logging and Tracing\Configure Schedulled Tasks preference logging and tracing`  

When configured, the log file will be created in:  
    `%SystemDrive%\ProgramData\GroupPolicy\Preference\Trace\User.log`

## Cause

The User GPP Scheduled Tasks item wasn't designed to run under the currently logged on users security context AND must be applied in the default system security context.

## Resolution

To avoid this issue, don't enable the **Run in logged-on user's security context (user policy option)** Common option when configuring user GPP Scheduled Tasks items.

The security context under which the Scheduled Task will run once it has been deployed can be specified in the **General settings** tab when creating the User GPP Scheduled Task item:

`User Configuration\Preferences\Control Panel Settings\Scheduled Tasks\New\"Scheduled Task (Windows Vista and later)"`  
General:  
Security Options -> "When running the task, use the following user account:"  

By default, it's set to: `%LogonDomain%\%LogonUser%`

It's where the security context under which the scheduled task will run should be configured.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
