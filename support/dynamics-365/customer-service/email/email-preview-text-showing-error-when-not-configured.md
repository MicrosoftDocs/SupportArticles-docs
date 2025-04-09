---
title: Email Preview Text Shows Error or Unintended Formatting
description: Provides a resolution to ensure that the email preview text is displayed correctly and avoids showing unintended formatting details in Dynamics 365 Customer Service.
ms.reviewer: Megha
ms.date: 04/09/2025
ms.custom: sap:E-Mail, DFM
---
# Email preview text shows an error or unintended formatting when not configured

This article guides you on resolving an issue where email preview text displays an error or unintended formatting in Dynamics 365 Customer Service.

## Symptoms

When you send an email in Dynamics 365 Customer Service, the email preview text may display an error or unintended formatting (for example, "{ 0 margins ..") instead of a meaningful preview. This issue typically occurs when the email content is primarily an image and no explicit email preview text has been set.

## Cause

This issue occurs because the system automatically uses the email's content as the preview text if no explicit preview text is configured. When the email content is an image, the system extracts the formatting details of the image, resulting in unintended text being displayed in the email preview.

## Resolution

To resolve this issue, add a simple email preview text to the email that contains an image as the primary content. The text will be displayed in the email preview instead of the extracted formatting details.
