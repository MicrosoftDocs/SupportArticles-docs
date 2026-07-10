---
title: Diagnose Email Engagement Drops in Customer Insights - Journeys
description: Email engagement drops can signal privacy changes rather than real problems. Discover how to diagnose declining open and click rates in Customer Insights - Journeys.
ms.date: 07/06/2026
ms.reviewer: alfergus, v-shaywood
search.audienceType:
  - admin
  - customizer
  - enduser
ms.custom:
  - sap:Email Sending
  - ai-gen-docs-bap
  - ai-gen-description
  - ai-seo-date:06/05/2025
---

# Troubleshoot email engagement drops in Customer Insights - Journeys

## Summary

This article helps you diagnose and respond to drops in email engagement in Dynamics 365 Customer Insights - Journeys. It explains how 2025 privacy updates, such as the GDPR, CCPA, DMA, and Apple Mail Privacy Protection, affect open and click tracking. It describes engagement-drop scenarios for new and existing customers, walks you through how to diagnose an unexpected drop in engagement rates, and explains when the email deliverability team can help.

## Symptoms

You notice that the engagement rates for your marketing emails, such as open rates and click-through rates, drop or appear lower than you expect. The drop might be sudden or gradual. It often affects only certain internet service providers (ISPs) rather than your entire audience.

## Cause

Privacy changes often cause engagement drops. These changes reduce the accuracy of email tracking. They don't cause an actual decline in how recipients interact with your emails.

New privacy regulations like the General Data Protection Regulation (GDPR), California Consumer Privacy Act (CCPA), and Digital Markets Act (DMA) affect email tracking. These regulations reinforce user rights to opt out of tracking.

In response to these regulations, Apple, Google, and Microsoft introduced features that improve user privacy and limit what email senders can track. For example, Apple Mail Privacy Protection (MPP) prevents senders from tracking recipient activity, such as when an email is opened. Google and Microsoft apply similar protections through stricter cookie policies and email tracking limitations.

These privacy changes affect email marketers in several ways:

- **Diminished open rate accuracy**: With Apple and Google privacy features, open rates might be artificially inflated or impossible to track accurately.
- **Reduced click tracking effectiveness**: Stricter privacy settings might prevent accurate click tracking in emails.
- **Increased dependence on first-party data**: Senders need to rely more on their own data and behavior insights rather than third-party tracking data.
- **Stricter consent requirements**: Regulations require explicit consent for tracking. This requirement limits the ability of email service providers (ESPs) to gather accurate data.

## Solution

How you respond to an engagement drop depends on how long you've used Customer Insights - Journeys. Follow the guidance for new customers or existing customers, depending on your situation.

### New customers

If you recently onboarded or have a short history with Customer Insights - Journeys, a drop might reflect more accurate data rather than an actual problem. The app uses the latest techniques to filter out nonhuman interactions (NHI), which gives senders more accurate data, especially for traffic directed to Microsoft 365. So if you didn't change your sending domains, audience, or email templates but you still see a sudden drop in engagement, the cause is likely not your sending reputation or the platform. Instead, the numbers are a more accurate representation of your current engagement rate. Keep monitoring your engagement rates and watch for any progressive, continuous drops.

### Existing customers

If you're an existing customer and you notice a consistent drop in your engagement rates, work through the following diagnostic steps to find the cause:

