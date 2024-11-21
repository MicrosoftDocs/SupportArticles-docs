---
title: Desktop flow ended with max session duration error.
description: Provides troubleshooting steps when the desktop flow ended with error code MaxRDSessionDurationReached or SessionHasLoggedOffWithMaxIdleTime.
ms.custom: sap:Desktop flows\Power Automate for desktop errors
ms.date: 11/15/2024
ms.author: fredg 
author: fredg
---

# Error code MaxRDSessionDurationReached or SessionHasLoggedOffWithMaxIdleTime in Microsoft Power Automate during a desktop flow run.


This article provides troubleshooting steps for an issue taht occurs during a desktop flow run with error code MaxRDSessionDurationReached or SessionHasLoggedOffWithMaxIdleTime in the cloud environment in Microsoft Power Automate.

## Symptoms
The desktop flow ended with error specifying a registry value name with a specific registry path:

```json
{ 
    "error":{
        "code": "MaxRDSessionDurationReached",
        "message": "The session 5 duration (1856000 milliseconds) exceeded the one set in registry for MaxConnectionTime with value 1200000 in registry path Software\Policies\Microsoft\Windows NT\Terminal Service."
    } 
}
```

or 
```json
{ 
    "error":{
        "code": "SessionHasLoggedOffWithMaxIdleTime",
        "message": "The session 5 duration (1856000 milliseconds) exceeded the one set in registry for MaxIdleTime with value 1200000 in registry path Software\Policies\Microsoft\Windows NT\Terminal Service."
    } 
}
```
The error message explains that the Remote Desktop session has been logged off after a duration in milliseconds. The duration is greater than the value found in the registry value name (MaxConnectionTime or MaxIdleTime) in the specified registry path.

## Cause
Those errors are returned when the remote desktop session used to run the desktop flow has been logged off. The flow service detected a session registry setting with a registry value lower than the execution time needed for the desktop flow.

## Resolution
> [!NOTE]
> You may ask to your administrator to change the settings in the following steps.

### Group Policy Settings
Those registry settings are usually set with the Group Policy settings: check the section **_Session time limits_** by opening the [Local Group Policy Editor](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn789185(v=ws.11)) and navigating to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Session Time Limits**. 

1. If the message error points the registry value **_MaxConnectionTime_**, verify the **_Set time limit for active Remote Desktop Services sessions_**, if enabled, disable it or set the value as **_Never_**. 

1. If the message error points the registry value **_MaxIdleTime_**, verify the **_Set time limit for active but idle Remote Desktop Services sessions_**, if enabled, disable it or set the value as **_Never_**. 

### Registry
Based on the registry path in error message, open **_Registry Editor_** tool and find the registry value name from the error message in the specified registry path under ``Computer\HKEY_LOCAL_MACHINE\``.

- example: ``Computer\HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\Terminal Service``. 

If the **_MaxConnectionTime_** or **_MaxIdleTime_** registry value exists, set it to **0** (zero) which means unlimited.
    - Note: the registry value can also be deleted, or set with a value greater than the max execution time of the desktop flow.


|Registry value name|Description|
|---|---|
| **_MaxConnectionTime_** | Specifies the max time of an active Remote Desktop session.|
| **_MaxIdleTime_** | Specifies the max time of an active Remote Desktop session but idle, meaning, without user input (mouse, key...).|
