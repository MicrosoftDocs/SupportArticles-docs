---
title: Lost Formatting When Copying Word Template Content To Email Message
description: Solves an issue where formatting isn't retained when copying and pasting content from a Word template into an email message in Microsoft Dynamics 365 apps.
author: Yerragovula
ms.author: srreddy
ms.reviewer: Meghgupta
ai-usage: ai-assisted
ms.date: 04/10/2025
ms.custom: sap:E-Mail, DFM
---
# Formatting is lost when copying Word template content to an email message

This article helps you isolate and work around formatting issues that may occur when content is pasted from a Word template into an email message in Dynamics 365 apps.

## Symptoms

When you copy and paste content from a Word template into an email message in Dynamics 365 apps, you might encounter the following issues:

- Hyperlinks are removed.
- Images don't appear.
- Text formatting is lost (for example, bold, italics, or font styles.)
- The pasted content appears as plain text.

## Cause

The formatting issues might be caused by the Word desktop application or a system level issue, where content is copied in plain text format. As a result, formatting is lost when the content is pasted into Dynamics 365 applications.

## Resolution

To solve this issue,

1. Verify the issue isn't specific to Dynamics 365:

    1. Copy the same content from the Word document.
    2. Paste the content into other applications, such as OneNote or Microsoft Teams chat.
    3. Check if the formatting is preserved.

       If the formatting is also lost in these applications, the issue isn't specific to Dynamics 365 but is related to the Word desktop application or the system's copy-paste functionality.

2. Use the Word web application as a workaround

    The Word web application can be used to retain formatting when copying and pasting content:

    1. Open the same content in the Word web application.
    2. Copy the content from the Word web application.
    3. Paste the content into the Dynamics 365 email message.
    4. Verify that the formatting, hyperlinks, and images are preserved.

3. If the issue persists and affects your workflow, contact Microsoft 365 support for further assistance.

## More information

[Use Word templates to create standardized documents](/power-platform/admin/using-word-templates-dynamics-365)
