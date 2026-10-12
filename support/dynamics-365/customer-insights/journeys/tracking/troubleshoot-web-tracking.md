---
title: Troubleshoot Web Tracking in Customer Insights - Journeys
description: Learn how to resolve web tracking issues in Dynamics 365 Customer Insights - Journeys when website visits or link clicks aren't recorded.
ms.date: 10/09/2026
ms.reviewer: alfergus, v-shaywood, petrjantac, stbeliak
ms.custom: "sap:Real-time journeys channels: text messages, push notifications, more"
ai-usage: ai-assisted
search.audienceType:
  - admin
  - customizer
  - enduser
---

# Troubleshoot web tracking in Customer Insights - Journeys

## Summary

This article helps you troubleshoot web tracking when website visits or link clicks aren't recorded in Dynamics 365 Customer Insights - Journeys. For an overview of how web tracking works and how to set it up, see [Personalize messages, make journey decisions based on web interactions](/dynamics365/customer-insights/journeys/interaction-journey-decision). To fix problems with tracking links in messages, see [Troubleshoot link tracking in Customer Insights - Journeys](troubleshoot-link-tracking.md).

## Confirm web tracking requirements

Most web tracking problems happen because a required condition isn't met. Before you investigate a specific symptom, confirm all of the following conditions:

1. The web tracking script from **Settings** > **Customer engagement** > **Web Tracking** is in the `<head>` element of every page you want to track, and each page has only one copy of the script.
1. The script comes from the same Customer Insights - Journeys environment that generates the tracking links to your website. A script from a sandbox or user acceptance testing (UAT) environment doesn't work with links that production generates.
1. Customer Insights - Journeys identified the visitor. The visitor's first arrival on your website came through a tracked link in a Customer Insights - Journeys message, or the visitor submitted a Customer Insights - Journeys form that has web tracking turned on.
1. Tracking consent allows tracking for the contact or lead. If the **Check contact consent in real-time journeys** feature switch is on, a contact's **Do not track** field must also be set to **Allow**. For more information, see [Consent to track user behavior](/dynamics365/customer-insights/journeys/real-time-marketing-email-text-consent#consent-to-track-user-behavior) and [Use DoNotEmail, DoNotBulkEmail, and DoNotTrack fields in real-time journeys](/dynamics365/customer-insights/journeys/real-time-marketing-compliance-settings#use-donotemail-donotbulkemail-and-donottrack-fields-in-real-time-journeys).
1. You're testing with a real journey, not with **Test send** or a preview.

> [!IMPORTANT]
> Web tracking applies only to known contacts and leads. Anonymous web interactions aren't supported. They don't start journeys, aren't evaluated in if/then branches, and don't appear in the out-of-box analytics. If Customer Insights - Journeys never identified a visitor through a link or a form submission, no interactions are recorded for them.

## Check whether the tracking script loads

Many symptoms in this article share the same first diagnostic step. Use your browser's developer tools to confirm that the script downloads:

