---
title: Resolve Form Issues in Customer Insights - Journeys
description: Troubleshoot forms in Dynamics 365 Customer Insights - Journeys, including embedding, publishing, lookup fields, submissions, and double opt-in emails.
ms.date: 10/09/2026
ms.reviewer: alfergus, v-shaywood, petrjantac, stbeliak
ai-usage: ai-assisted
search.audienceType: 
  - admin
  - customizer
  - enduser
ms.custom:
  - sap:Real-time journeys forms capturing, hosting and submission
  - sfi-image-nochange
---

# Troubleshoot forms in Customer Insights - Journeys

## Summary

This article helps you troubleshoot Marketing forms and Event Registration forms in Dynamics 365 Customer Insights - Journeys. It covers embedded forms that don't appear, broken styles or screen-reader problems, standalone publishing failures, missing lead sources, removed JavaScript, failed submissions, missing lookup values, and double opt-in confirmation emails that aren't sent. Start with the symptom that matches your problem.

## Embedded form isn't visible on the page

Make sure your domain is allowed for external form hosting. You don't need to finish the domain authentication process to turn on external form hosting for your domain. For more information, see [Domain authentication](/dynamics365/customer-insights/journeys/domain-authentication).

## Form styles look broken or screen readers don't work after embedding

Some web pages have a generic style definition for `<table>` elements. The embedded form inherits this style definition, so the form might look different from how it appears in the form editor. To fix the style conflict between your page and the form, use the table-less form layout, which uses `<div>` containers instead of tables. The table-less layout also improves screen reader performance for better accessibility.

The table-less layout is turned on by default. When you create a new form, it automatically uses the `<div>`-based layout. Existing forms are automatically converted to the table-less layout when you edit and save them.

To manage this setting, go to **Settings** > **Feature switches** > **Forms** and use the **Enable table-less layouts in Form editor** toggle. Save the settings after you change the feature switch.

:::image type="content" source="media/troubleshooting-forms/form-enable-div-layout.png" alt-text="Screenshot of the Enable table-less layouts in Form editor toggle." lightbox="media/troubleshooting-forms/form-enable-div-layout.png":::

## Form fails to publish as a standalone page

If the publish operation fails, try to run it again after a few minutes.

## Lead source is missing for newly created leads

Add the lead source as a field in the form editor, hide the field, and set its default value to the appropriate lead source.

## Form editor removes custom JavaScript or other code from the HTML body

Starting with Customer Insights - Journeys version 1.1.38813.80, you can add JavaScript code into the `<body>` section of the HTML. If you add JavaScript into the `<head>` section, the form editor automatically moves it to the top of the `<body>` section.

In versions of Customer Insights - Journeys older than 1.1.38813.80, you can add custom JavaScript code only to the `<head>` section of the HTML source code by using the HTML editor. If you place the JavaScript code inside the `<body>` section, the form editor automatically removes the code without warning.

