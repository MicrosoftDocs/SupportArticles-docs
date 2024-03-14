---
title: Error when you delete user record that's stuck in the User Activity window
description: Provides a solution to an error that occurs when you delete a user record that is stuck in the User Activity window in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 02/22/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "Get Change Operation on SY_Current Activity Record Was Already Locked" error when deleting a user record that's stuck in User Activity

This article provides a solution to an error that occurs when you delete a user record that is stuck in the User Activity window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 849240

## Symptoms

When you try to delete a user record that is stuck in the **User Activity** window in Microsoft Dynamics GP, you receive the following error message:

> Get Change Operation on SY Current Activity Record Was Already Locked

## Resolution

To resolve this problem, delete the record that's associated with the stuck user from the `ACTIVITY` table by using Microsoft SQL Server Management Studio.

To delete the record from the `ACTIVITY` table, follow these steps:

1. Determine the user ID of the user who is stuck by viewing the **User Activity** window.

   To do this, on the **Microsoft Dynamics GP** menu, point to **Tools** > **Utilities** > **System**, and then select **User Activity**.

2. On the computer that's running Microsoft SQL Server, start SQL Server Management Studio.

    1. Select **Start**.
    2. Select **Programs**.
    3. Point to **Microsoft SQL Server**, and then select **SQL Server Management Studio**.

        > [!NOTE]
        > The **Connect to Server** window opens.

    4. In the **Server name** box, type the name of the instance of SQL Server.
    5. In the **Authentication** list, select **SQL Authentication**.
    6. In the **User name** box, type *sa*.
    7. In the **Password** box, type the password for the sa user.
    8. Select **Connect**.

3. Make a SQL backup copy of the `ACTIVITY` table by running the following script.

    ```sql
    SELECT * into DYNAMICS..ACTIVITY_BAK from DYNAMICS..ACTIVITY
    ```

4. Run the following script against the `DYNAMICS` database.

    ```sql
    DELETE DYNAMICS..ACTIVITY WHERE USERID = '<XXX>'
    ```

    Replace \<XXX> with the user ID that you want to remove. For example, run the following script:

    ```sql
    DELETE DYNAMICS..ACTIVITY WHERE USERID = 'John'
    ```

5. Start Microsoft Dynamics GP.
6. After you verify that the user was removed successfully from the `ACTIVITY` table, and you can log in successfully, run the following script to drop the backup table that you created in step 3.

    ```sql
    DROP table DYNAMICS..ACTIVITY_BAK
    ```
