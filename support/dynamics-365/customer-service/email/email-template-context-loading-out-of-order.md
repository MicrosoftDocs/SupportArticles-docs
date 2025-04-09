---
title: Email Template Context Loading Out of Order
description: Solves an issue where the email template context doesn't appear in the correct order in Microsoft Dynamics 365 Customer Service.
ms.reviewer: Megha
ms.date: 04/09/2025
ms.custom: sap:E-Mail, DFM
---
# Email template context loads out of order in Dynamics 365 Customer Service

This article addresses an issue where the email template context loads out of order, particularly impacting content with bullet points in Dynamics 365 Customer Service.

## Symptoms

You may encounter the following issues when using email templates in Dynamics 365 Customer Service:

- The email template content doesn't appear in the correct order.
- Bullet points within the email template are particularly affected, with content being misaligned or rearranged.

## Cause

The issue occurs due to invisible characters embedded in the HTML code of the email template. These characters are often found around the bullet points and interfere with the proper rendering of the template context.

## Resolution

To resolve this issue, follow these steps:

1. Create a new email template and gradually test sections of the original template content to identify the problematic portion.

2. Use an API to inspect and compare the HTML code of the email templates. Look for invisible characters in the HTML, particularly around the bullet point sections.

3. Remove spaces or unnecessary formatting between the lines in the affected template content.

If the issue persists, consider disabling the [Enable a modern RichTextEditor control experience and email descriptions](/power-apps/maker/model-driven-apps/rich-text-editor-control#enable-the-modern-rich-text-editor-experience-from-the-classic-experience) option. The setting can be disabled for the entire organization via the [Setting definition](/power-apps/maker/data-platform/create-edit-configure-settings). Disabling it organization-wide will override the setting for all users.