1. Open a page on your website that contains the tracking script.
1. Use <kbd>F12</kbd> to open the developer tools, and then select the **Network** tab.
1. Refresh the page, and filter the requests for `WebTracking`.
1. Check the request for `WebTracking.bundle.js`:

    - **Status 200**: The script loads. Go to the section that matches your symptom.
    - **No request**: The script isn't on the page. Check how your content management system, tag manager, or page template adds the script.
    - **Status 403 or a blocked status, such as `(blocked:csp)`**: The script is blocked. For more information, see [The tracking script is blocked](#web-tracking-script-is-blocked).

## Web tracking script is blocked

The request for `WebTracking.bundle.js` fails with a 403 status or a blocked status. A common cause is your website's Content Security Policy (CSP). A CSP restricts which domains a page can load resources from, and the Customer Insights - Journeys domains must be allowed.

Update your website's CSP to allow the following domains in the `script-src`, `connect-src`, and `frame-ancestors` directives:

- `https://*.mkt.dynamics.com/`
- `https://*.azureedge.net`

Customer Insights - Journeys forms need the same domains to load. For more information, see [Conditions required for web tracking functionality if you use CSP](/dynamics365/customer-insights/journeys/interaction-journey-decision#conditions-required-for-web-tracking-functionality-if-you-use-csp).

If your CSP already allows these domains and the request still fails, a corporate proxy, a firewall, a browser extension, or a content blocker might block the request. To rule this out, reproduce the problem in a private browsing window with extensions turned off.

## Website visits are recorded, but link clicks are missing or intermittent

Website visits appear, but website link click interactions are recorded inconsistently or not at all.

This behavior happens on websites that aren't single-page applications. When a visitor selects a link, the browser starts going to the new URL immediately and cancels any requests that are still in progress, including the request that reports the click. The click is lost, even though the script works correctly.

To work around this problem, delay the navigation slightly so the click has time to be reported. Add a script like the following example to your pages. It delays navigation by one second.

```html
<script>
    (function () {
        document.addEventListener('click', function (e) {
            // Find the closest anchor element, in case the user selects an element inside the link.
            const link = e.target.closest('a');

            if (link && link.href) {
                // Prevent immediate navigation.
                e.preventDefault();

                const url = link.href;
                const target = link.target || '_self';

                // Delay navigation by 1000 ms.
                setTimeout(function () {
                    if (target === '_blank') {
                        window.open(url, target);
                    } else {
                        window.location.href = url;
                    }
                }, 1000);
            }
        });
    })();
</script>
```

Test the script on your site before you deploy it to production, especially if your pages already have custom click handlers.

## No web interactions are recorded from test sends or previews

A URL that you open from a **Test send** message or a preview can't create web interactions. These messages don't include a resolved tracking context, so the visit isn't associated with a contact or lead, and no website visit or website link click interactions are generated.

To test web tracking, publish a journey that sends the message to a real audience member, and then use the link from the delivered message.

## Web tracking script and links come from different environments

Web interactions aren't recorded, even though the script loads and the visitor used a Customer Insights - Journeys link.

This problem happens when the script on your website comes from one environment, but a different environment generated the tracking link. For example, the script comes from a sandbox environment, but the email was sent from production. The tracking context in the link can't be matched to the script, so nothing is recorded.

To make sure both come from the same environment, follow these steps:

1. In the environment that sends your journeys, go to **Settings** > **Customer engagement** > **Web Tracking**, and copy the script.
1. Replace the script on your website with this copy.
1. Send a new message from the same environment, and test again.

## Interactions appear on an unexpected contact or lead

Website visits and clicks are recorded, but on a different contact or lead than the one you tested with.

Check the following causes:

- **A form submission created a new record**: If the visitor submitted a Customer Insights - Journeys form that has web tracking turned on, the `msdynmkt_formsubmissionid` cookie associates later visits with the contact or lead from that submission. If the submitted values didn't match an existing record, the submission created a new contact or lead, and interactions are recorded on it.
- **A shared browser**: A cookie identifies a browser on a device, not a person. If several people use the same browser profile, their interactions are recorded as one person.
- **An older cookie from a previous test**: The `msdynci_trackingContext` cookie lasts 365 days. Clear the Customer Insights - Journeys cookies in the browser, open the website again through a new tracking link, and then test again.

## No interactions are recorded because cookies are blocked

Web tracking depends on cookies. If cookies aren't set, the visitor stays anonymous, and no interactions are recorded.

Check the following causes:

- **The page opts out of nonessential cookies**: If your pages define `disableCookiesUsage()` to return `true`, Customer Insights - Journeys doesn't set nonessential cookies, and web tracking capabilities are limited. If a consent service controls this function, ensure the function returns `false` after the visitor consents, and then reload the page.
- **A cookie banner blocks the script**: Some consent platforms hold back scripts until the visitor accepts cookies. Ensure the tracking script can run in the consent category that the visitor accepted.
- **Browser or device settings**: Private browsing, strict tracking prevention, and cookie-clearing extensions remove the cookie. Ensure the `msdynci_trackingContext` cookie exists under **Application** > **Cookies** in your browser's developer tools.

For more information, see [How real-time journeys uses cookies](/dynamics365/customer-insights/journeys/real-time-journeys-cookies).

## Related content

- [Troubleshoot link tracking in Customer Insights - Journeys](troubleshoot-link-tracking.md)
- [Personalize messages, make journey decisions based on web interactions](/dynamics365/customer-insights/journeys/interaction-journey-decision)
- [How real-time journeys uses cookies](/dynamics365/customer-insights/journeys/real-time-journeys-cookies)
- [Consent to track user behavior](/dynamics365/customer-insights/journeys/real-time-marketing-email-text-consent#consent-to-track-user-behavior)
- [Customer Insights - Journeys link tracking mechanics](/dynamics365/customer-insights/journeys/real-time-marketing-link-tracking-mechanics)
- [Form settings](/dynamics365/customer-insights/journeys/real-time-marketing-manage-forms#form-settings)
