---
title: Add the notes to the SOP Blank Packing Slip
description: This article describes how to add the notes that are attached to the Shipping Method in the Shipping Methods Setup window to the SOP Blank Packing Slip in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
---
# Add the notes that are attached to the Shipping Method in the Shipping Methods Setup window to the SOP Blank Packing Slip in Microsoft Dynamics GP

This article describes how to add the notes that are attached to the Shipping Method in the Shipping Methods Setup window to the SOP Blank Packing Slip in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 925662

## Introduction

This article describes how to add notes to the SOP Blank Packing Slip in Microsoft Dynamics GP. Specifically, this article describes how to add the notes that are attached to the Shipping Method in the Shipping Methods Setup window. This process may be useful if you have to print the address of the shipping company on the report. You can assign a separate shipping method for each shipping company, and then enter the shipper's address on the notes.

To add the notes from the Shipping Method to the SOP Blank Packing Slip, follow these steps.

## Back up the Reports.dic file

If the existing Microsoft Dynamics GP reports have been modified, back up the Reports.dic file. To locate the Reports.dic file, follow these steps:

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Edit Launch File**.
2. If you are prompted to enter the system password, type the password, and then click **OK**.
3. Use one of the following steps, depending on which version you are running:
    - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** in the **Edit Launch File** window.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the **Edit Launch File** window. Note the path that appears in the **Reports** box.
4. Click **OK** to close the **Edit Launch File** window.

## Open Report Writer

1. On the **Tools** menu, point to **Customize**, and then click **Report Writer**.
2. In the **Product** list, click either **Microsoft Dynamics GP** or **Great Plains**, depending on which version you are running.
3. Click **OK**.

## Create a new table relationship

Create a new table relationship from the SOP Document HDR Temp table to the Shipping Methods Master table. To do this, follow these steps:

1. On the toolbar, click **Tables**, and then click **Tables**.
2. In the **Tables** window, click **SOP_Document_HDR_TEMP**, and then click **Open**.
3. Click **Relationships**, and then click **New**.
4. Click the ellipsis button (...) to the right of **Secondary Table**.
5. Click **Shipping Methods Master** in the **Relationship Table Lookup** window.
6. Click **OK**.
7. In the **Secondary Table Key** list, click **SY_Shipping_Methods_MSTR_Key1**.
8. To match the **Shipping Method** field from the Secondary table, select **Shipping Method** in the **Primary Table** list.
9. Select **OK**, and then close all the open windows. If you are prompted to save changes, click **Save**.

## Open the SOP Blank Packing Slip Form

1. Click **Reports**.
2. In the **Original Reports** list, click **SOP Blank Packing Slip Form**, and then click **Insert**.
3. In the **Modified Reports** list, click **SOP Blank Packing Slip Form**, and then click **Open**.

## Add the Record Notes Master table to the SOP Blank Packing Slip Form

1. In the **Report Definition** window, click **Tables**.
2. In the **Report Table Relationships** window, click **01.Sales Document Header Temp**, and then click **New**.
3. In the **Related Tables** window, click **Shipping Methods Master**, and then click **OK**.
4. In the **Report Table Relationships** window, click **05.-Shipping Methods Master**, and then click **New**.
5. In the **Related Tables** window, click **Record Notes Master**, and then click **OK**.

    > [!NOTE]
    > The list of items in the **Report Table Relations** list should resemble the following list:
    >
    > 1. Sales Document Header Temp
    > 1. Sales Transaction Work
    > 1. Customer Master Address File
    > 1. Sales User-Defined Work History
    > 1. Shipping Methods Master
    > 1. Record Notes Master
    > 1. Sales Document Line Temp*
    > 1. Sales Transaction Amounts Work*
    > 1. Sales Line Comment Work and History
    > 1. Sales Serial/Lot Work and History*

6. Click **Close**.

## Add the note field to the page header of the report

1. In the Report Definition window, click **Layout**.
2. In the Toolbox window, click **Record Notes Master** in the resource list.
3. Drag the **Text Field** field to the PH section of the Report Layout window.
4. Close the Report Layout window.
5. Click **Save** when you are prompted to save the changes.
6. In the Report Definition window, click **OK**.
7. On the **File** menu, click either **Microsoft Dynamics GP** or **Microsoft Business Solutions - Great Plains** to exit Report Writer.

## Grant access to the report

Use one of the following methods to grant the user access to the report.

### Method 1: Use standard security in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**.
2. If you are prompted to enter the system password, type the password.
3. In the **User ID** list, select the user ID of the user to whom you want to give access to the report.
4. In the **Type** list, select **Modified Reports**.
5. In the **Series** list, select **Sales**.
6. In the **Access List** box, double-click **SOP Blank Packing Slip Form**, and then click **OK**.

> [!NOTE]
> An asterisk appears next to the report name.

### Method 2: Use Advanced Level Security in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**.
2. If you are prompted to enter the system password, type the password.
3. Click **View**, and then click **by Alternate, Modified and Custom**.
4. Expand either **Microsoft Dynamics GP** or **Great Plains**, expand **Reports**, expand **Sales**, and then expand **SOP Blank Packing Slip Form**.
5. Click either **Microsoft Dynamics GP (Modified)** or **Great Plains (Modified)**.
6. Click **Apply**, and then click **OK**.

> [!NOTE]
> By default, the current user, and the current company are selected when you start Advanced Level Security. Any changes that you make apply to the current user and to the current company. However, you can select other users in the User area of the Advanced Level Security window. You can select more companies in the Company area of the Advanced Level Security window.
