---
title: Disable Media Sensing feature for TCP/IP
description: Describes how to control the Media Sensing feature.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# How to disable the Media Sensing feature for TCP/IP in Windows

This article describes how to control the Media Sensing feature for TCP/IP.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 239924

## Summary

On a Windows-based computer that uses TCP/IP, you can use the Media Sensing feature to detect whether the network media are in a link state. Ethernet network adapters and hubs typically have a "link" light that indicates the connection status. This status is the same condition that Windows interprets as a link state. Whenever Windows detects a "down" state, it removes the bound protocols from that adapter until it is detected as "up" again. Sometimes, you may not want the network adapter to detect this state. You can set this configuration by modifying the registry.

> [!NOTE]
> 10B2 coaxial (RG-58) Ethernet cable is not a connection-based medium. Therefore, Windows does not try to detect a link state when this kind of cabling is used.

## More information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To prevent the network adapter from detecting a link state, follow these steps.

> [!NOTE]
> The NetBEUI protocol and the IPX protocol do not support Media Sensing.  

1. Start Registry Editor.
2. Locate the following registry subkey:
 `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters`  

3. Add the following registry entry to the **Parameters** subkey:

    Name: DisableDHCPMediaSense  
    Data type: REG_DWORD (Boolean)  
    Value: 1
    > [!NOTE]
    > This entry controls the behavior of Media Sensing. By default, Media Sensing events trigger a DHCP client to take an action. For example, when a connect event occurs, the client tries to obtain a lease. When a disconnect event occurs, the client may invalidate the interface and routes. If you set this value data to 1, DHCP clients and non-DHCP clients ignore Media Sensing events.
4. Restart the computer.

    > [!NOTE]
    > Microsoft Windows Server 2003 supports Media Sensing when it is used in a server cluster environment. By default, however, Media Sensing is disabled in a Windows Server 2003-based server cluster, and the DisableDHCPMediaSense registry entry has no effect. In Windows Server 2003 Service Pack 1 (SP1), the DisableClusSvcMediaSense registry entry was introduced. You can use this registry entry to enable Media Sensing on the Windows Server 2003-based nodes of a server cluster. The details of the DisableClusSvcMediaSense registry entry are as follows:
    >
    >Key: HKEY_LOCAL_MACHINE\Cluster\Parameters  
    Name: DisableClusSvcMediaSense  
    Data type: REG_DWORD (Boolean)  
    Default value: 0  
    By default, the DisableClusSvcMediaSense entry is set to 0. When this entry is set to 0, Media Sensing is disabled. If you set the DisableClusSvcMediaSense entry to 1, you can use the DisableDHCPMediaSense entry to enable Media Sensing. This behavior matches the behavior of a Microsoft Windows 2000 Server cluster environment.
