---
title: Agents Don't Receive Desktop Notifications for New Messages
description: Solves an issue where agents don't receive desktop notifications for new session messages when the browser isn't active in Microsoft Dynamics 365 Contact Center and Dynamics 365 Customer Service.
author: Yerragovula
ms.author: srreddy
ms.reviewer: courtser
ai-usage: ai-assisted
ms.date: 04/21/2025
ms.custom: sap:Live chat Widget (LCW), DFM
---
# Agents don't receive desktop notifications for new session messages when the browser isn't active

This article addresses an issue where agents don't receive notifications for newly assigned session messages when their browser page isn't actively viewed in Dynamics 365 Contact Center and Dynamics 365 Customer Service.

## Symptoms

Agents don't receive [notifications](/dynamics365/customer-service/administer/notification-templates#desktop-notifications) for new session messages when the browser is running in the background.

## Cause

This issue occurs because the system is configured to use default notification templates, which don't support desktop notifications when the application isn't actively in use.

## Resolution

To resolve this issue and enable desktop notifications for agents when the browser isn't active, follow these steps:

1. Create a new notification template:

    - Navigate to the [notification settings](/dynamics365/customer-service/administer/notification-templates#create-a-notification-template) in the Dynamics 365 environment.
    - Create a notification template named "When app is in the background."
    - Enable the **Show Desktop Notification** setting for this template.

    For more information, see [Use notifications in Dynamics 365 Customer Service](/dynamics365/customer-service/use/oc-notifications).

2. Associate the newly created notification template with the appropriate workstream:

    - Identify the workstream(s) that require the new notification template.
    - Associate the "When app is in the background" notification template with the relevant workstream(s).

    For step-by-step guidance, see [Associate notification templates with workstreams](/dynamics365/customer-service/administer/associate-templates).
