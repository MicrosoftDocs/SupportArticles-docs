---
title: Your attempt to log into the server failed because of an unknown error
description: This article provides a resolution for the problem that occurs when you start Microsoft Dynamics GP.
ms.reviewer: theley, kyouells
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "Your attempt to log into the server failed because of an unknown error" when you start Microsoft Dynamics GP

This article helps you resolve the problem that occurs when you start Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 865801

## Symptoms

When you start Microsoft Dynamics GP, you receive the following error message:

> Your attempt to log into the server failed because of an unknown error. Attempt to log in again.

## Cause

This problem occurs when the `DEX_LOCK` and `DEX_SESSION` tables don't exist in the `TEMPDB` database in the SQL Server that's being used for Microsoft Dynamics GP.

## Resolution 1

Restart the instance for SQL Server that's being used with Microsoft Dynamics GP. To do this, follow these steps:

1. Select **Start**, point to **All Programs** > **Microsoft SQL Server**, and then select **SQL Server Management Studio**.

2. In the **Connect to Server** window, follow these steps:

    1. In the **Server name** box, type the name of the server that is running SQL Server.
    2. In the **Authentication** box, select **SQL Authentication**.
    3. In the **login** box, type _sa_.
    4. In the **Password** box, type the password for the sa user, and then select **Connect**.

3. Right-click the instance name of the SQL Server, and then select **Restart**.

## Resolution 2

Start Microsoft Dynamics GP or Microsoft Dynamics GP Utilities as the sa user. To do this, follow these steps:

1. On a computer that's running Microsoft Dynamics GP, point to **All Programs** > **Microsoft Dynamics**, and then select **GP** or **Utilities**.

2. In the login box, type _sa_.

3. In the **Password** box, type the password for the sa user, and then select **OK**.

## Resolution 3

Re-create the tables by using the **dex_req.sql** script. To do this, follow these steps:

1. Locate the **dex_req.sql** file in the installation folder.

   - If you're running Microsoft Dynamics GP, the default location is **C:\Program Files\Microsoft Dynamics\GP\SQL\Utililty\0**.

2. Open the **dex_req.sql** file in SQL Server Management Studio, and then select **Execute** to run the script.
