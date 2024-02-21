---
title: Configure L2TP/IPsec server behind NAT-T device
description: Discusses how to configure an L2TP/IPsec server behind a NAT-T device in Windows Vista and in Windows Server 2008.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, samirj
ms.custom: sap:wireless-networking-and-802.1x-authentication, csstroubleshoot
---
# Configure a L2TP/IPsec server behind a NAT-T device

This article describes how to configure a L2TP/IPsec server behind a NAT-T device.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 926179

## Summary

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

By default, Windows Vista and Windows Server 2008 don't support Internet Protocol security (IPsec) network address translation (NAT) Traversal (NAT-T) security associations to servers that are located behind a NAT device. If the virtual private network (VPN) server is behind a NAT device, a Windows Vista or Windows Server 2008-based VPN client computer can't make a Layer 2 Tunneling Protocol (L2TP)/IPsec connection to the VPN server. This scenario includes VPN servers that are running Windows Server 2008 and Windows Server 2003.

Because of the way in which NAT devices translate network traffic, you may experience unexpected results in the following scenario:

- You put a server behind a NAT device.
- You use an IPsec NAT-T environment.

If you must use IPsec for communication, use public IP addresses for all servers that you can connect to from the Internet. If you must put a server behind a NAT device, and then use an IPsec NAT-T environment, you can enable communication by changing a registry value on the VPN client computer and the VPN server.

## Set AssumeUDPEncapsulationContextOnSendRule registry key

To create and configure the **AssumeUDPEncapsulationContextOnSendRule** registry value, follow these steps:

1. Log on to the Windows Vista client computer as a user who is a member of the Administrators group.
2. Select **Start** > **All Programs** > **Accessories** > **Run**, type *regedit*, and then select **OK**. If the **User Account Control** dialog box is displayed on the screen and prompts you to elevate your administrator token, select **Continue**.
3. Locate and then select the following registry subkey:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PolicyAgent`

    > [!NOTE]
    > You can also apply the **AssumeUDPEncapsulationContextOnSendRule** DWORD value to a Microsoft Windows XP Service Pack 2 (SP2)-based VPN client computer. To do so, locate and then select the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\IPSec` registry subkey.

4. On the **Edit** menu, point to **New**, and then select **DWORD (32-bit) Value**.
5. Type *AssumeUDPEncapsulationContextOnSendRule*, and then press ENTER.
6. Right-click **AssumeUDPEncapsulationContextOnSendRule**, and then select **Modify**.
7. In the **Value Data** box, type one of the following values:

   - 0

     It's the default value. When it's set to 0, Windows can't establish security associations with servers located behind NAT devices.
   - 1

     When it's set to 1, Windows can establish security associations with servers that are located behind NAT devices.
   - 2

     When it's set to 2, Windows can establish security associations when both the server and VPN client computer (Windows Vista or Windows Server 2008-based) are behind NAT devices.

8. Select **OK**, and then exit Registry Editor.
9. Restart the computer.
