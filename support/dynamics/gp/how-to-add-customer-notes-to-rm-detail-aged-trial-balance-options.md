---
title: How to add customer notes to RM Detail Aged Trial Balance Options
description: How to add the customer notes from the Customer Maintenance window to the RM Detail Aged Trial Balance - Options report in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: how-to
ms.date: 03/13/2024
---
# How to add customer notes from the Customer Maintenance window to the RM Detail Aged Trial Balance - Options report

This article describes how to add the customer notes from the Customer Maintenance window to the RM Detail Aged Trial Balance - Options report in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 851669

To add the customer notes from the Customer Maintenance window to the RM Detail Aged Trial Balance - Options report, follow these steps:

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, select **Report Writer**, select **Microsoft Dynamics GP** in the **Product** box, and then select **OK**.

   In Microsoft Business Solutions - Great Plains 8.0, select **Tools**, point to **Customize**, select **Report Writer**, select **Great Plains** in the **Product** box, and then select **OK**.

2. Create the table relationship. To do this, follow these steps:

    1. On the toolbar, select **Tables**, and then select **Tables**.
    2. In the Tables window, scroll down, select **RM_Customer_MSTR**, and then select **Open**.
    3. In the Table Definition window, select **Relationships**, and then select **New**.
    4. In the Table Relationship Definition window, select the ellipsis button (...) next to the Secondary Table.
    5. In the Relationship Table Lookup box, select **Record Notes Master**, and then select **OK**.
    6. In the Table Relationship Definition window, select **SY_Record_Notes_MSTR_Key_1** for the Secondary Table Key.
    7. In the Table Relationship Definition window, select **Note Index** for the Primary Table, and then select **OK**.
    8. Close all the open windows by selecting **OK** or by closing the window as appropriate.

3. Add the **Record Notes Master** field to the report layout. To do this, follow these steps:

    1. On the toolbar in Report Writer, select **Reports**.
    2. Under **Original Reports**, select **RM Detail Aged Trial Balance - Options**, and then select **Insert**.
    3. Under **Modified Reports**, select **RM Detail Aged Trial Balance - Options**, and then select **Open**.
    4. Select **Tables**.
    5. In the Report Table Relationships window, select **RM Customer MSTR**, and then select **New**.
    6. In the Related Tables window, select **Record Notes Master**, and then select **OK**.
    7. In the Report Table Relationships window, select **Close**.
    8. In the Report Definition window, select **Layout**.
    9. In the Toolbox window, select **Record Notes Master** in the list for the table.
    10. Select **Text Field** from the Record Notes Master table, and drag it to the Header 1 (H1) section of the report.

4. Save the changes to the report. To do this, follow these steps:

    1. On the **File** menu, select **Microsoft Dynamics GP** or **Microsoft Business Solutions-Great Plains**, and you are prompted to save the changes to this report.
    2. Select **Save** two times, and then Microsoft Dynamics GP opens.

5. Assign security permissions to the modified report. To assign security permissions to the modified report, use one of the following methods:

    - Method 1: Use the User Security Tool in Microsoft Dynamics GP 10.0

      1. Select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **System**, and then select **Alternate/Modified Forms and Reports**.
      2. In the **ID** field, type or select the alternate/modified forms and reports ID that is associated with the user ID that will print the modified report.
      3. In the **Product** box, select **Microsoft Dynamics GP**.
      4. In the **Type** box, select **Reports**.
      5. Expand **Sales**.
      6. Expand the **RM Detail Aged Trial Balance - Options** report.
      7. Select to select **Microsoft Dynamics GP (Modified)**.
      8. Select **Save**, and then close the window.
      9. Select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **System**, and then select **User Security**.
      10. In the **User** box, type or select a user ID from the list.
      11. In the **Company** box, select the appropriate company.
      12. In the **Alternate/Modified Forms and Reports ID** box, select the user ID that you typed in step b.

    - Method 2: Use the Advanced Security Tool in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0

      1. Select **Tools**, point to **Setup**, point to **System**, and then select **Advanced Security**.
      2. If it is necessary, type the password, and then select **OK**.
      3. Select **View**, and then select **by Alternate, Modified and Custom**.
      4. In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.

         In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.
      5. Expand **Reports**, expand **Sales**, and then expand the **RM Detail Aged Trial Balance - Options** report.
      6. In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP (Modified)**.

         In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains (Modified)**.
      7. Select **OK**.

         > [!NOTE]
         > By default, the current user and the current company are selected when you start the Advanced Security tool. Any changes that you make affect the current user and the current company. However, you can select additional users in the **Users** area of the Advanced Security window. You can select additional companies in the **Company Name** area of the Advanced Security window.

    - Method 3: Use the Security Tool in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains

      1. Select **Tools**, point to **Setup**, point to **System**, and then select **Security**.
      2. If it is necessary, type the password, and then select **OK**. Select **No** if you are prompted to open Advanced Security.
      3. In the **User ID** box, select the user ID of the user who you want to have access to the modified report.
      4. Select the appropriate company for the user.
      5. Leave the product of **Microsoft Dynamics GP**.
      6. In the **Type** box, select **Modified Reports**.
      7. In the **Series** box, select **Sales**.
      8. In the **Access List** box, select the **RM Detail Aged Trial Balance - Options** report, and then select **OK**.

         > [!NOTE]
         > An asterisk (*) appears next to the report name to signify that access was granted.

      > [!IMPORTANT]
      > Voided documents in the report are not removed from the total if the document was voided with a date that differs from the original document date and if the report was printed with a date that is before the voided date.
