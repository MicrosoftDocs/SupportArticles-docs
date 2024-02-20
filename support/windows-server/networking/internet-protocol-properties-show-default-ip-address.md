---
title: TCP/IP Properties dialog box displays the default IP address
description: Describes a problem in which the TCP/IP properties revert to the default settings after you manually configure a static IP address in Windows Server.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# The Internet Protocol (TCP/IP) Properties dialog box displays the default IP address settings after you manually configure a static IP address in Windows Server

This article describes a problem in which the TCP/IP properties revert to the default settings after you manually configure a static IP address.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 937056

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[256986](https://support.microsoft.com/help/256986) Description of the Microsoft Windows registry  

## Symptoms

In Windows Server, you manually configure the TCP/IP properties to add a static IP address. After you do this, the **Internet Protocol (TCP/IP) Properties** dialog box still displays the default settings. Additionally, the **Obtain IP address automatically** option is selected.

However, when you type `ipconfig /all` at a command prompt, the static IP address information that you entered manually is displayed.

## Resolution

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.  

To resolve this problem, follow these steps:  

1. Download and then install the latest version of the network adapter driver on the computer.

2. Click **Start**, click **Run**, type regedit, and then click **OK**.
3. Locate and then delete the following registry subkey:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Network\Config`  
4. If your server is a domain controller, go to step 5. (This includes servers that are running Windows Small Business Server 2003.) If your server is not a domain controller, delete the following registry subkeys:
     `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\ {GUID}`  
     `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{GUID}`  
5. Click **Start**, click **Run**, type `sysdm.cpl`, and then click **OK**.
6. In the **Systems Properties** dialog box, click the **Hardware** tab, and then click **Device Manager**.
7. In Device Manager, expand **Network adapters**, right-click the network adapter that you want, and then click **Uninstall**.
8. Restart the computer.

After the computer restarts, the operating system automatically detects the network adapter. If the network adapter isn't detected, you may have to manually reinstall the network adapter drivers.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
