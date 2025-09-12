---
title: Missing variables and actions during agent transfers from Copilot Studio agents
description: Provides a resolution for the required variables and actions that are missing during transfers from Copilot Studio agents to service representatives in Omnichannel for Customer Service.
ms.reviewer: nenellim
ms.author: yangao
ms.date: 12/12/2024
ms.update-cycle: 180-days
ms.custom: sap:Copilot Studio\Agent transfer
ms.collection: CEnSKM-ai-copilot
---
# Required variables and actions are missing during transfers from Copilot Studio agents to customer service representatives

This article provides a resolution for the error that occurs when you configure the handoff between a Copilot Studio agent and the voice workstream in Omnichannel for Customer Service.

## Symptoms

When you [configure the handoff](/microsoft-copilot-studio/configuration-hand-off-omnichannel) between a Copilot Studio agent and the Omnichannel voice workstream, an error message that resembles the following is displayed on the Copilot Studio dashboard.

> Your bot doesn't have access to all the required variables and actions. Ask your admin about installing the Omnichannel package or follow this step-by-step walkthrough.

## Cause

The configuration is missing extensions that allow the agent to access the variables and actions it needs to complete the transfers.

## Resolution

Ensure that the following extensions are installed. These extensions provide out-of-the-box actions or variables in the Copilot Studio authoring canvas that make the authoring experience easier for the agent author.

- [Power Virtual Agents telephony extension](https://appsource.microsoft.com/product/dynamics-365/mscrm.mspva_telephony_extension)
- [Omnichannel Power Virtual Agent extension](https://appsource.microsoft.com/product/dynamics-365/mscrm.omnichannelpvaextension)
- [Omnichannel Voice Power Virtual Agent extension](https://appsource.microsoft.com/product/dynamics-365/mscrm.omnichannelvoicepvaextension)
