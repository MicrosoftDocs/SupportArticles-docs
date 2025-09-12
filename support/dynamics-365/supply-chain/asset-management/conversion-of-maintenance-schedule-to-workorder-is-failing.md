---
title: Conversion of Maintenance Schedule to Work Orders Fails
description: Solves the errors that prevent you from creating work orders based on maintenance schedule in Microsoft Dynamics 365 Supply Chain Management.
author: sorenbacker2
ms.author: sorenba
ms.date: 03/14/2025
ms.custom: sap:Asset management\Issues with asset management
---
# Can't create work orders based on your maintenance schedule

This article provides the setup steps to ensure the conversion of maintenance schedule lines to work orders doesn't fail due to errors related to number sequence setup in Microsoft Dynamics 365 Supply Chain Management.

## Symptoms

When you try to create work orders for the selected schedule items selected using the [Open maintenance schedule lines](/dynamics365/supply-chain/asset-management/preventive-and-reactive-maintenance/creating-work-orders#create-work-orders-based-on-your-maintenance-schedule) in **Asset Management**, you receive the following error message after selecting **OK** in the **Create work orders** dialog.

> Number sequence \<Number sequence> has been exceeded.  
> Number selection is canceled.

## Cause

This issue is caused by the setup of a number sequence. Specifically, the actual number sequence exceeds the configured range of the work order number sequence.

## Resolution

To resolve the issue and ensure the successful conversion of maintenance schedule lines to work orders, follow these steps to properly set up the number sequence:

1. Go to **Asset management module** > **Setup** > **Asset management parameters**.
2. Select the **Number sequences** FastTab.
3. Select **Work order** in the **Reference** column, and then select the corresponding link in the **Number sequence code** column.

4. Go to the **Segments** FastTab. Find the line where the **Segment** column equals *Alphanumeric*. Ensure the corresponding field in the **Value** column has enough hash tags to match the desired length of the variable numeric part of the work order number sequence.

5. Go to the **General** FastTab. In the **Number allocation** field group, ensure that the **Largest** number matches (but is included in) the length of the variable numeric part of the work order number sequence set earlier. In other words, if the alphanumeric value from step 4 equals *######*, the largest number can be set as *999999*. Also, ensure that the number in the **Next** field is included in the range of the number sequence mentioned in steps 4 and 5.

6. Select **Save** to save the changes to the number sequence.

By configuring the work order number sequence correctly, the conversion of maintenance schedule lines to work orders can proceed without being blocked by an error.

## More information

[Set up number sequences on an individual basis](/dynamics365/fin-ops-core/fin-ops/organization-administration/tasks/set-up-number-sequences-individual-basis)
