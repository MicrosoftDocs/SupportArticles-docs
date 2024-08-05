---
title: Assembly cannot be migrated to SQL Server 2017 error
description: This article describes the Assembly cannot be migrated to SQL Server 2017 error in compatibility check for Configuration Manager database.
ms.date: 09/21/2022
ms.custom: sap:Database or Client application Development
---

# "Assembly cannot be migrated to SQL Server 2017" error in compatibility check for Configuration Manager database

This article introduces the "Assembly cannot be migrated to SQL Server 2017" error that occurs in compatibility check for the Configuration Manager database.

_Original product version:_ &nbsp; System Center Configuration Manager, SQL Server 2017 on Windows  
_Original KB number:_ &nbsp; 4465462

## Summary

In Microsoft SQL Server 2017, you use the built-in database compatibility checker to determine the upgrade compatibility of a Microsoft System Center Configuration Manager database. You also have `CLR Strict Security` enabled. When you run the check, you receive informational messages regarding the following indicated assemblies:

> Assembly [DcmObjectModel_SQLCLR] cannot be migrated to SQL Server 2017. For more details, please see: Line 1, Column 1.  
Assembly [MessageHandlerService] cannot be migrated to SQL Server 2017. For more details, please see: Line 1, Column 1.  
Assembly [ServiceBrokerInterface] cannot be migrated to SQL Server 2017. For more details, please see: Line 1, Column 1.  
Assembly [SMSSQLCLR] cannot be migrated to SQL Server 2017. For more details, please see: Line 1, Column 1.  
Assembly [StateSysSqlClr] cannot be migrated to SQL Server 2017. For more details, please see: Line 1, Column 1.

## Status

The informational messages are by design. Although the assemblies are marked as *UNSAFE*, they are handled correctly. You can safely ignore these messages and continue to run the database upgrade.

## More information

By default, all Configuration Manager databases should have the **Trustworthy** option set to **True** in the database properties. This is a requirement both for Configuration Manager and for the `CLR Strict Security` feature to function correctly.

To verify this setting, open the **Database Properties** window, select the **Options** page in the navigation pane, and then locate the **Trustworthy** row in the **Other options** list.

:::image type="content" source="media/assembly-name-cannot-migrated-error/database-properties.png" alt-text="Screenshot of the Options page of the Database Properties window.":::
