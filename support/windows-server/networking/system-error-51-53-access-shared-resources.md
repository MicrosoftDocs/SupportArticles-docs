---
title: Error 51 or 53 when you access shared resources
description: Provides a solution to system error 51 or 53 that occurs when you access shared resources.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-access, csstroubleshoot
---
# Error when you try to access shared resources on a computer: System error 53 has occurred or System error 51 has occurred

This article provides a solution to system error 51 or 53 that occurs when you access shared resources.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 259878

## Symptoms

When you try to access shared resources on a computer that is running Microsoft Windows 2000 or Microsoft Windows Server 2003, you may receive one of the following error messages:

- Message 1

    > System error 53 has occurred. The network path was not found.

- Message 2

    > System error 51 has occurred. The remote computer is not available.

When you try to view the properties of a Windows 2000 client on a domain controller that is running Microsoft Windows NT 4.0, you receive the following error in Server Manager:

> The remote computer is not available. net use * \\**server**\ **share**  
System error 53 has occurred. The network path was not found. Start, run \\**Server**\ **share**  

You cannot see any networks in Network Neighborhood.

For example, this problem may occur if you use the net view command or the net use command.

## Cause

This problem may occur if File and Printer Sharing for Microsoft Networks is disabled or is not installed.

## Resolution

To resolve this problem, make sure File and Printer Sharing for Microsoft Networks is enabled. To do this, follow these steps:

1. Log on to the computer by using administrative credentials.
2. Double-click **My Computer**, double-click **Control Panel**, and then double-click **Network and Dial-Up Connections**.
3. Double-click the network connection you want to modify, and then click **Properties**.
4. On the **General** tab in the **Components checked are used by this connection** area, locate File and Printer Sharing for Microsoft Networks. If it is not listed, install it by clicking the **Install** button and then double-clicking **Service**.
5. Make sure that the check box next to **File and Printer Sharing for Microsoft Networks** is selected. This setting makes shared resources available on the network.

## More information

File and Printer Sharing for Microsoft Networks is equivalent to the Microsoft Windows NT 4.0 Server service. If you do not want to share resources on a connection, disable this option in the properties of the connection. Windows 2000 Active Directory requires that File and Printer Sharing for Microsoft Networks is enabled on domain controllers for fundamental tasks such as propagation of the SYSVOL share by using the File Replication Service.
