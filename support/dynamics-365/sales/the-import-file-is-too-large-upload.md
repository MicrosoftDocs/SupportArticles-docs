---
title: The import file is too large to upload
description: Provides a solution to the 80040375 error that occurs when you try to import a solution in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# The import file is too large to upload error occurs when importing a solution in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you try to import a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4462491

## Symptoms

When you attempt to import a solution in Dynamics 365, the import fails and you see the following message:

> "The import file is too large to upload.  
Error code 80040375"

## Cause

Although the error message indicates a problem with the [Maximum size of solution to import](/dynamics365/customerengagement/on-premises/developer/create-export-import-unmanaged-solution#BKMK_MaxSizeOfSolution), another issue such as a SQL error may be the cause.

## Resolution

Select the **Download Log File** button to see a more detailed message. You may see details such as the following message:

> The import failed. For more information, see the related error messages. : System.Data.SqlClient.SqlException (0x80131904) Column names in each table must be unique. Column name '\<column name>' in table '\<entity/table name>' is specified more than once.

The example message above is a SQL error that can occur if you try to import a field that already exists in that entity.

Example: If you had created a custom field in the organization with a schema name called new_field1 on the Account entity. Now you're trying to import a solution that contains a field with that same schema name on the Account entity. SQL doesn't allow multiple columns with the same name in the same table so it will cause the import to fail. You may find that in the target environment, you already had a field with the same schema name but different casing such as new_Field1 and the field in the solution you're importing is new_field1. If the field with the same name isn't needed in the target environment, delete it and then try the import again.

If the error persists and you aren't able to resolve the issue using the details in the log file, contact Microsoft Support for assistance. You can also use the information in the log file to search for potential solutions in the [Dynamics 365 Communities](https://community.dynamics.com/forums/thread/).
