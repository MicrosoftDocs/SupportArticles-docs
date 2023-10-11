---
author: brunasilvalopes
description: Troubleshooting failures when migrating from Dynamics 365 Guides using the Content Migration Tool (Preview)
ms.author: brunasi
ms.service: dynamics-365-guides
ms.date: 01/11/2023
ms.topic: troubleshooting
title: Import failed when moving content with the Dynamics 365 Guides Content Migration Tool
ms.reviewer: v-wendysmith
ms.custom: bap-template 
---

# Import failed when moving content with the Dynamics 365 Guides Content Migration Tool

## Symptom

The error "Failed to import Microsoft.Xrm.Data.Powershell" displays when running the Guides Content Migration Tool script.

## Resolution

Before running the PowerShell script, unblock the *zipped* folder containing the Guides Content Migration Tool.

1. Download the [Guides Content Migration Tool](https://aka.ms/guidesmigration). The zipped folder is downloaded to your downloads folder.

1. In Windows File Explorer, select the zipped folder, right-click and then select **Properties**.

1. In the **Properties** dialog box, on the **General** tab, select the **Unblock** check box, and then select **Apply**.

   :::image type="content" source="../media/migration-unblock.PNG" alt-text="Unblock check box and Apply button":::

1. Then extract the contents and run the script. For more information, see [Migrate Dynamics 365 Guides content from one Microsoft Dataverse instance to another using the Content Migration Tool](/dynamics365/mixed-reality/guides/migrate).
