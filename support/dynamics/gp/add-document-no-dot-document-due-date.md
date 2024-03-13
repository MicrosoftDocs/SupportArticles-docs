---
title: Add document No. and document due date
description: Describes how to add the document number and the document due date from the invoices to the Computer Checks Posting Journal report.
ms.reviewer: ryanklev
ms.topic: how-to
ms.date: 03/13/2024
---
# How to add the document number and the document due date from invoices to the Computer Checks Posting Journal report in Microsoft Dynamics GP

This article describes how to add the document number and the document due date from invoices to the Computer Checks Posting Journal report.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 912953

## Introduction

This article contains step-by-step instructions about how to add the document number and the due date of the invoices that are being paid on the Computer Check Edit List. This report is named the Computer Checks Posting Journal report in Report Writer.

> [!NOTE]
>
> - You can also apply these steps to add the document number and the document due date to the MC Computer Checks Posting Journal report.
> - After you follow these steps, the general ledger distributions no longer appear in the Computer Checks Posting Journal report.

## More Information

To add the document number and the document due date to the Computer Checks Posting Journal report, follow these steps.

### Step 1: Start Report Writer

- In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then select **Report Writer**. In the **Product** list, select **Microsoft Dynamics GP**.
- In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, select **Tools**, point to **Customize**, and then select **Report Writer**. In the **Product** list, select **Great Plains**.

### Step 2: Add a table relationship

1. On the toolbar, select the **Reports** button.
2. In the Report Writer window, select the **Computer Check Posting Journal** report in the **Original Reports** list, and then select **Insert**.
3. In the **Modified Reports** list, select the **Computer Check Posting Journal** report, and then select **Open**.
4. In the Report Definition window, select the **Tables** button.
5. In the Report Table Relationships window, highlight the **Payables Journal Distributions Temporary File**, and then select **Remove**.
6. Select **OK** when you see the following message:

    > Are you sure you want to remove this table and its related tables? Remove all corresponding tables.
7. In the Report Table Relationships window, highlight **PM Payment WORK***, and then select **New**.
8. In the Related Tables window, highlight **PM Payment Apply To Work File***, and then select **OK** to close the window.
9. In the Report Table Relationships window, select **Close**.

### Step 3: Create the report restriction

1. In the Report Definition window, select the **Restrictions** button.
2. In the Report Restrictions window, highlight the **Dummy4** restriction, and then select **Delete**.
3. Select **Yes** when you see the following message:

    > Do you want to delete this restriction?

4. In the Report Restrictions window, select **New**.
5. In the Report Restriction Definition window, type a name in the **Restriction Name** field. For example, type **912953**.
6. Select **PM Payment Apply To Work File** for the **Report Table**.
7. Select **Apply To Voucher Number** for the **Table Fields**.
8. Select **Add Field**.
9. In the **Operators** box, select the equal sign (=).
10. Again, in the **Fields** box, select **Add Field**. It will create the following restriction expression:  
    `PM_Payment_Apply_WORK.Apply to Voucher Number=PM_Payment_Apply_WORK.Apply to Voucher Number`

11. Select **OK** to close the Report Restriction Definition window.
12. Close the Report Restrictions window.

### Step 4: Add the Invoice Number and Document Due Date fields to the report layout

1. In the Report Definition window, select the **Layout** button. The Report Layout window opens.
2. Delete the following fields from the body (B) of the report:
   - **Field9**  
   - **Field2**  
   - **Field3**  
   - **Field4**  
   - **Field5**
3. In the Toolbox window, drag the following fields from the PM Payment Apply To Work file table to the body (B) of the report:
   - **Apply To Voucher Number**  
   - **Document Number**  
   - **Document Due Date**  
   - **Amount Paid**

    > [!NOTE]
    > You will have to rearrange or remove some existing fields in the body (B) to make room for the new field.
4. Close the layout, and select **Save** when you're prompted to save the changes to the report layout.

### Step 5: Save the changes to the report, and then exit Report Writer

1. On the **File** menu, select **Microsoft Dynamics GP**.
2. Select **Save** when you're prompted to save the changes to the report layout.
3. Select **Save** when you're prompted to save the changes to the modified report.
4. Exit Report Writer.

### Step 6: Assign security permissions to the modified report

To assign security permissions to the modified report, use one of the following methods.

#### Method 1: Use security in Microsoft Dynamics GP 10.0

1. Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then select **Alternate/Modified Forms and Reports**.
2. In the **ID** box, type the Alternate/Modified Forms and Reports ID associated with the user ID that will print this modified report.
3. In the **Product** list, select **Microsoft Dynamics GP**.
4. In the **Type** list, select **Reports**.
5. Expand the **Purchasing** folder.
6. Expand the folder for the report that you modified.
7. Select **Microsoft Dynamics GP (Modified)**.
8. Select **Save**.
9. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **User Security**.
10. In the **User** list, select a user ID.
11. In the **Company** list, select a company.
12. In the **Alternate/Modified Forms and Reports ID** list, select the ID that you typed in step 2.

#### Method 2: Use the Advanced Security tool in a version earlier than Microsoft Dynamics GP 10.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.
2. If you're prompted, type the system password in the **Please Enter Password** box, and then select **OK**.
3. In the Advanced Security window, select **View**, and then select **By Alternate, Modified and Custom**.
4. Use the appropriate step:

    - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
    - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.
5. Expand **Reports**, expand **Sales**, and then expand the report that you modified.
6. Use the appropriate step:
   - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP (Modified)**.
   - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains (Modified)**.
7. Select **Apply**, and then select **OK**.

    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are for the current user and the current company. However, you can select additional users and companies in the **Company** area and in the **User** area of the Advanced Security window.

#### Method 3: Use the Standard Security tool in a version earlier than Microsoft Dynamics GP 10.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**.
2. If you're prompted, type the system password in the **Please Enter Password** box, and then select **OK**.
3. In the **User ID** list, select the user ID for the user who you want to have access to the report.
4. In the **Type** list, select **Modified Reports**.
5. In the **Series** list, select **Purchasing**.
6. In the **Access List** box, double-click the report that you modified, and then select **OK**.

    > [!NOTE]
    > An asterisk (*) appears next to the report name

    Q&A  
    Q: After following the above steps, I unmark **print previously applied documents** during the select checks process, but previously applied records still print.

    A: Add another restriction to the report. In the PM10201 table, computer checks have a **1** in the Select_To_Print field, but previously applied checks don't. So to restrict out previously applied information, add this restriction to the report:

    > PM PAYMENT APPLY WORK.Select to Print = 1
