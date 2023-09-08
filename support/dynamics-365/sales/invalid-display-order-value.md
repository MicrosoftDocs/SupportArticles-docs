---
title: Invalid display order value
description: Provides a solution to an error that occurs when importing a solution in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# "Invalid display order value. The display order must be greater or equal to 10000." error occurs when importing a solution in Microsoft Dynamics 365

This article provides a solution to an error that occurs when importing a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4465876

## Symptoms

When attempting to import a solution in Dynamics 365, you receive the following error:

> "The import of solution: \<Solution Name> failed."

You may also see a reference to error code 80044327.
When viewing the detailed error in the grid, the details column shows the following message:

> "Invalid display order value. The display order must be greater or equal to 10000."

If you select Download Log File and open the file in Excel, a message like the following one is found on the **components** tab:

> "0x80044327  
The nav pane order 0 is not allowed - it must be at least as large as 10000 for the entityRelationshipId \<relationshipId>"

## Cause

This error occurs if the solution includes a relationship from one entity to another and the Display Order (NavPaneOrder) is configured as a number less than 10000. Setting this value to a number less than 10000 isn't allowed when doing customizations within Dynamics 365 but could be the result of modifying the customizations.xml directly.

## Resolution

1. Extract the solution .zip file you're trying to import.
2. Open the customizations.xml file in a text editor.
3. Search for a section like the following example:

    \<NavPaneOrder>0\</NavPaneOrder>

    > [!NOTE]
    > It's possible the number in your example may be something other than 0 but some other number less than 10,000. As mentioned in the [Symptoms](#symptoms) section, you can refer to the message in the log file to confirm the nav pane order value that caused the failure.

4. After finding the invalid NavPaneOrder section, update the incorrect number to a value greater than or equal to 10000.

    > [!NOTE]
    > Don't include a comma.
5. Select all the files from the extracted solution and send them to a .zip file.
6. Attempt to import the updated solution.
