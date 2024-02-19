---
title: "\"Error 720: Can't connect to a VPN Connection\" when you try to establish a VPN connection"
description: Discusses how to troubleshoot error 720 that occurs when you try to establish a VPN connection.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-access, csstroubleshoot
---
# "Error 720: Can't connect to a VPN Connection" when you try to establish a VPN connection

This article discusses how to troubleshoot error 720 that occurs when you try to establish a VPN connection.

## Symptoms

When you try to establish a VPN connection, you receive the following error message:

> A connection to the remote computer could not be established. You might need to change the network settings for this connection.

:::image type="content" source="media/troubleshoot-error-720-when-establishing-a-vpn-connection/vpn-error-message.png" alt-text="Screenshot of the VPN Connection error, which shows Can't connect to VPN Connection.":::

Additionally, RasClient event ID 20227 (that mentions error 720) is recorded in the Application log:

```output
Log Name: Application
Source: Ras Client
Event ID: 20227
Description: The user dialed a connection named VPN Connection which has failed. The error code returned on failure is 720.
```

## Troubleshooting on the server side

On the server side, check whether any of the following issues occurs:

- The static IP Pool is exhausted.
- The DHCP server for the RRAS is not available or its scope is exhausted.
- The static IP address that's configured in the Active Directory user properties can't be assigned.

## Get network adapter binding on the client

**Error 720 : ERROR_PPP_NO_PROTOCOLS_CONFIGURED** typically occurs if the **WAN Miniport (IP)** adapter is not bound correctly on your PC. This is true even though the **WAN Miniport (IP)** adapter might look healthy when you examine the **Network adapters** node in **Device Manager**.

There are several scenarios that can cause this error. To troubleshoot the error, start by checking the linked driver of your **WAN Miniport (IP)**:

1. Open an elevated Windows PowerShell window.
2. Run the following command, and search for the **Name** value of the **WAN Miniport (IP)** interface.

   ```powershell
   Get-NetAdapter -IncludeHidden | Where-Object {$_.InterfaceDescription -eq "WAN Miniport (IP)"}
   ```

   For example, the name can be **Local Area Connection\* 6**.
3. Run the following command by using the **Name** value that you verified in step 2.

   ```powershell
   Get-NetAdapterBinding -Name "<interface_name>" -IncludeHidden -AllBindings
   ```

Based on the output, choose the appropriate troubleshooting scenario from the following options, and follow the provided steps.

## Scenario 1: Remote Access IP ARP Driver is disabled

If you see that **ms_wanarp** is disabled (as shown in the following example output), re-enable it by running the provided command.

```output
Name                   DisplayName                                        ComponentID          Enabled
----                   -----------                                        -----------          -------
<interface_name>       QoS Packet Schedular                               ms_pacer             True        
<interface_name>       Remote Access IP ARP Driver                        ms_wanarp            False　<<<<< ★
<interface_name>       WFP Native MAC Layer LightWeight                   ms_wfplwf_lower      True 
```

Run this command:

```powershell
Enable-NetAdapterBinding -Name "<interface_name>" -IncludeHidden -AllBindings -ComponentID ms_wanarp 
```

## Scenario 2: A third-party filter driver is bound

If you see that a third-party filter driver is bound (as shown in the following example output), disable it by running the provided command.

```output
Name                   DisplayName                                        ComponentID          Enabled
----                   -----------                                        -----------          -------
<interface_name>       QoS Packet Schedular                               ms_pacer             True        
<interface_name>       Remote Access IP ARP Driver                        ms_wanarp            True   
<interface_name>       <some_filter_driver>                               <some_filter>        True　<<<<< ★
<interface_name>       WFP Native MAC Layer LightWeight                   ms_wfplwf_lower      True
```

Run this command:

```powershell
Disable-NetAdapterBinding -Name "<interface_name>" -IncludeHidden -AllBindings -ComponentID <some_filter> 
```

## Scenario 3: Reinstall WAN Miniport (IP) interface drivers

If the previous scenarios don't apply, or if the steps don't fix the error, reinstall the **WAN Miniport (IP)** interface driver:

1. Open **Device Manager**.
2. Right-click all the network adapters whose name starts as "WAN Miniport," and then select **Uninstall device**. Here are some adapters that you may observe:
   - WAN Miniport (IP)
   - WAN Miniport (IPv6)
   - WAN Miniport (GRE)
   - WAN Miniport (L2TP)
   - WAN Miniport (Network Monitor)
   - WAN Miniport (PPPOE)
   - WAN Miniport (PPTP)
   - WAN Miniport (SSTP)
3. On the Device Manager menu bar, select **Action** > **Scan for hardware changes**. This will automatically reinstall your WAN Miniport devices.
