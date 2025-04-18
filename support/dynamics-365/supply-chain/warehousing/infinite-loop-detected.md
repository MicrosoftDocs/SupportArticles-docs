--- 
title: Infinite Loop During Warehouse Mobile App Operations
description: Solves an Infinite loop detected error that occurs during specific operations in the Warehouse Management mobile app in Microsoft Dynamics 365 Supply Chain Management.
author: Koalena 
ms.date: 04/18/2025
ms.custom: sap:Warehouse management
--- 
# "Infinite loop detected" error occurs when performing warehouse mobile app operations

This article addresses an "Infinite loop detected" error that occurs during specific operations in the [Warehouse Management mobile app](/dynamics365/supply-chain/warehousing/install-configure-warehouse-management-app).

## Symptoms

When you perform operations in the Warehouse Management mobile app, you might receive an error message that resembles one of the following:

- > Infinite loop detected during Movement by template.

- > Infinite loop detected during Report as Finished and put away.

## Cause

This issue occurs when the call stack depth exceeds a predefined limit, triggering a safeguard to prevent infinite loops. The error typically occurs when a large number of work lines are created or processed in a single scan.

## Resolution

To resolve this issue, reduce the number of work lines processed in a single operation. You can achieve this by [splitting a large work ID](/dynamics365/supply-chain/warehousing/work-split) into several smaller ones.
