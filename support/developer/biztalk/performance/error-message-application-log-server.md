---
title: Error message in the application log of a server
description: This article explains possible causes and resolutions for the error message in the application log of a server that is running Microsoft BizTalk Server 2006 or BizTalk Server 2004.
ms.date: 09/27/2020
ms.custom: sap:Performance
---
# Error message in the application log of a computer that is running BizTalk Server

This article explains possible causes and resolutions for the error message in the application log of a server that is running Microsoft BizTalk Server 2006 or BizTalk Server 2004.

_Original product version:_ &nbsp; BizTalk Server 2009 Developer, BizTalk Server 2009 Enterprise, BizTalk Server 2009 Standard  
_Original KB number:_ &nbsp; 841334

## Symptoms

You receive an error message that is similar to the following in the application log of a server that is running BizTalk Server 2006 or BizTalk Server 2004:

> Reading error. Exception information: TDDS failed to read from source database.  
SQLServer: SQLSERVER, Database: BizTalkMsgBoxDb.

You may also receive one of the following error messages in the application event log:

- Error message 1

  > Either another TDDS is processing the same data or there is an orphaned session in SQL server holding TDDS lock. SQL Server: SQLSERVER Database: BizTalkMsgBoxDb  

- Error message 2

  > Either another TDDS is processing the same data or there is an orphaned session in SQL server holding TDDS lock. Cannot open database requested in login 'Login'. Login fails.

- Error message 3

  > Either another TDDS is processing the same data or there is an orphaned session in SQL server holding TDDS lock.The ConnectionString property has not been initialized. SQLServer: SQLSERVER, Database: BizTalkMsgBoxDb  

  > [!NOTE]
  > SQLSERVER represents the name of the computer that is running SQL Server that houses the BizTalk MessageBox database, Login is a placeholder for a user name, and `BizTalkMsgBoxDb` is a placeholder for the name of the BizTalk Server MessageBox database.

## Cause

You may receive this error message for the following reasons:

- The user account that is specified as the Logon for a BizTalk Server Host instance that tracking is enabled for is not a member of the BizTalk Application Users group on the computer that is running SQL Server that houses the Health and Activity Tracking, Business Activity Monitoring, and MessageBox databases.

- An orphaned SQL Session is preventing the Tracking Data Decode Service (TDDS), also known as the BAM Event Bus Service, from starting.

## Resolution

To resolve this problem, check the text of the error description that immediately follows the error text that is listed in the Symptoms section. Depending upon the text of the error description that immediately follows the error text, follow these steps:

- If the error text that appears is similar to the following error message:

  > EXECUTE permission denied on object 'TDDS_Lock', table 'xxx', owner 'xxx'. SQLServer: xxx, Database: xxx.

  Make sure that the user account that is specified as the Logon for a BizTalk Server Host instance for which tracking is enabled is a member of the BizTalk Application Users group on the computer that is running SQL Server that houses the Health and Activity Tracking, Business Activity Monitoring, and MessageBox databases. Also make sure no other BizTalk servers process the same tracking data from the same BizTalk MessageBox database.

  > [!NOTE]
  > xxx is a placeholder for the actual name of the table, the database owner, the computer that is running SQL Server, and the database name.

- If the error text that appears is similar to the following error message:

  > Timeout expired. The timeout period elapsed prior to completion of the operation or the server is not responding.

## Status

This behavior is by design.

## More information

The **Either another TDDS is processing the same data or there is an orphaned session in SQL server holding TDDS lock** error message indicates that more than one Tracking Data Decode Service (TDDS) is processing at the same time and on the same data. This behavior locks the data and prevents access to the data. If you receive this error message in a clustered or multi-node BizTalk Server environment, follow these steps to make sure that your domain groups are added to the correct SQL Server database roles that are created when BizTalk Server is installed.

> [!NOTE]
> You must follow these steps on each instance of SQL Server on which BizTalk Server is installed.

## Microsoft SQL Server 2005

- **Configure the BAMArchive database**

  1. Open SQL Server Management Studio.
  2. Expand the instance of SQL Server that you want to configure, expand **Databases**, expand
    **BAMArchive**, expand **Security**, expand **Roles**, and then click **Database Roles**.
  3. Double-click **BTS_ADMIN_USERS**. If the BizTalk Server Administrators group is not a member of this role, add the BizTalk Server Administrators group to the role, and then click **OK**.
  4. Click **Users**. If the BizTalk Isolated Host Users group is not a login for this database, add the BizTalk Isolated Host Users group login to the database, and then click **OK**.
  5. Click **Database Roles**, and then double-click **BTS_HOST_USERS**. If the BizTalk Isolated Host Users group is not a member of the **BTS_HOST_USERS** role, add the BizTalk Isolated Host Users group login to the **BTS_HOST_USERS** role, and then click **OK**.

- **Configure the BAMPrimaryImport database**

  1. Under **Databases**, expand **BAMPrimaryImport**.
  2. Expand **Security**, and then click **Users**.
  3. Add the BizTalk Service Account (BtsService) account as a user. This step is not performed automatically when you run the BizTalk Server Configuration Wizard (Configuration.exe). To do this, right-click **Users**, and then click **New User**, add the user, and then click **OK**.
  4. Expand **Roles**, and then click **Database Roles**.
  5. Double-click **BAM_EVENT_WRITER**, add the BizTalk Service Account and the BizTalk Server Administrators group logins to the **BAM_EVENT_WRITER** role, and then click **OK**.
  6. Double-click **BAM_ManagementWS**, add the BizTalk Service Account and the BizTalk Server Administrators group logins to the **BAM_ManagementWS** role, and then click **OK**.

