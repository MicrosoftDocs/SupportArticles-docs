---
title: Resolve Email Template and Formatting Issues
description: Resolve email template formatting, spacing, and missing column issues when using Copilot with the Enhanced Email form in Dynamics 365 Customer Service.
ms.reviewer: meghgupta, srreddy, souravbihani
ai-usage: ai-assisted
ms.date: 10/15/2026
ms.custom: sap:E-Mail, DFM
---
# Issues with email templates and formatting in Dynamics 365 Customer Service

## Summary

This article addresses common email template and formatting issues, such as spacing issues, incorrect formatting, or missing columns, when you use Copilot with the Enhanced Email form in Dynamics 365 Customer Service.

## Symptoms

When [emails are sent using Copilot](/power-apps/maker/model-driven-apps/use-copilot-email-assist) with the **Enhanced Email** form, the emails received by end users have issues with their appearance. Specifically, there might be issues with spacing, incorrect formatting, or missing columns.

## Cause

The email formatting issue with Copilot and the **Enhanced Email** form occurs due to a known issue with the [modern text editor](/power-apps/maker/model-driven-apps/rich-text-editor-control) being enabled.

## Solution

Follow these steps to address the formatting issues caused by the **Enhanced Email** form:

1. Go to [Power Apps](https://make.powerapps.com).
1. Select the relevant environment.
1. Go to **Tables** > **Email** > **Forms**, and then select the **Enhanced Email** form.
1. Locate the **Body** field and delete the existing text editor control component.
1. Save and publish the changes.
1. Ensure that the **Enhanced Email Recipient control** component is enabled for the **From**, **To**, **CC**, and **BCC** fields. Map these fields appropriately.
1. Set the **Static value** option to **True** under the **Show email address** setting.

After removing the text editor control component from the **Body** field and enabling the **Enhanced Email Recipient control**, the email template rendering issues should no longer occur. For more information, see [Enable enhanced recipient control for email](/dynamics365/customer-service/administer/add-recipient-control).

For other template rendering scenarios, see [Email template context loading out of order](email-template-context-loading-out-of-order.md) and [Rich text editor limitations](/power-apps/maker/model-driven-apps/rich-text-editor-control#rich-text-editor-limitations).

## Related content

- [Add the rich text editor control to a model-driven app](/power-apps/maker/model-driven-apps/rich-text-editor-control)
- [Create email templates](/power-apps/user/email-template-create)
