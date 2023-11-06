---
title: Import failed when moving content with the Dynamics 365 Guides Content Migration Tool
description: Resolves the failure when migrating from Dynamics 365 Guides using the Content Migration Tool (Public Preview).
ms.author: brunasi
author: brunasilvalopes
ms.service: dynamics-365-guides
ms.date: 10/27/2023
ms.reviewer: v-wendysmith, mhart
ms.custom: bap-template 
---
# "Failed to import" error when migrating content with the Dynamics 365 Guides Content Migration Tool (Public Preview)

This article provides a resolution for an import failure with the Content Migration Tool (Public Preview) for Microsoft Dynamics 365 Guides.

## Symptoms

When you run the [Content Migration Tool (Public Preview)](https://aka.ms/ContentMigrationTool) script for Dynamics 365 Guides, you recieve the following error message:

> Failed to import Microsoft.Xrm.Data.Powershell.

## Resolution

Before running the PowerShell script, unblock the *.zip* folder that contains the Content Migration Tool (Public Preview).

1. Download the [Content Migration Tool](https://aka.ms/ContentMigrationTool). The *.zip* folder is downloaded to your *Downloads* folder.

1. In Windows File Explorer, select the *.zip* folder, right-click and then select **Properties**.

1. In the **Properties** dialog box, on the **General** tab, select the **Unblock** check box, and then select **Apply**.

   :::image type="content" source="media/failed-to-import-microsoft-xrm-data-powershell/migration-unblock.png" alt-text="Screenshot that shows the Unblock check box and the Apply button.":::

1. Extract the contents and run the script. For more information, see [Migrate Dynamics 365 Guides content from one Microsoft Dataverse instance to another using the Content Migration Tool](/dynamics365/mixed-reality/guides/migrate).
