---
title: Troubleshoot issue with integrated search providers
description: Provides a resolution for issues with integrated search providers in Dynamics 365 Customer Service.
author: lalexms
ms.author: laalexan
ms.topic: troubleshooting
ms.date: 03/08/2023
---

# Troubleshoot issues with integrated search providers (preview)

This article helps you troubleshoot issues with integrated search providers in Customer Service.

## Data isn't updated on the Insights tab for integrated search providers

### Symptom

Data doesn't get updated on the Insights tab for integrated search providers

### Cause

The configuration is missing extentions that allow the bot to access the variables and actions it needs to complete the transfers.

### Resolution

Ensure that the following extensions are installed. These extensions provide out-of-the-box actions or variables in the Power Virtual Agents authoring canvas that make the authoring experience easier for the bot author.

   - [Power Virtual Agents telephony extension](https://appsource.microsoft.com/product/dynamics-365/mscrm.mspva_telephony_extension)
   - [Omnichannel Power Virtual Agent extension](https://appsource.microsoft.com/product/dynamics-365/mscrm.omnichannelpvaextension)
   - [Omnichannel Voice Power Virtual Agent extension](https://appsource.microsoft.com/product/dynamics-365/mscrm.omnichannelvoicepvaextension)
