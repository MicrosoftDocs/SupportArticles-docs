---
title: Add the due date in the RM Statement on Blank Paper report
description: This article describes how to add the due date information in the RM Statement on Blank Paper report for customers who belong to a National Account in Microsoft Dynamics GP 9.0, in Microsoft Great Plains 8.0, and in Microsoft Great Plains 7.5.
ms.topic: how-to
ms.reviewer: ryanklev
ms.date: 03/13/2024
---
# Add the due date information in the RM Statement on Blank Paper report for customers who belong to a National Account

This article describes how to add the due date information in the RM Statement on Blank Paper report for customers who belong to a National Account in Microsoft Dynamics GP 9.0, in Microsoft Great Plains 8.0, and in Microsoft Great Plains 7.5.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 914169

## Introduction

This article describes how to add the due date information for customers who belong to a National Account in the RM Statement on Blank Paper report in Microsoft Dynamics GP 9.0, in Microsoft Business Solutions - Great Plains 8.0, and in Microsoft Great Plains 7.5.

## More information

1. Start Report Writer. To do this, follow these steps:
    1. On the **Tools** menu, point to **Customize**, and then click **Report Writer**.
    1. If you are using Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** in the **Product** list, and then click **OK**. If you are using Microsoft Great Plains 8.0 or Microsoft Great Plains 7.5, click **Great Plains** in the **Product** list, and then click **OK**.
2. In Report Writer, click **Reports**.
3. In the **Original Reports** list, click **RM Statement On Blank Paper**, and then click **Insert**.
4. Create a table relationship. To do this, follow these steps:
    1. On the toolbar, click **Tables**, and then click **Tables**.
    1. In the **Tables** dialog box, click **RM_Statements_TRX_TEMP**, and then click **Open**.
    1 In the **Table Definition** dialog box, click **Relationships**.
    1. In the **Table Relationship** dialog box, click **New**.
    1. Click the ellipsis button (**...**) to the right of the **Secondary Table** field.
    1. In the **Relationship Table Lookup** dialog box, click **RM Open File**, and then click **OK**.
    1. In the **Secondary Table Key** list, click **RM_Open_Key4**.
    1. In the first **Primary Table** list, click **RM Document Type-All**.
    1. In the second **Primary Table** list, click **Document Number**, and then click **OK**.
    1. Close the **Table Relationship** dialog box.
    1. Click **OK**.
    1. Close the **Tables** dialog box.
5. Create a report relationship. To do this, follow these steps:
    1. In the **Modified Reports** list, click **RM Statement On Blank Paper**, and then click **Open**.
    1. In the **Report Definition** dialog box, click **Tables**.
    1. In the **Report Table Relationships** dialog box, click **05.-RM Statement Transaction Temporary File**, and then click **New**.
    1. In the **Related Tables** dialog box, click **RM Open File**, and then click **OK**.
    1. Click **Close**.
6. Add the **Due Date** field to the layout. To do this, follow these steps:
    1. In the **Report Definition** dialog box, click **Layout**.
    1. In the **Toolbox** dialog box, click **RM Open File** in the table list.
    1. Drag the **Due Date** field to the **B** section of the report.
    1. Close the report layout.
    1. When you receive the following message, click **Save**: Do you want to save the changes to this report layout?
7. Save the report, and then close Report Writer. To do this, follow these steps:
    1. In the **Report Definition** dialog box, click **OK**.
    1. On the **File** menu, click **Microsoft Business Solutions - Great Plains**.</br></br> **Note** In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** on the **File** menu.
8. Grant access to the report.

    **Method 1: Use Advanced Security**

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**. Type the system password if you are prompted to do this.
    1. Click **View**, and then click **by Alternate, Modified and Custom**.
    1. Expand the following nodes:
        - **Great Plains** </br>**Note** In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
        - **Reports**
        - **Sales**
        - **RM Statement on Blank Paper**
    1. Click **Great Plains (Modified)**.</br> **Note** In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP (Modified)**.
    1. Click **Apply**, and then click **OK**.</br> **Note** By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are made for the current user and for the current company. However, you can select other users and companies in the following areas of the **Advanced Security** window:
        - **Company**
        - **User**

    **Method 2: Use standard security**

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**. Type the system password if you are prompted to do this.
    1. In the **User ID** list, click the user ID of the user to whom you want to give access to the report.
    1. In the **Type** list, click **Modified Reports**.
    1. In the **Series** list, click **Sales**.
    1. In the **Access List** box, double-click **RM Statement On Blank Paper**, and then click **OK**. An asterisk appears next to the report name.
