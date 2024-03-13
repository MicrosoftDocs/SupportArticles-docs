---
title: The Asset ID and Book ID already exist
description: Provides a solution to an error that occurs when you run a Fixed Assets integration by using Integration Manager for Microsoft Dynamics GP 10.0.
ms.reviewer: dlanglie
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "The Asset ID and Book ID already exist in the FA00200 and updates are not supported on Asset Books at this time" Error when you run a Fixed Assets integration by using Integration Manager for Microsoft Dynamics GP 10.0

This article provides a solution to an error that occurs when you run a Fixed Assets integration by using Integration Manager for Microsoft Dynamics GP 10.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 971839

## Symptoms

In Integration Manager for Microsoft Dynamics GP, you receive the following error message when you run a Fixed Assets integration, and there are multiple Suffix IDs for an Asset ID:
> The Asset ID and Book ID already exist in the FA00200 table and updates aren't supported on Asset Books at this time.

## Cause

This problem or behavior occurs when query relationships are incorrect.

## Resolution

To resolve this error, add a query relationship on both the Asset ID and the Suffix ID. To do it, follow these steps:

1. Open Integration Manager and the integration.

2. Double-click the **Query Relationships** window to open the window.

3. Select the **Asset ID** in the **General** source, and drag it to the **Asset ID** in the **Book** source.

4. Select the **Suffix ID** in the **General** source, and drag it to the **Suffix ID**.
