---
title: Error when you delete user record that's stuck in the User Activity window
description: Provides a solution to an error that occurs when you delete a user record that is stuck in the User Activity window.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Error when you try to delete a user record that is stuck in the User Activity window: "Get Change Operation on SY_Current Activity Record Was Already Locked"

This article provides a solution to an error that occurs when you delete a user record that is stuck in the User Activity window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 849240

## Symptoms

When you try to delete a user record that is stuck in the User Activity window in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you receive the following error message:

> Get Change Operation on SY Current Activity Record Was Already Locked

## Resolution

To resolve this problem, delete the record that is associated with the stuck user from the ACTIVITY table by using SQL Server Management Studio or SQL Query Analyzer.

To delete the record from the ACTIVITY table, follow these steps:

1. Determine the userid of the user who is stuck by viewing the User Activity window. To do this, follow the steps for your version of the program.

    - Microsoft Dynamics GP 2010 or Microsoft Dynamics GP 10.0

        On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **System**, and then click **User Activity**.

    - Microsoft Dynamics GP 9.0 or earlier versions

        On the **Tools** menu, point to **Utilities**, point to **System**, and then click **User Activity**.

2. On the computer that is running Microsoft SQL Server, start SQL Server Management Studio or SQL Query Analyzer. To do this, follow the steps for the program that you use.

    - SQL Server Management Studio 2008 or SQL Server Management Studio 2005

        1. Click **Start**.
        2. Click **Programs**.
        3. Point to **Microsoft SQL Server 2005** or to **Microsoft SQL Server 2008**, and then click **SQL Server Management Studio**.

            > [!NOTE]
            > The **Connect to Server** window opens.

        4. In the **Server name** box, type the name of the instance of SQL Server.
        5. In the **Authentication** list, click **SQL Authentication**.
        6. In the **User name** box, type *sa*.
        7. In the **Password** box, type the password for the sa user.
        8. Click **Connect**.

    - SQL Server 2000

        1. Click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **Query Analyzer**.
        2. In the **Server** name box, type the name of the instance of SQL Server.
        3. In the **Authentication** list, click **SQL Authentication**.
        4. In the **User name** box, type sa .
        5. In the **Password** box, type the password for the sa user, and then click **Connect**.

3. Make a SQL backup copy of the ACTIVITY table by running the following script.

    ```sql
    SELECT * into DYNAMICS..ACTIVITY_BAK from DYNAMICS..ACTIVITY
    ```

4. Run the following script against the DYNAMICS database.

    ```sql
    DELETE DYNAMICS..ACTIVITY WHERE USERID = '<XXX>'
    ```

    Replace \<XXX> with the userid that you want to remove. For example, run the following script:

    ```sql
    DELETE DYNAMICS..ACTIVITY WHERE USERID = 'John'
    ```

5. Start Microsoft Dynamics GP.
6. After you verify that the user was removed successfully from the ACTIVITY table, and you can log in successfully, run the following script to drop the backup table that you created in step 3.

    ```sql
    DROP table DYNAMICS..ACTIVITY_BAK
    ```
