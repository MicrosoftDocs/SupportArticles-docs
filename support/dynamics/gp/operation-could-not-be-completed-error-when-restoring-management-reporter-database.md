---
title: The operation could not be completed error when restoring Microsoft Management Reporter 2012 database
description: Describes an error message that you may receive if you restore or move the Management Reporter 2012 database to a new server. Provides a resolution.
ms.reviewer: theley, jopankow, kevogt
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Management Reporter
---
# "The operation could not be completed" error when you restore a Microsoft Management Reporter 2012 database

This article provides a resolution for the **The operation could not be completed** that may occur when you restore a Microsoft Management Reporter 2012 database.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics AX 2009, Microsoft Dynamics SL 2011, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2744330

## Symptoms

After you restore a Management Reporter 2012 database, you may receive the following error in the Management Reporter 2012 Report Designer:

> The operation could not be completed due to a failure on the server.

Error message that is received in the Windows Event Viewer Application log:

> System.Data.SqlClient.SqlException (0x80131904): Please create a master key in the database or open the master key in the session before performing this operation.The 'pEncryptGeneralUserData' procedure attempted to return a status of NULL, which is not allowed. A status of 0 will be returned instead.

## Cause

The Management Reporter 2012 database is encrypted by using server-specific information, and cannot be backed up/restored without additional steps.

## Resolution

The process for moving the Management Reporter 2012 database is as follows:

> [!NOTE]
> If you are using a Management Reporter 2012 provider that uses the Dynamic Datamart (DDM) database, do not move the DDM database. Instead, a new database will be created by using the process here.

1. Start the Management Reporter 2012 Configuration Console.
2. Select **Management Reporter Services**.
3. Record the name of the database listed under the Database connection heading. The database name will be listed after the SQL server name. For example: SQLServer (Database)
4. Record the name of the Service Account that is used.
5. Sign in to SQL Server Management Studio.
6. Back up the Management Reporter 2012 database recorded earlier in this topic.
7. Start the Management Reporter 2012 Report Designer.
8. Export each building block group. The reports can be reimported if a failure were to occur. You can do this by following these steps:

    1. Under the **Company** menu, select **Building Block Groups**.
    2. Select the building block group to export.
    3. Select **Export**.
    4. Select all building blocks to be exported on the Report Definitions, Row Definitions, Column Definitions, Reporting Tree Definitions tabs. Also, select all Dimension Value Sets.
    5. Select **Export**.
    6. Choose a location to save the `.tdbx` export file.

       > [!NOTE]
       > The default path on a Windows Server 2008 server is C:\Users\\*\<username>*\Documents\Management Reporter\Building Block Groups

    7. Select **Close** on the Building Block Groups window.

