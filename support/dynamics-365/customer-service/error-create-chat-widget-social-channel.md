---
title: Error occurs when trying to create a chat widget or social channel
description: Provides a solution to an error that occurs when trying to create a chat widget or social channel in Dynamics 365 Omnichannel for Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
---

# Error occurs when trying to create a chat widget or social channel

This article provides a solution to an error that occurs when trying to create a chat widget or social channel in Omnichannel for Customer Service.

## Symptom

Omnichannel solutions are installed in your environment when you receive a new trial organization. However, when you try to create a chat widget, Facebook page, or social channel in the Omnichannel Administration app, error messages similar to the following messsages might be displayed:

- An error occurred in the PreLiveChatConfigCreatePlugin plug-in.
- An error occurred in the PostOperationFacebookCreatePlugin plug-in.

## Cause

These errors occur because though the solutions are already installed in your environment, they need to be activated before you can start using them.

## Resolution

To provision the solutions, perform the steps outlined in [Provision Omnichannel for Customer Service](/dynamics365/customer-service/omnichannel-provision-license).
