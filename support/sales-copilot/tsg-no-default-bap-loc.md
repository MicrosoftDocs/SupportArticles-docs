---
title: No default BAP location found for this tenant 
description: Troubleshoot and resolve issues in Copilot for Sales when users are unable to use Copilot for Sales due to missing default environment
ms.date: 12/20/2023
ms.topic: troubleshooting-problem-resolution
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---

# No default BAP location found for this tenant

This article helps you troubleshoot and resolve issues in Copilot for Sales when users are unable to use Copilot for Sales due to missing default environment.

## Who is affected?

| Requirement type |Description  |
|----------------|--------------------|
| **Client App** | MS Outlook Only        |
| **Platform**   | Any (Web & Desktop)    |
| **OS**         | Any (Mac & Windows)    |
| **Deployment** | User and admin managed |
| **CRM**        | CRM less experience    |
| **Users**      | Users who do not have any Dynamics 365 licenses  |


## Symptom 

When you open the Copilot for Sales pane in Microsoft Outlook, the following error message is displayed: `No default BAP location found for this tenant`. 

:::image type="content" source="media/tsg-bap-location.png" alt-text="Screenshot showing BAP location error.":::

## Cause

Default environment is not created in Power Apps.

Copilot for Sales requires a Power Apps environment for every organization. When Copilot for Sales is launched for the first time, it calls a Power Platform API to get the region details. If the organization does not have an existing Power Platform environment an error message is displayed when attempting to get region details.

## Solution

To resolve the issue, open the [Power Platform admin center](https://admin.powerplatform.microsoft.com/). A default environment is created for the tenant.

## Is your issue still not resolved?

Visit the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.