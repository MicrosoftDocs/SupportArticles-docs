---
title: The file provided wasn't uploaded error
description: Provides a solution to an error that occurs when you try to import a solution in Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# The file provided was not uploaded error occurs when importing a solution in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you try to import a solution in Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4500498

## Symptoms

When attempting to import a solution in Dynamics 365, you receive the following error:

> "The file provided was not uploaded. Click the back button, select the solution file, and try again. If the problem persists, contact your system administrator.
>
> Error code 80071153."

## Cause

Error code 80071153 indicates a duplicate component is present in the XML of the solution. It's caused by someone manually modifying the XML.

## Resolution

To fix this issue, follow these steps:

1. Unzip the solution file you're attempting to import.
2. Open the customization.xml file.
3. Look for any duplicated nodes in the XML.
4. Remove the duplicate node(s).
5. Save the customizations.xml file.
6. Select all the files that were extracted from the .zip file and send them to a new compressed .zip file.
7. Attempt to import the solution again.
