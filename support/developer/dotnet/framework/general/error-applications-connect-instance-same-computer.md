---
title: Error when applications connect to an instance
description: This article provides three workarounds for the problem that occurs when applications connect to an instance of Microsoft SQL Server on the same computer.
ms.date: 01/07/2021
ms.reviewer: 
ms.topic: troubleshooting
---
# Known issue in the December Security and Quality Rollups 3210137 and 3210138 for the .NET Framework 4.5.2 on Windows 8.1, Windows Server 2012 R2, and Windows Server 2012

This article helps you work around the problem that occurs when applications connect to an instance of Microsoft SQL Server on the same computer.

_Applies to:_ &nbsp; .NET Framework 3.5 Service Pack 1  
_Original KB number:_ &nbsp; 3214106

## Summary

The December 13, 2016, Security and Quality Rollup updates [3210137](https://support.microsoft.com/help/3210137) and [3210138](https://support.microsoft.com/help/3210138) contain a known issue that affects the .NET Framework 4.5.2 running on Windows 8.1, Windows Server 2012 R2, and Windows Server 2012. The issue was also present in the November 15, 2016, rollup updates that were superseded by the December updates. This article contains a workaround for this issue.

## Symptoms

Applications that connect to an instance of Microsoft SQL Server on the same computer generate the following error message:

> provider: Shared Memory Provider, error: 15 - Function not supported

To work around this issue, use one of the following methods.

## Workaround 1

Disable the **Shared Memory** and **Named Pipes** protocols on the server side to force TCP-only connections to SQL Server. To do this, follow these steps.  

> [!IMPORTANT]
> Before you disable other protocols, make sure that the TCP/IP protocol is enabled.

1. Start SQL Server Configuration Manager.

    :::image type="content" source="./media/error-applications-connect-instance-same-computer/configuration-manager.png" alt-text="SQL Server Configuration Manager.":::

1. Expand the **SQL Server Network Configuration** node.
1. Select the **Protocols for <**SQLServer_instance**>** node for the instance of SQL Server that you're connecting to.
1. Right-click **Shared Memory**, and then select **Disable**.

    :::image type="content" source="./media/error-applications-connect-instance-same-computer/disable-shared-memory.png" alt-text="Screenshot of the sql server configuration manager window, showing menus to disable the protocol item named Shared Memory.":::

1. Repeat step 4 for **Named Pipes**, if it's enabled.

     > [!NOTE]
     > TCP/IP should be the only protocol in this list that's enabled.

1. Select the **SQL Server Services** node.
1. Right-click the instance of SQL Server that you updated.
1. Select **Restart**.

    :::image type="content" source="./media/error-applications-connect-instance-same-computer/restart-sql-server-service.png" alt-text="Screenshot shows menus to restart a SQL Server instance.":::

## Workaround 2

Create an alias on the server to force TCP protocol for local applications. To do this, see the following MSDN and TechNet topics:

- [Create or Delete a Server Alias for Use by a Client (SQL Server Configuration Manager)](/previous-versions/sql/sql-server-2012/ms190445(v=sql.110))

- [Creating a SQL Server alias using the SQL Server Client Network Utility](https://azurecloudai.blog/2013/01/22/creating-a-sql-server-alias-using-the-sql-server-client-network-utility/)

## Workaround 3

Disable shared memory from the Client Configuration tool (32-bit and 64-bit). To do this, follow these steps:

1. Start the Client Configuration tool on the server by typing *cliconfg.exe*.
1. If it's selected, clear the **Enable shared memory protocol** check box.

    :::image type="content" source="./media/error-applications-connect-instance-same-computer/client-network-utility-dialog-box.png" alt-text="Screenshot of the SQL Server Client Network Utility dialog box. The Enable shared memory protocol check box is cleared.":::  

    > [!NOTE]
    > On a 64-bit server, if you run 32-bit applications that connects to SQL Server, you must run this procedure by using the 32-bit Client Configuration tool that is located in the `C:\Windows\SysWOW64` folder.

## Applies to

This issue applies to users who have the .NET Framework 4.5.2 installed on Windows 8.1, Windows Server 2012 R2, or Windows 2012, and who have applied either of the following December 2016 updates:

- Security and Quality Rollup for the .NET Framework 4.5.2 on Windows 8.1 and Windows Server 2012 R2 (KB3210137)
- Security and Quality Rollup for the .NET Framework 4.5.2 on Windows Server 2012 (KB3210138)

This issue is also present in the following (now superseded) November 2016 Preview of Quality Rollup updates:

- November 2016 Preview of Quality Rollup for the .NET Framework 3.5, 4.5.2, 4.6, 4.6.1 on Windows 8.1 and Server 2012 R2 (KB3196684)
- November 2016 Preview of Quality Rollup for the .NET Framework 3.5, 4.5.2, 4.6, 4.6.1 on Windows Server 2012 (KB3195383)
- November 2016 Preview of Quality Rollup for the .NET Framework 3.5.1, 4.5.2, 4.6, 4.6.1 on Windows 7 SP1 and Windows Server 2008 R2 SP1 (KB3196686)
- November 2016 Preview of Quality Rollup for the .NET Framework 2.0 SP2, 4.5.2, 4.6 on Windows Vista SP2 and Windows Server 2008 SP2 (KB3195382)

## Resolution

This issue is resolved in the following updates:

- [Description of the Security and Quality Rollup for the .NET Framework 4.5.2 for Windows Server 2012: May 9, 2017](https://support.microsoft.com/help/4014513)

- [Description of the Security and Quality Rollup for the .NET Framework 4.5.2 for Windows 8.1 and Windows Server 2012 R2: May 9, 2017](https://support.microsoft.com/help/4014512)
