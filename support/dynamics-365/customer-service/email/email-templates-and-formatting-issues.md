---
title: Email Template Formatting Issues with Copilot
description: Learn about email template formatting, spacing, and missing columns when you use Copilot with the Enhanced Email form in Dynamics 365 Customer Service.
ms.reviewer: meghgupta, srreddy, souravbihani
ai-usage: ai-assisted
ms.date: 11/12/2026
ms.custom: sap:E-Mail, DFM
---
# Email template formatting issues in Dynamics 365 Customer Service

## Summary

Resolve email template formatting issues, including spacing errors and missing columns, when you use Copilot with the Enhanced Email form in Dynamics 365 Customer Service. This article also covers recipient display, cursor position, and font issues in template-based emails.

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

After you remove the text editor control component from the **Body** field and enable the **Enhanced Email Recipient control**, the email template rendering issues should no longer occur. For more information, see [Enable enhanced recipient control for email](/dynamics365/customer-service/administer/add-recipient-control).

For other template rendering scenarios, see [Email template context loading out of order](email-template-context-loading-out-of-order.md) and [Rich text editor limitations](/power-apps/maker/model-driven-apps/rich-text-editor-control#rich-text-editor-limitations).

## Additional troubleshooting scenarios

### Recipient display or address behavior is inconsistent in template-based emails

If the recipient name or email address appears differently than expected after template insertion, verify that the **Enhanced Email Recipient control** is enabled and mapped for **From**, **To**, **CC**, and **BCC**. Also verify that **Show email address** is set to **Static value** = **True** in the control settings.

### Cursor position jumps during template edits

Cursor jumps can occur in the modern rich text editor when template HTML contains hidden or inconsistent formatting. To reduce this behavior:

1. Simplify template content by removing extra spaces and unnecessary line-level formatting.
1. Paste content as plain text first, and then reapply formatting in the editor.
1. If the behavior persists, revert to the classic editor experience by using [Revert from the modern rich text editor experience to the classic experience](/power-apps/maker/model-driven-apps/rich-text-editor-control#revert-from-the-modern-rich-text-editor-experience-to-the-classic-experience).

### Fonts or formatting look different after save or send

When you author email content by using rich formatting, the rendered output can differ based on supported HTML and cascading style sheets in the editor and the recipient client. Use simple supported formatting and avoid complex nested styles. For known editor boundaries, review [Rich text editor limitations](/power-apps/maker/model-driven-apps/rich-text-editor-control#rich-text-editor-limitations).

## Quick triage checklist for support engineers

Use this checklist when investigating template-formatting tickets.

| Check | Why it matters |
|---|---|
| **Enhanced Email** form is in use | Issue pattern is specific to **Enhanced Email** and modern editor scenarios |
| Recipient control enabled and mapped for **From**, **To**, **CC**, and **BCC** | Prevents inconsistent recipient rendering behavior |
| **Show email address** = **Static value** **True** | Stabilizes recipient display behavior |
| Template tested with plain text baseline | Helps isolate template HTML and formatting artifacts |
| Rich text editor reverted to classic (if needed) | Mitigates persistent editor-side behavior |

**Suggested search keywords for support correlation**: enhanced email form, email template formatting, recipient control, cursor jump, rich text editor, template html.

## Related content

- [Add the rich text editor control to a model-driven app with Power Apps](/power-apps/maker/model-driven-apps/rich-text-editor-control)
- [Create email templates](/power-apps/user/email-template-create)
