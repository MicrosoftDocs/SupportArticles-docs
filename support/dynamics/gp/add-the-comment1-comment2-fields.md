---
title: Add the Comment1 and Comment2 fields
description: Describes how to add the Comment1 and Comment2 fields to the SOP Blank Invoice Form report by using Report Writer in Microsoft Dynamics GP 9.0.
ms.reviewer: theley, aeckman, lmuelle
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Distribution - Sales Order Processing
---
# How to add the Comment1 and Comment2 fields from the Customer Maintenance window to the SOP Blank Invoice Form report by using Report Writer in Microsoft Dynamics GP 9.0

This article describes how to add the Comment1 and Comment2 fields to the SOP Blank Invoice Form report by using Report Writer in Microsoft Dynamics GP 9.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 921219

## Introduction

These fields are in the Customer Maintenance window in the Receivables Management module.

## Back up and then open the SOP Blank Invoice Form report

1. Back up the Reports.dic file if you have any Microsoft Dynamics GP reports that are modified. To locate the Reports.dic file, follow these steps:

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**.

        > [!NOTE]
        > If you're prompted to type the system password, type the system password.
    1. In the Edit Launch File window, select **Microsoft Dynamics GP**. The path of the Reports.dic file appears in the **Reports** box.

2. On the **Tools** menu, point to **Customize**, and then select **Report Writer**.
3. In the **Product** list, select **Microsoft Dynamics GP**, and then select **OK**.
4. In Report Writer, select **Reports**.
5. In the **Original Reports** list, select **SOP Blank Invoice Form**, and then select **Insert**.
6. In the **Modified Reports** list, select **SOP Blank Invoice Form**, and then select **Open**.

## Create a table relationship between the Customer Master Address file and the RM Customer MSTR file

1. In the Report Definition window, select **Tables**.
2. In the Report Table Relationships window, select **03.--Customer Master Address File**, and then select **New**.
3. Select **RM Customer MSTR**, and then select **OK**.
4. Select **Close**.

## Add the Comment1 and Comment2 fields to the report layout

1. In the Report Definition window, select **Layout**.
2. In the **Toolbox** dialog box, select **RM Customer MSTR file** in the **Resource** list.
3. Drag the Comment1 field to the RH and PH sections of the report.
4. Drag the Comment2 field to the RH and PH sections of the report.

## Save the report

1. Close the Report Layout window.
2. Select **Save**.
3. In the Report Definition window, select **OK**.
4. On the **File** menu, select **Microsoft Dynamics GP**.

## Grant access to the report

**Method 1**: By using Advanced Security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.
    > [!NOTE]
    > If you're prompted to type the system password, type the system password.
2. Select **View**, and then select **by Alternate, Modified and Custom**.
3. Expand the following nodes:

    - Microsoft Dynamics GP
    - Reports
    - Sales
    - SOP Blank Invoice Form

4. Select **Microsoft Dynamics GP (Modified)**.
5. Select **Apply**, and then select **OK**.

    > [!NOTE]
    > By default, the current user and the current company are selected when you start Advanced Security. Any changes that you make apply only to the current user and the current company. However, you can select additional users in the **Advanced Security** dialog box in the **User** area. You can select additional companies in the **Advanced Security** dialog box in the **Company** area.

**Method 2**: By using Microsoft Dynamics GP security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**.
    > [!NOTE]
    > If you're prompted to type the system password, type the system password.
2. In the **User ID** list, select the user ID of the user who will access the report.
3. In the **Type** list, select **Modified Reports**.
4. In the **Series** list, select **Sales**.
5. In the **Access List** box, double-click **SOP Blank Invoice Form**, and then select **OK**.

    > [!NOTE]

    > After you select **OK**, an asterisk appears next to the report name.
