---
title: Missing privileges in Dynamics 365
description: Resolves the missing privileges error that occurs when signing in to Sales agent.
ms.date: 05/14/2026
ms.custom: sap:CRM Permissions and Configurations\CRM Permissions
ms.reviewer: shjais, v-shaywood
---
# Missing privileges in Dynamics 365 when signing in to Sales agent

This article helps you troubleshoot and resolve an error message related to missing privileges that occurs when a Microsoft Dynamics 365 user tries to sign in to Sales agent.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales agent in Outlook        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365        |
|**Users**     | Users who don't have Sales agent privileges in Dynamics 365   |

## Symptoms

When a Dynamics 365 user tries to sign in to Sales agent, an error message is displayed indicating that certain privileges are missing.

## Cause

The user doesn't have Sales agent privileges granted by the **Sales Copilot User** role in Dynamics 365.

## Resolution

To solve this issue, assign the user the [additional privileges required for Dynamics 365 customers](/microsoft-sales-copilot/privileges#privileges-required-for-dynamics-365-customers).

## More information

If your issue is still unresolved, go to the [Sales agent - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
