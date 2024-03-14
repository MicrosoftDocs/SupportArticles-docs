---
title: Remove named printers from the current installation in Microsoft Dynamics GP
description: How to remove named printers from the current installation in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# How to remove named printers from the current installation in Microsoft Dynamics GP

This article describes how to remove named printers from the current installation in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains. After you remove named printers from the current installation, named printers are no longer used for the default printer setup.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 862712

To remove named printers from the current installation, follow these steps:

1. Open the Dex.ini file in a text editor. Notepad and WordPad are text editors.

    > [!NOTE]
    >
    > - By default in Microsoft Dynamics GP 10.0, the Dex.ini file is located in the Data subfolder of the Microsoft Dynamics GP application directory.
    > - By default in Microsoft Dynamics GP 9.0 and in earlier versions, the Dex.ini file is located in the Microsoft Dynamics GP application directory.

2. In the Dex.ini file, remove any lines that begin with the following text:

    ST_

    For more information about which "ST_" lines are possible, see [Machine ID and shortcut information for named printers](https://support.microsoft.com/topic/machine-id-and-shortcut-information-for-named-printers-edf2f58b-2e1d-817e-f904-7827e84f56c3).

3. Save the changes to the Dex.ini file.
4. Close the Dex.ini file. Named printers should no longer be used for the default printer setup.
