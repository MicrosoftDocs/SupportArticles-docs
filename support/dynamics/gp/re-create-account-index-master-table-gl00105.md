---
title: Re-create the Account Index Master table (GL00105) in Microsoft Dynamics GP
description: Describes how to re-create the Account Index Master table (GL00105) in Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains 8.0.
ms.topic: how-to
ms.reviewer: theley, v-ancar, cwaswick
ms.date: 03/13/2024
---
# How to re-create the Account Index Master table (GL00105) in Microsoft Dynamics GP

This article describes how to re-create the Account Index Master table (GL00105) in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 855963

To re-create the Account Index Master table (GL00105) in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0, use one of the following options.

## Option 1: Use the SQL query tool, and then check the links

1. Have all users exit Microsoft Dynamics GP.
2. Delete the contents of the Account Index Master table. To do this, follow these steps:
   1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following methods depending on the program that you are using.

      - Method 1: For SQL Server Desktop Engine

          If you are using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, click **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then click **Support Administrator Console**.

      - Method 2: For SQL Server 2000

          If you are using SQL Server 2000, start SQL Query Analyzer. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **Query Analyzer**.

      - Method 3: For SQL Server 2005

          If you are using SQL Server 2005, start SQL Server Management Studio. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.

      - Method 4: For SQL Server 2008

          If you are using SQL Server 2008, start SQL Management Studio. to do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then click **SQL Server Management Studio**.  

   2. Run the following statement against the company database:
  
      ```sql
      Delete GL00105
      ```

    > [!NOTE]
    > There may be an Automated Solution available to perform this task.

3. Start Microsoft Dynamics GP.

4. Follow the appropriate step:

   - In Microsoft Dynamics GP 2010 and in Microsoft Dynamics GP 10.0, on the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **Check Links**.
   - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, on the **File** menu, point to **Maintenance**, and then click **Check Links**.
5. In the **Series** list, click **Financial**.
6. In the **Logical Tables** list, click **Account Master**.
7. Click **Insert**, and then click **OK**. When you are prompted, click to select the **Screen** check box to generate the error log report to the screen, and then click **OK**. After the check links process is complete, a report is generated.

## Option 2: Use the Toolkit

Use the Toolkit to re-create the GL00105 table. The Toolkit is a free tool in the Professional Services Tools Library (PSTL).

For more information about the Professional Services Tools Library, use one of the following options:

- Customers:

    For more information about PSTL, contact your partner of record. If you do not have a partner of record, visit the following web site to identify a partner:

    [Microsoft Pinpoint](https://pinpoint.microsoft.com/home)

- Partners:

    1. Start Microsoft Dynamics GP.

        > [!NOTE]
        > You must log on to Microsoft Dynamics GP as the sa user.

    2. Open the Professional Services Tools Library (PSTL).
    3. When you are prompted for a utilities registration code, leave the box blank, and then click **OK**.
    4. In the **System Tools** area, click **Toolkit**, and then click **Next**.
    5. In the Toolkit window, click **Rebuild GL00105**, and then click **Next**.
    6. Click **Rebuild GL00105**.
    7. When you are prompted to verify that all users are out of the system, click **Yes**.
    8. When you are prompted that the rebuild is complete, click **OK**.
