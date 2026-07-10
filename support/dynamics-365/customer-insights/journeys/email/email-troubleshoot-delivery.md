---
title: Resolve Email Delivery Issues in Customer Insights - Journeys
description: Resolve email deliverability issues in Dynamics 365 Customer Insights - Journeys, like spam filtering and forwarding. Fix delivery problems now.
ms.date: 07/06/2026
ms.reviewer: alfergus, v-shaywood
ms.custom: sap:Email Deliverability
search.audienceType: 
  - admin
  - customizer
  - enduser
---

# Email deliverability issues in Customer Insights - Journeys

## Summary

This article helps you resolve common email deliverability issues in Dynamics 365 Customer Insights - Journeys, where messages don't reach recipients or don't display as intended. It covers internal contacts who don't receive marketing emails because a spam filter quarantines them and how to allowlist sending services on common security solutions, forwarded emails that break or render incorrectly, a reply-to address that's ignored for automatic responses, and internal emails that are flagged as `[External]`. Start with the symptom you see to find the cause and the steps to fix it.

## Internal contacts aren't receiving your marketing emails

If you use Customer Insights - Journeys to send email messages to internal users and they aren't receiving your emails, your spam filter solution is likely quarantining the emails. To make sure that your emails arrive in your internal recipients' inboxes and pass your spam solution checks, follow these steps:

- [Add Dynamics 365 Customer Insights - Journeys to your SPF record](/dynamics365/customer-insights/journeys/mkt-settings-authenticate-domains)
- Check whether you use any email security software, such as Mimecast, Proofpoint, or IronPort.

If you use email security software, you need to allow Dynamics 365 Customer Insights - Journeys so that your marketing emails aren't blocked. The following references explain how to configure allowlist settings in popular email security software:

- Barracuda: [Configuring Inbound Email](https://campus.barracuda.com/product/essentials/download/10YQ/barracuda-email-security-service-configuring-inbound-email/)
- Cisco: [How do you Whitelist a Trusted Sender?](https://www.cisco.com/c/en/us/support/docs/security/email-security-appliance/118585-qa-esa-00.html)
- Mimecast: [Policies - Configuring Anti-Spoofing](https://mimecastsupport.zendesk.com/hc/articles/34000743640851-Policies-Configuring-Anti-Spoofing)
- Sophos: [Inbound Allow/Block](https://docs.sophos.com/central/customer/help/en-us/ManageYourProducts/GlobalSettings/EmailAllowBlock/index.html)
- Broadcom: [About user approved and blocked senders lists](https://techdocs.broadcom.com/us/en/symantec-security-software/email-security/email-security-cloud/1-0/about-user-approved-and-blocked-senders-lists-toc216427008-d2923e4300.html)

If you don't use any email security software, use the following links to set the default options for allowing Customer Insights - Journeys services in Office 365 or Exchange and in Google Workspace:

- Google Workspace: [Add IP addresses to allowlists in Gmail](https://support.google.com/a/answer/60751)
- Office 365 or Exchange: [Configure connection filtering in cloud organizations](/microsoft-365/security/office-365-security/configure-the-connection-filter-policy)

To find the public IP addresses that Dynamics 365 Customer Insights - Journeys uses to send emails, see [Public IP addresses used for sending emails](/dynamics365/customer-insights/journeys/public-ip-addresses-for-email-sending).

> [!IMPORTANT]
> If you experience issues allowlisting Dynamics 365 Customer Insights - Journeys in your email security software, contact the vendor's support team for specific instructions.

## Forwarded emails break or display incorrectly

Email forwarding is a standard way to share an email you received with another person. But forwarding emails can cause problems with the formatting or functionality of email content. As a result, emails often break when they're forwarded.

Web and desktop email clients, such as Gmail, Yahoo, and Outlook, each render emails differently. Forwarded emails also render differently, depending on the client they're sent from. Depending on the client, forwarding can strip some HTML elements or insert technical blocks into the HTML code of the email. The changed elements can alter the look of the email or even block functionality.

As a sender and email designer, you can't predict the behavior of every email client that your subscribers use, and you can't avoid all changes that result from email forwarding. But if you know that your subscribers or recipients regularly forward your marketing emails, the following recommendations can reduce forwarding-related errors:

- Keep your email design simple. Use a single-column design with few separate elements. This approach reduces the possibility of design-related HTML errors when you forward the email.
- Tell your recipients to forward your emails as an attachment. This approach increases the chance that the original email keeps its design and elements untouched.
- Some web-based email clients offer alternative ways to share emails without touching the email code. This approach usually doesn't create a traditional forward, but sends an original email on your behalf to the intended recipient or shares it through social networks.

## Reply-to address is ignored for automatic responses

When you send an email and your recipient replies, the reply goes to the email address listed in the `From:` header. The reply-to address, specified in the `Reply-To:` header, lets replies go to a different address than the one in the `From:` header.

For automatic responses, the `Reply-To:` header is ignored. As described in [RFC 3834](https://datatracker.ietf.org/doc/html/rfc3834), automatic responses are always sent to the address specified in the `From:` header.

Only manual replies (when the recipient selects **Reply**) are sent to the `Reply-To:` address.

## Internal emails are flagged as `[External]`

The `[External]` flag notifies recipients that an email came from outside their organization. It's a security feature that protects against phishing attacks, because external emails can often be fraudulent. The flag can sometimes be added incorrectly when the recipient's domain is hosted on Exchange Online or Microsoft 365.

When you send emails to recipients outside your organization, the `[External]` flag is expected behavior. It doesn't mean that your emails are marked as spam or junk, and you can't change this behavior from the sender's side. To avoid confusion, let your recipients know that the flag is a security feature and doesn't mean the email is unsafe.

The flag can also appear on emails that you send to recipients within your own organization. To stop internal emails from being flagged, check whether the recipient's domain is hosted on Exchange Online or Microsoft 365. If it is, contact your email administrator and ask them to adjust the email configuration so that messages sent from your domain aren't flagged as `[External]`.

## Related content

- [Best practices for email marketing](/dynamics365/customer-insights/journeys/get-ready-email-marketing)
- [Troubleshoot domain authentication errors](troubleshoot-domain-authentication.md)
- [Troubleshoot email rendering issues](email-troubleshoot-rendering.md)

[!INCLUDE [Third-party information disclaimer](../../../../includes/third-party-disclaimer.md)]
