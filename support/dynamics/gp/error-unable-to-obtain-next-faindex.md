---
title: Unable to obtain the next FAINDEX error when you use the Fixed Assets eConnect adapter on Microsoft Dynamics GP 10.0 to import asset general and asset book information 
description: Describes an error that occurs when you use the Fixed Assets eConnect adapter to import asset general and asset book information on Microsoft Dynamics GP 10.0.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error when you use the Fixed Assets eConnect adapter on Microsoft Dynamics GP 10.0 to import asset general and asset book information: "Unable to obtain the next FAINDEX"

This article describes an error that occurs when you use the Fixed Assets eConnect adapter to import asset general and asset book information.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 951768

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]

## Symptoms

When you use the Fixed Assets eConnect adapter on Microsoft Dynamics GP 10.0 to import asset general and asset book information, you receive the following error message when the integration starts:
> Microsoft.Dynamics.GP.eConnect: Number = 6625 Stored procedure taCreateAssetID : Description = unable to obtain the next FAINDEX.

## Cause

This problem is caused when eConnect looks for specific values in the tables, and the tables are empty. Adding a stored procedure to handle this operation could result in locking and blocking issues. So we recommend that you manually enter an asset, and then save it. After the asset is saved, the Fixed Assets eConnect Adapter can properly obtain the next **FAINDEX** value.

## Resolution

To resolve this problem, manually enter one transaction with both the asset general and asset book information, and then save the asset in Microsoft Dynamics GP. Once you've manually saved one asset, run the integration again.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
