---
title: Change default MTU size settings for PPP or VPN connections
description: Describes how to edit the registry to change the default maximum transmission unit (MTU) size settings for Point-to-Point Protocol (PPP) connections or for virtual private network (VPN) connections.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, tode
ms.custom: sap:remote-access, csstroubleshoot
---
# Change the default maximum transmission unit (MTU) size settings for PPP connections or for VPN connections

This article describes how to edit the registry to change the default maximum transmission unit (MTU) size settings for Point-to-Point Protocol (PPP) connections or for virtual private network (VPN) connections.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 826159

## Summary

Windows Server 2003, Windows 2000, and Windows XP use a fixed MTU size of 1500 bytes for all PPP connections and use a fixed MTU size of 1400 bytes for all VPN connections. This is the default setting for PPP clients, for VPN clients, for PPP servers, or for VPN servers that are running Routing and Remote Access.

PPP connections are connections such as modem connections, Integrated Services Digital Network (ISDN) connections, or direct cable connections over null serial cable or over parallel cable. VPN connections are Point-to-Point Tunneling Protocol (PPTP) connections or Layer 2 Tunneling Protocol (L2TP) connections.

> [!NOTE]
> Use the methods in this article to edit the registry to modify the MTU size settings. If you experience any problems or any performance-related issues after you modify the MTU size settings, remove the registry keys that you added.

## Change the MTU settings for PPP connections

To change the MTU settings for PPP connections, add the **ProtocolType** DWORD value, the **PPPProtocolType** DWORD value, and the **ProtocolMTU** DWORD value to the following registry key:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Ndiswan\Parameters\Protocols\0`

To do so, follow these steps.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Window](https://support.microsoft.com/help/322756).

1. Click **Start**, click **Run**, type *regedit* in the **Open** box, and then click **OK**.
2. Locate and then click the following subkey in the registry:  
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NdisWan\Parameters`

3. Add a **Protocols** subkey (if it does not already exist):
    1. On the **Edit** menu, point to **New**, and then click **Key**.
    2. Type *Protocols*, and then press ENTER.

4. Add a **0** (zero) subkey to the **Protocols** subkey:
    1. Click the **Protocols** subkey that you created step 3.
    2. On the **Edit** menu, point to **New**, and then click **Key**.
    3. Type 0 (zero), and then press ENTER.

5. Click the **0** subkey that you created in step 4.
6. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
7. In the **Value data** box, type *ProtocolType*, and then click **OK**.
8. On the **Edit** menu, click **Modify**.
9. In the **Value data** box, type *800*, make sure **Hexadecimal** is selected under **Base**, and then click **OK**.
10. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
11. Type *PPPProtocolType*, and then press ENTER.
12. On the **Edit** menu, click **Modify**.
13. In the **Value data** box, type *21*, make sure **Hexadecimal** is selected under **Base**, and then click **OK**.
14. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
15. Type *ProtocolMTU*, and then press ENTER.
16. On the **Edit** menu, click **Modify**.
17. Under **Base**, click **Decimal**, type the MTU size that you want in the **Value data** box, and then click **OK**.
18. Quit Registry Editor.
19. Restart your computer.

## Change the MTU settings for VPN connections

To change the MTU settings for VPN connections, add the **ProtocolType** DWORD value, the **PPPProtocolType** DWORD value, and the **TunnelMTU** DWORD value to the following registry key:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Ndiswan\Parameters\Protocols\0`

To do so, follow these steps.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Click **Start**, click **Run**, type *regedit* in the **Open** box, and then click **OK**.
2. Locate and then click the following subkey in the registry:  
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NdisWan\Parameters`

3. Add a **Protocols** subkey (if it does not already exist):
    1. On the **Edit** menu, point to **New**, and then click **Key**.
    2. Type *Protocols*, and then press ENTER.

4. Add a **0** (zero) subkey to the **Protocols** subkey:
    1. Click the **Protocols** sub key that you created in step 3.
    2. On the **Edit** menu, point to **New**, and then click **Key**.
    3. Type *0* (zero), and then press ENTER.

5. Click the **0** subkey that you created in step 4.
6. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
7. In the **Value data** box, type *ProtocolType*, and then click **OK**.
8. On the **Edit** menu, click **Modify**.
9. In the **Value data** box, type *800*, make sure **Hexadecimal** is selected under **Base**, and then click **OK**.
10. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
11. Type *PPPProtocolType*, and then press ENTER.
12. On the **Edit** menu, click **Modify**.
13. In the **Value data** box, type *21*, make sure **Hexadecimal** is selected under **Base**, and then click **OK**.
14. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
15. Type *TunnelMTU*, and then press ENTER.
16. On the **Edit** menu, click **Modify**.
17. Under **Base**, click **Decimal**, type the MTU size that you want in the **Value data** box, and then click **OK**.
18. Quit Registry Editor.
19. Restart your computer.

## References

For more information about PPP, see Request for Comments (RFC) 1548. To do so, see [RFC 1548](https://www.ietf.org/rfc/rfc1548.txt?number=1548).
