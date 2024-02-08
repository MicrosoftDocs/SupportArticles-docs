---
title: Errors connecting to Device Manager remotely
description: Fixes an issue where you can't connect remotely to Device Manager from a Windows-based computer.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:microsoft-management-console-mmc, csstroubleshoot
---
# Errors connecting to Windows Server 2008 R2 or Windows Server 2012 Device Manager remotely

This article helps fix an issue where you can't connect remotely to Device Manager from a Windows-based computer.  

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1, Window 10 – all editions  
_Original KB number:_ &nbsp; 2781106

## Symptoms

Consider the following scenario:  

- You're unable to connect remotely to Windows Server 2012 Device Manager from a Windows 8-based computer.
- You're unable to connect remotely to Windows Server 2012 Device Manager from a Windows 7-based computer.
- You're unable to connect remotely to Windows Server 2008 R2 Device Manager from a Windows 8-based computer.
- You're unable to connect remotely to Windows 8 Device Manager from a Windows 7-based computer.

Additionally, you may receive an error message that is similar to the following:

> Unable to access the computer \<computername>  
Make sure that this computer is on the network, has remote administration enabled, and is running the "Plug and Play" and "Remote Registry" services  
>
> The error was: Access is denied  

> [!Note]
> Other various errors may occur depending on if you're connecting from Windows 8 or Windows 7 client computer.

## Cause

This problem occurs because Remote access to the Plug and Play (PNP) RPC interface has been removed in Windows 8 and Windows Server 2012.

## Resolution

You must log in to the computer locally to use Device Manager.

## More information

Previously, a Windows 7-based computer could connect to a Windows Server 2008 R2 computer. Access to Device Manager on a remote computer is "read-only." You can't make any changes to devices or their settings.

To open Device Manager on a remote computer:  

1. Open Computer Management (compmgmt.msc).
2. On the Action menu, click Connect to another computer.
3. In the Select Computer dialog box, do one of the following:
   - In the Another computer text box, type the name of the computer to access, and then click OK.
   - Click Browse, and then click Advanced to find the computer you want. Click OK when you've selected the correct computer.

If the connection is successful, the name of the computer appears in parentheses next to the Computer Management label in the upper left.
