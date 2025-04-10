---
title: Issues with Email Templates and Formatting in Dynamics 365
description: Solves incorrect formatting, missing columns, spacing issues, the arbitrary tracking code appended to the subject line, and emails being sent only to the first contact in Microsoft Dynamics 365 apps.
ms.reviewer: Megha
ai-usage: ai-assisted
ms.date: 04/10/2025
ms.custom: sap:E-Mail, DFM
---
# Issues with email templates and formatting in Dynamics 365 apps

This article addresses common issues encountered with email templates and formatting in Dynamics 365 Customer Service and Dynamics 365 Sales, including problems with the Enhanced Email form and email tracking tokens.

## Symptom 1

When [emails are sent using Copilot](/dynamics365/sales/compose-send-email-copilot) with the **Enhanced Email** form, the emails received by end users have issues with their appearance. Specifically, the formatting is incorrect, some columns are missing, and there are problems with spacing.

### Cause

The email formatting issue with Copilot and the Enhanced Email form occurs due to a known issue with the "New Look" or [modern text editor](/power-apps/maker/model-driven-apps/rich-text-editor-control) being enabled.

### Resolution

Follow these steps to address the formatting issues caused by the Enhanced Email form:

1. Navigate to the [Power Apps](https://make.powerapps.com).
2. Select the relevant environment.
3. Go to **Tables** > **Email** > **Forms**, and then select the **Enhanced Email** form.
4. Locate the **Body** field and delete the existing text editor control component.
5. Save and publish the changes.
6. Ensure the **Enhanced Email Recipient control** component is enabled for the **From**, **To**, **CC**, and **BCC** fields. Map these fields appropriately.
7. Set the **Static value** option **True** under the **Show email address** setting.

After removing the text editor control component from the **Body** field and enabling the **Enhanced Email Recipient control**, the email template rendering issues should no longer occur.

For more information, see [Enable enhanced recipient control for email](/dynamics365/customer-service/administer/add-recipient-control).

## Symptom 2

When you send emails from Dynamics 365 Sales using templates, the system automatically adds a random tracking code (formatted as CRM:nnnnn) to the subject line of the email. Additionally, instead of sending the email to all the intended recipients in the selected list, it only sends the email to the first contact on that list.

### Cause

The arbitrary code appended to the email subject line and emails being sent only to the first contact is caused by the email tracking token setting being enabled.

### Resolution

To prevent arbitrary tracking codes from being appended to the subject line and ensure emails are sent to all selected recipients:

1. Access the Dynamics 365 Sales environment as a system administrator.
2. Navigate to **Settings** > **Administration** > **System Settings**.
3. Under the **Email** tab, locate the **Use tracking tokens** setting.
4. Disable the **Use tracking tokens** option.
5. Save the changes.

## More information

- [Add the rich text editor control to a model-driven app](/power-apps/maker/model-driven-apps/rich-text-editor-control)
- [Configure the enhanced email template editor page](/power-apps/user/cs-email-template-builder)
