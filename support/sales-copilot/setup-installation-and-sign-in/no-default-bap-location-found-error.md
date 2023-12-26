---
title: No default BAP location found for this tenant error
description: Resolves issues in Copilot for Sales when users can't use Microsoft Copilot for Sales due to missing default environment.
ms.date: 12/26/2023
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---
# "No default BAP location found for this tenant" error occurs in Copilot for Sales

This article helps you troubleshoot and resolve issues in Microsoft Copilot for Sales when users are unable to use Copilot for Sales due to missing default environment.

## Who is affected?

| Requirement type |Description  |
|----------------|--------------------|
| **Client App** | MS Outlook Only        |
| **Platform**   | Any (Web & Desktop)    |
| **OS**         | Any (Mac & Windows)    |
| **Deployment** | User and admin managed |
| **CRM**        | CRM less experience    |
| **Users**      | Users who don't have any Dynamics 365 licenses  |

## Symptoms

When you open the Copilot for Sales pane in Microsoft Outlook, the following error message is displayed:

> No default BAP location found for this tenant

:::image type="content" source="media/no-default-bap-location-found-error/no-default-bap-location.png" alt-text="Screenshot that shows the No default BAP location found for this tenant error.":::

## Cause

A default environment isn't created in Power Apps.

Copilot for Sales requires a Power Apps environment for every organization. When Copilot for Sales is launched for the first time, it calls a Power Platform API to get the region details. If the organization doesn't have an existing Power Platform environment, an error message is displayed when attempting to get region details.

## Resolution

To resolve the issue, open the [Power Platform admin center](https://admin.powerplatform.microsoft.com/). A default environment is created for the tenant.

## More information

If your issue is still not resolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
