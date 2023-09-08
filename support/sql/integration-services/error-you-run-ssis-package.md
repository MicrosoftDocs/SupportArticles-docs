---
title: Error when you try to run an SSIS package
description: This article provides resolutions for the problem that occurs when you try to run an SSIS package on systems where User Account Control (UAC) is enabled.
ms.date: 09/15/2020
ms.custom: sap:Integration Services
---
# Unable to prepare the SSIS bulk insert for data insertion on UAC enabled systems

This article helps you resolve the problem that occurs when you try to run an SSIS package on systems where User Account Control (UAC) is enabled.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2009672

## Symptoms

Consider the following scenario:

- You create a SQL Server Integration Services (SSIS) package that has a SQL Server Destination component within a Dataflow Task.
- You try to run this package on systems where User Account Control (UAC) is enabled (for example Vista or Windows 7) using one of the following methods：

  - Business Intelligence Development Studio (BIDS)
  - SQL Server Management Studio (SSMS) Object Explorer
  - DTExec.exe
  - DTExecUI.exe

In this scenario, you may get an error message that is similar to the following:

> SQL Server Destination] Error: Unable to prepare the SSIS bulk insert for data insertion.
[SSIS.Pipeline] Error: component "SQL Server Destination" failed the pre-execute phase and returned error code 0xC0202071.

> [!NOTE]
> You will not get this error if you run the package under the Builtin Administrator Account that gets created during Operating System installation. But you will get this message for any other user including those that are members of the Local Administrators group.
>
> The problem does not occur when you execute the same SSIS package as a SQL Server Agent job.
>
> After SQL 2008 Service Pack 2 is installed, the text of the error **DTS_E_BULKINSERTAPIPREPARATIONFAILED (0xC0202071)** has been changed to: **Unable to bulk copy data. You may need to run this package as an administrator.**
>
> This change was made in attempt to make it easier to understand the corrective action needed, as described in the resolution section of this KB.

## Cause

On systems where UAC is enabled, when an application (like SSIS) is launched by an account that is a member of the Administrators group, it gets two security tokens, one a low privileged token and another an elevated token. The elevated token is only used when the application is explicitly run under an Administrator account by choosing **Run as Administrator** option. By default SSIS always uses the low privileged token resulting in a failure when connecting to a SQL Destination.

## Resolution

Use one of the following methods to work around the problem:

- If you are running the package from either SQL Server Management Studio (SSMS) or Business Intelligence Development Studio (BIDS) or DTExecUI.exe, launch those tools under the elevated Administrator account. To do this, click **Start**, point to **All Programs**, point to **SQL Server 2005** or **SQL Server 2008**, right-click the tool you are using and then click **Run as administrator**. This launches the application with elevated privileges of the Built In Administrator account and the package executes successfully.

  Similarly if you are running the package using DTExec.exe launch it from an elevated command prompt. You can start the elevated command prompt by clicking **Start**, click **All Programs**, click **Accessories**, right-click **Command Prompt**, and then click **Run as administrator.**  

  > [!NOTE]
  > If you do not log on to the computer as an administrator, you are prompted to provide the administrator account. When you are prompted to provide the administrator account, type the administrator user name and password in the **User Account Control** dialog box. Then, click **OK**.  

- Replace the SQL Server Destination components in the Dataflow Tasks that are failing with OLE DB Destination components that point to the same SQL Server connection manager.

- Use an account that is not a member of the local Administrators group after assigning Create Global Objects user right to that account. To do this, follow these steps:

  1. Click **Start**, point to **Administrative Tools**, and then click **Local Security Policy**.
  2. Expand **Local Policies**, and then click **User Rights Assignment**.
  3. In the right pane, double-click **Create global objects**.
  4. In the **Local Security Policy Setting** dialog box, click **Add**.
  5. In the **Select Users** or **Group** dialog box, click the user accounts that you want to add, click **Add**, and then click **OK**.
  6. Click **OK**.
  
> [!NOTE]
> When using an account that is not a member of local Administrators group, UAC does not come into play.

## More information

- [How to use User Account Control (UAC) in Windows Vista](https://support.microsoft.com/help/922708)
- [Guided Help: Adjust User Account Control settings in Windows 7 and Windows 8](https://support.microsoft.com/help/975787)
- [What happened to the Run as command?](https://windows.microsoft.com/en-US/windows7/What-happened-to-the-Run-as-command)
