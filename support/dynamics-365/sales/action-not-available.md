---
title: Action not available
description: Provides a solution to action not available error when you select a solution in Dynamics 365 and then select the Apply Solution Upgrade button.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# "Action not available. To use this action, you must first select the old solution and then try again" message appears in Dynamics 365

This article provides a solution to an error that occurs when you select a solution in Dynamics 365 and then select the **Apply Solution Upgrade** button.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4457887

## Symptoms

When you select a solution in Dynamics 365 and then select the **Apply Solution Upgrade** button, you receive the following error:

> "Action not available.  
To use this action, you must first select the old solution and then try again."

If you select Download Log File, the log file includes a reference to error code -2147187396.

## Cause

This message appears if the solution you selected is the solution update and not the parent solution.

The **Apply Solution Upgrade** button is intended to be used when you've imported an update for another solution that is already installed. When importing the updated solution, there's a **Stage for upgrade** option that appears. If this checkbox is selected, the upgrade action isn't done during solution import. An **Apply Solution Upgrade** button appears at the end of the import process. If you didn't select this button, you can find the parent solution in the solution list and then select **Apply Solution Upgrade**.

Example: You previously imported a solution called SolutionA that was version 1.0.0.0. Later you import a newer version of SolutionA that is version 1.0.1.0. During the solution import, the **Stage for upgrade** option was selected. If you didn't select the **Apply Solution Upgrade** button that appeared at the end of the import process, you'll see SolutionA and also SolutionA_Upgrade in the **All Solutions** view. If you selected SolutionA_Upgrade and then selected **Apply Solution Upgrade**, you would see this error. Instead you need to select the parent solution (SolutionA) and then select **Apply Solution Upgrade**.

## Resolution

Select the parent solution and then select **Apply Solution Upgrade**.
