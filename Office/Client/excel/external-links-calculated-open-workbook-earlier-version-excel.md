---
title: External links may be calculated when you open a workbook
description: External links in a workbook from an earlier version of Excel are calculated.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Office Products
- Excel 2013
- Excel 2016
- Excel 2019
- Excel 2021
search.appverid: MET150
ms.reviewer: 
author: simonxjx
ms.author: v-six
ms.date: 03/31/2022
---
# External links may be calculated when you open a workbook that was last saved in an earlier version of Excel

## Symptoms

When you open a workbook that contains external links or User Defined Functions in Microsoft Excel, you might experience one or more of the following symptoms:

- The links in the workbook are calculated against the external link table stored in the workbook and may be different than what was previously calculated.
- Formulas that include or refer to external links to other workbooks that don't have values stored in the external link table may display one of the following errors:
  - > #REF!
  - > #VALUE!
- Formulas that include User Defined Functions from Add-ins or other workbooks that are not available may display the following error:
  - > #NAME?

Additionally, because the result is an error, other cells and functions that use this result might return other errors or unexpected results.

## Cause

This scenario occurs if the workbook that you open was last saved in a version of Excel that's earlier than the version that you are currently using to open the workbook. This scenario occurs because Excel forces a complete recalculation of all open workbooks that were previously saved in an earlier version of Excel, regardless of the link update status. To fully recalculate a workbook, Excel gets the currently stored value of all external references from the workbooks external link table. This behavior occurs even if you decide not to update those links when you are prompted. Excel updates the workbook calculation chain to the current version of Excel. If the values of the external link sources are not available in the external link table in the workbook, Excel cannot calculate correctly. Therefore, Excel returns #REF! errors. This is also true of DDE links that are unavailable during the recalculation process. By default Excel saves a hidden table of the link values for calculation purposes. In some scenarios, the values for the external links may not be the same as what was last calculated in the formulas. It's also possible to turn off the feature to store the external link values on an individual workbook basis in Excel options.

## Workaround

To work around this problem, use one of the following methods.

### Make sure that external link sources are available before you open the workbook

If you have errors in external link formulas when you open the workbook, but you have not yet saved the workbook, follow these steps:

1. Don't save the workbook. Instead, close the workbook without saving it. This will undo any changes that were made to the workbook.
2. For each different external link source in the workbook that you want to open, confirm that the source file is available at the path that is specified in the link formula. If any link sources are no longer available, change the link formula to point to an alternative source. Alternatively, remove the link formula permanently to break the link. Follow the steps in the "Update or remove links" section to edit links or to remove links.
3. After you confirm that all the link sources are available at their defined locations, open the linked workbook that experienced the problem in Excel. Let Excel update all external links within the workbook when you are prompted.
4. When you open the linked workbook and confirm that all external links have updated successfully and that the workbook has been successfully recalculated in the current version of Excel, save the workbook. It should now open and update links as expected in the current version of Excel.

### Update or remove links

If you already saved the workbook that has errors in the external link formulas, if the link source file has moved, or if the link source files are no longer available, locate the original linked source. Alternatively, find an alternative source file. Then, modify the links to these sources. To examine the external link sources and to restore or remove any broken links, follow these steps:

1. To temporarily prevent the recalculation of files that were last saved in an earlier version of Excel so that you can update or remove external links, set the calculation environment to manual. To temporarily set the calculation mode to manual, follow these steps:

   1. Close all workbooks.
   2. Create a new workbook.
   3. Select the **Microsoft Office Button**, and then select **Excel Options**.
   4. On the **Formulas**  tab, select **Manual** under **Calculation options**, and then select **OK**.
   5. Open the saved workbook.

2. On the **Data** tab, select **Edit Links** in the **Connections** group.

   Each link will list the file name of the source workbook to which this workbook is linked. If you select the link, the original file path location of the source workbook appears under the list in the **Location**  label.
3. Select **Check Status** to update the status for all the links in the list. Wait for the status of all links to be updated.
4. Examine the status in the **Status** column, select the link, and then perform one of the following actions:

   - If the status is **OK**, no action is required. The link is working and is current.
   - If the status is **Unknown**, select **Check Status** to update the status for all links in the list.
   - If the status is **Not applicable**, the link uses OLE or Dynamic Data Exchange (DDE). Excel cannot check the status of these types of links.
   - If the status is **Error: Source not found**, select **Change Source**, and then select the appropriate workbook for the link.
   - If the status is **Error: Worksheet not found**, select **Change Source**, and then select the appropriate worksheet in the appropriate file. The source may have been moved or renamed.
   - If the status is **Warning: Values not updated**, select **Update Values**. The link was not updated when the workbook was opened.
   - If the status is **Warning: Source not recalculated**, select **Open Source**, and then press F9 to calculate the workbook. The workbook may be set to manual calculation in the source file. To set the workbook to automatic calculation, select the **Microsoft Office Button**, and then select **Excel Options**. On the **Formulas**  tab, select **Automatic**  under **Calculation options**.
   - If the status is **Error: Undefined or non-rectangular name**, some names cannot be resolved until you open the source workbook. Select **Open Source**, switch back to the destination workbook, and then select **Check Status**. If this does not resolve the issue, make sure that the name is not missing or misspelled. Switch to the source workbook, select the **Formulas**  tab, select **Define Name**, and then look for the name.
   - If the status is **Warning: Open source to update values**, select **Open Source**. The link cannot be updated until you open the source.
   - If the status is **Source is open**, the source is open. No action is required unless you receive worksheet errors.
   - If the status is **Values updated from file name**, no action is required. The values have been updated.
   - If the status is **Error: Status indeterminate**, Excel cannot determine the status of the link. The source may contain no worksheets. Alternatively, the source may be saved in an unsupported file format. Select **Update Values**.
5. After you resolve all link references, reset calculation to automatic so that Excel can fully recalculate the workbook in the new version of the workbook. To do this, follow these steps:

   1. Select the **Microsoft Office Button**, and then select **Excel Options**.
   2. On the **Formulas** tab, select **Automatic** under **Calculation options**, and then select **OK**.

      Excel should now calculate the workbook. If the calculation is successful, save the workbook. The workbook should now open and update links as expected in the current version of Excel.

For more information about how the calculation environment is determined, see
[Description of how Excel determines the current mode of calculation](https://support.microsoft.com/help/214395).  

### Permanently remove the link formula, and then replace it with the value

If you don't need the formulas that refer to external links, copy these formulas, and then paste the values only in the target cells.

> [!NOTE]
> When you replace a formula with its value, Excel permanently removes the formula.

To copy the formulas and paste the values, follow these steps:

1. Open the workbook in the version of Excel in which the workbook was last saved. When you are prompted to update the links, select **No**. Because the file was last saved in this version of Excel, links are not forced to update. Calculation can occur with the last known value of the link.
2. Right-click the cell or range of cells that contain the formula that refers to an external link, and then select **Copy**.
3. Right-click the same cell or range of cells, and then select **Paste Special**.
4. In the **Paste Special**  dialog box, select **Values** under **Paste**, and then select **OK**.

After you remove all the unwanted links in this manner, save the workbook. You can then open the workbook in Excel without updating those links. This behavior occurs because the links no longer exist.
