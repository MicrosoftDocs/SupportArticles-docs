---
title: Error when you post a batch that has a Posting Interrupted status in the Batch Recovery window 
description: Discusses a problem that occurs if records are locked open on the server. Provides a resolution.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error when you try to post a batch that has a Posting Interrupted status in the Batch Recovery window in Microsoft Dynamics GP: Batch Failed to Complete Posting

This article provides a solution to an error that occurs when you post a batch that has a Posting Interrupted status in the Batch Recovery window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 923381

## Symptoms

When you try to post a batch that has a Posting Interrupted status in the Batch Recovery window in Microsoft Dynamics GP, you receive the following error message:

> Batch Failed to Complete Posting. Use the Batch Recovery Window to complete the posting process. Transaction not completed at initiating scripts exist, implicitly rolled back.

## Cause

This problem occurs if records are locked open on the server.

## Resolution

To resolve this problem, follow these steps:

1. Instruct all users to exit Microsoft Dynamics GP.

2. Make a full backup of Microsoft Dynamics GP that does not overwrite an existing backup.

3. Stop and then restart the computer that is running Microsoft SQL Server.

4. Run the Check Links procedure on the Sales table and on the Financial Series table. To do this, follow these steps:

    1. In Microsoft Dynamics GP, point to Maintenance on the Microsoft Dynamics GP menu, and then click **Check Links**.

    2. In the Series list, click **Sales**, and then click the **All** button.

    3. In the Series list, click **Financial Series**, and then click the **All** button.

    4. Click **OK**.

    5. Print the report.

5. Print the report. Start SQL Server Management Studio, and then run the following command against the DYNAMICS database.

    ```sql
    delete ACTIVITY
    delete SY00800
    delete SY00801
    ```

6. Start SQL Server Management Studio, and then run the following command against the TEMPDB database.

    ```sql
    delete DEX_LOCK
    delete DEX_SESSION
    ```

7. Verify that the MKDTOPST field and the BCHSTTUS field are set to 0 for all batches in the SY00500 table.
