---
title: What Reverse and Correct buttons do in Select Timesheets for Adjustment
description: Provides more information about what do the Reverse and Correct buttons do in the Select Timesheets for Adjustment window for Project Accounting in Microsoft Dynamics GP.
ms.reviewer: isolson, cwaswick
ms.date: 03/31/2021
---
# What do the Reverse and Correct buttons do in the "Select Timesheets for Adjustment" window for Project Accounting

This article provides the answer for the question that what do the Reverse and Correct buttons do in the **Select Timesheets for Adjustment** window for Project Accounting in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4020444

A general description for each button is below: (and/or review [blog](https://community.dynamics.com/blogs/post/?postid=3abaf0bb-06ca-4ebf-add5-63c45a9520b4) article to see example).

## What do the Reverse button do

The **Reverse** button will create a new timesheet that is exactly the opposite of the timesheet(s) selected. If the original entries were positive, then the new entries will be negative. So the net outcome is that the original timesheet and reversed timesheet offset each other, for a net result of 0.

> [!NOTE]
> The **Reverse** option will have the same effect as voiding.

## What do the Correct button do

The **Correct** button is used to make an adjustment to Costs and/or billing rates on timesheets. The method will create two new timesheets for each selected timesheet(s).

One timesheet is exactly opposite of the timesheet(s) selected to reverse it out, and the second timesheet has the new rates that you chose to update based on Project Number and Cost Category. You can update or override these fields: Unit Cost, Overhead-Unit, Overhead-Percent, Billing Type, Billing Rate, and/or Markup Percent. If you save the reversed and corrected timesheets to a batch, you can review before you post.
