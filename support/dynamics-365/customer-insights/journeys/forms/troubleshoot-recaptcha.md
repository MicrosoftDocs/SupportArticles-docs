---
title: Troubleshoot reCAPTCHA in Customer Insights - Journeys Forms
description: reCAPTCHA can block form submissions in Dynamics 365 Customer Insights - Journeys. Learn how to fix key mismatches, invalid domain errors, and failed submissions.
ms.date: 08/24/2026
ms.reviewer: alfergus, v-shaywood, petrjantac, udag
ms.custom: sap:Real-time journeys forms capturing, hosting and submission\Real-time form submissions
ai-usage: ai-assisted
search.audienceType: 
  - admin
  - customizer
  - enduser
---

# Troubleshoot reCAPTCHA issues in Customer Insights - Journeys forms

## Summary

reCAPTCHA blocks form submissions in Dynamics 365 Customer Insights - Journeys when the site key and secret key saved in the app don't match your project in the Google reCAPTCHA admin console. This article covers the default form configuration checklist for marketing forms and event registration forms, the "Invalid domain for site key" and "This reCAPTCHA is for testing purposes only" errors, which domain to register for a form that you publish as a standalone page, why reCAPTCHA doesn't render on the **Preview** tab, and how to read plug-in trace logs to find the validation error behind a failed submission.

> [!NOTE]
> The form doesn't show reCAPTCHA validation errors, so a failing form can look like nothing happened when the visitor selects **Submit**. Work through the checks in this article to find the mismatch.

## Check the reCAPTCHA configuration

1. Go to **Settings** > **Customer engagement** > **Form Settings**, and open the default configuration that matches your form type, either **Marketing form defaults** or **Event registration form defaults**.
1. On the **General** tab, confirm **Default setting** is set to **Yes**. The system ignores keys stored in a configuration that isn't the default.
1. On the **reCAPTCHA** tab, confirm both **Site key** and **Secret key** are filled in and saved.
1. If you use reCAPTCHA on both marketing and event registration forms, repeat these steps for both default configurations. Each form type reads its own keys.
1. Confirm your keys are **reCAPTCHA v2** keys. The default configuration supports v2 only. To use v3, see [Customize form submission validation](/dynamics365/customer-insights/journeys/real-time-marketing-form-customize-submission-validation).
1. Confirm the domain that hosts your form is added to your project in the [Google reCAPTCHA admin console](https://www.google.com/recaptcha/admin). If you publish the form as a standalone page, register `mkt.dynamics.com`. For more information, see [Error: Invalid domain for site key](#error-invalid-domain-for-site-key).
1. Republish the form after you change any of these settings.

If you set up reCAPTCHA on your form by using an earlier custom implementation, the form might not recognize the drag-and-drop reCAPTCHA element. Remove reCAPTCHA from the form, add it again from the **Elements** pane, and republish.

## Error: Invalid domain for site key

This error means the domain that serves your form isn't registered with the site key you're using.

1. Sign in to the [Google reCAPTCHA admin console](https://www.google.com/recaptcha/admin).
1. Select the project that uses the site key you entered in Customer Insights - Journeys.
1. Go to **Settings** and find the **Domains** section.
1. Add the domain that hosts your form, without `https://` or `http://`:

   - **Form embedded on your own website**. Enter your website domain, for example `contoso.com`.
   - **Form published as a standalone page**. Enter `mkt.dynamics.com`.
1. Save your changes.

If you publish the form as a standalone page and also embed it on your own website, add both domains.

> [!IMPORTANT]
> Don't register the exact standalone page domain that you see in your browser's address bar.

Microsoft serves standalone pages from a content delivery network that uses several subdomains for each geography, such as `assets-gbr.mkt.dynamics.com`, `assets1-gbr.mkt.dynamics.com`, and `assets2-gbr.mkt.dynamics.com`. If you register only the subdomain you happen to see, submissions from the other subdomains fail with this error. reCAPTCHA matches every subdomain of a domain you register, so `mkt.dynamics.com` covers all of them.

## Error: This reCAPTCHA is for testing purposes only

This error means you entered test keys from Google, or the keys aren't reCAPTCHA v2 keys.

1. In the Google reCAPTCHA admin console, generate a **reCAPTCHA v2** site key and secret key for your domain.
1. Enter the new keys on the **reCAPTCHA** tab of the default form configuration.
1. Republish the form.

To confirm which key type you have, see the [reCAPTCHA FAQ](https://developers.google.com/recaptcha/docs/faq).

## reCAPTCHA doesn't appear on the Preview tab

This behavior is by design. The form editor doesn't run scripts in the preview, so reCAPTCHA shows on the **Design** tab and on the live published form, but not on the **Preview** tab. Test reCAPTCHA on the published form.

## Find the underlying error in plug-in trace logs

If the earlier checks don't fix the problem, capture the validation error:

1. Temporarily [turn on plug-in trace logging](/power-apps/developer/data-platform/logging-tracing#enable-trace-logging).
1. Submit the form again.
1. Open the plug-in trace log records and look for entries that mention `recaptcha`.
1. Turn trace logging off when you're done, because it can affect performance.

Match the message you find to the fix in this table.

| Message | What it means | What to do |
| --- | --- | --- |
| `g-recaptcha-response field value is null or empty` | The submission arrived without a completed reCAPTCHA challenge. | Confirm the reCAPTCHA element is on the published form and the site key is saved in the default configuration. Remove the element, add it again, and republish. |
| `No form settings is found` | The submission can't find a form configuration to validate against. | Confirm a default configuration exists for the form type and that **Default setting** is **Yes**. |
| `No Marketing Form entity is found` | The submission can't be matched to a published form record. | Republish the form, then submit again. |
| `ReCAPTCHA is existed in the form, but secret key is missing` | The form uses reCAPTCHA, but no secret key is saved. | Enter the **Secret key** on the **reCAPTCHA** tab of the default configuration. |
| `Invalid domain for site key` | The hosting domain isn't registered with your site key. | Add the domain in the Google reCAPTCHA admin console. For standalone pages, add `mkt.dynamics.com`. |
| `This reCAPTCHA is for testing purposes only` | The keys are test keys or aren't v2 keys. | Generate and enter reCAPTCHA v2 keys. |

## Check the stored keys directly

If you're an admin, check the saved values without opening the form settings. In a browser, go to `<EnvironmentUrl>/api/data/v9.1/msdynmkt_formsettings(<FormSettingsId>)` and confirm that:

- `msdynmkt_recaptchasitekey` isn't empty
- `msdynmkt_recaptchasecretkey` isn't empty
- `msdynmkt_defaultgeneral` is `true`

## Related content

- [Security and privacy for Customer Insights - Journeys forms](/dynamics365/customer-insights/journeys/real-time-marketing-form-security-privacy)
- [Troubleshoot forms in Customer Insights - Journeys](troubleshooting-forms.md)
