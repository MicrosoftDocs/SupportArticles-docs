---
title: Address information is missing for the Ship-To Address error in Purchase Order Entry window in Microsoft Dynamics GP
description: Describes an error message in Purchase Order Entry window in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# "Address information is missing for the Ship-To Address" error in Purchase Order Entry window in Microsoft Dynamics GP

This article describes an issue where you can't enter a vendor in the Vendor ID field in the Purchase Order Entry window

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2633839

## Symptoms

When you enter a vendor in the Vendor ID field in the Purchase Order Entry window, you receive the following message:

> Address information is missing for the Ship-To Address. Verify address information.

## Cause

This problem occurs when an address ID at the Company Setup level is missing.

## Resolution

Follow these steps to resolve the issue:

1. In Microsoft Dynamics GP, click **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup** > **Company**, and then click **Company**.  
2. In the Company Setup window, use the lookup button to select an **Address ID**.
3. Click **OK** and test again to verify the issue has been resolved.
