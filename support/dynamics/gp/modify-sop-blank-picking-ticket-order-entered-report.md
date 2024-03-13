---
title: Modify the SOP Blank Picking Ticket Order Entered report
description: This article describes how to print more than four lines of line item comments on the SOP Blank Picking Ticket Order Entered report in Microsoft Dynamics GP.
ms.topic: how-to
ms.reviewer: ppeterso
ms.date: 03/13/2024
---
# Print more than four lines of line item comments on the SOP Blank Picking Ticket Order Entered report in Microsoft Dynamics GP

This article describes how to print more than four lines of line item comments on the SOP Blank Picking Ticket Order Entered report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 892775

## Summary

This article contains step-by-step instructions for how to modify the Sales Order Processing (SOP) Blank Picking Ticket Order Entered report. To successfully modify this report, you must create a new table relationship. After you create the new relationship, you can add the field and save your changes. Finally, you must grant security to the report. Detailed instructions are included for each of these steps.

## Introduction

This article describes how to print more than four lines of line item comments on the Sales Order Processing (SOP) Blank Picking Ticket Order Entered report in Microsoft Dynamics GP.

The SOP Blank Picking Ticket Order Entered report replaces the SOP Blank Picking Ticket report that was used in earlier versions because the Advanced Picking features were added in Microsoft Business Solutions - Great Plains 8.0. Standard users still have access to the SOP Blank Picking Ticket in Microsoft Dynamics GP 10.0, Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0.

### Step 1: Back up the Reports.dic file

Back up the Reports.dic file if you have any modified Microsoft Dynamics GP reports. To locate the Reports.dic file, follow these steps:

1. Use the appropriate step:
    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then click **Edit Launch File**.
    - In Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **System**, and then click **Edit Launch File**.
1. If you are prompted for the password, type the system password.
1. In the **Edit Launch File** window, click **Microsoft Dynamics GP**. The path of the Reports.dic file appears in the Reports box.

### Step 2: Open the report

1. In Report Writer, click **Reports**.
2. Click the **SOP Blank Picking Ticket Order Entered** report in the **Original Reports** list, and then click **Insert**.
3. Click the **SOP Blank Picking Ticket Order Entered** report in the **Modified Reports** list, and then click **Open**.

### Step 3: Create a report table relationship

To create a relationship between the Sales Transaction Amounts Work table and the Sales Line Comment Work and History table, follow these steps:

1. To open the **Report Table Relationships** dialog box, click **Tables**.
2. Click **04.-Sales Transaction Amounts Work** in the **Report Table Relations** list, and then click **New**.
3. Click **Sales Line Comment Work and History** in the **Tables** list, and then click **OK**.
4. Click **Close** to close the **Report Table Relationships** dialog box.

### Step 4: Add the Comment Text field to the report

1. In the **Report Definition** dialog box, click **Layout**.
2. Click the **Layout** tab in the toolbox, and then click **Sales Line Comment Work and History** in the resources list.</br></br> **Note** You may want to resize the **B** section or move other fields to make room for the new field.
3. Drag **Comment Text** from the field list to the **B** section of the report.</br></br> **Note** The Comment Text field must be as large as the largest comment that you want to print on the report. The space that is not used for a comment remains white. Therefore, every item that does not have a comment has white space underneath it.

### Step 5: Save your changes and quit Report Writer

1. Use the appropriate step:
    - In Microsoft Dynamics GP 10.0, click **File**, and then click **Microsoft Dynamics GP**.
    - In Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0, click **File**, and then click **Microsoft Business Solutions-Great Plains**.
1. When you receive the following message, click **Save**: Do you want to save changes to this report layout?
1. When you receive the following message, click **Save**: Do you want to save changes to this report?

### Step 6: Grant security to the report

#### Method 1: Use security in Microsoft Dynamics GP 10.0

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **Alternate/Modified Forms and Reports**.
2. In the **ID** box, type the alternate or modified forms and reports ID that is associated with the user who will print this changed report.</br></br>This ID is the ID that is assigned to the user in the User Security Setup window. To open the User Security Setup window, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then click **User Security**.
3. In the **Product** list, click **Microsoft Dynamics GP**.
4. In the **Type** list, click **Reports**.
5. Expand **Sales**.
6. Expand **SOP Blank Picking Ticket Order Entered**.
7. Click **Microsoft Dynamics GP (Modified)**.
8. Click **Save**.
9. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **User Security**.
10. In the **User** list, click a user ID.
11. In the **Company** list, click a company.
12. In the **Alternate/Modified Forms and Reports ID** list, click the ID that you typed in step 2 of this section.

#### Method 2: Use the Advanced Security tool in a version that is earlier than Microsoft Dynamics GP 10.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**.
2. If you are prompted for a password, type the system password in the **Please Enter Password** box, and then click **OK**.
3. In the Advanced Security window, click **View**, and then click **By Alternate, Modified and Custom**.
4. Do one of the following:
    - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
    - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.
5. Expand **Reports**, expand **Sales**, and then expand **SOP Blank Picking Ticket Order Entered**.
6. Do one of the following:
    - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP (Modified)**.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains (Modified)**.
7. Click **Apply**, and then click **OK**.

**Note** By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make affect the current user and the current company. However, you can select other users in the **Users** area of the Advanced Security window. You can select other companies in the **Company Name** area of the Advanced Security window.

#### Method 3: Use the Standard Security tool in a version that is earlier than Microsoft Dynamics GP 10.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**.
2. If you are prompted for a password, type the system password in the **Please Enter Password** box, and then click **OK**.
3. In the **User ID** list, click the ID of the user who you want to have access to the changed report.
4. In the **Type** list, click **Modified Reports**.
5. In the **Series** list, click **Sales**.
6. In the **Access List** box, double-click **SOP Blank Picking Ticket Order Entered**, and then click **OK**.

> [!NOTE]
> An asterisk (*) appears next to the report name.
