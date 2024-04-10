---
title: Event 1202 with status 0x534 logged
description: Provides a solution to an event logged on domain controllers after modifying security policy.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, arrenc
ms.custom: sap:Group Policy\Problems Applying Group Policy, csstroubleshoot
---
# Event 1202 with status 0x534 logged on Windows Server 2008 R2 domain controllers after modifying security policy

This article provides a solution to an event logged on domain controllers after modifying security policy.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2000705

## Symptoms

The Application log on Windows Server 2008 R2 domain controllers contains Event ID 1202 with status code "0x534: No mapping between account names and security IDs was done" every time security policy is applied. The relevant part of the Event ID 1202 is shown below:

> Log Name: Application  
Source: SceCli  
Date: MM/DD/YYYY HH:MM:SS AM | PM  
Event ID: 1202  
Task Category: None  
Level: Warning  
Keywords: Classic  
User: N/A  
Computer: \<computer name>  
Description:  
Security policies were propagated with warning. 0x534 : No mapping between account names and security IDs was done.
>
> Advanced help for this problem is available on https://support.microsoft.com. Query for "troubleshooting 1202 events".
>
> Error 0x534 occurs when a user account in one or more Group Policy objects (GPOs) could not be resolved to a SID.  This error is possibly caused by a mistyped or deleted user account referenced in either the User Rights or Restricted Groups branch of a GPO.  To resolve this event, contact an administrator in the domain to perform the following actions:  

The WINLOGON.LOG contains the following text: 

> ...  
Configure S-1-1-0.  
Configure S-1-5-11.  
Configure S-1-5-32-554.  
Configure S-1-5-32-548.  
Configure S-1-5-32-550.  
Configure S-1-5-9.  
Configure WdiServiceHost.  
Error 1332: No mapping between account names and security IDs was done.  
  Cannot find WdiServiceHost.  
Configure S-1-5-21-2125830507-553053660-2246957542-519.  
  add SeTimeZonePrivilege.  
 User Rights configuration was completed with one or more errors.
...

By default, the GPTMPL.INF policy in the Default Domain Controllers Policy looks like this:
> SeSystemProfilePrivilege = *S-1-5-80-3139157870-2983391045-3678747466-658725712-1809340420,*S-1-5-32-544  

Once an unrelated security setting is modified in the Default Domain Controllers Policy, the `SeSystemProfilePrivilege` entry in Default Domain Controllers Policy appears as below:  
> SeSystemProfilePrivilege = *S-1-5-32-544,WdiServiceHost

For more information, see [SceCli 1202 events are logged every time Computer Group Policy settings are refreshed on a computer that is running Windows Server 2008 R2 or Windows 7](https://support.microsoft.com/help/974639).

## Cause

When modifying any security setting in the Default Domain Controllers Policy using the Group Policy Management Console (GPMC) from the console of a Windows Server 2008 R2 domain controller, GPMC incorrectly translates the SID for the Wdiservice account in the policy to a user name that isn't recognized by the local machines where the policy is enforced.
This issue also occurs when a Windows 7 or Windows Server 2008 R2 member computer modifies any security setting in the Default Domain Controllers Policy on a Windows Server 2008 R2 domain controller.

## Workaround

As a temporary workaround, manually edit the GPTMPL.INF file by adding the **NT Service\\** prefix in front of the **wdiservicehost** account name for the **Profile System Performance** user right in the Default Domain Controllers Policy. Which has to be done every time *any security* setting in the Default Domain Controllers Policy is administered with GPMC.

This step will prevent the 1202 event from being logged until the next time security policy is modified in the Default Domain Controllers Policy by the relevant operating system versions.

1. Open the GPTTMPL.INF file for the Default Domain Controllers Policy of a domain controller logging the Event ID 1202. The path to the GPTTMPL.INF file when SYSVOL is located below %SystemRoot% is:  
    `%SystemRoot%\Sysvol\domain\Policies\{6AC1786C-016F-11D2-945F-00C04fB984F9}\MACHINE\Microsoft\Windows NT\SecEdit\GPTTMPL.INF`

2. Locate the `SeSystemProfilePrivilege` entry in the GPTTMPL.INF and modify it as follows:

    Before: `SeSystemProfilePrivilege` = *S-1-5-32-544,WdiServiceHost  

    After: `SeSystemProfilePrivilege` = *S-1-5-32-544,nt service\WdiServiceHost

    > [!NOTE]
    > **NT Service\\** should appear after the "," delimiter. Don't prefix **NT Service\\** with the "*" character.

3. Save the changes to GPTTMPL.INF.

4. From a command prompt on the console of the domain controller whose GPTTMPL.INF file was modified in Step 1, type **Gpupdate /force.**  

5. View the Application log to see if an Event ID 1202 with status code 0x534 was logged. If so, review the WINLOGON.LOG to see if the event was caused by the WdiServiceHost security principal.

## More information

In the Default Domain Controllers Policy on a Windows Server 2008 R2 domain controller, the SID for the Diagnostics Service Host (wdiservicehost) account is granted the `SeSystemProfilePrivilege` where it's added to the local SAM of the machine, picked up by SCE, then added to the GPTTMPL.INF.

When any security setting is modified in the Default Domain Controllers Policy on a Windows Server 2008 domain controller, a code defect causes the SID for the Wdiservicehost account to be replaced with its SAM account but fails to add the **NT Service\\** prefix required by SCECLI to resolve the account's name. (that is, NT Service\Wdiservicehost).

1. The issue described in this policy occurs when the Group Policy Management Editor on Windows 7 or Windows Server 2008 R2 computers is used to modify security settings in Default Domain Controllers Policy on a Windows Server 2008 domain controller.

2. This issue doesn't occur when security policy is modified in policies other than Default Domain Controllers Policy.

3. Despite the logging of the Event ID 1202 with status code 0x534, this issue doesn't prevent Windows computers from applying security policy contained in the Default Domain Controllers Policy. However, there's no way to distinguish a false positive event caused by this issue from a legitimate misconfiguration that will prevent security policy from applying, identified by the same Event ID 1202 and 0x534 status code.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
