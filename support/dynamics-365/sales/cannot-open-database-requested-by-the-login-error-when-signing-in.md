---
title: Cannot open database requested by the login error when you sign in
description: Describes a problem that occurs when you try to sign in to Microsoft Dynamics CRM 2011. A resolution is provided.
ms.reviewer: njohnson, svetter
ms.topic: troubleshooting
ms.date: 
---
# Cannot open database requested by the login error when you sign in to Microsoft Dynamics CRM

This article provides a resolution for the issue that you may receive a **Cannot open database "Organization_MSCRM" requested by the login** error when sign in to Microsoft Dynamics CRM.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 946286

## Symptoms

You install Microsoft Dynamics CRM. When you try to sign in to Microsoft Dynamics CRM, you receive the following error message:

> Cannot open database "**Organization**_MSCRM" requested by the login.  
The login failed. Login failed for user 'NT AUTHORITY\NETWORK SERVICE'.

If the DevErrors value is set to **On** in the Web.config file, you receive an error message that resembles the following:

> Server Error in '/' Application.
>
> Cannot open database "MSCRM_CONFIG" requested by the login. The login failed.  
Login failed for user '**Domain\\CRMServer$**'.  
Description: An unhandled exception occurred during the execution of the current web request. Please review the stack trace for more information about the error and where it originated in the code.
>
> Exception Details: System.Data.SqlClient.SqlException: Cannot open database "MSCRM_CONFIG" requested by the login. The login failed. Login failed for user '**Domain\\CRMServer$**'.
>
> Source Error:
>
> An unhandled exception was generated during the execution of the current web request. Information regarding the origin and location of the exception can be identified using the exception stack trace below.
>
> Stack Trace:
>
> [SqlException (0x80131904): Cannot open database "MSCRM_CONFIG" requested by the login. The login failed.
>
> Login failed for user '**Domain\\CRMServer$**'.]
>
> System.Data.ProviderBase.DbConnectionPool.GetConnection(DbConnection owningObject) +437  
System.Data.ProviderBase.DbConnectionFactory.GetConnection(DbConnection owningConnection) +82  
System.Data.ProviderBase.DbConnectionClosed.OpenConnection(DbConnection outerConnection, DbConnectionFactory connectionFactory) +105  
System.Data.SqlClient.SqlConnection.Open() +111  
Microsoft.Crm.CrmDbConnection.Open() +386  
Microsoft.Crm.SharedDatabase.DatabaseMetadata.LoadMetadataXmlFromDatabase(CrmDBConnectionType connectionType, String connectionString, Int32& maxBlobSize) +125  
Microsoft.Crm.SharedDatabase.DatabaseMetadata.LoadCacheFromDatabase(CrmDBConnectionType connectionType, String connectionString) +65  
Microsoft.Crm.ConfigurationDatabase.ConfigurationMetadata.LoadCache() +41  
Microsoft.Crm.ConfigurationDatabase.ConfigurationMetadata.get_Cache() +114  
Microsoft.Crm.ConfigurationDatabase.ConfigurationDatabaseService.InitializeMetadataCache() +28  
Microsoft.Crm.SharedDatabase.DatabaseService.Initialize(String tableName) +53  
Microsoft.Crm.SharedDatabase.DatabaseService.Retrieve(String tableName, String[] columns, PropertyBag[] conditions) +109  
Microsoft.Crm.ServerLocatorService.GetSiteSettingIdFromDatabase() +155  
Microsoft.Crm.ServerLocatorService.GetSiteSettingId() +187  
Microsoft.Crm.ServerLocatorService.GetSiteSetting(String settingName) +82  
Microsoft.Crm.LocatorService.GetSiteSetting(String settingName) +35  
Microsoft.Crm.CrmTrace.get_RefreshTrace() +654  
Version Information: Microsoft .NET Framework Version:2.0.50727.832; ASP.NET Version:2.0.50727.832  

## Cause

This problem occurs if one or more of the following conditions are true:

- You install Microsoft Dynamics CRM in a multiple-server environment. Then, you install Microsoft Dynamics CRM directly on a server that is running Microsoft SQL Server. However, some SQL Server permissions are not set.
- The Microsoft Dynamics CRM server is not added to the SQLAccessGroup group in the Active Directory directory service.

## Resolution

To resolve this problem, use one or more of the following methods.

### Method 1

Set up the NT AUTHORITY\NETWORK SERVICE account as a SQL Server user who has access to the Microsoft Dynamics CRM databases. To do this, follow these steps:

1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Management Studio**.
    > [!NOTE]
    > For Dynamics CRM 2011, it will be Microsoft SQL Server 2008.
2. To sign in to SQL Server Management Studio, select **OK**.
3. In Object Explorer, expand **Databases**, expand the **Organization_MSCRM** database, and then expand **Security**.
4. Right-click **Users**, and then select **New User**.
5. In the **Database User - New** dialog box, type *NT AUTHORITY\NETWORK SERVICE* in the following fields:
    - The **User name** field.
    - The **Login name** field.
6. In the **Database role membership** area, select the **db_owner** check box, and then select **OK**.

### Method 2

Add the Microsoft Dynamics CRM server to the SQLAccessGroup group in Active Directory. To do this, follow these steps:

1. Select **Start**, select **Run**, type *dsa.msc*, and then select **OK**.
2. Select the organizational unit in which you install Microsoft Dynamics CRM.
3. Double-click **SQLAccessGroup**.
4. In the **SQLAccessGroup** dialog box, select **Members**, select **Add**, select **Object Types**, select the **Computers** check box, and then select **OK**.
5. In the **Enter the object names to select** box, type the name of the Microsoft Dynamics CRM server, and then select **Check Names**.
6. Verify that the name of the Microsoft Dynamics CRM server in the **Enter the object names to select** box is available, and then select **OK** two times.
7. Restart the Microsoft Dynamics CRM server.
