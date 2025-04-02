---
title: Troubleshoot Unexpected RDS Session Locks or Disconnections
description: Introduces how to configure RDS session time-outs to troubleshoot unexpected session locks or disconnections.
ms.date: 03/11/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:remote desktop services and terminal services\session connectivity
- pcy:WinComm User Experience
---
# Troubleshoot unexpected RDS session locks or disconnections

A Remote Desktop Services (RDS) session can enter a **locked** and **disconnected** status at regular intervals. In this situation, the session requires users to sign in or reconnect to the session. This article introduces how to troubleshoot unexpected lock and disconnection time intervals.

## Introduction

RDS can have the following statuses:

- **Active**: The user is currently connected and interacting with the system.
- **Idle**: The user is connected but hasn't interacted with the server for a specific period.
- **Locked**: Users are redirected to the login screen, but their sessions remain active without any error message.
- **Disconnected**: The user's connection to the server has been severed, and then the RDP window typically closes with an error message. The session remains to run on the server.

Disconnections occurring without a consistent timing pattern are more likely caused by network issues rather than configuration settings.

## Verify if the session time-out is a disconnection

On a Windows computer, when **MaxIdleTime** or **MaxConnectionTime** is configured, RDS sessions disconnect when conditions are met with distinct messages. Other RDS session time limit policies determine the behavior after a session is disconnected.

| Configuration             | Set a time limit for active but idle RDS sessions                                                           | Set a time limit for active RDS sessions                                                                                                         |
| :------------------------ | :-------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------- |
| Registry (Type: `REG_DWORD`) | `MaxIdleTime`                                                                                               | `MaxConnectionTime`                                                                                                                              |
| Message when disconnected | Your Remote Desktop Services session ended because the remote computer didn't receive any input from you. | The remote session ended because the total logon time limit was reached. This limit is set by the server administrator or by network policies. |

You can use the following two methods to configure these registry values.

### RDS deployment

The default configuration for these session limits should be set in **Collection** > **Properties tasks** > **Session** on the server that manages the RDS deployment. Usually, the server is the Remote Desktop Connection Broker. These settings are then applied to the registries of the Remote Desktop Session Hosts in that collection.

The registry values are located at `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp`.

> [!NOTE]
>
> - If you connect to the RDS deployment through a Remote Desktop Gateway (RDGW), a similar configuration can be done in **RDGW manager > Policies > Connection Authorization Policies > Timeouts tab**. Users who bypass the RDGW won't be affected.
> - The session time-out disconnection message is distinct from the message caused by the **MaxConnectionTime** setting: **The connection has been disconnected because the session timeout limit was reached.**

### Computer and user policies

Computer and user policies should be configured with **gpedit.msc** (locally) or **gpmc.msc** (domain level) at the following path:  
**Administrative Templates > Windows Components > Remote Desktop Services > Remote Desktop Session Host > Session Time Limits**

Policy configurations are applied to the corresponding registry paths:

- Computer policy registry path: **HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services**
- User policy registry path: **HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows NT\Terminal Services**

> [!IMPORTANT]
>
> - Policies have precedence over default configurations.
> - Computer policies have precedence over user policies.
> - Registry values are expressed in milliseconds.
> - To apply these configurations, users must reconnect or log off/on.

## Verify if the session time-out is a lock

On a Windows machine, there are two distinct forms of a session lock configuration:

1. The **Machine inactivity limit** policy.
2. **Screen saver**.

If any of the preceding settings are configured, sessions are locked when conditions are met.

> [!IMPORTANT]
>
> - Policies have precedence over default configurations.
> - These configurations apply immediately, but if not, ask users to reconnect or log off/on.

### Machine inactivity limit policy

This policy can only be configured at the computer level, with the value specified in seconds. The configuration policy path and the corresponding registry path are:

- Policy path: **Computer Configuration > Windows Settings > Security Settings > Local Policies > Security Options** - **Interactive logon: Machine inactivity limit**
- Registry path: `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System - InactivityTimeoutSecs`  
  
  Type: `REG_DWORD`

### Screen saver

To enable a screen saver that locks the session, three registry values of type `REG_SZ` must be configured:

- **ScreenSaveActive** - Enable (**1**) or disable (**0**) the screen saver.
- **ScreenSaverIsSecure** - Password protected (**1**) or unprotected (**0**).
- **ScreenSaveTimeOut** - How much user idle time (in seconds) must elapse before the screen saver is launched.

Screen saver is a user configuration. The configuration can be set by using the **Screen Saver Settings** console or using policies.

#### Screen Saver Settings

To configure on **Screen Saver Settings**:

1. Open Command Prompt and run the following command to open the console:

    ```cmd
    control desk.cpl,,1
    ```

2. Select from the **Screen saver** dropdown box.
3. Define a time-out.
4. Select the **On resume, display logon screen** checkbox.

The values are written in the registry path: `Computer\HKEY_CURRENT_USER\Control Panel\Desktop`

#### Policies

Three policies must be configured to enable the screen saver: **Enable screen saver**, **Password protect the screen saver**, and **Screen saver timeout**.

The configuration policy path and the corresponding registry path are:

- Policy path: **User Configuration > Administrative Templates > Control Panel > Personalization**.
- Registry path: `Computer\HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Control Panel\Desktop`.

## Contact Microsoft Support

If the preceding steps can't resolve the issue, collect data on the affected machine while replicating the issue. Download [the TroubleShootingScript (TSS) script](https://aka.ms/getTSS) and run the following command on an elevated PowerShell prompt:

```powershell
.\TSS.ps1 -Scenario UEX_RDSsrv -start  -UEX_Logon
```

For more information, see [Gather information by using TSS for user experience-related issues](../../windows-client/windows-tss/gather-information-using-tss-user-experience.md).
