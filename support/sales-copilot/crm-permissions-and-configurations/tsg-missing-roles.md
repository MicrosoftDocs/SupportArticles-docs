---
title: Missing privileges in Dynamics 365
description: Resolves the error message in Microsoft Copilot for Sales related to missing privileges in Dynamics 365.
ms.date: 12/25/2023
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---
# Missing privileges in Dynamics 365

This article helps you troubleshoot and resolve the error message related to missing privileges that occurs when a Dynamics 365 user tries to sign in to Microsoft Copilot for Sales.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365        |
|**Users**     | Users who don't have Copilot for Sales privileges in Dynamics 365   |

## Symptoms

When a Dynamics 365 user tries to sign in to Copilot for Sales, an error message is displayed indicating that certain privileges are missing.

## Cause

The user doesn't have Copilot for Sales privileges in Dynamics 365 granted by the **Copilot for Sales User** role.

## Resolution

To solve this issue, the [additional privileges required for Dynamics 365 customers](/microsoft-sales-copilot/install-viva-sales#additional-privileges-required-for-dynamics-365-customers) should be assigned to the user.

## More information

If your issue is still not resolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