9. Exit Management Reporter 2012 Report Designer.
10. Start the Management Reporter 2012 Configuration Console.
11. In the navigation bar, select the name of the SQL server.
12. Select Remove to remove the ERP integration.
13. Select **Yes** to the prompt **Are you sure you want to remove the ERP Integration?**.
14. In the navigation bar, select **Management Reporter Services**.
15. Select **Remove Process Service**.
16. Select **Yes** to the prompt **Are you sure you want to remove 'Management Reporter 2012 Process Service'?**.
17. Select **Remove Application Service**.
18. Select **Yes** to the prompt **Are you sure you want to remove 'Management Reporter 2012 Application Service'?**.
19. Sign in to SQL Server Management Studio.
20. Back up the Management Reporter 2012 database recorded earlier in this topic.
21. Sign in to SQL Server Management Studio on the *new* SQL server.
22. Restore the Management Reporter 2012 database on the *new* SQL server.
23. Verify that the Management Reporter 2012 service account has the correct permissions on the SQL server and to the new database. Refer to the Management Reporter installation guides at [Management Reporter 2012 for Microsoft Dynamics ERP: Installation, Migration, and Configuration Guides](https://www.microsoft.com/download/details.aspx?id=5916).

24. Using the instructions here, run the following script against the Management Reporter 2012 database on the new SQL server:

    ```sql
    --////////////////////////////////////////////////////////////////
    -- 
    -- Script Instructions:
    -- 
    -- 1. Update the line in the following code, starting with 'CREATE MASTER KEY ENCRYPTION BY PASSWORD', to contain the 
    -- Master key you wish to use. The master key must meet the Windows password policy 
    -- requirements of the computer that is running the instance of SQL Server.
    --
    -- 2. Run this script against the Management Reporter 2012 database. This script
    -- will output a message if it does not detect the Management Reporter 2012 database.
    --
    --////////////////////////////////////////////////////////////////
    
    IF EXISTS (SELECT Name FROM sys.tables WHERE Name = 'ControlReportSchedule')
     BEGIN
     IF EXISTS (SELECT TOP(1) name FROM sys.symmetric_keys WHERE name = 'GeneralUserSymmetricKey')
     DROP SYMMETRIC KEY GeneralUserSymmetricKey
    
    IF EXISTS (SELECT TOP(1) name FROM sys.certificates WHERE name = 'GeneralUserCertificate')
     DROP CERTIFICATE GeneralUserCertificate
    
    IF EXISTS (SELECT TOP(1) name FROM sys.symmetric_keys WHERE name = 'ConnectorServiceSymmetricKey')
     DROP SYMMETRIC KEY ConnectorServiceSymmetricKey
    
    IF EXISTS (SELECT TOP(1) name FROM sys.certificates WHERE name = 'ConnectorServiceCertificate') 
     DROP CERTIFICATE ConnectorServiceCertificate
    
    IF EXISTS (SELECT TOP(1) name FROM sys.symmetric_keys WHERE name = '##MS_DatabaseMasterKey##')
     DROP MASTER KEY
    
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Access!23'
     -- NOTE Where Access!23 is your actual password
    
    CREATE CERTIFICATE [ConnectorServiceCertificate]
     AUTHORIZATION [dbo]
     WITH SUBJECT = N'Certificate for symmetric key encryption - for use by the connector service.'
    
    CREATE CERTIFICATE [GeneralUserCertificate]
     AUTHORIZATION [dbo]
     WITH SUBJECT = N'Certificate for access symmetric keys - for use by users assigned to the GeneralUser Role.'
    
    CREATE SYMMETRIC KEY [ConnectorServiceSymmetricKey]
     AUTHORIZATION [dbo]
     WITH ALGORITHM = AES_256
     ENCRYPTION BY CERTIFICATE [ConnectorServiceCertificate]
    
    CREATE SYMMETRIC KEY [GeneralUserSymmetricKey]
     AUTHORIZATION [dbo]
     WITH ALGORITHM = AES_256
     ENCRYPTION BY CERTIFICATE [GeneralUserCertificate]
    
    IF NOT EXISTS (SELECT TOP(1) name FROM sys.database_principals WHERE name='GeneralUser') 
     BEGIN 
     CREATE ROLE [GeneralUser]
     AUTHORIZATION [dbo]
     END 
    
    GRANT CONTROL ON CERTIFICATE::[GeneralUserCertificate] TO [GeneralUser]
     GRANT VIEW DEFINITION on SYMMETRIC KEY::[GeneralUserSymmetricKey] TO [GeneralUser]
     GRANT CONTROL ON CERTIFICATE::[ConnectorServiceCertificate] TO [GeneralUser]
     GRANT VIEW DEFINITION on SYMMETRIC KEY::[ConnectorServiceSymmetricKey] TO [GeneralUser] 
     UPDATE Connector.Adapter
     SET Settings.modify('declare namespace x="https://www.microsoft.com/2009/Dynamics/Integration";
     replace value of 
     (/SettingsCollection/x:ArrayOfSettingsValue/x:SettingsValue[x:Attributes="Password"]/x:Value/text())[1] 
     with ""')
     UPDATE Connector.MapCategoryAdapterSettings
     SET Settings.modify('declare namespace x="https://www.microsoft.com/2009/Dynamics/Integration";
     replace value of 
    (/SettingsCollection/x:ArrayOfSettingsValue/x:SettingsValue[x:Attributes="Password"]/x:Value/text())[1] 
     with ""')
     END
    ELSE
     BEGIN
     PRINT 'WARNING: Incorrect database selected.'
     Print 'Execute script against the Management Reporter 2012 database.'
     PRINT 'This can be found in the Management Reporter 2012 Configuration Console.'
     END
    ```

    > [!NOTE]
    > If using Management Reporter 2012 with Microsoft Dynamics AX 2012, also run the following SQL statements to reset the organization hierarchies in the Microsoft Management Reporter 2012 Report Designer. This information will be retrieved from Microsoft Dynamics AX once the new integration is enabled.

    ```sql
    delete ControlTreeMaster where FolderID in (select FolderID from ControlFolderIntegration)
    delete ControlFolder where ID in (select FolderID from ControlFolderIntegration)
    delete ControlFolderIntegration
    ```

25. Start the Microsoft Management Reporter 2012 Configuration Console.
26. Under the **File** menu, select **Configure**.
27. Put a check next to Management Reporter Application Service and Management Reporter Process Service.
28. Select **Next**.
29. Correct any issues noted on the Prerequisite Validation screen, and then select **Next**.
30. In the Service Account section, enter the name of the service account recorded earlier. Also enter the password for the service account.
31. In the Database Configuration section, put a check in Connect to an existing database.
32. Enter the name of the new SQL Server in the Database server field.
33. Select to use Windows authentication, or enter a SQL authenticated username and password.
34. In the Database dropdown, select the name of the newly restored Management Reporter 2012 database.
35. In the Application Service section, enter a port number for the application service to run on. If the Windows Firewall is enabled on the server, put a check next to Open this port in the Windows Firewall.
36. Select **Next**.
37. Select **Configure**.
38. Select **Close** on the Configure Management Reporter screen when the process is completed.
39. Under the **File** menu, select **Configure**.
40. Put a check next to the ERP that is correct for your environment.
41. Select **Next**.
42. Follow the instructions for the ERP for your environment using the appropriate guide at [Management Reporter 2012 for Microsoft Dynamics ERP: Installation, Migration, and Configuration Guides](https://www.microsoft.com/download/details.aspx?id=5916).

    > [!NOTE]
    > If you use a Management Reporter 2012 provider that uses the Dynamic Data mart (DDM) database, do not move the DDM database. Instead, create a new data mart database.

43. After the integration has successfully created, select **Close**. You must complete the steps below before you select **Enable Integration**.
44. In the Management Reporter 2012 Configuration Console, select the name of the data mart integration.
45. Select Update Dynamics XX credentials, where XX is either AX, GP, SL, or NAV (depending on your Dynamics ERP).
46. Enter the appropriate credentials to connect to the Dynamics ERP database, and then select **OK**.
47. Select **Update data mart credentials**.
48. Enter the appropriate credentials to be used to update the data mart database, and then select **OK**.
49. In the Management Reporter 2012 Configuration Console, stop the Management Reporter 2012 Application Service and the Management Reporter 2012 Process Service.
50. In the Management Reporter 2012 Configuration Console, start the Management Reporter 2012 Application Service and the Management Reporter 2012 Process Service.
51. In the Management Reporter 2012 Configuration Console, select the name of the data mart integration.
52. Select **Enable Integration**.