- **Configure the BizTalkDTADb database**

  1. Under **Databases**, expand **BizTalkDTADb**.
  2. Expand **Security**, expand **Roles**, and then click **Database Roles**.
  3. Double-click **BAM_EVENT_WRITER**. Add the BizTalk Server Administrators group login and the BizTalk Service Account login to the **BAM_EVENT_WRITER** role, and then click **OK**.
  4. Double-click **HM_EVENT_WRITER**. Add the BizTalk Server Administrators group login and the BizTalk Service Account login to the **HM_EVENT_WRITER** role, and then click **OK**.

- **Configure the BizTalkMgmtDb database**

  1. Under **Databases**, expand **BizTalkMgmtDb**.
  2. Expand **Security**, expand **Roles**, and then click **Database Roles**.
  3. Double-click **BAM_CONFIG_READER**. Add the BizTalk Server Administrators group login and the BizTalk Service Account login to the **BAM_CONFIG_READER** role, and then click **OK**.

- **Configure the BizTalkMsgBoxDb database**

  1. Under **Databases**, expand **BizTalkMgmtDb**.
  2. Expand **Security**, and then click **Users**.
  3. Right-click the right pane, click **New User**, add the BizTalk Service account as a login to this database, and then click **OK**.
  4. Expand **Roles**, and then click **Database Roles**.
  5. Double-click **BAM_EVENT_READER**, add the BizTalk Service account login to the **BAM_EVENT_WRITER** role, and then click **OK**.

## Microsoft SQL Server 2000

- **Configure the BAMArchive database**

  1. Open SQL Server Enterprise Manager.
  2. Expand the instance of SQL Server that you want to configure, expand **Databases**, expand
    **BAMArchive**, and then click **Roles**.
  3. Double-click **BTS_ADMIN_USERS**.
  
     If the BizTalk Server Administrators group is not a member of this role, click
    **Add** to add the group, and then click
    **OK**.

     > [!NOTE]
     > If the BizTalk Server Administrators group is not available, follow these steps:

      1. Click **Cancel**.
      2. Click **Logins**.
      3. Add the BizTalk Server Administrators group as a new login for the database, and then click **OK**.
      4. Click **Roles**.
      5. Click **Add** to add the BizTalk Server Administrators group to the role.
      6. Click **OK**.

  4. Click **Users**.

     If the BizTalk Isolated Host Users group is not a login for this database, right-click the right pane, click **New User**, add the BizTalk Isolated Host Users group login to the database, and then click **OK**.

  5. Click **Roles**, and then double-click **BTS_HOST_USERS**.

     If the BizTalk Isolated Host Users group is not a member of the **BTS_HOST_USERS** role, click **Add** to add the BizTalk Isolated Host Users group login to the **BTS_HOST_USERS** role, and then click **OK**.

- **Configure the BAMPrimaryImport database**

  1. Under **Databases**, expand **BAMPrimaryImport**.
  2. You must add the BizTalk Service Account (BtsService) as a user. This step is not performed automatically when you run the BizTalk Server Configuration Wizard (ConfigFramework.exe). To do this, follow these steps:
  
     1. Click **Users**.
     2. Right-click the right pane, click **New User**, and then add the BizTalk Service Account login to this database.
     3. Click **OK**.

  3. Click **Roles**, and then double-click **BAM_EVENT_WRITER**.
  4. Add the BizTalk Service Account and the BizTalk Server Administrators group logins to the **BAM_EVENT_WRITER** role.
  5. Click **OK**.
  6. In BizTalk Server 2003, double-click **BAMQueryWS** under **Roles**. In BizTalk Server 2006, double-click **ManagementWS** under **Roles**.
  7. Add the BizTalk Service Account and the BizTalk Isolated Host Users group logins to the **BAMQueryWS** role.
  8. Click **OK**.

- **Configure the BizTalkDTADb database**

  1. Under **Databases**, expand **BizTalkDTADb**.
  2. Click **Roles**, and then double-click **BAM_EVENT_WRITER**.
  3. Add the BizTalk Server Administrators group login and the BizTalk Service Account login to the **BAM_EVENT_WRITER** role.
  4. Click **OK**.
  5. Under **Roles**, double-click **HM_EVENT_WRITER**.
  6. Add the BizTalk Server Administrators group and the BizTalk Service Account login to the **HM_EVENT_WRITER** role.
  7. Click **OK**.

- **Configure the BizTalkMgmtDb database**

  1. Under **Databases**, expand **BizTalkMgmtDb**.
  2. Click **Roles**, and then double-click
    **BAM_CONFIG_READER**.
  3. Add the BizTalk Service Account to the **BAM_CONFIG_READER** role.
  4. Click **OK**.

- **Configure the BizTalkMsgBoxDb database**

  1. Under **Databases**, expand **BizTalkMsgBoxDb**.
  2. Click **Users**.
  3. Right-click the right pane, click **New User**, and then add the service account as a login to this database.
  4. Click **OK**.
  5. Under **Roles**, double-click the **BAM_EVENT_READER** role.
  6. Add the BizTalk Service Account to the **BAM_EVENT_READER** role.
  7. Click **OK**.

> [!IMPORTANT]
> By default, these database security settings are already set when you configure BizTalk Server 2004.
