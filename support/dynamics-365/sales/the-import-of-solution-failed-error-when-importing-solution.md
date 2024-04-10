---
title: The import of solution failed error when importing solution
description: The import of solution failed error occurs when you try to import a solution in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# "The import of solution failed" error occurs in Microsoft Dynamics 365

This article provides a resolution for **The import of solution: [solution name] failed** error that occurs when you try to import a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4346891

## Symptoms

When attempting to import a solution in Microsoft Dynamics 365, you encounter the following error details:

> The import of solution: [solution name] failed.

Within the **Detail** column of the grid, you see the following message:

> Fields that are not valid were specified for the entity.

If you select **Download Log File**, you see a message similar to the following:

> Attribute [attribute name] is a Boolean, but a Picklist type was specified.

You also see a reference to error code **80041A06**.

## Cause

This error can occur if you had previously created a field (attribute) of a certain data type and later try to import a solution that contains the same field name but with a different data type.

Example: You create a field called CustomField1 with the Data Type set as Two Options (Boolean). If you try to import a solution with the same field name but a different Data Type such as Option Set (Picklist), you will encounter this error.

## Resolution

If you are intentionally trying to import the same field with a different type with the goal of changing the type, this is not supported. For example: If you created a field of a certain type and later decide you want to change the type, you would need to use one of the following options:

1. **Create the field with a different name in the solution you are trying to import.** After you create/import the field with a different schema name, you can migrate the data (if needed) and then delete the previously existing field (if no longer needed).
2. **Delete the existing field in the organization where you are trying to import the solution.**

   > [!IMPORTANT]
   > This option should only be used if you do not need to keep the existing data in this field.
