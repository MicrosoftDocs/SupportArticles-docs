---
author: srreddy
ms.author: srreddy
ms.service: dynamics-365-customer-service
ms.topic: troubleshooting-general
ms.date: 03/20/2025
title: Troubleshoot email field validation in pre-chat survey
description: Troubleshoot email field validation in pre-chat survey
---
# Troubleshoot email field validation in pre-chat survey

This article provides guidance on addressing issues related to the validation of the email field in the pre-chat survey for live chat widgets in Microsoft Dynamics 365 Customer Service.

## Prerequisites

- Basic understanding of Dynamics 365 Customer Service.
- Access to Dynamics 365 Customer Service environment.
- Familiarity with customization in Dynamics 365 or Microsoft Copilot Studio.

## Potential quick workarounds

### Workaround 1: Develop a custom live chat widget

The default functionality of the live chat widget does not support specific validations for the email field. To enable email format validation, consider developing a custom live chat widget.

1. Refer to [Develop a custom live chat widget | Microsoft Learn](/dynamics365/customer-service/develop/develop-live-chat-widget) for detailed steps.
2. Implement custom logic to validate email formats during the pre-chat survey.

### Workaround 2: Use a Copilot bot for email collection

An alternative approach is to create a Copilot bot that includes an "identification" topic to collect and validate email addresses from users.

1. Refer to [Create and edit topics - Microsoft Copilot Studio | Microsoft Learn](/microsoft-copilot-studio/authoring-create-edit-topics?tabs=webApp) for more information.
2. Design the bot to prompt users for their email addresses and validate the input.

## Troubleshooting checklist

### Verify default functionality

Check whether the issue arises due to the limitations of the default live chat widget in Dynamics 365 Customer Service.

### Explore customization options

Evaluate whether implementing custom logic or using Copilot bot methods aligns with your requirements.

## Cause: Lack of built-in email validation

The default live chat widget does not include built-in functionality to validate email formats in the pre-chat survey. Customization is necessary to enforce email validation.

### Solution: Implement email validation through customization

1. Develop a custom live chat widget that supports email validation. Follow the guidance in [Develop a custom live chat widget | Microsoft Learn](/dynamics365/customer-service/develop/develop-live-chat-widget).
2. Alternatively, configure a Copilot bot with an "identification" topic to handle email collection and validation. Refer to [Create and edit topics - Microsoft Copilot Studio | Microsoft Learn](/microsoft-copilot-studio/authoring-create-edit-topics?tabs=webApp).

## Advanced troubleshooting and data collection

For future enhancements, customers can submit their requests through the [Dynamics 365 Ideas portal](/experience.dynamics.com/ideas/), where similar requests from other users are already being tracked. This feedback helps Microsoft prioritize feature improvements.

If further assistance is required, collect relevant configuration details from your Dynamics 365 environment and submit a support ticket through the Microsoft support portal.