---
title: HOW TO: Change the Default Maximum Transmission Unit (MTU) Size Settings for PPP Connections or for VPN Connections
description: 
ms.date: 12/03/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: tode
---
# HOW TO: Change the Default Maximum Transmission Unit (MTU) Size Settings for PPP Connections or for VPN Connections

_Original product version:_ &nbsp; Microsoft Windows Server 2003 Enterprise Edition (32-bit x86), Microsoft Windows XP Professional  
_Original KB number:_ &nbsp; 826159

### IN THIS TASK


- [SUMMARY](#SUMMARY) 
- [Change the MTU Settings for PPP Connections](#Change-the-MTU-Settings-for-PPP-Connections) 
- [Change the MTU Settings for VPN Connections](#Change-the-MTU-Settings-for-VPN-Connections) 
- [REFERENCES](#REFERENCES)  

## Summary

This step-by-step article describes how to edit the registry to change the default maximum transmission unit (MTU) size settings for Point-to-Point Protocol (PPP) connections or for virtual private network (VPN) connections.

Microsoft Windows Server 2003, Microsoft Windows 2000, and Microsoft Windows XP use a fixed MTU size of 1500 bytes for all PPP connections and use a fixed MTU size of 1400 bytes for all VPN connections. This is the default setting for PPP clients, for VPN clients, for PPP servers, or for VPN servers that are running Routing and Remote Access.

PPP connections are connections such as modem connections, Integrated Services Digital Network (ISDN) connections, or direct cable connections over null serial cable or over parallel cable. VPN connections are Point-to-Point Tunneling Protocol (PPTP) connections or Layer 2 Tunneling Protocol (L2TP) connections.

> [!NOTE]
> Use the methods in this article to edit the registry to modify the MTU size settings. If you experience any problems or any performance-related issues after you modify the MTU size settings, remove the registry keys that you added.

[back to the top](#back-to-the-top) 

### Change the MTU Settings for PPP Connections

To have us the MTU Settings for PPP Connections for you, go to the "[Here's an easy fix](#fixitformealways)" section. If you prefer to fix this problem manually, go to the "[Let me fix it myself](#letmefixitmyselfalways)" section.

### Here's an easy fix

To fix this problem automatically, click the **Download** button. In the **File Download** dialog box, click **Run** or **Open**, and then follow the steps in the easy fix wizard.
- Type the desired MTU size between 1  and 1500  when asked during the installation process.
- This wizard may be in English only. However, the automatic fix also works for other language versions of Windows.
- If you're not on the computer that has the problem, save the easy fix solution to a flash drive or a CD, and then run it on the computer that has the problem.

##### Change the MTU Settings for PPP Connections

#### Let me fix it myself

*Easy fix 50613*  

To change the MTU settings for PPP connections, add the **ProtocolType** DWORD value, the **PPPProtocolType** DWORD value, and the **ProtocolMTU** DWORD value to the following registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Ndiswan\Parameters\Protocols\0` 
To do so, follow these steps.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

1. Click **Start**, click **Run**, type regedit in the **Open** box, and then click **OK**.
2. Locate and then click the following subkey in the registry:
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NdisWan\Parameters` 

3. Add a **Protocols** subkey (if it does not already exist). To do so:
  1. On the **Edit** menu, point to **New**, and then click **Key**.

2. Type Protocols , and then press ENTER.
4. Add a **0** (zero) subkey to the **Protocols** subkey. To do so:
  1. Click the **Protocols** subkey that you created step 3.
  2. On the **Edit** menu, point to **New**, and then click **Key**.

3. Type 0 (zero), and then press ENTER.
5. Click the **0** subkey that you created in step 4.
6. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
7. In the **Value data** box, type ProtocolType , and then click **OK**.
8. On the **Edit** menu, click **Modify**.
9. In the **Value data** box, type 800 , make sure **Hexadecimal** is selected under **Base**, and then click **OK**.
10. On the **Edit** menu, point to **New**, and then click **DWORD Value**.

11. Type PPPProtocolType , and then press ENTER.
12. On the **Edit** menu, click **Modify**.
13. In the **Value data** box, type 21 , make sure **Hexadecimal** is selected under **Base**, and then click **OK**.
14. On the **Edit** menu, point to **New**, and then click **DWORD Value**.

15. Type ProtocolMTU , and then press ENTER.

16. On the **Edit** menu, click **Modify**.
17. Under **Base**, click **Decimal**, type the MTU size that you want in the **Value data** box, and then click **OK**.
18. Quit Registry Editor.
19. Restart your computer. [back to the top](#back-to-the-top) 

### Change the MTU Settings for VPN Connections

To have us change the MTU Settings for VPN Connections for you, go to the "[Here's an easy fix](#fixitformealways)" section. If you prefer to fix this problem manually, go to the "[Let me fix it myself](#letmefixitmyselfalways)" section.

### Here's an easy fix

To fix this problem automatically, click the **Download** button. In the **File Download** dialog box, click **Run** or **Open**, and then follow the steps in the easy fix wizard.
- Type the desired MTU size between 1  and 1500 when asked during the installation process.
- This wizard may be in English only. However, the automatic fix also works for other language versions of Windows.
- If you're not on the computer that has the problem, save the easy fix solution to a flash drive or a CD, and then run it on the computer that has the problem.

#### Let me fix it myself

*Easy fix 50614*  

To change the MTU settings for VPN connections, add the **ProtocolType** DWORD value, the **PPPProtocolType** DWORD value, and the **TunnelMTU** DWORD value to the following registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Ndiswan\Parameters\Protocols\0` 
To do so, follow these steps.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

1. Click **Start**, click **Run**, type regedit in the **Open** box, and then click **OK**.
2. Locate and then click the following subkey in the registry:
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NdisWan\Parameters` 

3. Add a **Protocols** subkey (if it does not already exist). To do so:
  1. On the **Edit** menu, point to **New**, and then click **Key**.

2. Type Protocols , and then press ENTER.
4. Add a **0** (zero) subkey to the **Protocols** subkey. To do so:
  1. Click the **Protocols** sub key that you created in step 3.
  2. On the **Edit** menu, point to **New**, and then click **Key**.

3. Type 0 (zero), and then press ENTER.
5. Click the **0** subkey that you created in step 4.
6. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
7. In the **Value data** box, type ProtocolType , and then click **OK**.
8. On the **Edit** menu, click **Modify**.
9. In the **Value data** box, type 800 , make sure **Hexadecimal** is selected under **Base**, and then click **OK**.
10. On the **Edit** menu, point to **New**, and then click **DWORD Value**.

11. Type PPPProtocolType , and then press ENTER.
12. On the **Edit** menu, click **Modify**.
13. In the **Value data** box, type 21 , make sure **Hexadecimal** is selected under **Base**, and then click **OK**.
14. On the **Edit** menu, point to **New**, and then click **DWORD Value**.

15. Type TunnelMTU , and then press ENTER.

16. On the **Edit** menu, click **Modify**.
17. Under **Base**, click **Decimal**, type the MTU size that you want in the **Value data** box, and then click **OK**.
18. Quit Registry Editor.
19. Restart your computer. [back to the top](#back-to-the-top) 

#### Did this fix the problem?

Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](/contactus).

## References

For additional information about MTU size in Microsoft Windows NT 4.0, click the following article number to view the article in the Microsoft Knowledge Base:

[183229](https://support.microsoft.com/help/183229) RAS Uses Fixed TCP/IP MTU Size  

For more information about PPP, see Request for Comments (RFC) 1548. To do so, visit the following Internet Engineering Task Force (IETF) Web site: [http://www.ietf.org/rfc/rfc1548.txt?number=1548](http://www.ietf.org/rfc/rfc1548.txt?number=1548) 
 [back to the top](#back-to-the-top)
