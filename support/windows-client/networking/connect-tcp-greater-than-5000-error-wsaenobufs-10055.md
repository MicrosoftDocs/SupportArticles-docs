---
title: error WSAENOBUFS (10055)
description: Describes how to resolve a problem that returns an error when you try to set up a connection on a TCP port greater than 5000.
ms.date: 09/27/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, dsmith
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
#  You receive the error 'WSAENOBUFS (10055)' when you try to connect from TCP ports greater than 5000

This article helps to fix the error 'WSAENOBUFS (10055)' when you try to connect from TCP ports greater than 5000.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 196271

## Symptoms

If you try to set up TCP connections from ports that are greater than 5000, the local computer responds with the following WSAENOBUFS (10055) error message:  
>An operation on a socket could not be performed because the system lacked sufficient buffer space or because a queue was full.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

The default maximum number of ephemeral TCP ports is 5000 in the products that are included in the "Applies to" section. A new parameter has been added in these products. To increase the maximum number of ephemeral ports, follow these steps:

1. Start Registry Editor.

2. Locate the following subkey in the registry, and then click **Parameters:

   HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters

3. On the **Edit** menu, click **New**, and then add the following registry entry:  
Value Name: MaxUserPort  
Value Type: DWORD
Value data: 65534
Valid Range: 5000-65534 (decimal)
Default: 0x1388 (5000 decimal)
Description: This parameter controls the maximum port number that is used when a program requests any available user port from the system. Typically, ephemeral (short-lived) ports are allocated between the values of 1024 and 5000 inclusive. After the release of security bulletin MS08-037, the behavior of Windows Server 2003 was changed to more closely match that of Windows Server 2008 and Windows Vista. For more information about Microsoft security bulletin MS08-037, click the following article numbers to view the articles in the Microsoft Knowledge Base:

   [951746](https://support.microsoft.com/help/951746) MS08-037: Description of the security update for DNS in Windows Server 2008, in Windows Server 2003, and in Windows 2000 Server (DNS server-side): July 8, 2008  

   [951748](https://support.microsoft.com/help/951748) MS08-037: Description of the security update for DNS in Windows Server 2003, in Windows XP, and in Windows 2000 Server (client side): July 8, 2008  

   [953230](https://support.microsoft.com/help/953230) MS08-037: Vulnerabilities in DNS could allow spoofing  

4. Exit Registry Editor, and then restart the computer.

   > [!NOTE]
   > An additional TCPTimedWaitDelay registry parameter determines how long a closed port waits until the closed port can be reused.

## More information

For more information about a related topic, visit the following Microsoft Web site:

[https://technet.microsoft.com/library/bb726981.aspx](https://technet.microsoft.com/library/bb726981.aspx)  
 For more information about a related topic, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[314053](https://support.microsoft.com/help/314053) TCP/IP and NBT configuration parameters for Windows XP  

### Technical support for x64-based versions of Microsoft Windows

If your hardware came with a Microsoft Windows x64 edition already installed, your hardware manufacturer provides technical support and assistance for the Windows x64 edition. In this case, your hardware manufacturer provides support because a Windows x64 edition was included with your hardware. Your hardware manufacturer might have customized the Windows x64 edition installation by using unique components. Unique components might include specific device drivers or might include optional settings to maximize the performance of the hardware. Microsoft will provide reasonable-effort assistance if you must have technical help with a Windows x64 edition. However, you might have to contact your manufacturer directly. Your manufacturer is best qualified to support the software that your manufacturer installed on the hardware. If you purchased a Windows x64 edition such as a Windows Server 2003 x64 edition separately, contact Microsoft for technical support.
