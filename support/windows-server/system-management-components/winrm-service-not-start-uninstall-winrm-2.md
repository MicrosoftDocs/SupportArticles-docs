---
title: WinRM service does not start
description: Describes the issue in which the Windows Remote Manager service doesn't start after you uninstall WinRM 2.0.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:winrm, csstroubleshoot
ms.technology: windows-server-system-management-components
---
# The Windows Remote Manager (WinRM) service doesn't start after you uninstall WinRM 2.0  

This article provides a resolution for the issue that Windows Remote Manager (WinRM) service doesn't start after you uninstall WinRM 2.0.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 974504

## Symptoms

You uninstall Windows Remote Manager 2.0 (WinRM) from a computer that is running Windows Server 2008 or Windows Vista. When you try to start the WinRM service by using the net start winrm command, the WinRM service doesn't start, and you receive an "Access Denied" error.

## Cause

This issue occurs when you uninstall WinRM 2.0, and there was an existing WinRM listener on port 5985.

## Resolution

To resolve this issue, use one of the following methods.

### Restore the WinRM configuration

To restore the WinRM configuration to its default state, follow these steps:

1. Open a Command Prompt window.

2. At the command prompt, type the following command, and then press ENTER:

   ```console  
   winrm quickconfig  
   ```

### Delete the WinRM listener on port 5985

1. Open a Command Prompt window.

2. At the command prompt, type the following command, and then press ENTER:  

   ```console
   winrm enumerate winrm/config/listener  
   ```  

   It enumerates all listeners that WinRM currently uses.

3. Locate the listener that has the following parameters and values:
   - Port=5985
   - Transport=HTTP
4. Note the value that is listed for the listener's **Address** parameter.

5. Type the following command, and then press ENTER:  
winrm delete winrm/config/Listener?Address= **Address** +Transport=HTTP  
In this command, the **Address** placeholder is the value that you noted in step 4.
