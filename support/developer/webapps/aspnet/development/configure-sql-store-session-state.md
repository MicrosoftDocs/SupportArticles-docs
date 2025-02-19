---
title: Store ASP.NET SQL Server mode session state
description: This article describes how to configure ASP.NET SQL Server mode session state management.
ms.date: 03/26/2020
ms.custom: sap:General Development
ms.topic: how-to
---
# Configure SQL Server to store ASP.NET session state  

This article demonstrates how to configure Microsoft SQL Server for ASP.NET SQL Server mode session state management.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 317604

## Requirements

The following list outlines the recommended hardware, software, network infrastructure, and service packs that you need:

- Windows
- .NET Framework
- Internet Information Services (IIS)
- SQL Server

## Configure SQL Server for ASP.NET SQL Server session state

The following steps describe how to run the *InstallSqlState.sql* and the *UninstallSqlState.sql* script files to configure SQL Server mode session state management.

1. In SQL Query Analyzer, on the **File** menu, select **Open**.
2. In the **Open Query File** dialog box, browse to the *InstallSqlState.sql* script file, and then select **Open**. By default, *InstallSqlState.sql* is located in one of the following folders:

    - `system drive\WINNT\Microsoft.NET\Framework\version\`
    - `system drive\Windows\Microsoft.NET\Framework\version\`
3. After *InstallSqlState.sql* opens in SQL Query Analyzer, select **Execute** on the **Query** menu to run the script.
4. Before you run the *UninstallSqlState.sql* script file to uninstall SQL Server mode session state management configuration, you must stop the w3svc process. To do this, follow these steps:

    1. On the **Windows Start** menu, select **Run**, type **cmd**, and then select **OK** to open a command prompt.
    2. At the command prompt, type `net stop w3svc`. You receive confirmation that the w3svc process is stopped.
5. In SQL Query Analyzer, on the **File** menu, select **Open**.
6. In the **Open Query File** dialog box, browse to the *UninstallSqlState.sql* script file, and then select **Open**. By default, *UninstallSqlState.sql* is located in one of the following folders:

    - `system drive\WINNT\Microsoft.NET\Framework\version\`
    - `system drive\Windows\Microsoft.NET\Framework\version\`  
7. After *UninstallSqlState.sql* opens in SQL Query Analyzer, select **Execute** on the **Query** menu to run the script.
8. After you uninstall SQL Server mode session state management configuration, you must restart the w3svc service. To restart the w3svc process, type `net start w3svc` at a command prompt.

## Modify the Web.config file of your application

To implement ASP.NET SQL Server mode session state management, you must modify the `<sessionState>` element of your application's *Web.config* file as follows:

1. Set the mode attribute of the `<sessionState>` element to **SQLServer** to indicate that session state is stored in SQL Server.
2. Set the `sqlConnectionString` attribute to specify the connection string for SQL Server. For example:

    ```xml
    sqlConnectionString="data source=MySQLServer;user id=<username>;password=<strongpassword>"
    ```

    > [!NOTE]
    > The user, \<user name>, must have permissions to perform this operation on the database.

The modified `<sessionState>` element should appear as follows:

```xml
<sessionState
    mode="SQLServer"
    sqlConnectionString="data source=127.0.0.1;user id=<username>;password=<strongpassword>"
    cookieless="false"
    timeout="20"
/>
```

> [!NOTE]
> Ensure that you use the correct case when you specify the `<sessionState>` element and the associated attribute values. This code is case sensitive.

## Troubleshooting

- If you don't stop the w3svc process before you run the *UninstallSqlState.sql* script file, you receive the following error message:

    > Cannot drop the database 'ASPState' because it is currently in use

- If entries in the *ASPStateTempSessions* table aren't removed after the related sessions expire, make sure that the SQL Server agent is running. You can implement this functionality through stored procedures that are scheduled through jobs in SQL Server. The SQL Server agent manages these jobs.

- When you use the default *InstallSqlState.sql* and *UninstallSqlState.sql* script files to configure ASP.NET SQL Server mode session state management. These files add the *ASPStateTempSessions* and the *ASPStateTempApplications* tables to the *tempdb* database in SQL Server by default. Furthermore, if you restart SQL Server, you lose the session state data that was stored in the *ASPStateTempSessions* and the *ASPStateTempApplications* tables. For more information about how to run alternative scripts to configure persistent SQL Server session state management so that the session data isn't lost when you restart the server.

## References

[Session State](/previous-versions/dotnet/netframework-1.1/87069683(v=vs.71))
