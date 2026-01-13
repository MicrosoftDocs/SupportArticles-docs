---
title: Unexpected block or warning on customer website in Microsoft Edge
description: Troubleshoot unexpected Microsoft Defender SmartScreen blocks or warnings on websites and learn how to report false positives.
ms.custom: "sap:Web Platform and Development\Connectivity and Navigation: TCP, HTTP, TLS, DNS, Proxies, Downloads"
ms.reviewer: dili, Johnny.Xu, v-shaywood
ms.date: 07/01/2025
---

# Unexpected SmartScreen block or warning on website

When you visit a website in Microsoft Edge, [Microsoft Defender SmartScreen](/windows/security/operating-system-security/virus-and-threat-protection/microsoft-defender-smartscreen) might unexpectedly block the site or display a warning if it determines the site is potentially unsafe. This article describes the criteria that SmartScreen uses to determine if a site is potentially unsafe and how to resolve a site being incorrectly marked as unsafe.

## Symptoms

When you visit a website, Microsoft Edge displays a warning page indicating that the site is reported as unsafe.

:::image type="content" source="./media/unexpected-block-warning/site-blocked.png" alt-text="Screenshot of a SmartScreen block page":::

## Cause

Microsoft Defender SmartScreen determines whether a site is potentially unsafe based on several factors:

| Dimension            | Description                                                                       |
| -------------------- | --------------------------------------------------------------------------------- |
| **URL Reputation**   | Newly registered domains, malicious history, hosting provider, and traffic volume |
| **Page Content**     | Presence of deceptive forms, malicious scripts, or phishing pages                 |
| **File Behavior**    | Whether sensitive files are downloaded and their signature status                 |
| **TLS Security**     | Certificate validity and protocol version                                         |
| **User Feedback**    | Number of reports and trust level                                                 |
| **Dynamic Behavior** | JavaScript activity, redirects, and obfuscation                                   |

If a site fails the checks of these dimensions, SmartScreen reports the site as unsafe.

## Solution

### You're the website owner

1. Select **Report that this site doesn't contain (malware/phishing) threats** under the **More information** header on the block page.

   :::image type="content" source="./media/unexpected-block-warning/report-site-safe-blocked.png" alt-text="Screenshot of a SmartScreen block page with the link to 'Report that this site doesn't contain malware threats' highlighted.":::

1. Wait for a confirmation email from the SmartScreen Reputation Group:

   :::image type="content" source="./media/unexpected-block-warning/smartscreen-team-reply.png" alt-text="Screenshot of the SmartScreen Reputation Group reply email.":::

1. If the issue is urgent or you need a response after the Reputation Group's investigation, reply to the email from the Reputation Group with your concerns.

### You're not the website owner

1. Reach out to the website owner and recommend that they report the issue by using the steps in [You are the website owner](#youre-not-the-website-owner).

1. Both the site owner and you can report the issue by using the [WDSI file submission portal](https://www.microsoft.com/en-us/wdsi/filesubmission). When prompted for user type, select **Enterprise customer**.

### Prevent your site from being blocked

To reduce the likelihood of SmartScreen blocking your site:

1. Enable _HTTPS_ and use a valid certificate.
1. Block iframe loading of unknown third-party content.
1. Use _Content Security Policy (CSP)_ and other secure response headers.
1. Regularly scan for WebShells, trojans, and suspicious uploaded files.
1. Maintain _domain reputation_ and avoid frequent changes to hosting or DNS.

## Related content

- [Microsoft Defender for Endpoint demonstrations](/defender-endpoint/defender-endpoint-demonstrations)
- [SmartScreen URL reputation demonstration](/defender-endpoint/defender-endpoint-demonstration-smartscreen-url-reputation)
