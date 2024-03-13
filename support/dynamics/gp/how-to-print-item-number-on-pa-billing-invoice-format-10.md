---
title: How to print Item Number on PA Billing Invoice Format 10 
description: Introduces how to print the Item Number field on the PA Billing Invoice Format 10 report in Microsoft Dynamics GP.
ms.reviewer: ppeterso
ms.topic: how-to
ms.date: 03/13/2024
---
# How to print the Item Number field on the "PA Billing Invoice Format 10" report in Microsoft Dynamics GP

This article describes how to print the Item Number field on the PA Billing Invoice Format 10 report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 922560

To print the Item Number field on the PA Billing Invoice Format 10 report in Microsoft Dynamics GP, follow these steps:

1. Back up the report, and then open the report. To do this, follow these steps:

   1. If you have existing modified Microsoft Dynamics GP reports, back up the Parept.dic file. To find the Parept.dic file, follow these steps:

      1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**. If you are prompted, type the system password.
      2. In the Edit Launch File window, select **Project Accounting**. The location of the Parept.dic file is displayed in the **Reports** field.

   2. Select **Tools**, point to **Customize**, and then select **Report Writer**.
   3. In the **Product** list, select **Project Accounting**, and then select **OK**.
   4. In Report Writer, select **Reports** on the toolbar.
   5. In the **Original Reports** column, select **PA Billing Invoice Format-Invoice Format 10**, and then select **Insert**.
   6. In the **Modified Reports** list, select **PA Billing Invoice Format-Invoice Format 10**, and then select **Open**.

2. Create the table relationship. To do this, follow these steps:

    1. In Report Writer, select **Tables** on the toolbar, and then select **Tables**.

    2. Select **PA_Billing_ITEM_TEMP2**, and then select **Open**.
    3. Select the **Relationships** button.
    4. Select **New**.
    5. Select the ellipsis button (...), select **PA PO Receipt Line History**, and then select **OK**.
    6. Select the **Secondary Table Key** list, select the first key in the list, and then match the following fields in the bottom of the window:

        - Match the **PA Cost Document No.** field to the **PA Vendor Invoice Document No** field.
        - Match the **PA Cost Sequence Number** field to the **Receipt Line Number** field.

    7. Select **OK**.
    8. In the **Modified Reports** list, select the report, and then select **Open**.
    9. In the **Report Definition** window, select **Tables**.
    10. Select **PA Billing Item Temp2**, and then select **New**.
    11. Select **PA PO Receipt Line History**, select **OK**, and then select **Close**.
    12. In the Report Definition window, select **Layout**.
    13. In the Toolbox window, select **PA PO Receipt Line History**.
    14. Drag the **Item Number** field into the **Body** section of the report.
    15. Close the report layout.
    16. When you are prompted to save your changes, select **Save**.

3. Exit Report Writer. To do this, follow these steps:

    1. In the **Report Definition** dialog box, select **OK**.
    2. On the **File** menu, select **Microsoft Dynamics GP** or **Microsoft Business Solutions - Great Plains**.

4. Grant access to the report by using Advanced Security or by using standard Microsoft Dynamics GP security. To do this, use one of the following methods.

   Method 1: Use Advanced Security

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.

       > [!NOTE]
       > If you are prompted, type the system password.

    2. Select **View**, and then select **by Alternate, Modified and Custom**.
    3. Expand **Project Accounting**, expand **Reports**, expand **Project**, expand **PA Billing Invoice Format-Invoice Format 10**, and then select **Project Accounting (Modified)**.
    4. Select **Apply**, and then select **OK**.

        > [!NOTE]
        > By default, the current user and the current company are selected when you start Advanced Security. Any changes that you make are for the current user and for the current company. However, you can select additional users in the **Advanced Security** dialog box in the User area. You can select additional companies in the **Advanced Security** dialog box in the **Company** area.

    Method 2: Use standard Microsoft Dynamics GP security

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**.

       > [!NOTE]
       > If you are prompted, type the system password.

    2. In the **User ID** list, select the user ID of the user for whom you want to grant access to the report.
    3. In the **Product** list, select **Project Accounting**.
    4. In the **Type** list, select **Modified Reports**.
    5. In the **Series** list, select **Project**.
    6. In the **Access List** dialog box, double-click **PA Billing Invoice Format-Invoice Format 10**, and then select **OK**.

       > [!NOTE]
       > An asterisk appears next to the report name.
