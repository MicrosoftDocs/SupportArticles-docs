---
title: Email Template Context Loads Out of Order
description: Email template context can appear out of order in Dynamics 365 Customer Service. Learn how to troubleshoot bullet points and localized template text.
ms.reviewer: meghgupta, srreddy, souravbihani
ai-usage: ai-assisted
ms.date: 11/12/2026
ms.custom: sap:E-Mail, DFM
---
# Email template context loads out of order in Dynamics 365 Customer Service

## Summary

This article explains how to troubleshoot email template content that appears out of order in Dynamics 365 Customer Service. Learn how to identify invisible characters in template HTML, correct misaligned bullet points, and compare language variants when localized template text appears in an unexpected order.

## Symptoms

You might encounter the following issues when using [email templates](/power-apps/user/email-template-create) in Dynamics 365 Customer Service:

- The email template content doesn't appear in the correct order.
- Bullet points within the email template are particularly affected, with content being misaligned or rearranged.

## Cause

Invisible characters embedded in the HTML code of the email template cause the issue. These characters often appear around the bullet points and interfere with the proper rendering of the template context.

## Resolution

To troubleshoot this issue, follow these steps:

1. Create a new email template and gradually test sections of the original template content to identify the problematic portion.

1. Use an API to inspect and compare the HTML code of the email templates. Look for invisible characters in the HTML, particularly around the bullet point sections.

1. Remove spaces or unnecessary formatting between the lines in the affected template content.

If the issue persists, consider disabling the modern rich text editor experience by following the steps in [Revert from the modern rich text editor experience to the classic experience](/power-apps/maker/model-driven-apps/rich-text-editor-control#revert-from-the-modern-rich-text-editor-experience-to-the-classic-experience). You can also disable this setting for the entire organization via the [Setting definition](/power-apps/maker/data-platform/create-edit-configure-settings). Disabling it organization-wide overrides the setting for all users.

## Related scenario: localized template text appears in an unexpected order

In localized environments, template output can appear out of order if translation content introduces hidden formatting differences between language variants. If only one language variant reproduces the issue:

1. Compare the template HTML between affected and unaffected language variants.
1. Normalize list formatting and spacing in the affected variant.
1. Retest with a simplified plain-text baseline and reintroduce formatting gradually.

For broader formatting issues in **Enhanced Email**, see [Email template formatting issues in Dynamics 365 Customer Service](email-templates-and-formatting-issues.md).
