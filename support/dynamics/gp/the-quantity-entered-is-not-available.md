---
title: The quantity entered is not available
description: Describes a problem that occurs if one item has the same number for the lot number and for the bin number. A resolution is provided.
ms.reviewer: theley, kvogel, bgardner
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Distribution - Inventory
---
# "The quantity entered is not available for this current bin" Error message when you have multi-bin items and lot-numbered items in a Sales Transaction integration in Integration Manager for Microsoft Dynamics GP

This article provides a solution to an error that occurs when you have multi-bin items and lot-numbered items in a Sales Transaction integration in Integration Manager for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 938563

## Symptoms

Consider the following scenario in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0. You have multi-bin items, and you have lot-numbered items. These items have multiple cost layers for one item. Additionally, this one item has the same number for the lot number and for the bin number.

You run a Sales Transaction integration for an invoice. You run this integration in Integration Manager for Microsoft Dynamics GP, or in Integration Manager for Microsoft Business Solutions - Great Plains. When you run the Sales Transaction integration, the invoice has a quantity of two for the item that is using the same number for the lot number and for the bin number. In this scenario, you receive the following error message:
> The quantity entered is not available for this current bin.

## Resolution

Integration Manager for Microsoft Business Solutions - Great Plains 8.0

To resolve this problem, obtain the latest service pack for Integration Manager for Microsoft Business Solutions - Great Plains 8.0.

## Status

- Integration Manager for Microsoft Dynamics GP 9.0

    Microsoft has confirmed that it's a problem in the Microsoft products that are listed in the Applies to section.

- Integration Manager for Microsoft Business Solutions - Great Plains 8.0

    Microsoft has confirmed that it's a problem in the Microsoft products that are listed in the Applies to section. This problem was corrected in Service Pack 5 for Integration Manager for Microsoft Business Solutions - Great Plains 8.0.
