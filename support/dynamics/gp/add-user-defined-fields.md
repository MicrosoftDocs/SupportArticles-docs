---
title: Add user-defined fields to POP Receivings Posting Journal
description: This article describes how to add the receiving user-defined fields to the POP Receivings Posting Journal report in Microsoft Dynamics GP.
ms.reviewer: 
ms.topic: how-to
ms.date: 03/13/2024
---
# Add the receiving user-defined fields to the POP Receivings Posting Journal report in Microsoft Dynamics GP

This article describes how to add the receiving user-defined fields to the POP Receivings Posting Journal report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 858590

## Introduction

This article describes how to add the receiving user-defined fields to the POP Receivings Posting Journal report in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains 8.0.

## Add the user-defined fields

1. Open Report Writer in Microsoft Dynamics GP as follows:
    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then click **Report Writer**.
    - In Microsoft Dynamics GP 9.0 and in earlier versions, point to **Customize** on the **Tools** menu, and then click **Report Writer**.
1. Click **Tables**.|
1. In the Tables window, click **POP_Receipt**, and then click **Open**.
1. In the Table Definition window, click **Relationships**, and then click **New**.
1. Click the ellipsis button to the left of the Secondary Table line.
1. Click **Purchasing Receipt User Defined**, and then click **OK**.
1. For the **Secondary Table Key**, select **(POP_ReceiptUserDefinedldx_ID)**.
1. In the **Primary Table** list, click **POP Receipt Number**.
1. Click **OK**.
1. Close the Table Relationships window, and then click **OK**.
1. Close the Tables window.
1. Click **Reports**.
1. In the **Original Reports** list, click **POP Receivings Posting Journal**, and then click **Insert**.
1. In the **Modified Reports** list, click the same report, and then click **Open**.
1. In the Report Definition window, click **Tables**.
1. In the Report Table Relationships window, click **Purchase Receipts Work**, and then click **New**.
1. Click **Purchasing Receipt User Defined**, click **OK**, and then click **Close**.
1. In the Report Definition window, click **Layout**.
1. In the Toolbox, click **Purchasing Receipt User Defined**.
1. Click **User Defined Text 01** or the field that you are using, and then drag it into the H1 section or the RH section of the report.

## Save the report

1. Close the Report layout dialog box.
2. If you are prompted to save changes, click **Save**, and then click **OK**.
3. On the **File** menu, click **Microsoft Dynamics GP** or **Microsoft Business Solutions - Great Plains**.

## Grant access to the report

### In Microsoft Dynamics GP 10.0

1. Create the ID to print the modified report. To do this, follow these steps:
    1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, point to **Security**, and then click **Alternate/Modified Forms and Reports**. If you are prompted for the system password, type the system password.
    1. Type the ID in the **ID** box, and then type the description in the **Description** box.
    1. Click **Microsoft Dynamics GP** in the **Product** field, and then click **Reports** in the **Type** field.
    1. Expand **Purchasing**, and then click **POP Receivings Posting Journal**.
    1. Click **Save**.
2. Assign the security to print the modified report. To do this, follow these steps:
    1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, point to **Security**, and then click **User Security**.
    1. Click the user ID and the company database.
    1. Click the menu next to the **Alternate/Modified Forms and Reports ID** field, and then click the ID that you created in step 1b.
    1. Save the changes.

### In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0

#### Method 1: Use the Advanced Security tool

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**.
2. Type the system password if you are prompted.
3. Click **View**, and then click **by Alternate, Modified and Custom**.
4. Expand the following nodes:
    - **Microsoft Dynamics GP** or **Microsoft Great Plains**
    - **Reports**
    - **Purchasing**
5. Expand the purchase order form that you modified.
6. Click **Microsoft Dynamics GP (Modified)** or **Microsoft Great Plains (Modified)**.
7. Click **Apply**, and then click **OK**.</br></br> **Note** By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select other users in the **User** area of the Advanced Security window. You can select more companies in the **Company** area of the Advanced Security window.

### Method 2: Use standard Microsoft Dynamics GP security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**. If you are prompted, type the system password.
2. In the **User ID** list, click the user ID for the user who you want to have access to the report.
3. In the **Type** list, click **Modified Reports**.
4. In the **Series** list, click **Purchasing**.
5. In the **Access List** box, double-click the report that you modified, and then click **OK**. An asterisk (*) appears next to the report name.