1. **Identify the most affected ISPs**: Engagement drops rarely happen across your entire audience. Typically, only a few ISPs are affected, so compare your engagement rates by ISP to pinpoint which ones show the drop. Note when the drop started for each affected ISP so that you can focus your investigation on the right providers and timeframe.
1. **Check sender authentication settings**: Double-check that your DNS entries for Sender Policy Framework (SPF), DomainKeys Identified Mail (DKIM), and Domain-based Message Authentication, Reporting, and Conformance (DMARC) are correctly set up. Compare them with the DNS records that Customer Insights - Journeys provides in the [domain authentication](/dynamics365/customer-insights/journeys/domain-authentication) panel.
1. **Analyze DMARC reports**: If you enforce DMARC, review DMARC reports to detect unauthorized email senders that use your domain.
1. **Monitor sender reputation**: Use tools like Google Postmaster or Yahoo Sender Hub to track sender reputation. Any dips, even if temporary, could indicate spam complaints, bounces, or issues with a specific campaign that require further investigation. For an in-depth guide on Google Postmaster, see [Google Postmaster Tools - what it is and how it can help you](/dynamics365/customer-insights/journeys/google-postmaster).
1. **Review email strategy changes**: Assess recent changes to your email strategy, such as new subscriber lists, template changes, and automation settings. Changes like these can trigger spam filters and lower engagement, especially if they're sudden or untested.
1. **Run inbox placement tests**: One way to assess your deliverability is through an inbox placement test. This test helps you check where your emails land (inbox or spam). By monitoring your inbox placement rates over time, you can identify when issues arise. These tools aren't perfect because they track a limited number of inboxes, and each mailbox is unique. An email that lands in the spam folder for one mailbox might land in the primary inbox for another. So it's essential to use these tools with other email metrics to gain a comprehensive understanding of your email deliverability.
1. **Check your list hygiene**: Maintain list hygiene by avoiding old or inactive lists and ensuring proper opt-in strategies. For example, you might be sending to an outdated list that should have been archived, skipped an opt-in strategy that keeps your list clean, or uploaded inactive lists or segments that haven't been emailed in a long time.

    It's also important to review spam complaints by domain. An issue with spam complaints might begin with an inbox provider that represents only a small percentage of your list. As you gain more readers on that ISP, the issue could become more significant. For more information, see [Best practices for email marketing](/dynamics365/customer-insights/journeys/get-ready-email-marketing).
1. **Review bounce data**: Always review and interpret the raw bounce errors and bounce categories. They offer valuable insights into your sending reputation. Pay attention to ISP-specific, reputation-related bounces to check whether there are any spikes in temporary rejections.

    Bounces can provide deep insights into the health of your email list. For example, a bounce might suggest that an ISP blocked the email because of suspected spam. These types of bounces serve as warnings that your sender reputation could be at risk, and they help you identify which ISPs you need to address.

    Monitoring bounce messages closely is crucial. Inboxes sometimes provide valuable feedback through "bounce codes," such as "blocked due to spam-like content" or "too many complaints from this domain." If you ignore these signals, you can run into broader deliverability issues.

    Pay special attention to whether your bounces are concentrated around one or two ISPs. If a significant percentage of your bounces come from a single ISP (for example, Microsoft), it could indicate specific issues with that provider. This might be because of content triggers, reputation problems, or list hygiene issues that are more sensitive to that ISP's spam filters.

### Contact the email deliverability team

If you can't resolve or diagnose the engagement drop on your own, contact the Microsoft Dynamics 365 Customer Insights email deliverability team.

Before you reach out, complete the [diagnostic steps](#existing-customers) and gather the information the team needs to assist you:

- A clear pattern of the engagement drop
- The period when the drop started
- Which ISPs are the most affected

The deliverability team can help most in specific cases, such as when you see a spam placement decision on one of your inbox tests or when a recipient reports that your emails landed in their spam box. In these cases, provide an email sample of the incident, either the full email headers or the email saved as an .eml attachment. Email forwarding removes essential headers that the team needs for the investigation.

> [!NOTE]
> Because logs are only retained for 30 days, the team can't investigate engagement drop events that occurred more than 30 days earlier. To allow time for investigation before logs are removed, contact the team no later than 20 days after an engagement rate drop that needs investigation.

## Related content

- [Deliverability recommendations when changing ESPs](/dynamics365/customer-insights/journeys/deliverability-change-esp)
- [Troubleshoot email deliverability issues](email-troubleshoot-delivery.md)