To follow security best practices, the form editor might remove unknown code from the body. For more information, see [Customize your form by using JavaScript](/dynamics365/customer-insights/journeys/real-time-marketing-manage-forms#add-custom-javascript-to-your-form).

## Resubmit a failed form submission

A form submission might fail because of issues with custom plug-ins or because of invalid values in the submission.

- If the form submission failed because of a plug-in issue, you can resubmit the submission from the list of submissions.
- If the form submission failed because of an invalid value, you can edit the submission values from the list of submissions. Select the form submission to see the submitted values, select the value you need to change, and then edit it.

> [!IMPORTANT]
> You can only resubmit failed submissions. By resubmitting, you might create a duplicate contact, such as when the submission fails because of a contact point consent creation error. Resubmitting runs the entire submission process again. To avoid duplicate records, you can change the matching strategy before you resubmit.

## Lookup field values are missing

If values are missing in lookup fields on a form, the issue is often caused by missing or insufficient field permissions. Check the following settings:

- Confirm that the required permissions are granted for all fields used in the lookup, including custom fields and fields referenced in filters.
- If the lookup uses filters, confirm that the filters are set up correctly.

## Double opt-in confirmation email isn't sent

Double opt-in is turned on for the form's compliance profile, but people who submit the form don't receive the confirmation email. Instead, the submission is processed right away, and the contact or lead is created or updated without waiting for confirmation.

First, rule out the settings that stop double opt-in from applying to a submission. Learn more in [Double opt-in in real-time journeys](/dynamics365/customer-insights/journeys/real-time-marketing-double-opt-in).

- The **Double Opt-In** feature switch is off, or double opt-in isn't turned on in the **Double Opt-In** tab of the compliance profile.
- Double opt-in is turned off in the form's settings. Forms that existed before the feature switch was turned on have double opt-in turned off by default.
- The compliance profile sends the confirmation email only to new customers, and the email address already has contact point consent for that compliance profile. This behavior is by design.
- The form is an event registration form or a preference center form. Double opt-in doesn't support these forms.

If none of these settings apply, check that the form's email field is a recipient field in audience configuration. The confirmation email is sent only to an email address that comes from one of the email recipient fields set up for the form's audience (contacts, leads, or both). If the form collects the email address in a field that isn't a recipient field, such as a custom email field, there's no email address from a configured recipient field to confirm. The submission is then processed as if double opt-in were off, and no error is shown.

To fix this issue, follow these steps:

1. In the form editor, check which contact or lead field the form's email field is mapped to.
1. Go to **Settings** > **Customer engagement** > **Audience configuration**.
1. Select **Contact** or **Lead** to match the form's audience, and add the field from step 1 as an email recipient field. For more information, see [Select the audience source for journeys](/dynamics365/customer-insights/journeys/real-time-marketing-audience-data).
1. Submit the form with a test email address, and check that the confirmation email arrives.

Alternatively, map the form's email field to a field that's already an email recipient field.

The change applies only to new submissions. Submissions that were already processed without double opt-in don't get a confirmation email.

## Investigate failed form submissions

Failed form submissions typically appear as "Failed to create target entity" or "Failed to update target entity" in the logs. These errors often relate to a customization that creates or updates a contact or lead entity.

:::image type="content" source="media/troubleshooting-forms/submission-pipeline.png" alt-text="Diagram comparing successful and unsuccessful form submission pipelines." lightbox="media/troubleshooting-forms/submission-pipeline.png":::

To troubleshoot a failed form submission, follow these steps:

1. Temporarily [turn on plug-in trace logs](/power-apps/developer/data-platform/logging-tracing#enable-trace-logging). Plug-in trace logs can negatively affect performance, so make sure to turn them off when you're done.
1. Resubmit the failed form submission. See [Resubmit a failed form submission](#resubmit-a-failed-form-submission) for instructions and precautions.
1. Check the logs. If there's a plug-in-related error, you see a plug-in name and a reason why the plug-in crashed. Follow up with the plug-in provider or [disable the plug-in](/power-platform/admin/plug-ins). Don't disable Microsoft plug-ins, which are any plug-ins whose names start with `Microsoft.Dynamics.Cxp.Forms.`.
1. Check the processes connected to the contact, lead, or other entity you're trying to create through the form submission. Try to disable the process that's interfering with the contact creation.

    :::image type="content" source="media/troubleshooting-forms/dynamics-processes.png" alt-text="Screenshot of the list of processes connected to the entity." lightbox="media/troubleshooting-forms/dynamics-processes.png":::

## Related content

- [Customize the Customer Insights - Journeys form editor](/dynamics365/customer-insights/journeys/real-time-marketing-customize-forms)
- [Customize form submission validation](/dynamics365/customer-insights/journeys/real-time-marketing-form-customize-submission-validation)
- [Double opt-in in real-time journeys](/dynamics365/customer-insights/journeys/real-time-marketing-double-opt-in)
