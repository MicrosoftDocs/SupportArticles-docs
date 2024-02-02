---
title: Error message when you try to install a network printer in Windows 7
description: Provides a workaround to an error that occurs when you try to install a network printer in Windows 7.
ms.date: 05/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:management-and-configuration-installing-print-drivers, csstroubleshoot
---
# Error message when you try to install a network printer in Windows 7: "0x0000052e"

This article provides a workaround to an error "0x0000052e" that occurs when you try to install a network printer in Windows 7.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2269296

## Symptoms

When you try to install a network printer on a computer that is running Windows 7, you receive the following error message:
> Windows cannot connect to the printer (details: Operation failed with error 0x0000052e)

## Cause

This problem can occur if the credentials on the Windows 7 client do not match the credentials that are stored on the print server. Error message "0x0000052e" indicates the following error:
> "Logon failure: unknown user name or bad password."

## Workaround

To work around this problem, use either of the following methods.

### Workaround 1

Before you add the network printer, open a **Command Prompt** window, and type the following at the **Command Prompt**:

```console
start \\<servername>\<printername>
```

> [!NOTE]
> In this command, \<servername> represents the name of the print server and \<printername> represents the share name of the printer.

In the authentication window, enter the appropriate credentials.

### Workaround 2

Store a trusted credential in **Credential Manager**. To do this, follow these steps:

1. In **Control Panel**, open **Credential Manager**.
2. Click **Add a Windows credential**.
3. In the dialog box, enter an appropriate print server name. Then, enter a user name and password that are trusted on the print server.
4. Click **OK**.

## More Information

This behavior is different in earlier Windows versions. In those versions, you are prompted for credentials if the connection fails because of an unknown user name or a bad password.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
