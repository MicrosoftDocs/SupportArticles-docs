---
title: Email Template Context Loading Out of Order
description: Solves an issue where the email template context doesn't appear in the correct order in Microsoft Dynamics 365 Customer Service.
author: Yerragovula

ms.author: srreddy

ms.reviewer: Meghgupta


ms.reviewer: Meghgupta

ai-usage: ai-assisted
ms.date: 04/10/2025
ms.custom: sap:E-Mail, DFM
---
# Email template context loads out of order in Dynamics 365 Customer Service

This article solves an issue where the email template context loads out of order, particularly impacting content with bullet points in Dynamics 365 Customer Service.
You may encounter the following issues when using [email templates](/power-apps/user/email-template-create) in Dynamics 365 Customer Service:
## Symptoms


You may encounter the following issues when using [email templates](/power-apps/user/email-template-create) in Dynamics 365 Customer Service:


- The email template content doesn't appear in the correct order.
- Bullet points within the email template are particularly affected, with content being misaligned or rearranged.

## Cause

To troubleshoot this issue, follow these steps:


## Resolution

To troubleshoot this issue, follow these steps:


1. Create a new email template and gradually test sections of the original template content to identify the problematic portion.
If the issue persists, consider disabling the modern rich text editor experience by following the steps in [Revert from the modern rich text editor experience to the classic experience](/power-apps/maker/model-driven-apps/rich-text-editor-control#revert-from-the-modern-rich-text-editor-experience-to-the-classic-experience). This setting can also be disabled for the entire organization via the [Setting definition](/power-apps/maker/data-platform/create-edit-configure-settings). Disabling it organization-wide will override the setting for all users.

2. Use an API to inspect and compare the HTML code of the email templates. Look for invisible characters in the HTML, particularly around the bullet point sections.

3. Remove spaces or unnecessary formatting between the lines in the affected template content.

If the issue persists, consider disabling the modern rich text editor experience by following the steps in [Revert from the modern rich text editor experience to the classic experience](/power-apps/maker/model-driven-apps/rich-text-editor-control#revert-from-the-modern-rich-text-editor-experience-to-the-classic-experience) option. This setting can also be disabled for the entire organization via the [Setting definition](/power-apps/maker/data-platform/create-edit-configure-settings). Disabling it organization-wide will override the setting for all users.

