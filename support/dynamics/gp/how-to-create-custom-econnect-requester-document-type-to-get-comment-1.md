---
title: How to create eConnect Requester Document Type to get Comment_1
description: Introduces how to create a custom eConnect Requester Document Type to retrieve the Comment_1 information for a transaction in Sales Order Processing.
ms.reviewer: theley, dclauson
ms.topic: how-to
ms.date: 03/13/2024
---
# How to create a custom eConnect "Requester Document Type" to retrieve the Comment_1 information for a transaction in Sales Order Processing

This article describes how to create a custom eConnect Requester Document Type to retrieve the Comment_1 information for a transaction in Sales Order Processing in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 919442

> [!NOTE]
> In this example, the eConnect Transaction Requester Service is used to gather the Comment_1 information for a Sales Order Processing transaction and to put the data into the eConnect_Out table. The new custom Requester Document Type must pull data from the Sales Line Comment Work and History table. The data will be retrieved from the SOP10202 table.

To create and to test a custom Requester Document Type, follow these steps:

1. Copy the following SQL script into SQL Query Analyzer. Then, run the script against the company database to create the settings that you want for this new Requester Document Type.

    ```sql
    INSERT INTO eConnect_Out_Setup (QUEUE_ENABLED, DOCTYPE, INSERT_ENABLED, UPDATE_ENABLED, DELETE_ENABLED, TABLENAME, ALIAS, MAIN, PARENTLEVEL, ORDERBY,REQUIRED1, INDEX1, INDEX2, INDEX3, INDEX4, INDEXCNT, TRIGGER1, TRIGGER2, TRIGGER3, TRIGGER4,TRIGGERCNT, DATACNT, DATA1) VALUES (0, 'SopComment', 1, 1, 0, 'SOP10202', 'SopComment', 1, 0, 0, 'COMMENT_1','SOPNUMBE', 'SOPTYPE', 'CMPNTSEQ', 'LNITMSEQ', 4, 'SOPNUMBE', 'SOPTYPE','CMPNTSEQ','LNITMSEQ', 4, 1, 'COMMENT_1')
    ```

2. After the new Requester Document Type has been created in the eConnect_Out_Setup table, test the new Requester Document Type. To do this, select **Sales** on the **Transactions** menu, and then select **Sales Transaction Entry**.

3. Create a new invoice or order, and then add an item number to the transaction in Sales Order Processing.

4. Select the **Item Number** expansion button to open the Sales Item Detail Entry window. Select the **Comment ID** expansion button, and then add a comment. Select **OK**.

    > !NOTE]
    > The **Item Number** expansion button is the arrow icon to the right of **Item Number**. The **Comment ID** expansion button is the arrow icon to the right of **Comment ID**.

5. In the Sales Item Detail Entry window, select **Save**.
6. Query the eConnect_Out table to verify that you have a record for the Requester Document Type SopComment.
