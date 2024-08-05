---
title: You cannot be in the accounting system
description: Provides a solution to an error that occurs when you start Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "Your login has been removed from the user activity file and you cannot be in the accounting system" Error message when you start Microsoft Dynamics GP

This article provides a solution to an error that occurs when you start Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 916679

## Symptoms

When you start Microsoft Dynamics GP, you receive the following error message:

> Your login has been removed from the user activity file and you cannot be in the accounting system.

## Cause

This problem occurs when an automatic client update is published. Additionally, the path of the Microsoft Windows Installer file (.msp file) is incorrect, or the .msp file is missing.

## Resolution

To resolve this problem, use one of the following methods.

### Method 1

If the client update is already installed on all clients, delete the client update that is published. To do it, follow these steps:

1. Sign in to Microsoft Dynamics GP by using a system administrator (sa) user account.
2. Use the appropriate step:
   - In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then select **Client Updates**.
   - In Microsoft Dynamics GP 9.0, point to **Setup** on the **Tools** menu, point to **System**, and then select **Client Updates**.
3. In the **Manage Automated Client Updates** window, select the icon next to the **Update Name** box.
4. In the **Updates** window, select the update that you installed, and then select **Select**.
5. In the **Manage Automated Client Updates** window, select **Delete**.

### Method 2

If you want to keep the client update, verify that the .msp file exists and that the path of the .msp file is correct. To do it, follow these steps:

1. Sign in to Microsoft Dynamics GP by using a sa user account.
2. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Client Updates**.
3. In the **Manage Automated Client Updates** window, select the icon next to the **Update Name** box.
4. In the **Updates** window, verify that the path of the .msp file is correct. Correct the path if it's incorrect.
5. Verify that the .msp file is in the directory at the end of the path.

### Method 3

If no user can sign in to the system, remove the automatic client update from the automatic client update table in the DYNAMICS database. To do it, follow these steps:

1. Confirm that you have a backup of the DYNAMICS database.
2. Open SQL Query Analyzer or SQL Server Management Studio.
3. To display all automatic client updates, run the following SQL statement.

    ```sql
    select * from DYNAMICS..SYUPDATE
    ```

4. Remove the automatic client update that doesn't have a valid UNCPath. To do it, run the following script.

    ```sql
    delete DYNAMICS..SYUPDATE where UPDATENAME = 'XXXX'
    ```

    > [!NOTE]
    > Replace 'XXXX' with the correct update name.
5. Sign in to Microsoft Dynamics GP.

## Status

Microsoft has confirmed that it's a problem in the Microsoft products that are listed in the Applies to section. This problem isn't scheduled to be fixed.
