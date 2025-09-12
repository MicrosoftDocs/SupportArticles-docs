---
title: Issues with Email Templates and Formatting in Dynamics 365
description: Solves incorrect formatting, missing columns, spacing issues, the arbitrary tracking code appended to the subject line, and emails being sent only to the first contact in Microsoft Dynamics 365 Customer Service.
author: Yerragovula
ms.author: srreddy
ms.reviewer: meghgupta
ai-usage: ai-assisted
ms.date: 04/14/2025
ms.custom: sap:E-Mail, DFM
---
# Issues with email templates and formatting in Dynamics 365 Customer Service

This article addresses common issues encountered with email templates and formatting when using the Enhanced Email form in Dynamics 365 Customer Service.

## Symptoms

When [emails are sent using Copilot](/dynamics365/sales/compose-send-email-copilot) with the **Enhanced Email** form, the emails received by end users have issues with their appearance. Specifically, there may be issues with spacing, incorrect formatting, or missing columns.

## Cause

The email formatting issue with Copilot and the Enhanced Email form occurs due to a known issue with the [modern text editor](/power-apps/maker/model-driven-apps/rich-text-editor-control) being enabled.

## Resolution

Follow these steps to address the formatting issues caused by the Enhanced Email form:

1. Navigate to [Power Apps](https://make.powerapps.com).
2. Select the relevant environment.
3. Go to **Tables** > **Email** > **Forms**, and then select the **Enhanced Email** form.
4. Locate the **Body** field and delete the existing text editor control component.
5. Save and publish the changes.
6. Ensure the **Enhanced Email Recipient control** component is enabled for the **From**, **To**, **CC**, and **BCC** fields. Map these fields appropriately.
7. Set the **Static value** option **True** under the **Show email address** setting.

After removing the text editor control component from the **Body** field and enabling the **Enhanced Email Recipient control**, the email template rendering issues should no longer occur. For more information, see [Enable enhanced recipient control for email](/dynamics365/customer-service/administer/add-recipient-control).

## More information

- [Add the rich text editor control to a model-driven app](/power-apps/maker/model-driven-apps/rich-text-editor-control)
- [Configure the enhanced email template editor page](/power-apps/user/cs-email-template-builder)
