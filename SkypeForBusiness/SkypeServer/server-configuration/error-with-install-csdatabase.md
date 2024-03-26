---
title: Error when you create databases by using the Install-CsDatabase cmdlet
description: Fixes an issue in which you receive an error message when you run the Install-CsDatabase cmdlet. This issue occurs when you try to create databases in a Lync Server 2013 environment.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.reviewer: miadkins
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Lync Server 2013
ms.date: 03/31/2022
---

# Error when you create databases by using the Install-CsDatabase cmdlet in Lync Server 2013

## Symptoms

Assume that you try to create the Microsoft Lync Server 2013 Enterprise Edition back-end database. To do this, you use one of the following steps: 

- You use the Publish Topology… option in Lync Server 2013 Topology Builder.   
- You use the Install Database... option in Lync Server 2013 Topology Builder. 
- You run the Install-CsDatabase -ConfigureDatabases PowerShell cmdlet.   

In this situation, you receive error messages in the following log file:

```adoc
LocalDrive:\Users\Administrator.contoso\AppData\Local\Temp\2\Create-ApplicationStore-server01.contoso.com-yyyy_mm_dd][hh_mm_ss].log - log file
```

The error message reassembles the following:

```adoc
Trying to connect to Sql Server server01.contoso.com. using windows authentication...
Sql version: Major: 10, Minor: 50, Build 4000.
Sql version is acceptable.
Validating parameters...
DbName rgsconfig validated.
SqlFilePath C:\Program Files\Common Files\Microsoft Lync Server 2013\DbSetup validated.
DbFileBase rgsconfig validated.
DbPath C:\CsData\ApplicationStore\(default)\DbPath validated.
Effective database Path: \\ server01.contoso.com \C$\CsData\ApplicationStore\(default)\DbPath.
LogPath C:\CsData\ApplicationStore\(default)\LogPath validated.
Effective Log Path: \\ server01.contoso.com \C$\CsData\ApplicationStore\(default)\LogPath.
Checking state for database rgsconfig.
Checking state for database rgsconfig.
State of database rgsconfig is detached.
Attaching database rgsconfig from Data Path
\\server01.contoso.com \C$\CsData\ApplicationStore\(default)\DbPath, Log Path 
\\server01.contoso.com \C$\CsData\ApplicationStore\(default)\LogPath.
The operation failed because of missing file '
\\ server01.contoso.com \C$\CsData\ApplicationStore\(default)\DbPath\rgsconfig.mdf'
Attaching database failed because one of the files not found. The database will be created.
State of database rgsconfig is DbState_DoesNotExist.
Creating database rgsconfig from scratch. Data File Path = C:\CsData\ApplicationStore\(default)\DbPath, Log File Path= C:\CsData\ApplicationStore\(default)\LogPath.
Clean installing database rgsconfig.
The CREATE DATABASE statement failed. The primary file must be at least 100 MB to accommodate a copy of the model database.
```

## Cause

This issue occurs because the instance of SQL Server that is designated as the Lync Server 2013 Enterprise Edition back-end database uses a nondefault initial model database size and automatic growth configuration. 

> [!NOTE]
> The SQL Server model database is a SQL Server system database. This database provides the instance of SQL Server with a method to define SQL Server database sizing configurations. During the installation of the instance of SQL Server, the model database is installed with a default minimal file size and minimal increments of unrestricted growth. The database administrator for the instance of SQL Server can update the file size and growth properties of the model database to meet their specific requirements.

In an instance of SQL Server, you can configure the model database to create new SQL Server databases that are larger than the default size of any of the Lync Sever 2013 Enterprise Edition back end databases. If you use this configuration, the Install-CsDatabase -ConfigureDatabases PowerShell cmdlet fails, and the error that is listed in the "Symptoms" section is generated.

Lync Server 2013 Enterprise Edition back-end databases that are created by using the Install-CsDatabase -ConfigureDatabases cmdlet have default sizes. For more information about the default size of the database, see the following list.

> [!NOTE]
> The .mdf file name extension represents the database data file and the .ldf file name extension represents the database transaction log file. The size is in megabytes (MB).

rtcab.mdf - size = 128 filegrowth = 128

rtcab.ldf - size = 128 filegrowth = 128


rtcshared.mdf – size = 128 filegrowth = 128

rtcshared.ldf – size = 128 filegrowth = 128


rtcxds.mdf – size = 4000 filegrowth = 512

rtcxds.ldf – size = 4000 filegrowth = 512


rgsdyn.mdf - size = 32 filegrowth = 32

rgsdyn.ldf - size = 32 filegrowth = 16

cpsdyn.mdf - size = 32 filegrowth = 32

cpsdyn.ldf - size = 32 filegrowth = 16

rgsconfig.mdf - size = 32 filegrowth = 32

rgsconfig.ldf - size = 32 filegrowth = 16

lcscdr.mdf – size = 128 filegrowth = 128

lcscdr.ldf – size = 1024 filegrowth = 128

lcslog.mdf – size = 128 filegrowth = 128

lcslog.ldf – size = 1024 filegrowth = 128

qoemetrics.mdf – size = 128 filegrowth = 128

qoemetrics.ldf – size = 1024 filegrowth = 128

## Resolution

To resolve this issue, follow these steps.

> [!NOTE]
> To run these steps, you must be a SQL Server administrator and a member of the sysadmin SQL Server role.

1. Open the Microsoft SQL Server Management Studio console.    
2. Connect to the instance of SQL Server that is designated as the Lync Server 2013 Enterprise Edition SQL Server file store.   
3. Use the **Object Explorer** pane to expand the **System Databases** node.   
4. Right-click the model database, and then click **Properties**.   
5. Click the **Files** option under the**Select a page** pane.   
6. Check whether the **Initial Size** setting of the modeldev Logical Name object is larger than the database data file size values that are listed in the "Cause" section.   
7. Check whether the **Autogrowth** setting of the modeldev Logical Name object is larger than the database data filegrowth values that are listed in the "Cause" section.   
8. Check whether the **Initial Size** setting of the modellog Logical Name object is larger than the database transaction log size values that are listed in the "Cause" section.   
9. Check whether the **Autogrowth** setting of the modellog Logical Name object is larger than the database transaction log filegrowth values that are listed in the "Cause" section.   
10. If any of the results from step 6 to step 9 is true, continue with the remaining steps.

    > [!NOTE]
    > The results indicate that the model database creates databases that have larger data size and filegrowth values than the default size and values of Lync Server 2013 Enterprise Edition back end databases.    
11. Click **cancel** to close the **Databases Properties - model** dialog box.   
12. Use the **Object Explorer** pane to expand the **System Databases** node.   
13. Right-click the model database, click **Task**, click **Shrink**, and then click **Database**.

    > [!NOTE]
    > The following steps change the sizing properties of the model database of the instance of SQL Server.   
14. Click **OK**.   
15. Right-click the model database, and then click **Properties**.   
16. Click the **Files** option under the **Select a page** pane.    
17. Check the values of the initial size of the modeldev and modellog Logical Name objects. Confirm the values are smaller than the values of the database data files and database transaction log files that are listed in the "Cause" section. The modeldev and modellog database file Autogrowth values for the instance of SQL Server should now be set to the default values   
18. Click the **...** button under the **Autogrowth** field for the modeldev and modellog Logical Name objects.    
19. Select the **Enable Autogrowth** option, select the **In Percent** option, set the value to 10, and then click **OK**.   

##  More Information

For more information about the Model database, see [model Database](/sql/relational-databases/databases/model-database).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).