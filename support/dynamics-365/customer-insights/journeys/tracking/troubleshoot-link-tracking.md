---
title: Troubleshoot Link Tracking Issues in Customer Insights - Journeys
description: Resolve link tracking issues in Dynamics 365 Customer Insights - Journeys, including missing email opens, unexpected click counts, and missing UTM parameters.
ms.date: 10/09/2026
ms.reviewer: alfergus, v-shaywood, petrjantac, stbeliak
ms.custom: "sap:Real-time journeys channels: text messages, push notifications, more"
ai-usage: ai-assisted
search.audienceType:
  - admin
  - customizer
  - enduser
---

# Troubleshoot link tracking in Customer Insights - Journeys

## Summary

This article helps you fix problems with link tracking, email open tracking, click counts, and Urchin Tracking Module (UTM) parameters in Dynamics 365 Customer Insights - Journeys. To fix problems with website visits and clicks that the web tracking script records, see [Troubleshoot web tracking in Customer Insights - Journeys](troubleshoot-web-tracking.md).

Before you start, it helps to understand how link tracking works. For more information, see [Customer Insights - Journeys link tracking mechanics](/dynamics365/customer-insights/journeys/real-time-marketing-link-tracking-mechanics).

## Links in a message aren't replaced with tracking links

If prefill, link tracking, or UTM parameters don't work for a specific link, the link probably wasn't replaced with a tracking link. Check the following causes in order.

### The link is marked as non-trackable

In the email designer, select the link or button, and check the **Tracking** setting in its properties. A link that's marked as non-trackable is delivered as is, and no click is recorded for it.

### The recipient didn't consent to tracking

