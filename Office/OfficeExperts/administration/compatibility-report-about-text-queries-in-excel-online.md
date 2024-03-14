---
title: Compatibility Report about text queries in Excel Online
description: Describes the steps to troubleshoot the compatibility report when you edit a workbook that contains text queries in Microsoft Excel Online.
author: helenclu
ms.author: luche
ms.reviewer: jhaak
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:office-experts
  - CSSTroubleshoot
appliesto: 
  - Excel Online
ms.date: 03/31/2022
---

# Compatibility Report about text queries in Excel Online

This article was written by [Tom Schauer](https://social.technet.microsoft.com/profile/Tom+Schauer+-+MSFT), Technical Specialist.

## Symptoms

When you try to edit a workbook that contains text queries in Microsoft Excel Online, you may receive a Compatibility Report which states:

> We can't show these features in the browser:
> - Text queries


:::image type="content" source="media/compatibility-report-about-text-queries-in-excel-online/text-query-error.png" alt-text="Screenshot of the compatibility report dialog box.":::

## Cause

This issue occurs because Excel Online doesn't support text queries. 

## Resolution

To resolve the issue, use one of the following workarounds:

### Method 1: Create a copy of the workbook in Excel Online to remove the unsupported feature

1. Select **Edit Workbook** > **Edit in Excel Online** in the workbook.
1. In the prompt dialog box, select **Edit a Copy**.

   :::image type="content" source="media/compatibility-report-about-text-queries-in-excel-online/edit-a-copy.png" alt-text="Screenshot to select the Edit a copy option in the prompt dialog box.":::

1. Type a new file name for this copy, and then click **Save**.

   :::image type="content" source="media/compatibility-report-about-text-queries-in-excel-online/create-a-copy.png" alt-text="Screenshot to select the Save option after typing a new file name for this copy.":::

A copied workbook that doesn't contain any unsupported features will be created through this method. It will be saved to the same directory as the original workbook.

:::image type="content" source="media/compatibility-report-about-text-queries-in-excel-online/copied-workbook.png" alt-text="Screenshot of the new copy workbook dialog box in Excel Online.":::

### Method 2: Remove the query definition directly

1. Right-click the table and select **Data Range Properties**.
1. Clear the **Save query definition** check box in the **External Data Range Properties** dialog box.

   :::image type="content" source="media/compatibility-report-about-text-queries-in-excel-online/clear-save-query-definition.png" alt-text="Screenshot to clear the Save query definition check box.":::

1. On the **Data** tab, select **Properties**, and then clear the **Save query definition** check box in the **External Data Range Properties** dialog box.

   :::image type="content" source="media/compatibility-report-about-text-queries-in-excel-online/clear-option.png" alt-text="Screenshot shows steps to clear the Save query definition check box.":::

### Method 3: Edit the Excel file in the desktop app

If you have it available, open the Excel file in the desktop app, where you will be able to edit the workbook with the text query. 

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).