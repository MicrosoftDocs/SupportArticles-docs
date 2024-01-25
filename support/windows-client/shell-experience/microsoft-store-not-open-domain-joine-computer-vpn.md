---
title: Microsoft Store doesn't open after a domain-joined computer makes a VPN connection
description: Discusses an issue in which Microsoft Store doesn't open after a domain-joined computer connects to a VPN connection. The VPN connection has force tunneling enabled.
ms.date: 09/21/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: davusa, winciccore, kaushika
ms.custom: sap:modern-inbox-and-microsoft-store-apps, csstroubleshoot
ms.subservice: shell-experience
---
# Microsoft Store doesn't open after a domain-joined computer makes a VPN connection

This article discusses an issue in which you can't open Microsoft Store after a domain-joined computer connects to a VPN connection that has force tunneling enabled.

_Applies to:_ &nbsp; Windows 10 – all editions  
_Original KB number:_ &nbsp; 4537233

## Symptoms

Assume that you connect a domain-joined Windows 10 computer to a VPN connection that has force tunneling enabled. When you try to open Microsoft Store, it doesn't open, and you receive a "This page failed to load" error message.

If you do one of the following operations, Microsoft Store opens as expected:

- Disconnect the computer from the domain, and then connect to the VPN connection.
- Connect the computer to a VPN connection that has force tunneling disabled.
- Turn off the **Windows Defender Firewall** service, and then connect the computer to the VPN connection.

## Cause

The Microsoft Store app uses a security model that depends on network isolation. Specific network capabilities and boundaries must be enabled for the store app, and network access must be allowed for the app.

When the Windows Firewall profile isn't **Public**, a default block rule blocks all outgoing traffic that has the remote IP set as **0.0.0.0**. While the computer is connected to a VPN connection that has force tunneling enabled, the default gateway IP is set as **0.0.0.0**. If the network access boundaries aren't set appropriately, the following behaviors occur:

- The default block firewall rule is applied.
- Microsoft Store app traffic is blocked.

## Resolution

To fix this issue, follow these steps to create a Group Policy object (GPO):

1. Open the Group Policy Management snap-in (gpmc.msc), and create, or open a Group Policy for editing.
2. From the Group Policy Management Editor, expand **Computer Configuration** > **Policies** > **Administrative Templates** > **Network**, and then select **Network Isolation**.
3. In the right pane, double-click **Private network ranges for apps**.
4. In the **Private network ranges for apps** dialog box, select **Enabled**.
5. In the **Private subnets** text box, type the IP range of your VPN adapter, and then select **OK**.

    For example, If your VPN adapter IPs are in the 172.x.x.x range, add **172.0.0.0/8** in the text box.
6. Double-click **Subnet definitions are authoritative**, select **Enabled**, and then select **OK**.
7. Restart the client to make sure that the GPO takes effect.

After the Group Policy is applied, the added IP range is the only private network range that's available for network isolation. Windows will now create a firewall rule that allows the traffic, and will override the previous outbound block rule with the new rule.

> [!NOTE]
>
>- When your VPN address pool range changes, you should change this GPO accordingly. Otherwise, the issue will recur.
>- You can push the same GPOs from the DC to multiple computers.
>- On the individual computers, you can check the following registry location to make sure that the GPO takes effect:

 `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkIsolation`

## More information

You can use the "checknetisolation" built-in tool to check the network capabilities. When the computer is connected to the domain profile and VPN force tunneling, the InternetClient and InternetClientServer capabilities aren't active. For example:

```console
C:\Windows\system32>checknetisolation Debug -n=microsoft.windowsstore_8wekyb3d8bbwe

Network Isolation Debug Session started.
Reproduce your scenario, then press Ctrl-C when done.
      Collecting Logs.....

Summary Report

Network Capabilities Status
----------------------------------------------------------------------
    InternetClient                Not Used and Insecure  
    InternetClientServer          Not Used and Insecure  
    PrivateNetworkClientServer    Missing, maybe intended  


Network Capabilities Status
----------------------------------------------------------------------
    InternetClient                Used and Declared
    InternetClientServer          Not Used and Insecure
```

> [!NOTE]
> On the same client, if you remove the computer from the domain or disconnect the VPN, you can see that **internetclient** is being used.

For more information, see [Isolating Windows Store Apps on Your Network](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831418%28v=ws.11%29).
