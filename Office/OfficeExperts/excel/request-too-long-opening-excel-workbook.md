---
title: Request Was Taking Too Long when you open a workbook in Excel Online
description: You can't open a workbook in Excel Online if the workbook takes longer than 30 seconds to open. 
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-solutions
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: thempel
appliesto:
- Excel Online
---

# "Request Was Taking Too Long" when you open a workbook in Excel Online

This article was written by [Tom Schauer](https://social.technet.microsoft.com/profile/Tom+Schauer+-+MSFT), Technical Specialist.

## Symptoms

When you open a specific workbook in Excel Online, you receive a "Request Was Taking Too Long" error message.

## Cause

This issue occurs if the workbook takes longer than 30 seconds to open in Excel Online.

Although there can be many reasons why a file is slow to open, excess formatting is a very typical cause.

The Excel client team has written an excellent article about how to clean up a workbook so that it uses less memory. We can use the same method to avoid the "Request Was Taking Too Long" errors in Excel Online. This is because all the steps that are mentioned in the referenced post relate to tidying up a file to make it consume fewer resources, and open and run more quickly.

A very complex workbook that contains many workbook elements may take a long time to open. The following are some common problem areas to consider when you troubleshoot this issue:

- **Worksheet protection**: Removing the worksheet protection probably isn't the best option because this method prevents users from being able to edit certain cells that most likely contain formulas.
- **VLOOKUP formulas**: If you remove VLOOKUP formulas, you may break the calculation chain of your workbook. Therefore, this most likely isn't a viable solution.
- **Defined names**: You probably can't remove defined names because those may be necessary for data validation or an Excel Web Access web part that uses those named items.
- **Styles**: When a workbook has too many cell styles, shapes, or formatting, it can cause Excel Online to take many times longer to open a file than usual. To see the cell styles for an Excel workbook, locate the Home tab, and then click the Down arrow in the lower-right corner of the Styles group.

To view existing styles in a workbook, locate **Home** tab > **Styles** > Down arrow.

![Down arrow in Style group](./media/request-too-long-opening-excel-workbook/down-arrow.png)

In a new workbook, your list of styles should resemble the following list.

![An example of style list in a workbook](./media/request-too-long-opening-excel-workbook/style-list.png)

Here are examples of duplicate or excessive formatting.

**Example 1**: This example has 3,284 duplicate formatting items.

![An example that has 3,284 duplicate formatting items](./media/request-too-long-opening-excel-workbook/example1.png)

**Example 2**: This example has 11,837 excessive formatting items.

![An example that has 11,837 excessive formatting items](./media/request-too-long-opening-excel-workbook/example2.png)

These excessive cell styles, mixed with the many other elements in this workbook (such as sheet protection, defined names, and VLOOKUP formulas), cause the loading process to exceed the 30-second time-out duration that is set by Excel Online.

## Resolution

To have Excel to clear excess or duplicate formatting, use the Inquire add-in. To load the Inquire add-in for Excel, follow these steps:

1. Select **File** > **Options** > **Add-ins**.
1. On the Manage menu at the bottom of the page, select **COM Add-ins**, and then select **Go**.
1. After the **COM Add-ins** window opens, make sure that the check box next to **Inquire** is selected, and then click **OK**.
  
   ![Selecting Inquire in COM Add-ins window](./media/request-too-long-opening-excel-workbook/inquire-add-in.png)

You should now see the Inquire add-in loaded in the workbook ribbon. Open the **Inquire** tab, and then select **Clean Excess Cell Formatting**.

![Selecting Clean Excess Cell Formatting on the Inquire tab](./media/request-too-long-opening-excel-workbook/clean-excess-cell-formatting.png)

## More Information

In addition to cleaning up excess or duplicate formatting, consider tidying up your workbook by using the following resources:

- [Locate and reset the last cell on a worksheet](https://support.office.com/article/Locate-and-reset-the-last-cell-on-a-worksheet-C9E468A8-0FC3-4F69-8038-B3C1D86E99E9)
- [Excel add-In to reset the last worksheet cell](https://archive.codeplex.com/?p=xsformatcleaner)
- [You receive a "Too many different cell formats" error message in Excel](https://support.microsoft.com/help/213904/you-receive-a-too-many-different-cell-formats-error-message-in-excel)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]
