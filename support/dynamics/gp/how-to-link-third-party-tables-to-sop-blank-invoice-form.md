---
title: Link third-party tables to SOP Blank Invoice Form via Dexterity
description: How to link third-party tables to the SOP Blank Invoice Form report by using Dexterity for Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Distribution - Sales Order Processing
---
# How to link third-party tables to the SOP Blank Invoice Form report by using Dexterity for Microsoft Dynamics GP

This article describes how to link third-party tables to the SOP Blank Invoice Form report by using Dexterity for Microsoft Dynamics GP 9.0 and for Microsoft Business Solutions - Great Plains 8.0. This article is specifically intended for developers who have created tables in a Dexterity program. This article describes how to link these tables to the SOP Blank Invoice Form report. However, you can use the procedure for any report in which you must link to third-party tables.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 935380

## More information

Consider the following scenario:

You create the SOP Ship Weight table in a Dexterity program. The SOP Ship Weight table is the companion table to the SOP Line Work table that contains the **Item Shipping Weight** field. You want the **Item Shipping Weight** field to appear in the SOP Blank Invoice Form report. To link the SOP Ship Weight table to the SOP Blank Invoice Form report, follow these steps.

> [!NOTE]
> You must create a one-to-one relationship if the tables have the same key. If you try to create a direct relationship from the SOP Line Work table to the SOP Ship Weight table, the table relationship will be lost when you create the chunk file.

1. In Dexterity, open the SOP Blank Invoice Form report. To do this, follow these steps:

    1. In the **Resource Explorer** pane, select **Reports**.
    2. In the **Reports** list, double-click **SOP Blank Invoice Form**.
    3. In the Report Definition window, select **Tables**.
    4. In the Report Table Relationships window, note the items in the **Report Table Relations** list. You will need this information later when you add the tables back to the report. You have to add the tables back to the report because you have to duplicate every table in the **Report Table Relations** list above the Sales Transaction Amounts Work table. This includes the Sales Transaction Amounts Work table.

2. Duplicate the tables. To do this, follow these steps:

    1. In the **Resource Explorer** pane, select **Tables**.
    2. In the **Tables** list, select **SOP_Document_HDR_TEMP**.
    3. On the **Utilities** menu, select **Duplicate**.
    4. In the **New Name** field, type a name for the table, and then select **OK**. For example, type *SOP_Document_HDR_Temp_DUP*.
    5. Double-click the new duplicate table, and then add DUP to the display name in the **Display Name** field.
    6. Select **OK** to save the duplicate table.

3. Reopen the duplicate table, and then create a new relationship from the duplicate table to the original SOP Document Header temporary table. To do this, follow these steps:

    1. Double-click the new duplicate table.
    2. Select **Relationships**, and then select **New**.
    3. In the **Relationship Table Lookup** window, select the duplicate table that you created in step 2.
    4. In the **Secondary Table Key** list, select **SOP_DOCUMENT_HDR_TEMP_Key1**.
    5. In the **Primary Table** list, duplicate the items that are listed in the **Secondary Table** list.
    6. Select **OK**.
    7. Repeat step 3a through step 3f for each table that you noted in step 1d. Specifically, duplicate the following tables:

       - Sales Document Header Temp
       - Sales Transaction Work
       - Sales Transaction Amounts Work

       > [!NOTE]
       > You do not have to duplicate the other tables because you are not linking directly to the tree in which these tables belong.

4. In the duplicate Sales Transaction Amounts Work table, create a relationship to the SOP Ship Weight table. To do this, follow these steps:

    1. In the **Resource Explorer** pane, double-click the duplicate Sales Transaction Amounts Work table in the **Tables** list.
    2. Select **Relationships**, and then select **New**.
    3. In the Relationship Table Lookup window, select **SOP Ship Weight**, and then select **OK**.
    4. In the **Secondary Table Key** list, select **SOP Ship Weight Key1**.
    5. In the **Primary Table** list, duplicate the items that are listed in the **Secondary Table** list.
    6. Select **OK**.

5. Follow step 3a through step 3f to add the following relationships:

   - Add a relationship from the Sales Document Header Temp duplicate table to the Sales Transaction Work duplicate table. Use key 1 for the relationship.
   - Add a relationship between the Sales Transaction Work duplicate table to the Sales Transaction Amounts duplicate table. Use key 1 for the relationship.

6. In the Report Definition window, change the main table of the report from the current table to the Sales Document Header Temp duplicate table that you created. To do this, follow these steps:

    1. Select the tables button, and then select **New**. Add the original Sales Document Header Temp table to the Sales Document Header Temp duplicate table.
    2. Link the Sales Transaction Work duplicate table to the Sales Document Header Temp duplicate table.
    3. Link the original Sales Transaction Work table to the Sales Transaction Work duplicate table.
    4. Link the Customer Master Address table and the Sales User Defined Work History table to the original Sales Transaction Work table.
    5. Link the Sales Transactions Amounts Work duplicate table to the Sales Transaction Work duplicate table.
    6. Link the original Sales Transaction Amounts Work table and the SOP Ship Weight table to the Sales Transactions Amounts Work duplicate table.
    7. Link the Sales Line Comment Work and History table and the Sales Serial/Lot Work and History table to the original Sales Transaction Amounts Work table.

7. Open the SOP Blank Invoice Form report layout. Drag the **Item Shipping Weight** field into the **H2** section of the report.

> [!NOTE]
> The report that you created by using this method will function slower than the original report. This occurs because the tables have been duplicated and because more data is evaluated. However, by using this method, you can transfer any data from the companion table to the report. When you use this method, the report must be included as an additional report. Any changes to the report by the client must be redone in the additional report.

## References

There is an alternate method that you can use to incorporate third-party data into a Microsoft Dynamics GP report. This method uses Report Writer functions and does not require that you use another report. For more information, see [Useful functions for developers to use instead of creating alternate reports in Microsoft Dynamics GP](https://support.microsoft.com/topic/useful-functions-for-developers-to-use-instead-of-creating-alternate-reports-in-microsoft-dynamics-gp-ad87080c-b0ee-ca4d-2d79-db808b019190).
