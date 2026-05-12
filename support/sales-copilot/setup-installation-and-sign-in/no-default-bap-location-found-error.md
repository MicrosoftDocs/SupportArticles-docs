---
title: No default BAP location found for this tenant error
description: Resolves issues in Sales agent when users can't use Sales agent due to missing a default environment.
ms.date: 05/12/2026
author: sbmjais
ms.author: shjais
manager: shujoshi
ms.custom: sap:Setup, Installation and Sign-in\CRM Sign-In & Sign Out
---
# "No default BAP location found for this tenant" error in Sales agent

This article helps you troubleshoot and resolve issues in Sales agent when users are unable to use Sales agent due to missing a default environment.

## Who is affected?

| Requirement type |Description  |
|----------------|--------------------|
| **Client App** | Microsoft Outlook only        |
| **Platform**   | Web and desktop clients    |
| **OS**         | Windows and    |
| **Deployment** | User managed and admin managed |
| **CRM**        | CRM less experience    |
| **Users**      | Users who don't have any Dynamics 365 licenses  |

## Symptoms

When you open the Sales agent pane in Microsoft Outlook, the following error message is displayed:

> No default BAP location found for this tenant

:::image type="content" source="media/no-default-bap-location-found-error/no-default-bap-location.png" alt-text="Screenshot that shows the No default BAP location found for this tenant error.":::

## Cause

No default environment is created in Power Apps.

Sales agent requires a Power Apps environment for every organization. When Sales agent is launched for the first time, it calls a Power Platform API to get the region details. If the organization doesn't have an existing Power Platform environment, an error message is displayed when attempting to get region details.

## Resolution

To resolve the issue, open the [Power Platform admin center](https://admin.powerplatform.microsoft.com/). A default environment is created for the tenant.

## More information

If your issue is still unresolved, go to the [Sales agent - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
