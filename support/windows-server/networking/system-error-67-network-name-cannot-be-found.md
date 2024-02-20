---
title: System error 67 has occurred
description: Helps to fix the error message "System error 67 has occurred. The network name cannot be found".
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# You receive a "System error 67 has occurred. The network name cannot be found" error message  

This article helps to fix the error message "System error 67 has occurred. The network name cannot be found".  

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 843156

## Symptoms

If you try to log on to a computer by using your domain account, the domain controller stops responding. Additionally, you cannot access your folder by using the universal naming convention (UNC) network path, and you receive the following error message:  
>System error 67 has occurred. The network name cannot be found

## Cause

This issue occurs if one of the following conditions is true:  

- The network components on the domain controller are not configured correctly.
- You did not update the network drivers on the domain controller or the drivers don't work with Microsoft Windows Server 2003.

## Resolution

To resolve this issue, use either of the following methods.

### Method 1

Update the network adaptor driver on the domain controller.

> [!NOTE]
> Make sure that you use a network adaptor driver that works with the operating system that you are using.

### Method 2

If Network Address Translator (NAT) is installed but is not configured correctly, disable the Internet Protocol (IP) NAT driver, and then restart the computer. You can follow these steps:  

1. Click **Start**, right-click **My Computer**, and then click **Properties**.
2. On the **Hardware** tab, click
 **Device Manager**.
3. On the **View** menu, click **Show hidden devices**.
4. Expand **Non-Plug and Play Drivers**, right-click **IP Network Address Translator**, and then click **Disable**.
5. Click **Yes** two times to restart the computer.

## Workaround

To work around this issue, restart the Distributed File System service on the domain controller.
