---
title: Troubleshoot Forms in Customer Insights - Journeys
description: Fix forms in Dynamics 365 Customer Insights - Journeys, including embedding, styling, publishing, lookup, and submission issues.
ms.date: 07/06/2026
ms.reviewer: alfergus, v-shaywood
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

This article helps you troubleshoot forms in Dynamics 365 Customer Insights - Journeys. It applies to both Marketing forms and Event Registration forms. It covers embedded forms that don't appear on a page, broken styles or screen-reader problems after embedding, forms that fail to publish as a standalone page, a missing lead source on new leads, custom JavaScript that the form editor removes, failed form submissions that you resubmit or investigate, and missing values in lookup fields. Start with the symptom that matches your problem to find the cause and the fix.

## An embedded form isn't visible on the page

Make sure your domain is allowed for external form hosting. You don't need to finish the domain authentication process to turn on external form hosting for your domain. For more information, see [Domain authentication](/dynamics365/customer-insights/journeys/domain-authentication).

## Form styles look broken or screen readers don't work after embedding

Some web pages have a generic style definition for `<table>` elements. The embedded form inherits this style definition, so the form might look different from how it appears in the form editor. To fix the style conflict between your page and the form, use the table-less form layout, which uses `<div>` containers instead of tables. The table-less layout also improves screen reader performance for better accessibility.

The table-less layout is turned on by default. When you create a new form, it automatically uses the `<div>`-based layout. Existing forms are automatically converted to the table-less layout when you edit and save them.

To manage this setting, go to **Settings** > **Feature switches** > **Forms** and use the **Enable table-less layouts in Form editor** toggle. Save the settings after you change the feature switch.

:::image type="content" source="media/troubleshooting-forms/form-enable-div-layout.png" alt-text="Screenshot of the Enable table-less layouts in Form editor toggle." lightbox="media/troubleshooting-forms/form-enable-div-layout.png":::

## A form fails to publish as a standalone page

If the publish operation fails, try to run it again after a few minutes.

## Lead source is missing for newly created leads

Add the lead source as a field in the form editor, set the field as hidden, and set the correct default value to match your newly created lead's data.

## The form editor removes custom JavaScript or other code from the HTML body

Starting with Customer Insights - Journeys version 1.1.38813.80, you can add JavaScript code into the `<body>` section of the HTML. If you add JavaScript into the `<head>` section, the form editor automatically moves it to the top of the `<body>` section.

In versions of Customer Insights - Journeys older than 1.1.38813.80, you can add custom JavaScript code only to the `<head>` section of the HTML source code by using the HTML editor. If you place the JavaScript code inside the `<body>` section, the form editor automatically removes the code without warning.

To follow security best practices, the form editor might remove unknown code from the body. For more information, see [Customize your form by using JavaScript](/dynamics365/customer-insights/journeys/real-time-marketing-manage-forms#add-custom-javascript-to-your-form).

## Resubmit a failed form submission

A form submission might fail because of issues with custom plug-ins or because of invalid values in the submission.

- If the form submission failed because of a plug-in issue, you can resubmit the submission from the list of submissions.
- If the form submission failed because of an invalid value, you can edit the submission values from the list of submissions. Select the form submission to see the submitted values, select the value you need to change, and then edit it.

> [!IMPORTANT]
> You can only resubmit failed submissions. By resubmitting, you might create a duplicate contact, such as when the submission fails because of a contact point consent creation error. Resubmitting runs the entire submission process again. To avoid duplicate records, you can change the matching strategy before you resubmit.

## Values are missing in lookup fields

If values are missing in lookup fields on a form, the issue is often caused by missing or insufficient field permissions. Follow these steps to check that all required permissions are set correctly.

1. Confirm that the required permissions are granted for all fields used in the lookup. This step is especially important when you use custom fields or apply filters to lookup queries.
1. Make sure any custom fields referenced by the lookup have the appropriate permissions. Missing permissions can prevent values from appearing in the lookup field.
1. If the lookup uses filters, confirm that the filters are set up correctly and that all fields referenced in the filters have the necessary permissions.

## Investigate failed form submissions

Failed form submissions typically appear as "Failed to create target entity" or "Failed to update target entity" in the logs. These errors often relate to a customization that creates or updates a contact or lead entity.

:::image type="content" source="media/troubleshooting-forms/submission-pipeline.png" alt-text="Chart comparing successful and unsuccessful submission pipelines." lightbox="media/troubleshooting-forms/submission-pipeline.png":::

To troubleshoot a failed form submission, follow these steps:

1. Temporarily [turn on plug-in trace logs](/power-apps/developer/data-platform/logging-tracing#enable-trace-logging). Plug-in trace logs can negatively affect performance, so make sure to turn them off when you're done.
1. Resubmit the form.
1. Check the logs. If there's a plug-in-related error, you see a plug-in name and a reason why the plug-in crashed. Follow up with the plug-in provider or [disable the plug-in](/power-platform/admin/plug-ins). Don't disable Microsoft plug-ins, which are any plug-ins whose names start with `Microsoft.Dynamics.Cxp.Forms.`.
1. Check the processes connected to the contact, lead, or other entity you're trying to create through the form submission. Try to disable the process that's interfering with the contact creation.

:::image type="content" source="media/troubleshooting-forms/dynamics-processes.png" alt-text="Screenshot of the list of processes connected to the entity." lightbox="media/troubleshooting-forms/dynamics-processes.png":::

## Related content

- [Customize the Customer Insights - Journeys form editor](/dynamics365/customer-insights/journeys/real-time-marketing-customize-forms)
- [Customize form submission validation](/dynamics365/customer-insights/journeys/real-time-marketing-form-customize-submission-validation)
