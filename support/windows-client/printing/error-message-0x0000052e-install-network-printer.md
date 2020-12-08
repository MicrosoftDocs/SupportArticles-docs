---
title: Error message when you try to install a network printer in Windows 7: 
description: Describes that you receive a .
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Error message when you try to install a network printer in Windows 7: "0x0000052e"

_Original product version:_ &nbsp;   
_Original KB number:_ &nbsp; 2269296

## Symptoms

When you try to install a network printer on a computer that is running Windows 7, you receive the following error message:

Windows cannot connect to the printer (details: Operation failed with error 0x0000052e) 

## Cause

This problem can occur if the credentials on the Windows 7 client do not match the credentials that are stored on the print server. Error message "0x0000052e" indicates the following error: "Logon failure: unknown user name or bad password."

## Workaround

To work around this problem, use either of the following methods.

### Workaround 1

Before you add the network printer, open a Command Prompt window, and type the following at the command prompt: start \\<servername>\<printername> 
> [!NOTE]
>  In this command, <servername> represents the name of the print server and <printername> represents the share name of the printer.

In the authentication window, enter the appropriate credentials.

### Workaround 2

Store a trusted credential in Credential Manager . To do this, follow these steps: 

1. In Control Panel , open Credential Manager .
2. Click **Add a Windows credential** a. 
** 3. In the dialog box, enter an appropriate print server name. Then, enter a user name and password that are trusted on the print server.
4. Click **OK**.

## More Information

This behavior is different in earlier Windows versions. In those versions, you are prompted for credentials if the connection fails because of an unknown user name or a bad password.
