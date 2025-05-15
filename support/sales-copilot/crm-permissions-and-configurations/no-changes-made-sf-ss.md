---
title: No changes were made error when enabling Salesforce server-to-server flow
description: Resolves an error that occurs when no changes are made while enabling Salesforce server-to-server flow.
ms.date: 05/14/2025
author: sbmjais
ms.author: shjais
manager: shujoshi
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---

# "No changes were made" error when enabling Salesforce server-to-server flow

This article helps you troubleshoot the error "No changes were made." when you enable Salesforce server-to-server flow.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Teams        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce        |
|**Users**     | Administrator|

## Symptoms

When you try to enable Salesforce with server-to-server flow, the following error message is displayed:

> No changes were made.

## Cause

During Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user that is created automatically. A permission set is then assigned to the integration user. The error occurs when the same permission set has already been assigned to the user.

## Resolution

To resolve this issue, check for any manual changes to the connected app or profile with the prefix "CopilotForSales." If the changes were not intentional, revert them. Otherwise, try again and contact Microsoft Support if the issue persists.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
