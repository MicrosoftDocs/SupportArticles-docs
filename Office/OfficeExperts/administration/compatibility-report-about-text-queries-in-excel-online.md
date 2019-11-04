---
title: Compatibility Report about text queries in Excel Online
author: AmandaAZ
ms.author: jhaak
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.service: sharepoint-online
localization_priority: Normal
appliesto:
- Excel Online
---

# Compatibility Report about text queries in Excel Online

This article was written by [Tom Schauer](https://social.technet.microsoft.com/profile/Tom+Schauer+-+MSFT), Technical Specialist.

## Symptoms

When you try to edit a workbook that contains text queries in Microsoft Excel Online, you may receive a Compatibility Report:

![the compatibility report dialog box](./media/compatibility-report-about-text-queries-in-excel-online/text-query-error.png)

## Resolution

This issue occurs because Excel Online doesn't support a text query. To resolve the issue, use either of the following workarounds:

**Create a copy of the workbook in Excel Online to remove the unsupported feature**

1. Select **Edit Workbook** > **Edit in Excel Online** in the workbook.
1. In the prompt dialog box, select **Edit a Copy**.

   ![the edit a copy dialog box](./media/compatibility-report-about-text-queries-in-excel-online/edit-a-copy.PNG)

1. Type a new file name for this copy, and then click **Save**.

   ![the create a copy dialog box](./media/compatibility-report-about-text-queries-in-excel-online/create-a-copy.jpg)

A copied workbook that doesn't contain any unsupported features will be created through this method. It will be saved to the same directory as the original workbook.

![the new copy workbook dialog box](./media/compatibility-report-about-text-queries-in-excel-online/copy.PNG)

**Remove the query definition directly**

1. Right-click the table and select **Data Range Properties**.
1. Clear the **Save query definition** check box in the **External Data Range Properties** dialog box.

   ![the clear option dialog box](./media/compatibility-report-about-text-queries-in-excel-online/clear-option.PNG)

1. On the **Data** tab, select **Properties**, and then clear the **Save query definition** check box in the **External Data Range Properties** dialog box.

   ![the clear option two dialog box](./media/compatibility-report-about-text-queries-in-excel-online/clear-option-two.PNG)