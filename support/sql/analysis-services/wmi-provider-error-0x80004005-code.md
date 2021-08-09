---
title: WMI Provider Error and 0x80004005 code
description: This article provides a resolution for the problem that occurs when you change the service account that was specified during SQL Server setup to a new domain account using SQL Server Configuration Manager.
ms.date: 11/09/2020
ms.prod-support-area-path: Analysis Services
ms.prod: sql
---
# Can't start SQL Server Analysis Services clustered instance after changing service account

This article helps you resolve the problem that occurs when you change the service account that was specified during SQL Server setup to a new domain account using SQL Server Configuration Manager.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4041637

## Symptom

Assume that you have clustered instances in Microsoft SQL Server 2008 or in SQL Server 2008 R2. When you change the service account in SQL Server Configuration Manager from the account that was specified during SQL Server setup to a new domain account, you receive an error message that resembles the following in SQL Server Configuration Manager:  

> WMI Provider Error  
Unspecified error [0x80004005]

Additionally, you can't start the SQL Server Analysis Services clustered instance. When you check the system event log, you see the following error message:

> The MSSQLServerOLAPService service was unable to log on as \<Domain>\<New account> with the currently configured password due to the following error:
>
>Logon failure: the user has not been granted the requested logon type at this computer.
>
>Service: MSSQLServerOLAPService  
>Domain and account:\<Domain>\<New account>
>
>This service account does not have the required user right "Log on as a service."
>
>User Action
>
>Assign "Log on as a service" to the service account on this computer. You can use Local Security Settings (Secpol.msc) to do this. If this computer is a node in a cluster, check that this user right is assigned to the Cluster service account on all nodes in the cluster.
>
>If you have already assigned this user right to the service account, and the user right appears to be removed, check with your domain administrator to find out if a Group Policy object associated with this node might be removing the right.

> [!NOTE]
> The Service shown earlier is for the default instance. For a named instance, the service name is MSOLAP$\<instance name>.

## Cause

This issue occurs because when you set up the clustered instance of Analysis Services, the service SID isn't granted the **Log on as a service local policy user** right (SeServiceLogonRight).

## Resolution

To fix this issue, grant the SQL Server Analysis Services service SID the local policy user Log on as a service right.

- For a default instance of SQL Server Analysis Services, t he name of the service SID is `NT SERVICE\MSSQLServerOLAPService`.
- For a named instance, the name is `NT SERVICE\MSOLAP$\<instance name>`.

To grant the **Log on as a service right** to the service SID, follow these steps:

1. Open **Local Security Policy** by running the **Secpol.msc** command.
2. Expand **Local Policies**.
3. Click **User Rights Assignment**.
4. In the right pane, right-click **Log on as a service**, and then click **Properties**.
5. Click **Add User or Group**.
6. Click the **Locations** button, select the server name, and then click **OK**.
7. In **Enter the object names to select** box, type *NT SERVICE\MSSQLServerOLAPService*, and then click **OK**.

   > [!NOTE]
   > For a named instance, instead use `MSOLAP$\<instance name>`.

8. Click **OK**.

You must repeat these steps for all nodes in the cluster.

## More information

This issue only affects clustered instances of Analysis Services for SQL Server 2008 and SQL Server 2008 R2. For SQL Server 2012 and later versions of the program, you can't reproduce this issue.
