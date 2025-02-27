---
title: Conversion of Maintenance Schedule to Work Orders Is Failing
description: Provides a resolution to the failing conversion of Maintenance Schedule lines to Work Orders in Microsoft Dynamics 365 Supply Chain Management.
author: sorenbacker2
ms.author: sorenba
ms.date: 02/27/2025
ms.custom: sap:Asset management\Issues with asset management
---
# Conversion of maintenance schedule to work orders is failing

This article provides the setup steps to ensure the conversion of maintenance schedule lines into work orders isn't failing with errors related to number sequence setup in Microsoft Dynamics 365 Supply Chain Management.

## Symptoms

From **Open maintenance schedule lines** in Asset Management module a user selects a subset of lines. Then **New** > **Work order** is selected from the action pane, and in the **Create work orders** dialogue anything that will result in multiple work orders is selected. However, after selecting **OK**, instead of creating a given number of work orders, an error message appears, saying that a number sequence has been exceeded or that a given number does not match a given format. This blocks the further process.

## Cause

This issue is related to the setup of a number sequence. The core issue is that the actual number sequence outgrows the configured range of the work order number sequence.

## Resolution

To ensure the conversion of maintenance schedule lines into work orders isn't failing with blocking errors related to number sequence setup, follow these steps to set up this Number sequence, thus avoiding the blocking error.

1.  Go to **Asset management module** > **Setup** > **Asset management parameters**.

2.  Select the fast tab **Number sequences**.

3.  Select **Work order** in the **Reference** column, and then select the corresponding link in the **Number sequence code** column.

4.  Go to the **Segments** FastTab. Find the line where the **Segment** column equals *Alphanumeric*. Make sure the corresponding field in the **Value** column has enough hash tags to match the desired length of the variable numeric part of the work order number sequence.

5.  Go to the **General** fast tab. In the **Number allocation** field group, make sure that the **Largest** number matches (but is included in) the length of the variable numeric part of the work order number sequence set above (i.e. if the alphanumeric value from step 4 equals *######* the largest number could be set as *999999*). Also make sure that the number in the **Next** field is included in the range of the number sequence (re. step 4 and 5 here).

6.  Select **Save** to save the changes to the number sequence.

The work order number sequence has now been configured to allow the conversion of open maintenance schedule lines into work orders without being blocked by an error.

## More information

[Set up number sequences on an individual basis](/dynamics365/fin-ops-core/fin-ops/organization-administration/tasks/set-up-number-sequences-individual-basis)