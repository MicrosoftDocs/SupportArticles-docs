---
title: Unexpected errors when enabling Salesforce server-to-server flow
description: Resolves an error that occurs during the Salesforce server-to-server flow setup.
author: sbmjais
ms.author: shjais
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---

# Unexpected errors when enabling Salesforce server-to-server flow

This article helps you troubleshoot some unexpected errors when you enable Salesforce server-to-server flow.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Teams        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Administrator  |

## Symptoms

When you try to enable Salesforce with server-to-server flow, one of the following error messages is displayed.

- Couldn't get deployment status due to incorrect ID format.
- Couldn't find the connected app.
- Couldn't get user license ID is missing to create connection user.
- Couldn't fully remove connection data from Dataverse. Contact Sales support to request manual cleanup.
- Couldn't complete the connected app or permission set deployment to Salesforce. Try again.
- Couldn't complete the connected app deployment to Salesforce. Try again.
- Couldn't complete the permission set deployment to Salesforce. Try again.

## Cause

During Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user that is created automatically. A permission set is then assigned to the integration user. In this process, some unexpected errors may occur.

## Resolution

To resolve this issue, try again. If the issue persists, gather the error details and contact Microsoft support.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]