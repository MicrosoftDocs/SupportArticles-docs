---
title: Fix Domain Authentication in Customer Insights - Journeys
description: Resolve domain authentication issues in Customer Insights - Journeys. Discover how to check DNS records, locate hostnames, and confirm your sending domain.
ms.date: 07/06/2026
ms.reviewer: alfergus, v-shaywood
ms.custom: sap:Email Sending\Domain authentication help
search.audienceType: 
  - admin
  - customizer
  - enduser
---

# Troubleshoot domain authentication errors in Customer Insights - Journeys

## Summary

In Dynamics 365 Customer Insights - Journeys, a sending domain must pass authentication before you can send email from it. When the domain fails authentication, one or more required DNS records are usually missing or still updating, or the DNS confirmation status isn't yet **Confirmed**. This article helps you check the ownership hostname, DKIM CNAME records, Envelope-from record, and DNS confirmation status so that you can authenticate the domain and send email.

## Symptoms

When you set up a sending domain in Dynamics 365 Customer Insights - Journeys, the domain fails authentication, and you can't send email from it.

## Cause

Domain authentication fails when one or more required DNS records are missing or aren't updated, or when the DNS confirmation status isn't **Confirmed**.

## Solution

Work through the following checklist to find why your domain fails authentication.

### Check for all required DNS records

First, make sure that you add all the required DNS records. The following articles describe how to edit and create DNS records with common DNS providers:

- [Cloudflare](https://support.cloudflare.com/hc/articles/200168626-How-do-I-add-a-SPF-record-)
- [GoDaddy](https://www.godaddy.com/help/manage-dns-for-your-domain-names-680)
- [NameCheap](https://www.namecheap.com/support/knowledgebase/article.aspx/317/2237/how-do-i-add-txtspfdkimdmarc-records-for-my-domain)

### Check that DNS records are updated

Check that your DNS records are updated. Depending on your DNS provider, DNS records can take up to 24 hours to update.

One way to check whether a DNS value is updated is to use a service like [What's My DNS](https://www.whatsmydns.net/).

When you use *What's My DNS*, use the correct hostname and select the DNS record type: TXT for ownership, or CNAME for DKIM or Envelope-from.

:::image type="content" source="media/troubleshoot-domain-authentication/whats-my-dns.png" alt-text="Screenshot of What's My DNS." lightbox="media/troubleshoot-domain-authentication/whats-my-dns.png":::

Use the following sections to identify the hostnames that you need to check.

#### Ownership hostname

The ownership hostname is the sending domain name that you add in the **Domain name** section in Customer Insights - Journeys.

#### DKIM CNAME records

The DKIM CNAME record hostname is made up of the host portion from inside the CNAME instructions plus the sending domain.

Always separate your email flows into marketing and transactional emails. You usually send marketing emails from a subdomain of your main domain. Always include the full domain name, including the subdomain, as in the following example:

- **Domain name**: `test.dynmkt.com`
- **CNAME host part**: `namkey1._domainkey`
- **Full hostname**: `namkey1._domainkey.test.dynmkt.com`

If you assign your root domain as the sending domain, your setup looks like the following example:

- **Domain name**: `dynmkt.com`
- **CNAME host part**: `namkey1._domainkey`
- **Full hostname**: `namkey1._domainkey.dynmkt.com`

#### Envelope-from

Copy the Envelope-from domain directly from Customer Insights - Journeys.

:::image type="content" source="media/troubleshoot-domain-authentication/envelope-from.png" alt-text="Screenshot of the Envelope-from domain name." lightbox="media/troubleshoot-domain-authentication/envelope-from.png":::

### Check the DNS confirmation status

Finally, check the [DNS confirmation status](/dynamics365/customer-insights/journeys/domain-authentication#authenticate-a-domain). You can complete authentication only if the status is **Confirmed**.

:::image type="content" source="media/troubleshoot-domain-authentication/completed.png" alt-text="Screenshot of a completed confirmation status." lightbox="media/troubleshoot-domain-authentication/completed.png":::

If the status isn't confirmed yet, select the **Confirm** button.

For a detailed video guide describing the domain authentication process, see [Domain Authentication in Dynamics 365 Customer Insights - Journeys](https://community.dynamics.com/blogs/post/?postid=79124091-f18c-465f-8d7f-2458159d66a0).

## Related content

- [Best practices for email marketing](/dynamics365/customer-insights/journeys/get-ready-email-marketing)
- [BIMI support](/dynamics365/customer-insights/journeys/bimi-support)

[!INCLUDE [Third-party information and solution disclaimer](../../../../includes/third-party-information-solution-disclaimer.md)]
