---
title: Couldn't create user when enabling Salesforce server-to-server flow
description: Resolves an error that occurs due to Salesforce Integration license limit.
ms.date: 05/15/2024
author: sbmjais
ms.author: shjais
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---

# Couldn't create user when enabling Salesforce server-to-server flow

This article helps you troubleshoot the "Couldn't create user because Salesforce integration license limit reached." error when you enable Salesforce server-to-server flow.

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

When you try to enable Salesforce with server-to-server flow, the following error message is displayed.

> Couldn't create user because Salesforce integration license limit reached.

## Cause

During Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user that is created automatically. Salesforce Integration user license is assigned to this integration user. The error occurs when the maximum allowed number of Salesforce Integration user licenses has already been reached.

## Resolution

To resolve this issue, check if the maximum allowed number of Salesforce Integration user licenses has been reached. If so, you need to either reassign existing integration users to other licenses or purchase more licenses.

To check the number of integration user licenses available in your Salesforce organization:

1. Sign in to Salesforce as an administrator.
2. Go to **Setup** > **Company Settings** > **Company Information**.
3. Under **User Licenses**, check the number of **Salesforce Integration** licenses available under the **Remaining Licenses** column. If the number is 0, you need to either deactivate existing integration users or change their licenses to other types. You can also purchase more licenses.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]