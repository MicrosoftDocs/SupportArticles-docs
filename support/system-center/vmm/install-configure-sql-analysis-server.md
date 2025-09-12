---
title: Install and configure a SQL Analysis Server
description: Describes how to how to install and configure a SQL Analysis Server using service templates in System Center 2012 Virtual Machine Manager.
ms.date: 04/09/2024
ms.reviewer: wenca, alvinm
---
# How to install and configure a SQL Analysis Server using service templates in Virtual Machine Manager

This article describes how to install and configure a SQL Analysis Server using service templates in System Center 2012 Virtual Machine Manager.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2830465

## Symptoms

System Center 2012 Virtual Machine Manager (VMM 2012) does not provide a way to install and configure a SQL Analysis Server using service templates. The method below can be used to achieve a similar result.

## Resolution

The way to accomplish this is to have a SysPrep version of SQL Server in a template. In the service template, configure the SQL Server and provide the media path. Then, add a post install script that runs setup for SQL Analysis Server from the media path provided. The script will look something like the following:

```console
Setup.exe /q /IAcceptSQLServerLicenseTerms /ACTION=install /FEATURES=AS /ASSERVERMODE=TABULAR /INSTANCENAME=ASTabular /INDICATEPROGRESS /ASSVCACCOUNT=<DomainName\UserName> /ASSVCPASSWORD=<StrongPassword> /ASSYSADMINACCOUNTS=<DomainName\UserName>
```

## More Information

For more information on how to setup SQL Analysis Services using a command line, see the following articles:

- [Install SQL Server from the Command Prompt](/sql/database-engine/install-windows/install-sql-server-from-the-command-prompt)
- [Install SQL Server Analysis Services](/analysis-services/instances/install-windows/install-analysis-services)
