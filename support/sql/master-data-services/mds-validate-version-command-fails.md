---
title: MDS Validate Version command fails
description: This article provides resolutions for the problem where MDS Validate Version command fails with a server error in SQL Server.
ms.date: 05/09/2025
ms.custom: sap:Master Data Services
ms.reviewer: jopilov
---
# MDS Validate Version command fails with a server error in SQL Server

This article helps you resolve the problem where Master Data Services (MDS) Validate Version command fails with a server error in SQL Server.

_Original product version:_ &nbsp; SQL Server    
_Original KB number:_ &nbsp; 2711671

## Symptoms

Consider the following scenario:

- An administrator installs Microsoft SQL Server and then deploys the MDS website by using a new application pool account.

- Later, you browse to the MDS website and then follow these steps:

    1. You click the **Manage Versions** page.

    1. You click the **Validate Version** command on the top toolbar.

    1. You select the **Validate** check box for **Model**.

    1. You confirm the **Are you sure that you want to validate this version?** prompt and then click **OK**.

In this scenario, you receive the following error message in the browser window:

> Server Error in '/' Application.  
An error occurred while processing message request type 'ValidationGetRequest'. See exception details for more information.  
Description: An unhandled exception occurred during the execution of the current web request. Please review the stack trace for more information about the error and where it originated in the code.  
Exception Details: Microsoft.MasterDataServices.WebUI.ServiceAdapterException: An error occurred while processing message request type 'ValidationGetRequest'. See exception details for more information.  
Source Error:  
An unhandled exception was generated during the execution of the current web request.  Information regarding the origin and location of the exception can be identified using the exception stack trace below.  
Stack Trace:  
[ServiceAdapterException: An error occurred while processing message request type 'ValidationGetRequest'. See exception details for more information.]  
Microsoft.MasterDataServices.WebUI.ServiceAdapter.InspectResponseForErrors(MessageRequest request, MessageResponse response) +687  
Microsoft.MasterDataServices.WebUI.ServiceAdapter.ExecuteRequest(MdmServiceOperation 2 operation, TRequestType request) +75  
Microsoft.MasterDataServices.WebUI.ServiceAdapter.GetValidationStatus(Int32 versionInternalId, Nullable 1 entityInternalId, Nullable 1 memberType, String notificationUserName, IList 1 memberIds, Boolean omitSummary, Boolean omitIssuesList, Int32 pageNumber, Int32 pageSize, String sortColumn, SortDirection sortDirection) +678  
Microsoft.MasterDataServices.WebUI.ServiceAdapter.GetValidationStatus(Int32 versionInternalId, Int32 pageNumber, Int32 pageSize, String sortColumn, SortDirection sortDirection) +133  
Microsoft.MasterDataServices.WebUI.Common.Validations.LoadGrid() +355  
Microsoft.MasterDataServices.WebUI.Audit.Dimensions.LoadGrid() +26  
Microsoft.MasterDataServices.WebUI.Audit.Dimensions.EvaluateSelectedVersion() +267  
Microsoft.MasterDataServices.WebUI.Audit.Dimensions.OnLoad(EventArgs e) +776  
System.Web.UI.Control.LoadRecursive() +71  
System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint) +3064

> [!NOTE]
> A similar problem may occur when a custom Microsoft .NET Framework application uses the MDS API class ValidationGetRequest. This problem is documented on: [ValidationGetRequest Class](/dotnet/api/microsoft.masterdataservices.validationgetrequest).

## Cause

This problem occurs because new accounts are not granted the `VIEW SERVER STATE` permission.

When you use the Master Data Services Configuration Manager utility to create an MDS website, the tool prompts you for the application pool user account credentials for the application pool identity.

Next, after the MDS server and database are selected, the tool grants permissions to the account. The specified application pool credential account is granted several permissions in the specified MDS database and is added to the `MDS_ServiceAccounts` local users group and to the `mds_exec` database role within the specified MDS database catalog.

However, the `VIEW SERVER STATE` permission is not granted to the master database. Sometimes, Windows accounts may have that permission in SQL Server. However, by default, new accounts are not granted that permission.

The `VIEW SERVER STATE` permission is useful to query the service broker by using the `sys.dm_broker_activated_tasks` dynamic management view (DMV) to check the progress of queued background activity.

The MDS web application internally runs the exec `mdm.udpValidationIsRunning` stored procedure to check the validation progress. However, the application pool credential that is running the query does not have permissions to the DMV and receives the following error message:

> The user does not have permission to perform this action.

The following statement inside the procedure fails, and the webpage is not rendered:

```sql
IF EXISTS (SELECT 1 FROM sys.dm_broker_activated_tasks
    WHERE procedure_name = N'[mdm].[udpValidationQueueActivate]')
```

## Workaround

To work around this problem, use an account that is a member of the system administrator fixed server role to manually grant permissions to the account designated to run the MDS application pool.

For example, to manually grant the permissions, run the following commands:

```sql
USE Master;

GO

GRANT VIEW SERVER STATE TO <domain\MdsWebAppAccount>;
```

> [!NOTE]
> The placeholder \<domain\MdsWebAppAccount> represents the correct account for your configuration.

## More information

To determine whether this problem is related to the `VIEW SERVER STATE` permission, run a SQL Profiler trace, and then look for the following error message when you run the statements as described in the [Cause](#cause) section:

> The user does not have permission to perform this action.

Then, check the account for effective permissions, and add the permissions if it is necessary. To do this, follow these steps:

1. Open Management Studio, and then connect to the SQL Server database engine that is hosting the MDS catalog.

1. In the **Object Explorer** pane, expand the **Security** folder.

1. Locate the account that is used to run the IIS MDS application pool.

1. Right-click the account, and then click **Properties**.

1. Click the **Securables** page. In the bottom pane, click the **Effective** tab.

    - If the effective permission `VIEW SERVER STATE` is listed, this is likely not the problem.

    - If the permission is not listed, return to the **Explicit** tab on the **Login Properties** dialog box, and then click to select the **View Server State Permissions** check box to grant permissions to the account.

## References

For more information about how to use the Master Data Manager web application to validate data, see:

- [Validate a Version against Business Rules (Master Data Services)](/sql/master-data-services/validate-a-version-against-business-rules-master-data-services)

- [sys.dm_broker_activated_tasks (Transact-SQL)](/sql/relational-databases/system-dynamic-management-views/sys-dm-broker-activated-tasks-transact-sql)
