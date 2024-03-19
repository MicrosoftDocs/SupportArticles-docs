---
title: Delete temporary and permanent SharePoint data
description: Introduces how to delete temporary and permanent data in SharePoint Workspace 2010.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: clake, fselkirk, patrigan, v-chsu
ms.custom: 
  - sap:Administration\Other
  - CSSTroubleshoot
  - CI 110761
appliesto: 
  - SharePoint Workspace 2010
ms.date: 12/17/2023
---

# How to delete temporary and permanent data in SharePoint Workspace 2010

## Introduction

This article describes how to delete temporary and permanent SharePoint Workspace data by using the Groove.exe command. In Microsoft Office SharePoint Workspace 2010, the Groove.exe command has switches that replace the GrooveClean.exe command. The GrooveClean.exe command is included in earlier versions of Groove.

## More information

The Groove.exe command is included in SharePoint Workspace 2010. This command has options to delete temporary and permanent SharePoint Workspace data.

### How to delete temporary SharePoint Workspace data

To delete temporary SharePoint Workspace data, follow these steps:
1. Exit SharePoint Workspace.
1. After SharePoint Workspace is closed, open a command prompt, type the following command, and then press ENTER:
    - On a 32-bit Windows platform:

       %SystemDrive%\Program Files\Microsoft Office\Office14\Groove.exe /clean

    - On a 64-bit Windows platform:

       %SystemDrive%\Program Files (x86)\Microsoft Office\Office14\Groove.exe /clean

> [!NOTE]
> This command deletes the following temporary data:
> - The transmit and receive buffer files.
> - The cached diagnostic information.
> - All associated log files.

You may lose some transient information by deleting the buffer files. In particular, instant messages that have not yet been sent or that were received but not processed will be lost. However, the transport mechanisms for Groove workspaces and Shared Folders should recover changes that you made, even if the changes have not yet been transmitted. Therefore, it is generally safe to run the Groove.exe together with the /clean switch.

**Note** Network activity may increase temporarily while changes are made.

### How to delete permanent SharePoint Workspace data

Sometimes, you may have to delete permanent data, such as your account file. To do this, run Groove.exe together with the /clean switch and the /all switch. When you add the /all switch, all SharePoint Workspace accounts, Groove workspaces, and temporary data are deleted.

To delete permanent SharePoint Workspace data, follow these steps:
1. Exit SharePoint Workspace.
1. After SharePoint Workspace is closed, open a command prompt, type the following command, and then press ENTER:

    - On a 32-bit Windows platform:
    
       %SystemDrive%\Program Files\Microsoft Office\Office14\Groove.exe /clean /all

    - On a 64-bit Windows platform:

       %SystemDrive%\Program Files (x86)\Microsoft Office\Office14\Groove.exe /clean /all

> [!NOTE]
> This command deletes the following data:
> - Your local SharePoint Workspace account.
> - The local SharePoint Workspace message history. This includes all message content.
> - All SharePoint Workspace contact information.
> - All Groove workspaces and any data that workspaces contain.
> - The synchronization information for all Shared Folders. The files are not deleted from the Windows folder.
> - The synchronization information for all SharePoint workspaces. Local copies of SharePoint workspace files are deleted from the Office Document Cache.
> - The transmit and receive buffer files.
> - The cached diagnostic information.
> - All associated log files.

> [!IMPORTANT]
> When you run Groove.exe together with the /clean switch and the /all switch, all SharePoint Workspace account data and most file data are deleted. In this case, you cannot use SharePoint Workspace until you create a new account or import a previously saved account. If you create a new account, it will not have the same identity and will not belong to any workspaces. This occurs even if you use all the same information when you create the account. If you create a new account, distribute your new identity to all SharePoint Workspace contacts so that you can be re-invited to workspaces.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
