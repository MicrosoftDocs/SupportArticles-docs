---
title: Re-create stored procedures for a company database and for the DYNAMICS database for Manufacturing in Microsoft Dynamics GP
description: Discusses how to re-create stored procedures for a company database and for the DYNAMICS database for Manufacturing in Microsoft Dynamics GP.
ms.topic: how-to
ms.reviewer: theley, aeckman
ms.date: 03/13/2024
ms.custom: sap:Manufacturing Series
---
# How to re-create stored procedures for a company database and for the DYNAMICS database for Manufacturing in Microsoft Dynamics GP

This article describes how to re-create stored procedures for a company database and for the DYNAMICS database for Manufacturing in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850013

## Re-create stored procedures for a company database and for the DYNAMICS database in Microsoft Dynamics GP 9.0

1. Make sure that all users are logged off Microsoft Dynamics GP.
2. Back up the DYNAMICS database and all the company databases.
3. Use one of the following methods to start a query tool:
   - If you are running Microsoft SQL Server 2000, click **Start**, point to **All Programs**, click **Microsoft SQL Server**, and then click **Query Analyzer**.
   - If you are running Microsoft SQL Server 2005, click **Start**, point to **All Programs**, click **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.
4. Click **File**, and then click **Open**. Open the Procs.cmp file. The following folder is the default folder for the Procs.cmp file:

   C:\\Program Files\\Microsoft Dynamics\\GP\\SQL\\Install\\346\\Company

5. Click **Edit**, and then click **Replace**.
6. In the **Find what** box, type *%SysDBName%*.
7. In the **Replace with** box, type *DYNAMICS*, and then click **Replace All**.
8. Run the script for each company database. To do this, click the green arrow button. Or, press F5.
9. Click **File**, and then click **Open**. Open the Dexprocs.cmp file. The following folder is the default folder for the Dexprocs.cmp file:

    C:\\Program Files\\Microsoft Dynamics\\GP\\SQL\\Install\\346\\Company

10. Run the script for each company database. To do this, click the green arrow button. Or, press F5.
11. In the **Database** list, click **DYNAMICS**.
12. Click **File**, and then click **Open**. Open the Procs.sys file. The following folder is the default folder for the Procs.cmp file:

     C:\\Program Files\\Microsoft Dynamics\\GP\\SQL\\Install\\346\\System

13. Run the script. To do this, click the green arrow button. Or, press F5.
14. Click **File**, and then click **Open**. Open the Procs.sys file. The following folder is the default folder for the Dexprocs.sys file:

    C:\\Program Files\\Microsoft Dynamics\\GP\\SQL\\Install\\346\\System

15. Run the script. To do this, click the green arrow button. Or, press F5.

## Re-create stored procedures for a company database and for the DYNAMICS database in versions that are earlier than Microsoft Dynamics GP 9.0

1. Make sure that all users are logged off Microsoft Business Solutions - Great Plains.
2. Back up the DYNAMICS database and all the company databases.
3. Use one of the following methods to start a query tool:
   - If you are running SQL Server 2000, click **Start**, point to **All Programs**, click **Microsoft SQL Server**, and then click **Query Analyzer**.
   - If you are running SQL Server 2005, click **Start**, point to **All Programs**, click **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.
4. In the **Database** list, click the company database for which you want to re-create the stored procedure.
5. Click **File**, and then click **Open**.
6. In the Open Query File window, click **Mfgprocs.cmp**. The following folder is the default folder for the Mfgprocs.cmp file:

    C:\\Program Files\\Microsoft Business Solutions\\Great Plains\\Sql\\Company

7. Run the script for each company database. To do this, click the green arrow button. Or, press F5.
8. Click **File**, and then click **Open**.
9. In the **Open Query File** window, click **Mfgdprocs.cmp**. The following folder is the default folder for the Mfgdprocs.cmp file:

    C:\\Program Files\\Microsoft Business Solutions\\Great Plains\\Sql\\Company

10. Run the script for each company database. To do this, click the green arrow button. Or, press F5.
11. In the **Database** list, click **DYNAMICS**.
12. Click **File**, and then click **Open**.
13. In the Open Query File window, click **Mfgprocs.sys**. The following folder is the default folder for the Mfgprocs.sys file:

    C:\\Program Files\\Microsoft Business Solutions\\Great Plains\\Sql\\System

14. Run the script. To do this, click the green arrow button. Or, press F5.
15. Click **File**, and then click **Open**.
16. In the Open Query File window, click **Mfgprocs.sys**. The following folder is the default folder for the Mfgprocs.sys file:

    C:\\Program Files\\Microsoft Business Solutions|Great Plains\\Sql\\System

17. Run the script. To do this, click the green arrow button. Or, press F5.
18. Click **File**, and then click **Open**.
19. In the **Open Query File** window, click **Mfgdproc.sys**. The following folder is the default folder for the Mfgdproc.sys file:

    C:\\Program Files\\Microsoft Business Solutions|Great Plains\\Sql\\System

20. Run the script. To do this, click the green arrow button. Or, press F5.
21. In Microsoft Great Plains Utilities, perform the Perform Special Upgrade task. To do this, follow these steps:

    1. Start Microsoft Business Solutions - Great Plains Utilities.
    2. In the Welcome to Microsoft Business Solutions - Great Plains Utilities window, verify the server name, type the system administrator user ID and password, and then click **OK**.

        > [!NOTE]
        > You must log on to Microsoft Business Solutions - Great Plains Utilities as the system administrator user.

    3. Click **Next** two times.
    4. In the Additional Tasks window, click **Perform special upgrade** in the task list. A check mark will appear next to the **Dynamics (System)** database and next to all the company databases to indicate a successful upgrade.
