---
title: Add standard cost per component to the Single Level Bill of Materials report in Microsoft Dynamics GP
description: How to add the standard cost per component to the Single Level Bill of Materials report in Microsoft Dynamics GP.
ms.topic: how-to
ms.date: 03/13/2024
ms.reviewer: theley
ms.custom: sap:Manufacturing Series
---
# How to add the standard cost per component to the Single Level Bill of Materials report in Microsoft Dynamics GP

This article describes the steps to add the standard cost per component field to the Single Level Bill of Materials report in Microsoft Dynamics GP by using the Report Writer module

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 871931

## Step 1: Back up the report, and then open the report

1. Back up the Reports.dic file if you have existing Microsoft Great Plains reports that have been modified. To find the location of the Reports.dic file, follow these steps:

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Edit Launch File**. If you are prompted for a password, type the system password.
    2. In the Edit Launch File window, click **Great Plains**. The location of the Reports.dic file is in the **Reports** field.

2. On the **Tools** menu, point to **Customize**, and then click **Report Writer**.
3. In the **Product** list, click **Great Plains**, and then click **OK**.
4. In Report Writer, click **Reports**.
5. In the **Original Reports** list, click **BM Bill of Materials**, and then click **Insert**.
6. In the **Modified Reports** list, click **BM Bill of Materials**, and then click **Open**.

## Step 2: Create a calculated field for the standard cost

1. In the Report Definition window, click **Layout**.
2. In the Toolbox, click **Calculated Fields**, and then click **New**.
3. In the **Name** field, type *Std cost*.
4. In the **Result Type** list, click **Currency**, and then mark **Calculated** as the **Expression Type**.
5. In the Expressions area, click **Calculated**, and then click the **Fields** ta2.
6. In the **Resources** list, click **Bill of Materials Report Detail Temp**, and then in the **Field** list, click **Design Quantity**.
7. Click **Add**, and then in the **Operators** area, click \*.
8. Click the **Functions** tab, and in the **Function** list, click **STR_CUR**, and then click **Add**.
9. Click the **Fields** tab, in the **Resources** list, click **Calculated Fields**, in the **Fields** list, click **Comp Cost**, and then click **Add**.

    > [!NOTE]
    > Your calculated field appears as follows: `bmBillRptDtlTemp.Design Quantity * STR_CUR(Comp Cost)`
10. Click **OK**.

## Step 3: Add the Std Cost calculated field to the report layout

1. In the **Calculated Fields** list, click **Std Cost**.
2. Drag the field onto the **H3** section of the report layout.
3. Double-click **Std Cost** field to open the Report Field Options window.
4. Click the **ellipsis** button next to the **Format** field, and then click **New**.
5. In the **Format Name** field, type *Decimal 2*.
6. In the **Decimal Digits** field, type 2, and then mark the **Show Currency Symbol** check box.
7. Click **OK**, and then click **OK** in the Report Field Options window.

## Step 4: Save your report, and then quit Report Writer

1. Close the **Report Layout** window. You will receive the message:

    > Do you want to save changes to this report layout?

    Click **Save**.
2. In the **Report Definition** window, click **OK**.
3. On the **File** menu, click **Microsoft Business Solutions - Great Plains**.

## Step 5: Grant access to the report

Use one of the following methods to grant access to the report.

### Method 1:Use the Advanced Security tool

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**. If you are prompted, type the system password.
2. Click **View**, and then click **by Alternate, Modified and Custom**.
3. Expand the following nodes:

    - **Great Plains**
    - **Reports**
    - **Inventory**
    - **Bm Bill of Materials**

4. Click **Great Plains (Modified)**.
5. Click **Apply**, and then click **OK**.

    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and company are selected. Any changes that you make are for the current user and company. However, you can select additional users and companies in the Company area and in the User area of the Advanced Security dialog box.

### Method 2: Use standard Microsoft Great Plains security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**. If you are prompted for a password, type the system password.
2. In the **User ID** list, click the user ID of the user whom you want to have access to the report.
3. In the **Type** list, click **Modified Reports**.
4. In the **Series** list, click **Inventory**.
5. In the **Access List** box, double-click **BM Bill of Material**, and then click **OK**. An asterisk appears next to the report name.
