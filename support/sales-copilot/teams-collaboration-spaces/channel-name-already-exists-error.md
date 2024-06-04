---
title: Resolve Microsoft Copilot for Sales channel creation error
description: Resolve errors when creating a channel for an account or opportunity in Microsoft Copilot for Sales due to duplicate names.
ms.date: 06/03/2024
author: sbmjais
ms.author: shjais
ms.custom:
  - sap:CRM Permissions and Configurations\CRM Settings
  - ai-gen-docs-bap
  - ai-gen-title
  - ai-seo-date:06/03/2024
  - ai-gen-desc
---
# Unable to create a channel for account or opportunity with an existing channel name

This article helps you to resolve an error that occurs when you try to create a channel for an account or opportunity in Microsoft Copilot for Sales. The error message indicates that the channel name you entered already exists for the account or opportunity.  

| Requirement type |Description |
|------------------|------------|
|**Client app** | Copilot for Sales Outlook add-in |
|**Platform** | Web and desktop clients |
|**OS** | Windows and Mac |
|**Deployment** | User managed and admin managed |
|**CRM** | Dynamics 365 and Salesforce |
|**Users** | Users who try to create new channel using the collaboration flow in Outlook |

## Symptoms

When you try to create a channel for an account or opportunity in Microsoft Copilot for Sales, the following error message is displayed&mdash;*A channel with that name already exists or was recently deleted, use a different channel name.*

## Cause and resolution

### Issue 1: Channel with the same name was recently deleted

**Cause**  
A channel with the same name was recently deleted. However, the update isn't populated to the **Graph API** response, and the **Graph API** considers this request as an attempt to create a duplicate channel with the same name.

**Resolution**
To resolve this issue, use either of the following methods:  

1. Use a different name to create the channel.
1. Wait for sometime, and create the channel again.

### Issue 2: Channel with the same name exists

**Cause**  

A channel with the same name already exists under the same team.

**Resolution**
To resolve this issue, use either of the following methods:  

1. Use a different name to create the channel.
1. Delete the existing channel, wait for sometime, and create the channel again.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
