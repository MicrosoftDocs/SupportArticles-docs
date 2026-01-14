---
title: Unexpected Block or Warning on Customer Website in Microsoft Edge
description: Troubleshoot unexpected Microsoft Defender SmartScreen blocks or warnings on websites and learn how to report false positives.
ms.custom: 'sap:Web Platform and Development\Connectivity and Navigation: TCP, HTTP, TLS, DNS, Proxies, Downloads'
ms.reviewer: dili, Johnny.Xu, v-shaywood
ms.date: 07/01/2025
---

# Unexpected SmartScreen block or warning on website

When you visit a website in Microsoft Edge, [Microsoft Defender SmartScreen](/windows/security/operating-system-security/virus-and-threat-protection/microsoft-defender-smartscreen) might unexpectedly block the site or display a warning if it determines that the site is potentially unsafe. This article discusses the criteria that SmartScreen uses to determine whether a site is potentially unsafe, and how to resolve the issue if a site is incorrectly marked as unsafe.

## Symptoms

When you visit a website, Microsoft Edge displays a warning page that indicates that the site is reported as unsafe.

:::image type="content" source="./media/unexpected-block-warning/site-blocked.png" alt-text="View of the SmartScreen block page.":::

## Cause

Microsoft Defender SmartScreen determines whether a site is potentially unsafe based on several factors, as listed in the following table.

| Dimension            | Description                                                                       |
| -------------------- | --------------------------------------------------------------------------------- |
| **URL Reputation**   | Newly registered domains, malicious history, hosting provider, and traffic volume |
| **Page Content**     | Presence of deceptive forms, malicious scripts, or phishing pages                 |
| **File Behavior**    | Whether sensitive files are downloaded and their signature status                 |
| **TLS Security**     | Certificate validity and protocol version                                         |
| **User Feedback**    | Number of reports and trust level                                                 |
| **Dynamic Behavior** | JavaScript activity, redirects, and obfuscation                                   |

If a site fails these dimension checks, SmartScreen reports the site as unsafe.

## Solution

### If you're the website owner

1. Select **Report that this site doesn't contain (malware/phishing) threats** under the **More information** header on the block page.

   :::image type="content" source="./media/unexpected-block-warning/report-site-safe-blocked.png" alt-text="A SmartScreen block page that has the link to 'Report that this site doesn't contain malware threats' highlighted.":::

1. Wait for a confirmation email message from the SmartScreen Reputation Group.

   :::image type="content" source="./media/unexpected-block-warning/smartscreen-team-reply.png" alt-text="The SmartScreen Reputation Group reply email message.":::

1. If the issue is urgent, or you need a response after the Reputation Group's investigation, reply to the message from the Reputation Group to present your concerns.

### If you're not the website owner

1. Reach out to the website owner, and recommend that they report the issue by using the steps in [If you're the website owner](#if-youre-the-website-owner).

1. Both the site owner and you can report the issue by using the [WDSI file submission portal](https://www.microsoft.com/en-us/wdsi/filesubmission). When you're prompted for user type, select **Enterprise customer**.

### Prevent your site from being blocked

To reduce the likelihood of SmartScreen blocking your site:

1. Enable _HTTPS_, and use a valid certificate.
1. Block iframe from loading unknown third-party content.
1. Use _Content Security Policy (CSP)_ and other secure response headers.
1. Regularly scan for WebShells, trojans, and suspicious uploaded files.
1. Maintain _domain reputation_ and avoid frequent changes to hosting or DNS.

## Related content

- [Microsoft Defender for Endpoint demonstrations](/defender-endpoint/defender-endpoint-demonstrations)
- [SmartScreen URL reputation demonstration](/defender-endpoint/defender-endpoint-demonstration-smartscreen-url-reputation)
