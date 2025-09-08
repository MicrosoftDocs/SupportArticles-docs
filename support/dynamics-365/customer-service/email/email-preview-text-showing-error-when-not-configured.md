---
title: Email Preview Text Shows Error or Unintended Formatting
description: Provides a resolution to ensure that the email preview text is displayed correctly and avoids showing unintended formatting details in Dynamics 365 Customer Service.
author: Yerragovula
ms.author: srreddy
ms.reviewer: meghgupta
ai-usage: ai-assisted
ms.date: 04/14/2025
ms.custom: sap:E-Mail, DFM
---
# Email preview text shows an error or unintended formatting when not configured

This article provides guidance for resolving issues where email preview text displays an error or unintended formatting in Dynamics 365 Customer Service.

## Symptoms

When you send an email in Dynamics 365 Customer Service, the email preview text might display an error or unintended formatting (for example, **{ 0 margins ..**) instead of a meaningful preview. This issue typically occurs when the email content is primarily an image and no explicit email preview text is set.

## Cause

If no explicit email preview text is configured, the system automatically uses the email's content as the preview text. When the email content is an image, the system extracts the formatting details of the image, resulting in unintended text being displayed in the email preview.

## Resolution

To prevent unintended formatting issues, add an email preview text to the email that contains an image as the primary content. The text will then be displayed in the email preview instead of the extracted formatting details.
