---
title: Dynamics needs a shared directory to store your OLE notes error when you click the Note icon in Microsoft Dynamics GP
description: Fixes an issue in which you receive an error when you click the Note icon.
ms.reviewer: theley, kyouells, sarahcud
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "Dynamics needs a shared directory to store your OLE notes" error message when you click the Note icon in Microsoft Dynamics GP

This article helps fix the **Dynamics needs a shared directory to store your OLE notes** error that occurs when you click the **Note** icon in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 873845

## Symptoms

When you click the **Note** icon in Microsoft Dynamics GP, you receive the following error message:
> Dynamics needs a shared directory to store your OLE notes. Enter a path to a directory that all workstations can access, (for example, F:\Dynamics\\).

## Cause

This problem occurs because the OLE path is invalid in the Dex.ini file. The Dex.ini file is located in the Dynamics folder on each workstation.

## Resolution 1: Open the Dex.ini file and update the path manually

1. Locate the Dex.ini file. By default, the Dex.ini file is located in the following folder:
    *C:\Program Files\Microsoft Dynamics\GP\Data*
1. Double-click the Dex.ini file to open it. By default, the Dex.ini file is open in Notepad.
1. Type a valid OLEPath. For example, *OLEPath=F:\Dynamics\\*.
    > [!NOTE]
    > Universal Naming Convention (UNC) pathnames aren't recognized as a valid path for OLE notes.
1. Save changes.

## Resolution 2: Use the Browse Folder function in the OLE Pathname window to select the path

In the OLE Pathname window, use the Browse Folder function to select the path that the Dex.ini file is saved. For example, *F:\Dynamics\\*.

> [!NOTE]
>
> - The Dex.ini file will be automatically updated.
> - Universal Naming Convention (UNC) pathnames are not recognized as a valid path for OLE notes.
