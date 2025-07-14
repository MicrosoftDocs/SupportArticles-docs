---
title: Could not deploy package error when you deploy DACPAC files
description: Describes how to troubleshoot errors such as Could not deploy package when you deploy DACPAC files from Access web app package.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Access
ms.date: 05/26/2025
---

# "Could not deploy package" or "Script execution error" when you deploy DACPAC files from Access web app package

## Introduction

As part of the retirement process for Access web apps, apps are packaged into an Access app package as they are retired. These packages are stored in a newly created document library that is given the same name as the app.

To retrieve data from a packaged app, extract the *.DACPAC file, and then deploy the [data-tier application](/sql/relational-databases/data-tier-applications/data-tier-applications?view=sql-server-2017&preserve-view=true) to SQL Server. To do this, follow the step in the "Open an Access app package to work with its contents" section of the [Access Services in SharePoint Roadmap](https://support.office.com/article/497fd86b-e982-43c4-8318-81e6d3e711e8) article.

This article describes an alternative method to recover the data in the tables of an Access web app when you experience the following scenarios:

- The Access web app contains validation errors.
- You receive error messages that resemble the following ones:

  - **Error SQL72014: Could not deploy package.**

  - **Error SQL72045: Script execution error.**
- You can't deploy the DACPAC.

## More Information

To recover the data by using the alternative method, follow these steps.

### Unpack the DACPAC

1. Download and install [Microsoft SQL Server Data-Tier Application Framework (17.8 GA DacFx)](https://www.microsoft.com/download/details.aspx?id=57073).
2. Double-click the appdb.dacpac from your Access app package, select a destination location, and then click **Unpack**.

    :::image type="content" source="media/deploy-dacpac-access-web-app-package/select-destination-and-unpack-files.png" alt-text="Screenshot of the Unpack D A C Package File window where you select a destination location.":::

    See the "Open an Access app package to work with its contents" section of the [Access Services in SharePoint Roadmap](https://support.office.com/article/Access-Services-in-SharePoint-Roadmap-497fd86b-e982-43c4-8318-81e6d3e711e8) article for more information about how to extract the DACPAC from an app package.

### Create SQL Server database

- Create a database in SQL Server.

### Create tables from a DACPAC model.sql script

1. Create a query, and make sure that the database context in SQL Server Management Studio (SSMS) is pointing to the newly created database. 

    :::image type="content" source="media/deploy-dacpac-access-web-app-package/create-query.png" alt-text="Screenshot shows your database context in S S M S is selected when creating a new query." border="false":::
2. Add the following CREATE SCHEMA syntax to the new query.

    :::image type="content" source="media/deploy-dacpac-access-web-app-package/add-create-schema-to-new-query.png" alt-text="Screenshot to add the CREATE SCHEMA syntax to the new query.":::
3. Open model.sql from the unpacked DACPAC in SSMS.
4. Locate the CREATE TABLE syntax for the tables that you want to restore.
5. Copy and paste the desired CREATE TABLE syntax into the new query under the CREATE SCHEMA entries.
6. After you locate the desired tables and create your own script in the new query, run the query.

    The following sample script creates the Person and PersonAddress tables:

    :::image type="content" source="media/deploy-dacpac-access-web-app-package/create-table.png" alt-text="Screenshot shows the script creates the Person and PersonAddress tables as an example in SQL command prompt.":::

### Populate tables with data by using a bulk copy program (BCP)

1. Sign in to SQL Server.
2. A bcp utility should already be installed. If it is necessary, install it as part of the [Microsoft Command Line Utilities 14.0 for SQL Server](https://www.microsoft.com/download/details.aspx?id=53591).
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

For more information about the bcp utility, see [bcp Utility](/sql/tools/bcp-utility?view=sql-server-2017&preserve-view=true).
