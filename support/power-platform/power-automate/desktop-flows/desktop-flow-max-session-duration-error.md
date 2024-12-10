---
title: MaxRDSessionDurationReached or SessionHasLoggedOffWithMaxIdleTime Error
description: Solves the error code that occurs during a desktop flow run in Microsoft Power Automate.
ms.date: 12/10/2024
ms.reivewer: guco
ms.author: fredg 
author: fredgGitHub
ms.custom: sap:Desktop flows\Unattended flow runtime errors
---
# MaxRDSessionDurationReached or SessionHasLoggedOffWithMaxIdleTime occurs during a desktop flow run

This article provides a resolution for the error code that occurs during a desktop flow run in the cloud environment in Microsoft Power Automate.

## Symptoms

When you run a desktop flow in the cloud environment in Power Automate, the flow run might fail with one of the error codes that indicate a registry value name and its specific registry path.

```jsonc
{ 
    "error":{
        "code": "MaxRDSessionDurationReached",
        "message": "The session 5 duration (1856000 milliseconds) exceeded the one set in registry for MaxConnectionTime with value 1200000 in registry path Software\Policies\Microsoft\Windows NT\Terminal Service."
    } 
}
```

Or

```jsonc
{ 
    "error":{
        "code": "SessionHasLoggedOffWithMaxIdleTime",
        "message": "The session 5 duration (1856000 milliseconds) exceeded the one set in registry for MaxIdleTime with value 1200000 in registry path Software\Policies\Microsoft\Windows NT\Terminal Service."
    } 
}
```

## Cause

The error message indicates that the remote desktop session was logged off because it exceeded the time limit specified in the registry (MaxConnectionTime or MaxIdleTime). This happens when the session time limit in the registry setting is shorter than the time needed for the desktop flow to complete.

## Resolution

> [!NOTE]
> To solve this issue, contact your administrator to change the settings by following one of the options.

### Option 1: Through the Local Group Policy Editor

Verify group policy settings to ensure no configurations are set to sign out from the remote desktop session due to time limits. You can do this by [opening the Local Group Policy Editor](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn789185(v=ws.11)) and navigating to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Session Time Limits**.

- If the message error points the **MaxConnectionTime** registry value, verify the **Set time limit for active Remote Desktop Services sessions** setting. If it's enabled, disable it or set the **Active session limit** value to **Never**.
- If the message error points the **MaxIdleTime** registry value, verify the **Set time limit for active but idle Remote Desktop Services sessions** setting. If it's enabled, disable it or set the **Active session limit** value to **Never**.

### Option 2: Manually set up in Registry Editor

Based on the registry path in the error message, [open Registry Editor](/previous-versions/windows/it-pro/windows-server-2003/cc758067(v=ws.10)) and find the registry value name from the error message in the specified registry path under **Computer\HKEY_LOCAL_MACHINE\\**.

For example: **Computer\HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\Terminal Service**

If the **MaxConnectionTime** or **MaxIdleTime** registry value exists, set it to **0** (zero) which means unlimited.

> [!NOTE]
> The registry value can also be deleted, or set to a value greater than the maximum execution time of the desktop flow.

|Registry value name|Description|
|---|---|
| **MaxConnectionTime** | Specifies the maximum amount of time (in milliseconds) that a remote desktop session can remain active, regardless of activity.|
| **MaxIdleTime** | Specifies the maximum amount of (in milliseconds) that a remote desktop session can remain idle (without user input such as keyboard or mouse activity) before it's logged off.|
