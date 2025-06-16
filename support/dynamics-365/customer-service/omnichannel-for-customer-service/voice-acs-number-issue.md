---
title: Customers are unable to add phone numbers to Azure Communication Services (ACS) service request
description: Resolves an issue where customers are unable to add phone numbers to Azure Communication Services (ACS) service request in Omnichannel for Customer Service.
ms.reviewer: mgandham
ms.author: mgandham
ms.date: 06/16/2025
ms.custom: sap:Voice channel
ms.collection: CEnSKM-ai-copilot
---

# Unable to add phone numbers to Azure Communication Services service request

This article provides a solution to an issue where customers are unable to add phone numbers to the Azure Communication Services (ACS) service request in Omnichannel for Customer Service.
 
## Cause

Active numbers are already present in the Communication Data Store (CDS) with an old environment, which prevents adding new numbers.
 
## Resolution

Delete the numbers from old environment and then add them to the new environment.