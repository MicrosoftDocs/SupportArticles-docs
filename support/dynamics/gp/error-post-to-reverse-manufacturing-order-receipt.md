---
title: Error when you post to reverse a manufacturing order receipt in Microsoft Dynamics GP 10.0
description: Describes a problem that occurs because the inventory adjustment may contain incorrect component quantities when you post to reverse the manufacturing order receipt.
ms.reviewer: theley, ttorgers, lmuelle
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Manufacturing Series
---
# Error when you post to reverse a manufacturing order receipt in Microsoft Dynamics GP 10.0: "An error occurred while saving transaction line. Check the data and try again"

This article describes an issue that occurs when you post to reverse the manufacturing order receipt.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 950017

## Symptoms

When you post a manufacturing order receipt in Microsoft Dynamics GP 10.0, components of the finished goods are back-flushed. Then, you try to post to reverse the manufacturing order receipt. This action puts the components back into the inventory to adjust the inventory. However, when you post to reverse the manufacturing order receipt, you receive the following error message:
> An error occurred while saving transaction line. Check the data and try again.

## Cause

This problem occurs because the inventory adjustment may contain incorrect component quantities when you post to reverse the manufacturing order receipt.

## Resolution

### Service pack information

To resolve this problem, obtain the latest service pack for Microsoft Dynamics GP 10.0.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section. This problem was first corrected in Microsoft Dynamics GP 10.0 Service Pack 3.