Links are replaced only for recipients whose consent allows tracking. For more information, see [Tracking consent blocks tracking](#tracking-consent-blocks-tracking).

### The message was a test send or a preview

Messages sent with **Test send** and previews aren't tracked. This behavior is by design. Use a real journey to check tracking behavior.

### The link has another attribute that ends in href

Customer Insights - Journeys replaces the value of the first attribute on the link whose name ends in `href`. If another attribute, such as `data-cke-saved-href`, comes before the real `href` attribute, the real `href` isn't replaced, and the link isn't tracked.

This condition usually happens when you paste HTML from an external editor into the email. To fix it, select **HTML** in the email designer to open the HTML editor, and then use one of the following methods:

- Remove every attribute that ends in `href` but isn't the real `href` attribute, such as `data-cke-saved-href`.
- Move `href="<LinkUrl>"` so it's the first attribute on the element that ends in `href`.

## Email opens or link clicks aren't recorded

Check the following causes in order.

### Tracking consent blocks tracking

The **Tracking** purpose in the compliance profile that the message uses controls tracking. Tracking consent covers email opens through the tracking pixel, link clicks, UTM parameters, form prefill, and website interactions.

- **Restrictive enforcement model**: Nothing is tracked unless the recipient explicitly opts in to tracking. If you never collected tracking opt-ins, no recipient is tracked, and no links are replaced.
- **Nonrestrictive enforcement model**: Interactions are tracked unless the recipient opts out of tracking.

If the **Check contact consent in real-time journeys** feature switch is on, contacts are also checked against their **Do not track** field. Tracking links and the tracking pixel are added only when this field is set to **Allow** and the contact point consent record also allows tracking. This check applies only to contacts, not to leads. For more information, see [Use DoNotEmail, DoNotBulkEmail, and DoNotTrack fields in real-time journeys](/dynamics365/customer-insights/journeys/real-time-marketing-compliance-settings#use-donotemail-donotbulkemail-and-donottrack-fields-in-real-time-journeys).

If no links are tracked anywhere in your environment, the cause is almost always a restrictive model without any tracking opt-in records.

To review and update consent records, go to **Consent center**, or open the **Communication** tab of a contact or lead. For more information, see [Configure tracking consent in Dynamics 365 Customer Insights - Journeys](/dynamics365/customer-insights/journeys/real-time-marketing-tracking-consent) and [Configure consent management controls](/dynamics365/customer-insights/journeys/real-time-marketing-compliance-settings).

### The email client didn't download images

A tracking pixel, which is a small, invisible image, detects email opens. Many email clients, including desktop Outlook, block remote images by default. If the client doesn't download images, the open isn't recorded, even though the recipient reads the message.

Because of this limitation, treat open rate as a directional signal, and use clicks as your main engagement metric. For more information, see [Beyond open rate: Rethinking email marketing metrics](https://www.microsoft.com/dynamics-365/blog/it-professional/2024/10/16/rethinking-email-metrics-the-evolving-landscape-of-open-rates/).

### The message was a test send, or the link isn't trackable

Test sends and previews aren't tracked, so neither opens nor clicks are recorded for them. Clicks also aren't recorded for links that are marked as non-trackable. For more information, see [Links in a message aren't replaced with tracking links](#links-in-a-message-arent-replaced-with-tracking-links).

## Click or open counts don't match what you expect

Analytics can show fewer or more interactions than you expect. The cause depends on the direction of the difference.

### Fewer clicks or opens than expected

- **Missing tracking consent**: Recipients without tracking consent don't produce open or click interactions. For more information, see [Tracking consent blocks tracking](#tracking-consent-blocks-tracking).
- **Blocked images**: Opens are undercounted when the email client doesn't download the tracking pixel.
- **Bot protection**: Bot protection removes nonhuman clicks from your analytics and keeps them as separate bot interactions. If a click you made through an automated tool or an unusual client isn't counted, bot protection might have classified it as nonhuman. For more information, see [Exclude bot interactions for reliable analytics](/dynamics365/customer-insights/journeys/bot-protection).

### More clicks or opens than expected

- **Automated opens**: Email security services and mailbox privacy features, such as Apple Mail Privacy Protection, can load the tracking pixel before the recipient does anything. Bot protection for email opens is limited to simpler checks, so this automated activity can still raise email open counts and open rates.
- **Undetected automated clicks**: Detecting automated activity is an industry-wide challenge, and no solution catches every scanner. Some nonhuman clicks can still reach your reports.

## UTM parameters aren't added to links

Check the following causes:

- **The UTM tracking feature switch is off**: Go to **Settings** > **Overview** > **Feature switches**, turn on **UTM tracking**, and then select **Save**. The change can take up to five minutes to apply.
- **Tracking consent isn't granted**: UTM parameters are added only when the recipient's consent allows tracking. Under a restrictive enforcement model, they're added only for recipients who opted in to tracking. For more information, see [Tracking consent blocks tracking](#tracking-consent-blocks-tracking).
- **The link is marked as non-trackable**: UTM parameters are added only to trackable links.
- **The link isn't in a recognized HTML attribute**: Links are detected in a specific set of HTML attributes. If your custom HTML puts the URL in an attribute that isn't recognized, no UTM parameters are added to it. Move the URL into a standard `href` attribute on an anchor element. If you can't change the HTML, contact Microsoft Support and include a copy of the email HTML.

For more information, see [Measure marketing effectiveness using UTM codes](/dynamics365/customer-insights/journeys/real-time-marketing-utm).

## A mailto link opens a browser before the mail app

When tracking is on for a `mailto:` link, the recipient's browser opens the tracking redirect first, and then the mail app opens.

To avoid this behavior, mark the `mailto:` link as non-trackable. In the email designer, select the link, and then turn off tracking in its **Tracking** setting. The link is delivered unchanged and opens the mail app directly, but no click is recorded for it.

## Related content

- [Troubleshoot web tracking in Customer Insights - Journeys](troubleshoot-web-tracking.md)
- [Troubleshoot email engagement drops in Customer Insights - Journeys](../email/email-troubleshoot-engagement.md)
- [Customer Insights - Journeys link tracking mechanics](/dynamics365/customer-insights/journeys/real-time-marketing-link-tracking-mechanics)
- [Configure tracking consent in Dynamics 365 Customer Insights - Journeys](/dynamics365/customer-insights/journeys/real-time-marketing-tracking-consent)
- [Configure consent management controls](/dynamics365/customer-insights/journeys/real-time-marketing-compliance-settings)
- [Exclude bot interactions for reliable analytics](/dynamics365/customer-insights/journeys/bot-protection)
- [Measure marketing effectiveness using UTM codes](/dynamics365/customer-insights/journeys/real-time-marketing-utm)
- [Email insights](/dynamics365/customer-insights/journeys/email-insights)
- [Data subject request (DSR) handling](/dynamics365/customer-insights/journeys/dsr-handling)
