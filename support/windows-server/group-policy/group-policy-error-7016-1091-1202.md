---
title: Errors when unknown environment variable is used
description: Describes an issue where Group Policy error events are logged when unknown environment variable is used. Provides a solution to this issue.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
---
# Group Policy error events logged when unknown environment variable is used

This article helps avoid Group Policy error events that are logged when unknown environment variable is used.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2003730

## Symptoms

If you are running an Active Directory forest and using a file system security policy, you may see the following events logged:

- Windows Vista, Windows Server 2008, Windows 7, and Windows Server 2008 R2 will log this event to the Group Policy operational log:

    > Log Name: Microsoft-Windows-GroupPolicy/Operational  
    Source: Microsoft-Windows-GroupPolicy  
    Event ID: 7016  
    Task Category: None  
    Level: Error  
    Keywords:  
    User: SYSTEM  
    Description:  
    Completed Security Extension Processing in 20984 milliseconds.  
    Event Xml:  
    \<Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event">  
    ...  
    \<EventData>  
    \<Data Name="CSEElaspedTimeInMilliSeconds">20984\</Data>  
    \<Data Name="ErrorCode">1252\</Data>  
    \<Data Name="CSEExtensionName">Security\</Data>  
    \<Data Name="CSEExtensionId">{827D319E-6EAC-11D2-A4EA-00C04F79F83A}\</Data>  
    \</EventData>  
    \</Event>

- Windows XP and Windows Server 2003 will log this event in the Application log:

    > Event ID: 1091  
    Category: None  
    Source: Userenv  
    Type: Error  
    Message: The Group Policy client-side extension Security failed to log RSOP (Resultant Set of Policy) data. Look for any errors reported earlier by that extension.  

- All Windows version will log this event in the Application log:

    > Event ID: 1202  
    Category: None  
    Source: SceCli  
    Type: Warning  
    Message: Security policies were propagated with warning. 0xd: The data is invalid.  
    Depending on the actual policy configuration, the settings in the security policies may or may not be present. The **More Information** section explains the conditions for policy failure or success (despite the errors).

## Cause

The events are logged because the file system security settings of one policy contain an environment variable that is unknown on the client computer. To find out more about the problem, enable logging of the security configuration client-side extension:

[Troubleshoot SCECLI 1202 events](scecli-1202-events.md).

In the %windir%\security\logs\winlogon.log file, you will see an entry such as:

> Process GP template gpt0000x.inf.  
>
> Error 13: The data is invalid.  
    Error converting %PROGRAMFILES(X86)%\MyApplication.

%PROGRAMFILES(X86)% is only an example. It is used when the policy is edited on a 64-bit version of Windows and security settings are made for the folder C:\PROGRAM FILES (X86) or one of its subfolders.

The gpt0000x.inf file, a text file containing the policy settings, can be found in the %windir%\security\templates\policies folder. It also contains the location of the policy in Active Directory in the line starting with **GPOPath**, allowing you to identify which policy has the unknown environment variable.

## Resolution

To avoid the problem, create a new policy at the same level that receives the settings referencing the missing environment variable. Then use a WMI filter to allow the policy to only apply to machines that have the environment variable defined.

For example, the WMI filter for %PROGRAMFILES(X86)% would be:

> Select * from Win32_Envrionment where Name = 'PROGRAMFILES(X86)'

## More information

This section explains why in some cases the policy settings apply successfully, but in other cases they do not.

Security group policy is driven by the Userenv.dll library running within the Winlogon.exe process, or on Windows Vista and later, the Group Policy Service (GPSvc). This is the component that gets the list of policies that are assigned to the machine, and filters out the ones that do not apply. They may be filtered based on the permissions on the policy or a WMI filter.  

Userenv/GPSvc then sorts the policies based on their priority. The first policy applied is the one with the lowest priority, the last one is the one with the highest priority. For security policy, Userenv/GPSvc calls the security policy client-side extension (SCECLI) with the policy settings file downloaded from SYSVOL.  

SCECLI has two phases. In the first phase, it takes the settings passed to it and feeds them into the security database. The second phase is applying these settings to the system, for example, set user rights, security options or set security descriptors on the registry and files.  

The first phase is active until the last policy is being processed. The call from Userenv/GPSvc to SCECLI for the last policy is a special case. When the call is made, the first phase is still active and the settings from the last policy are read into the security database as with all other policies. But before the call returns, SCECLI sees that this is the last policy and, within the same call, executes the second phase.  

The settings for registry and file system policy are deemed to be expensive to commit, SCECLI does not execute them in the calling thread in foreground mode. For these settings, Userenv/GPSvc would create an additional thread so processing can complete while the user can already logon. Domain controllers are an exception to this rule. They would always first complete all security policy application before the user can logon.  

With regard to missing environment variables, SCECLI reads the settings in the first phase and encounters an error when it resolves the environment variable to the actual path. SCECLI will skip the entry and continue adding settings to the security database and later return an error to Userenv/GPSVC.  

When the problem happens in any policy except the last policy, Userenv/GPSVC treats the error as a fatal problem and aborts security group policy. Therefore the second phase is never happening. When the problem happens in the last policy, SCECLI ignores the error and executes the second phase. Userenv/GPSVC still aborts policy application with an error, but actually policy processing has been completed by this point.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
