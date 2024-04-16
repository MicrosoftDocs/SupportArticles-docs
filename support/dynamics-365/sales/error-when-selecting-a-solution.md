---
title: Error when selecting a solution
description: Provides a solution to an error that occurs when you select a solution and then select the Apply Solution Upgrade button.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# "The [Solution Name] solution doesn't have an upgrade that is ready to be applied" error message appears in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you select a solution in Dynamics 365 and then select the **Apply Solution Upgrade** button.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4457858

## Symptoms

When you select a solution in Dynamics 365 and then select the **Apply Solution Upgrade** button, you receive the following error:

> "Action not available.  
The [Solution Name] solution doesn't have an upgrade that is ready to be applied."

If you select **Download Log File**, the log file includes a reference to error code -2147187397.

## Cause

This message appears if the solution you selected doesn't have a solution upgrade to be applied.

The **Apply Solution Upgrade** button is intended to be used when you've imported an update for another solution that is already installed. When importing the updated solution, there's a **Stage for upgrade** option that appears. If this checkbox is selected, the upgrade action isn't done during solution import. An **Apply Solution Upgrade** button appears at the end of the import process. If you didn't select this button, you can find the parent solution in the solution list and then select **Apply Solution Upgrade**.

## Resolution

Only use the **Apply Solution Upgrade** button if you've imported an update for a solution that was already installed and you chose the **Stage for upgrade** option.
