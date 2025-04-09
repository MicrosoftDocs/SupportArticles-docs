---
title: Troubleshoot common configuration issues with automatic record creation and update rules
description: Provides resolutions for common configuration issues with automatic record creation and update rules in Dynamics 365 Customer Service.
ms.reviewer: Megha
ms.date: 04/09/2025
ms.custom: sap:E-Mail, DFM
---

# Formatting lost when copying Word template text to CRM email message

When copying text from a Word template into a Dynamics 365 Customer Service CRM email message, users may notice that the formatting, including hyperlinks, images, and other text styles, is lost. This article outlines the symptoms, cause, and steps to resolve this issue.

## Symptoms

When copying and pasting content from a Word template into a Dynamics 365 CRM email message, the following symptoms may occur:

- Hyperlinks are removed.
- Images do not appear.
- Text formatting is lost (e.g., bold, italics, font styles).
- The pasted content appears as plain text.

## Cause

This issue is not specific to Dynamics 365 but stems from a system-level or Word application behavior. The Word desktop application is allowing content to be copied in plain text format only, which results in the loss of formatting when pasting into CRM or other applications like OneNote.

## Solution 1: Verify the issue is not specific to Dynamics 365

To confirm the root cause of the issue:

1. Copy the same content from the Word document.
2. Paste the content into other applications, such as OneNote or Microsoft Teams chat.
3. Check if the formatting is preserved.

If the formatting is also lost in these applications, the issue is not specific to Dynamics 365 but is related to the Word desktop application or the system's copy-paste functionality.

## Solution 2: Use the Word web application as a workaround

The Word web application can be used as an alternative to preserve formatting:

1. Open the Word document in the Word web application.
2. Copy the content from the Word web application.
3. Paste the content into the Dynamics 365 CRM email message.
4. Verify that the formatting, hyperlinks, and images are preserved.

This workaround ensures the formatting is retained when copying and pasting content.

## Solution 3: Contact Office 365 support for a permanent resolution

If the issue persists and affects your workflow:

1. Reach out to your Office 365 support team to investigate the issue further.
2. Alternatively, open a support ticket directly with the Office 365 team for a thorough diagnosis and resolution.

Since this issue falls outside the scope of Dynamics 365 support, Office 365 support is best positioned to provide a permanent fix.