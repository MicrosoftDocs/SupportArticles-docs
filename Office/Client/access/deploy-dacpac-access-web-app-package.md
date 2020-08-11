---
title: Could not deploy package error when you deploy DACPAC files
description: Describes how to troubleshoot errors such as Could not deploy package when you deploy DACPAC files from Access web app package.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Access
---

# "Could not deploy package" or "Script execution error" when you deploy DACPAC files from Access web app package

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Introduction

As part of the retirement process for Access web apps, apps are packaged into an Access app package as they are retired. These packages are stored in a newly created document library that is given the same name as the app.

To retrieve data from a packaged app, extract the *.DACPAC file, and then deploy the [data-tier application](https://docs.microsoft.com/sql/relational-databases/data-tier-applications/data-tier-applications?view=sql-server-2017) to SQL Server. To do this, follow the step in the "Open an Access app package to work with its contents" section of the [Access Services in SharePoint Roadmap](https://support.office.com/article/497fd86b-e982-43c4-8318-81e6d3e711e8) article.

This article describes an alternative method to recover the data in the tables of an Access web app when you experience the following scenarios: 

- The Access web app contains validation errors.    
- You receive error messages that resemble the following: 

    **Error SQL72014: Could not deploy package.**
    
    **Error SQL72045: Script execution error.**    
- You can't deploy the DACPAC.    

## More Information

To recover the data by using the alternative method, follow these steps.

### Unpack the DACPAC
 
1. Download and install [Microsoft SQL Server Data-Tier Application Framework (17.8 GA DacFx)](https://www.microsoft.com/download/details.aspx?id=57073).    
2. Double-click the appdb.dacpac from your Access app package, select a destination location, and then click **Unpack**. 

    ![Unpack a DAC Package file window where you select a destination location](./media/deploy-dacpac-access-web-app-package/select-destination-and-unpack-file.png)

    See the "Open an Access app package to work with its contents" section of the [Access Services in SharePoint Roadmap](https://support.office.com/article/Access-Services-in-SharePoint-Roadmap-497fd86b-e982-43c4-8318-81e6d3e711e8) article for more information about how to extract the DACPAC from an app package. 

### Create SQL Server database

- Create a database in SQL Server.

### Create tables from a DACPAC model.sql script
 
1. Create a query, and make sure that the database context in SQL Server Management Studio (SSMS) is pointing to the newly created database. 

    ![Your database context in SSMS is selected when creating a new query](./media/deploy-dacpac-access-web-app-package/create-query.png)    
2. Add the following CREATE SCHEMA syntax to the new query. 

    ![CREATE SCHEMA syntax for Access, AccessExternal, AccessSystem, AccessRunTime shows in a command prompt in SQL](./media/deploy-dacpac-access-web-app-package/add-create-schema-to-new-query.png)    
3. Open model.sql from the unpacked DACPAC in SSMS.    
4. Locate the CREATE TABLE syntax for the tables that you want to restore.    
5. Copy and paste the desired CREATE TABLE syntax into the new query under the CREATE SCHEMA entries.    
6. After you locate the desired tables and create your own script in the new query, run the query.

    The following sample script creates the Person and PersonAddress tables:

    ![Script creating Person and PersonAddress tables as an example in SQL command prompt](./media/deploy-dacpac-access-web-app-package/create-table.png)    

### Populate tables with data by using a bulk copy program (BCP)
 
1. Sign in to SQL Server.    
2. A bcp utility should already be installed. If it is necessary, install it as part of the [Microsoft Command Line Utilities 14.0 for SQL Server](https://www.microsoft.com/download/details.aspx?id=53591).    
3. Open a Command Prompt window.    
4. Create and run the bcp command for your environment or tables.

    **SQL Signin**  
    
    ```sql
    bcp <NewDatabaseName>.<Schema>.<Table> in "<BCPFilePath>" -N -S <ServerName> -U <UserName> -P <Password> 
    ```
    
    **Example:**  
    
    ```sql
    bcp SampleDatabase.Access.Person in "c:\temp\appdb\Data\Access.Person\TableData-000-00000.BCP" -N -S Server1 -U User1 -P PWD 
    ```
    
    **Integrated Security/Trusted Connection**  
    
    ```sql
    bcp <NewDatabaseName>.<Schema>.<Table> in "<BCPFilePath>" -N -T 
    ```
    
    **Example:**  
    
    ```sql
    bcp SampleDatabase.Access.Person in "c:\temp\appdb\Data\Access.Person\TableData-000-00000.BCP" -N -S Server1 -T
    ```
5. Repeat the command for each table that you want to populate with data.

For more information about the bcp utility, see [bcp Utility](https://docs.microsoft.com/sql/tools/bcp-utility?view=sql-server-2017).
