---
title: COM+ application stops working when users logs off
description: Provides a solution to an issue where a COM+ application stops working when a user logs off Windows.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Application Technologies and Compatibility\DCOM service startup and permissions, csstroubleshoot
---
# A COM+ application may stop working in Windows when a user logs off

This article provides a solution to an issue where a COM+ application stops working in Windows when a user logs off.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10 - all editions, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2287297

## Symptoms

On a Windows server, you have a COM+ server application in which the identity is configured to run as a specific user. After working for some time, the application may stop working and keep failing. You have to restart the COM+ application to resolve the issue.

You may see an error that resembles the following in the Application log on the CLIENT machine. If the client executable runs on the same computer as the COM+ server application, you will see this error on the COM+ server:

> Event Type:        Error  
Event Source:    DCOM  
Event Category:                None  
Event ID:              10006  
Date:                     *\<DateTime>*  
Time:                    *\<DateTime>*  
User:                     Domain\user  
Computer:          *****  
Description:  
DCOM got error "Unspecified error" from the computer 'servername' when attempting to activate the server: {XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX}

In this case, the event message tells you that the error (E_FAIL or 80004005 or Unspecified error) is returned from the server. The CLSID of the component will be listed in the event log entry.

You'll also see events that resemble the following in the Application log of the computer on which the COM+ application runs:

> Log Name:      Application  
Source:        Microsoft-Windows-User Profiles Service  
Date:          *\<DateTime>*  
Event ID:      1530  
Task Category: None  
Level:         Warning  
Keywords:      Classic  
User:          SYSTEM  
Computer:      SERVERNAME  
Description:  
Windows detected your registry file is still in use by other applications or services. The file will be unloaded now. The applications or services that hold your registry file may not function properly afterwards.
>
> DETAIL -  
1 user registry handles leaked from \Registry\User\S-1-5-21-1049297961-3057247634-349289542-1004_Classes:  
Process 2428 (\Device\HarddiskVolume1\Windows\System32\dllhost.exe) has opened key \REGISTRY\USER\S-1-5-21-1123456789-3057247634-349289542-1004_CLASSES

You may see the call to create an instance of the component returns 0x800703fa.

## Cause

The user identity that is associated with the COM+ application is logged on when the COM+ application is first initialized. If this user were to log off of the machine, then the user's profile would get unloaded and the COM+ application can no longer read registry keys in the profile of the user identity. Starting with Windows Vista the User Profile Service will force the unloading of a user profile when that user logs off. This is a situation where the functionality of forcing the unload of the user profile may break an application if registry handles are not closed in the process. This new User Profile Service functionality is the default behavior.

## Resolution

As a workaround it may be necessary to modify the default behavior of the User Profile Service. The policy setting **Do not forcefully unload the user registry at user logoff** counters the default behavior of Vista and newer operating systems. When enabled, the User Profile Service will not forcefully unload the registry, instead it waits until no other processes are using the user registry before it unloads it. The policy can be found in the group policy editor (gpedit.msc). The **Do not forcefully unload the user registry at user logoff** policy is located under **Computer Configuration** > **Administrative Templates** > **System** > **User Profiles**.

Change the setting from **Not Configured** to **Enabled** which disables the new User Profile Service feature. **DisableForceUnload** is the value added to the registry.

## More information

Windows will always unload the users registry, even if there are any open handles to the per-user registry keys at user logoff. Using this policy setting, an administrator can negate this behavior, preventing Windows from forcefully unloading the users registry at user logoff.

> [!NOTE]
> This policy should only be used for cases where you may be running into application compatibility issues due to this specific Windows behavior. It is not recommended to enable this policy by default as it may prevent users from getting an updated version of their roaming user profile.

If you enable this policy setting, Windows will not forcefully unload the users registry at logoff, but will unload the registry when all open handles to the per-user registry keys are closed.

If you disable or do not configure this policy setting, Windows will always unload the users registry at logoff, even if there are any open handles to the per-user registry keys at user logoff.

Even if you enabled the **Do not forcefully unload the user registry at user logoff** policy setting, the Event ID 1530 warning may be logged. The warning is logged after the first attempt to unload the registry hive. If this fails, the policy is checked to determine whether the registry hive should be forced to unload regardless of open registry handles.
