---
title: Remotely edit the registry
description: Describes how to remotely edit the registry of a client computer from a host computer after you use Remote Recover to connect the host computer to the client computer.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:microsoft-management-console-mmc, csstroubleshoot
ms.subservice: system-mgmt-components
---
# How to remotely edit the registry of a client computer from a host computer after you use Remote Recover to connect the host computer to the client computer

This article describes how to remotely edit the registry of a client computer from a host computer after you use Remote Recover to connect the host computer to the client computer.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 934958

## Introduction

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Windows registry information for advanced users](https://support.microsoft.com/help/256986).

> [!NOTE]
> Remote Recover is a component of Winternals Administrator's Pak.

## More information

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft can't guarantee that these problems can be solved. Modify the registry at your own risk.

> [!NOTE]
> To remotely edit the registry of a client computer, the following conditions must be true for the client computer and for the host computer:
>
> - The computers must run the same operating system.
> - The computers must have the same service pack installed.

To remotely edit the registry of a client computer from a host computer, follow these steps:

1. On the host computer, start Registry Editor.
2. Locate the following subtree, and then select it:  
   **HKEY_LOCAL_MACHINE**  
3. On the **File** menu, select **Load Hive**.
4. Locate and then select the registry hive on the client computer that you want to edit.

    > [!NOTE]
    > The registry hive is located in the `%Windir%\System32\Config` folder as one of the following files:
    >
    > - SAM represents the Sam hive.
    > - SECURITY represents the Security hive.
    > - SOFTWARE represents the Software hive.
    > - SYSTEM represents the System hive.

5. Select **Open**.
6. In the **Load Hive** dialog box, type a name in the **Key Name** box for the registry hive that you want to edit.
7. Edit the registry keys.
    > [!NOTE]
    > In step 7, you can edit the registry keys because they're now part of the registry of the host computer.
