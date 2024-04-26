---
title: Changes in the purchasing functionality in Project Accounting for Microsoft Dynamics GP
description: Describes changes in the Project Accounting purchasing functionality that result from the merging of Project Accounting purchasing with the Purchase Order Processing in Microsoft Dynamics GP.
ms.reviewer: theley, jchrist, lmuelle
ms.date: 03/20/2024
ms.custom: sap:Project Accounting
---
# Description of the changes in the purchasing functionality in Project Accounting for Microsoft Dynamics GP

This article describes changes in the purchasing functionality in Project Accounting for Microsoft Dynamics GP. Starting with Microsoft Dynamics GP 9.0, the purchasing functionality in Project Accounting was merged with Purchase Order Processing in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 921630

## Changes in the purchasing functionality

Changes in the purchasing functionality in Project Accounting include:

- Project Accounting purchasing reports cannot be upgraded. It means that purchase order formats cannot be upgraded.
- If you modified any Project Accounting purchasing reports, the modifications will no longer exist. This issue occurs because the table structure has changed completely.
- The **Site ID** field wasn't a required field in earlier versions of Project Accounting. However, since Microsoft Dynamics GP 9.0, the **Site ID** field is a required field in Project Accounting. You must add the **Site ID** field to any purchase orders that were entered before you upgraded to Microsoft Dynamics GP 9.0.

    > [!NOTE]
    >
    > - If the value in the **PO Status** field is **New**, you can open the purchase order in the Purchase Order Entry window and then enter the site ID.
    > - If the value in the **PO Status** field is not **New**, you must update the site ID in the table by using SQL Query Analyzer.
  
    For more information about how to update the site ID in the table, contact technical support.
  
    For information about technical support for Microsoft Dynamics GP, visit the following Microsoft Web site:
  
    [Dynamics Support](https://support.microsoft.com/topic/microsoft-dynamics-technical-support-numbers-df1e1f22-fb0c-48d8-6105-81febfbb87bf)  

- New security settings exist that must be granted so that users can see the fields for the project number and for the cost category ID in the entry windows. If the security settings are granted to alternate reports, the project number and the cost category ID are automatically printed on the purchasing reports.

To assign security permissions to the alternate windows or to the alternate reports, use one of the following methods.

## Method 1: Use the Security tool in Microsoft Dynamics GP 10.0

1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then click **Alternate/Modified Forms and Reports**.
2. In the **ID** box, click the ID for the alternate form or for the alternate report.
    > [!NOTE]
    > The default ID is "DEFAULTUSER."
3. In the **Product** list, click **Project Accounting**.
4. In the **Type** list, click **Windows**.
5. Expand the **Purchasing** folder.
6. Expand each folder.
7. Click **Project Accounting** for each folder.
8. In the **Type** list, click **Reports**.
9. Expand the **Purchasing** folder.
10. Expand each folder.
11. Click **Project Accounting** for each folder.
12. Click **Save**.
13. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then click **User Security**.
14. In the **User** box, click a user ID.
15. In the **Company** field, select the company.
16. In the **Alternate/Modified Forms and Reports ID** field, add the ID that you clicked in step 2. This step grants the user ID access to the alternate window or to the alternate report.
17. Click **Save**.

## Method 2: Use the Advanced Security tool in Microsoft Dynamics GP 9.0

1. On the **Tools** menu, point to **System**, and then click **Advanced Security**. If you're prompted, type the system password.
2. Click the **View** box, and then click **by Alternate, Modified and Custom**.
3. Expand the following nodes, and then expand each window or report in which you want the project number and cost category ID fields to appear:
    - **Project Accounting**  
    - **Forms or Reports**  

    > [!NOTE]
    > If you want these fields to appear in a form, expand the **Forms** node to select the specific form. If you want these fields to appear in a report, expand the **Reports** node to select the specific report.

   - **Purchasing**

4. Click **Project Accounting**.
5. Click **Apply** > **OK**.
6. In the **Product** list, click **Project Accounting**.

## Method 3: Use the Standard Security tool in Microsoft Dynamics GP 9.0

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Security**. If you're prompted, type the system password.

2. In the Security Setup window, specify the following settings:

    - **User ID**: **UserID**  
    - **Company**: **CompanyName**  
    - **Product**: **Project Accounting**  
    - **Type**: **Alternate Dynamics GP windows**  
    - **Series**: **Purchasing**

3. Click **Mark All**.
4. In the **Type** field, click **Alternate Dynamics GP reports**.
5. Click **Mark All**.
6. Click **OK** to close the Security Setup window.

## Notes

- You should enable the new **Allow blank Project and Cost Category** user security setting so that users can enter purchase orders that are not project related. This security setting replaces the **None** project option in earlier versions. To enable this security setting, follow these steps:

    1. On the **Tools** menu, point to **Setup** > **Project**, and then click **User**.
    2. In the User Project Accounting Settings window, type the user ID in the **User ID** box, and then click **Purchase Order**.
    3. In the User Purchase Order Settings window, click to select the **Allow blank Project and Cost Category** check box.

- The setup window for Project Accounting purchasing is now included in the core Purchase Order Processing Setup window. To access this window, follow these steps:

    1. On the **Tools** menu, point to **Setup** > **Purchasing**, and then click **Purchase Order Processing**.
    2. In the Purchase Order Processing Setup window, click **Project** to open the PA Purchase Order Processing Setup Options window.

- In Project Accounting, upgraded purchase orders in which the **PO Status** field is set to **New** cannot be printed from the Purchase Order Entry window. To print the purchase orders, you must first change the value in the **PO Status** field to **Released** in the Edit Purchase Order Status window.
- You can enter billing notes in the Purchasing Item Detail Entry window. You can do this operation for purchase orders that contain information from Project in Microsoft Dynamics GP. To open the Purchasing Item Detail Entry window from the Purchase Order Entry window, click the **Item Detail** expansion arrow in the **Item** field, and then click the expansion arrow in the **Cost Cat. ID** field.
- You can't enter billing notes on purchase orders that don't have a project and a cost category.
- Billing notes from upgraded purchase orders that didn't have projects aren't printed on purchase orders in Microsoft Dynamics GP 9.0 or 10.0.
