---
title: Error message when you start Microsoft Dynamics GP
description: This article provides a resolution for the problem that occurs when you start Microsoft Dynamics GP.
ms.reviewer: kyouells
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error message when you start Microsoft Dynamics GP (Your attempt to log into the server failed because of an unknown error. Attempt to log in again.)

This article helps you resolve the problem that occurs when you start Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 865801

## Symptoms

When you start Microsoft Dynamics GP, you receive the following error message:

> Your attempt to log into the server failed because of an unknown error. Attempt to log in again.

## Cause

This problem occurs when the `DEX_LOCK` and `DEX_SESSION` tables do not exist in the database TEMPDB Database in the SQL Server that is being used for Microsoft Dynamics GP.

## Resolution

- Method 1

  Restart the instance for SQL Server that is being used with Microsoft Dynamics GP. To do this, follow these steps depending on the SQL Server version you are using.

  - Microsoft SQL Server 2000

    1. Click **Start**, point to **All Programs**, and then click **Enterprise Manager**.

    2. In the **Connect to Server** window, follow these steps:

       1. In the **Server name** box, type the name of the server that is running SQL Server.

       2. In the **Authentication** box, click **SQL Authentication**.

       3. In the **login** box, type *sa*.

    3. Right-click the instance name of the SQL Server, click **Stop**, and then click **Start**.

  - Microsoft SQL Server 2005 and SQL Server 2008

    1. Click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005** or **Microsoft SQL Server 2008**, and then click **SQL Server Management Studio**.

    2. In the **Connect to Server** window, follow these steps:

       1. In the **Server name** box, type the name of the server that is running SQL Server.

       2. In the **Authentication** box, click **SQL Authentication**.

       3. In the **login** box, type sa .

       4. In the Password box, type the password for the sa user, and then click **Connect**.

    3. Right-click the instance name of the SQL Server, and then click **Restart**.

- Method 2

  To resolve this issue, start Microsoft Dynamics GP or Microsoft Dynamics GP Utilities as the sa user. To do this, follow these steps:

  1. On a computer that is running Microsoft Dynamics GP 10.0, point to **All Programs**, point to **Microsoft Dynamics**, point to **GP 10.0**, and then click **GP** OR click **Utilities**.

     - If you are running Microsoft Dynamics GP 9.0, click **Start**, point to **All Programs**, point to **Microsoft Dynamics**, point to **GP 9.0**, and then click **GP** OR click **Utilities**.

     - If you are running Microsoft Business Solutions Great Plains 8.0, click **Start**, point to **All Programs**, point to **Microsoft Business Solutions**, point to **Great Plains**, and then click **Great Plains** OR click **Great Plains Utilities**.

  2. In the login box, type *sa*.

  3. In the **Password** box, type the password for the sa user, and then click **OK**.

- Method 3

  To resolve this issue, re-create the tables by using the dex_req.sql script. To do this, follow these steps:

  1. Locate the dex_req.sql file that is located in the installation folder.

     - If you are running Microsoft Dynamics GP 10.0 or 9.0, the default location is `C:\Program Files\Microsoft Dynamics\GP\SQL\Utililty\0`.

     - If you are running Microsoft Business Solutions-Great Plains 8.0, the default location is located on a Server installation at `C:\Program Files\Microsoft Business Solutions\Great Plains\SQL\Util`.

  2. Open the dex_req.sql file in Query Analyzer or Management Studio, and then click **Execute** to run the script.
