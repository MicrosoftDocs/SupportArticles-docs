---
title: Troubleshoot unexpected RDS session locks or disconnections
description: Introduces how to configure RDS session time-outs to troubleshoot unexpected session locks or disconnections.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:remote desktop services and terminal services\session connectivity
- pcy:WinComm User Experience
---
# Troubleshoot unexpected RDS session locks or disconnections

A Remote Desktop Services (RDS) session can enter **locks** and **disconnects** status at regular intervals. In this situation, the session requires users to sign in or reconnect to the session. This article introduces how to troubleshoot unexpected **locks** and **disconnects** time intervals.

## Introductions

RDS can have the following status:

- **active**: the user is currently connected and interacting with the system.
- **idle**: the user is connected but hasn't interacted with the server for a specific period.
- **locked**: users are redirected to the login screen, but their sessions remain active without any error message.
- **disconnected**: The user's connection to the server has been severed, and then the RDP window typically closes with an error message. The session remains to run on the server.

Disconnects occurring without a consistent timing pattern are more likely caused by **network issues** rather than configuration settings.

## Verify if the session time-out is a disconnect

On a Windows computer, when **MaxIdleTime** or **MaxConnectionTime** are configured, RDS sessions disconnect when conditions are met with distinct messages. Additional RDS session time limit policies determine the behavior after a session is disconnected.

The two registry values locate at `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp`.

| Configuration             | Set time limit for active but idle RDS sessions                                                           | Set time limit for active RDS sessions                                                                                                         |
| :------------------------ | :-------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------- |
| Registry (Type:REG_DWORD) | MaxIdleTime                                                                                               | MaxConnectionTime                                                                                                                              |
| Message when disconnected | Your Remote Desktop Services session ended because the remote computer didn't receive any input from you. | The remote session ended because the total sign-in time limit was reached. This limit is set by the server administrator or by network policies. |

You can use the following two methods to configure the above registry values.

### RDS Deployment

The default configuration for these session limits should be set at the **Collection** > **Properties tasks** > **Session** on the server that manages the RDS deployment. Usually, the server is the Remote Desktop Connection Broker. These settings are then applied to the registry of the Remote Desktop Session Hosts in that collection.

> [!NOTE]
>
> - If users connect to the RDS Deployment through a Remote Desktop Gateway (RDGW), similar configuration can be done in **RDGW manager > Policies > Connection Authorization Policies > Timeouts tab**. Users that bypass the RDGW won't be affected.
> - Session time-out has a distinct disconnect message compared to the message caused by the **MaxConnectionTime** setting: **The connection has been disconnected because the session timeout limit was reached.**

### Computer and User policies

Computer and User policies should be configured with **gpedit.msc** (locally) or **gpmc.msc** (domain level) on the following path:  
**Administrative Templates > Windows Components > Remote Desktop Services > Remote Desktop Session Host > Session Time Limits**

Policy configurations are applied to the corresponding registry path:

- Computer policy registry path: **HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services**
- User policy registry path: **HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows NT\Terminal Services**

## Verify if the session time-out is a Lock

On a Windows machine, there are two distinct forms of configuring a session lock:

1. **Machine inactivity limit** policy.
2. Configuring a **Screen saver**.

If any of the above settings is configured, sessions are locked when conditions are met.

> [!IMPORTANT]
>
> - Policies have precedence to default configurations.
> - These configurations apply immediately, but if not, ask users to reconnect or logoff/logon.

### Machine inactivity limit policy

The policy can only be configured at the Computer level, with the value specified in seconds. The following are the configuration policy path and the corresponding registry path:

- Policy path: **Computer Configuration > Windows Settings > Security Settings > Local Policies > Security Options** - **Interactive logon: Machine inactivity limit**
- Registry path: Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System - InactivityTimeoutSecs  
  Type:REG_DWORD

### Screen saver

To enable a screen saver that locks the session, three registry values of type:REG_SZ must be configured:

- **ScreenSaveActive** - Enable (**1**) or Disable (**0**) a Screen Saver
- **ScreenSaverIsSecure** - Password protected (**1**) or unprotected (**0**)
- **ScreenSaveTimeOut** - How much user idle time (seconds) must elapse before the screen saver is launched

Screen saver is a user configuration. The configuration can be set by using **Screen Saver Settings** console or by using policies.

#### Screen Saver Settings

To configure on Screen Saver Settings:

- open CMD and run following command to open the console: *control desk.cpl,,1*
- Select from **Screen saver** dropdown box.
- Define a time-out.
- Select **On resume, display logon screen** checkbox.

Values are written on registry path: `Computer\HKEY_CURRENT_USER\Control Panel\Desktop`

#### Policies

Three below policies must be configured to enable Screen Saver: **Enable screen saver**, **Password protect the screen saver**, and **Screen saver timeout**.

The following are the configuration policies path and the corresponding registry path:

- Policy path: **User Configuration > Administrative Templates > Control Panel > Personalization**.
- Registry path: `Computer\HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Control Panel\Desktop`.

## Contact Microsoft Support

If the preceding steps can't resolve the issue, collect data on the affected machine while replicating the issue. Download [TSS script](https://aka.ms/getTSS), and run the following command on an elevated PowerShell:

```powershell
.\TSS.ps1 -Scenario UEX_RDSsrv -start  -UEX_Logon
```

For more information, see [Gather information by using TSS for user experience-related issues](../../windows-client/windows-tss/gather-information-using-tss-user-experience.md).
