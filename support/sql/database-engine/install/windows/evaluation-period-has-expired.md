---
title: Evaluation period has expired when you use SSMS
description: This article provides a resolution for the problem that occurs when you use Microsoft SQL Server tools such as SQL Server Management Studio (SSMS) or SQL Profiler.
ms.date: 10/22/2020
ms.custom: sap:Database Engine
---
# Evaluation period has expired error message when working with SQL server

This article helps you resolve the problem that occurs when you use Microsoft SQL Server tools such as SQL Server Management Studio (SSMS) or SQL Profiler.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 971268

## Symptoms

You may encounter the following error message when using SQL Server tools such as SQL Server Management Studio (SSMS) or SQL Profiler:

Evaluation period has expired. For information on how to upgrade your evaluation software please go to [https://www.microsoft.com/sql/howtobuy](https://www.microsoft.com/sql/howtobuy).

Additionally, you may see the following error message when you try to connect to an expired installation of SQL Server instance:

> A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: Named Pipes Provider, error: 40 - Could not open a connection to SQL Server)

> [!NOTE]
> The connectivity error message is a generic message, and it's not always tied to an expired installation of a SQL Server instance.

## Cause

The problem usually occurs when you are running an evaluation instance of SQL Server and the evaluation time period has expired.

> [!NOTE]
> In the case of SQL Server 2008, you may see this error message even after upgrading to a licensed version because of a known bug.

## Resolution

- **Case 1 - You have an expired version of SQL server evaluation edition**

    > [!NOTE]
    > This also applies to scenarios wherein only tools are installed from an evaluation version.

    To upgrade the Evaluation Edition to a retail edition, you can consult the following topics in Books Online:

    - [Upgrade to a Different Edition of SQL Server 2012 (Setup)](/previous-versions/sql/sql-server-2012/cc707783(v=sql.110))

    - [Supported version & edition upgrades (SQL Server 2016)](/sql/database-engine/install-windows/supported-version-and-edition-upgrades)

    > [!NOTE]
    > In either of these topics, you can select the version picker tool at the top to pick a topic that's relevant to your environment. For SQL Server 2008 you can also refer to the KB article: [Upgrade to a Different Edition of SQL Server (Setup)](/sql/database-engine/install-windows/upgrade-to-a-different-edition-of-sql-server-setup). For SQL Server 2005, check the following KB article [Upgrade to a Different Edition of SQL Server (Setup)](/sql/database-engine/install-windows/upgrade-to-a-different-edition-of-sql-server-setup).

- **Case 2 - Moving from an enterprise evaluation edition to an express edition**

    In some cases, you may decide to move from an Enterprise evaluation edition to an Express edition. Since there's no upgrade path available, you can consult the following article on moving your user databases from the evaluation edition to express edition.

  - **Scenario 1 - You are still able to start your SQL Server evaluation version**

    Consult the following topic in SQL Server Books Online on how to move user databases: [Database Detach and Attach (SQL Server)](https://technet.microsoft.com/library/ms190794.aspx)

   > [!NOTE]
   > The maximum relational database size for SQL Express editions is 10 gigabytes (GB).

  - **Scenario 2 - You can't start an expired edition of your Enterprise evaluation edition because the evaluation period has expired**

    If the database size is less than 10 gigabytes (GB), you can follow these steps:

    1. [Install an express edition](https://www.microsoft.com/Download/details.aspx?id=101064) of the product.
    1. Locate the data files (mdf and ldf) files for your database.
    1. [Attach these files](https://technet.microsoft.com/library/ms190794%28v=sql.120%29.aspx) to the SQL express edition.

       > [!NOTE]
       > Before you attach the data files to SQL Express edition, if these files are currently located in the default data directory for the old instance, you may want to move the database files from their current location to either the new data directory for the new installation or to another location on the server.

- **Case 3 - You are running into this issue in SQL Server 2008 environments even after upgrading to a licensed version of SQL Server**

    In this case, you have the following options.

    > [!NOTE]
    > You will also notice this issue on systems where you had originally installed the evaluation edition of the shared tools and later upgrade to a licensed version.

  - Option 1

    Apply Service Pack 1 for SQL Server 2008 before upgrading the evaluation edition to a licensed edition.

    > [!NOTE]
    > If you had already performed the edition upgrade before applying Service Pack 1 for SQL Server 2008, you will be required to go through all the steps mentioned in the Option 2 section to resolve the problem. The service pack will only prevent issues that involve future edition upgrades.

  - Option 2

    Use the following procedure to fix the issue:

    > [!IMPORTANT]
    > This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

    1. Select **Start** > **Run**, enter *Regedt32*, and then select **OK**.
    1. Locate and then select the following key in the Registry Editor:

        `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\100\ConfigurationState`

    1. In the right pane of the **Registry Editor**, select **CommonFiles** (DWord type).
    1. On the **Edit** menu, select **Modify**.
    1. Type *3*, and then select **OK**.
    1. Quit **Registry Editor**.
    1. Rerun the [Upgrade to a Different Edition of SQL Server (Setup)](/sql/database-engine/install-windows/upgrade-to-a-different-edition-of-sql-server-setup) procedure to complete the upgrade of all the components to a licensed edition.

## Check whether SSMS will expire

1. Start **SQL Server Management Studio**.
1. Select the **Help** menu and then select the **About...** submenu from the list. You will run into the problem discussed in the article if the component **Microsoft SQL Server Management Studio** has **expires in 'x' days** next to it.

## Applies to

- SQL Server 2008 Developer
- SQL Server 2008 Enterprise
- SQL Server 2008 Standard
- SQL Server 2008 Web
- SQL Server 2008 Workgroup
- SQL Server 2008 R2 Developer
- SQL Server 2008 R2 Enterprise
- SQL Server 2008 R2 Express with Advanced Services
- SQL Server 2008 R2 Standard
- SQL Server 2008 R2 Standard Edition for Small Business
- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
- SQL Server 2012 Express
- SQL Server 2012 Standard
- SQL Server 2012 Web
- SQL Server 2012 Enterprise Core
- SQL Server 2014 Developer
- SQL Server 2014 Enterprise
- SQL Server 2014 Enterprise Core
- SQL Server 2014 Express
- SQL Server 2014 Standard
