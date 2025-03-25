---
title: Email Field Validation Doesn't Work in Pre-conversation Survey
description: Explains why email field in the Pre-conversation survey doesn't validate for incorrect email formats in Microsoft Dynamics 365 Customer Service.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/25/2025
ms.custom: sap:Live Chat Widget (LCW), DFM
---
# Email field validation in a Pre-conversation survey doesn't work as expected

This article explains email field validation in the [Pre-conversation survey](/dynamics365/customer-service/administer/configure-pre-chat-survey) for live chat widgets in Microsoft Dynamics 365 Customer Service.

## Symptoms

The email field in the Pre-conversation survey doesn't validate for incorrect email formats, allowing users to enter malformed email addresses. This issue can result in difficulties in collecting accurate user information and might affect communication.

## Cause

The default live chat widget doesn't include built-in functionality to validate email formats in the Pre-conversation survey. Customization is necessary to enforce email format validation.

## Resolution

To solve this issue, create a custom live chat widget that supports email validation. Follow the guidance in [Develop a custom live chat widget](/dynamics365/customer-service/develop/develop-live-chat-widget).

Alternatively, you can configure a Copilot bot with an "identification" topic to handle email collection and validation. For more information, see [Create and edit topics in Copilot Studio](/microsoft-copilot-studio/authoring-create-edit-topics?tabs=webApp).
