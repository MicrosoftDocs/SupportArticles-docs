---
title: Troubleshoot issue with missing required variables and actions during agent tranfers from Power Virtual Agents bots
description: Provides a resolution for missing required variables and actions during agent tranfers from Power Virtual Agents bots in Omnichannel for Customer Service.
author: lalexms
ms.author: laalexan
ms.topic: troubleshooting
ms.date: 01/19/2023
---

# Troubleshoot issue with missing required variables and actions during agent tranfers from Power Virtual Agents bots

This article helps you troubleshoot an error message that occurs when you're configuring the handoff between Power Virtual Agents bot and the Omnichannel voice workstream.

## Symptom

An error message similar to the following message is displayed on the Power Virtual Agents dashboard when you're configuring the handoff between Power Virtual Agents bot and the Omnichannel voice workstream:

"Your bot doesn't have access to all the required variables and actions. Ask your admin about installing the Omnichannel package or follow this step-by-step walkthrough".

## Cause

The configuration is missing extentions that allow the bot to access the variables and actions it needs to complete the transfers.

## Resolution

Ensure that the following extensions are installed. These extensions provide out-of-the-box actions or variables in the Power Virtual Agents authoring canvas that make the authoring experience easier for the bot author.

   - [Power Virtual Agents telephony extension](https://appsource.microsoft.com/product/dynamics-365/mscrm.mspva_telephony_extension)
   - [Omnichannel Power Virtual Agent extension](https://appsource.microsoft.com/product/dynamics-365/mscrm.omnichannelpvaextension)
   - [Omnichannel Voice Power Virtual Agent extension](https://appsource.microsoft.com/product/dynamics-365/mscrm.omnichannelvoicepvaextension)

