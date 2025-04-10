---
title: Lost Formatting When Copying Word Template Content To Email Message
description: Solves an issue where formatting isn't retained when copying and pasting content from a Word template into an email message in Microsoft Dynamics 365 apps.
ms.reviewer: Megha
ms.date: 04/10/2025
ms.custom: sap:E-Mail, DFM
---
# Formatting is lost when copying Word template content to an email message

This article provides guidance on identifying the lost formatting issue that occurs when the content is pasted from a Word template into an email message in Dynamics 365 apps and provides solutions to preserve the original formatting.

## Symptoms

When you copy and paste content from a Word template into an email message in Dynamics 365 apps, you might encounter the following issues:

- Hyperlinks are removed.
- Images don't appear.
- Text formatting is lost (for example, bold, italics, or font styles.)
- The pasted content appears as plain text.

## Cause

This issue might be caused by a behavior in the Word desktop application or at the system level, where content is copied in plain text format. As a result, formatting is lost when the content is pasted into Dynamics 365 or other applications, such as OneNote.

## Resolution

To solve this issue,

1. Verify the issue isn't specific to Dynamics 365:

    1. Copy the same content from the Word document.
    2. Paste the content into other applications, such as OneNote or Microsoft Teams chat.
    3. Check if the formatting is preserved.

       If the formatting is also lost in these applications, the issue isn't specific to Dynamics 365 but is related to the Word desktop application or the system's copy-paste functionality.

2. Use the Word web application as a workaround

    The Word web application can be used to retain formatting when copying and pasting content:

    1. Open the Word document in the Word web application.
    2. Copy the content from the Word web application.
    3. Paste the content into the Dynamics 365 email message.
    4. Verify that the formatting, hyperlinks, and images are preserved.

    This workaround ensures the formatting is retained when copying and pasting content.

3. If the issue persists and affects your workflow, contact Microsoft 365 support for further assistance.

## More information

[Use Word templates to create standardized documents](/power-platform/admin/using-word-templates-dynamics-365)
