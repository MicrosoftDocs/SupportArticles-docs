---
title: Configure antivirus exclusions in Service Manager
description: Describes how to configure antivirus exclusions in System Center Service Manager.
ms.date: 08/04/2020
ms.reviewer: brunoga
---
# Configure antivirus exclusions in a System Center Service Manager environment

Antivirus exclusions need to be properly configured in a System Center Service Manager environment in order to avoid potential performance issues due to antivirus scanning operations.

_Original product version:_ &nbsp; System Center 2016 Service Manager, System Center 2012 R2 Service Manager, Microsoft System Center 2012 Service Manager Service Pack 1  
_Original KB number:_ &nbsp; 2787044

To configure the exclusions for your Service Manager environment, you will need to configure the exclusions documented below.

## For Service Manager database servers

For SQL Servers hosting the Service Manager related databases, configure the exclusion for the files with the following extensions:

- MDF
- NDF
- LDF

The files are often located in a folder like:

- E:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data
- E:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Log
