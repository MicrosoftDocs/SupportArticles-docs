---
title: Unexpected block or warning on customer website in Microsoft Edge
description: Troubleshoot unexpected Microsoft Defender SmartScreen blocks or warnings on websites and learn how to report false positives.
ms.custom: "sap:Web Platform and Development\Connectivity and Navigation: TCP, HTTP, TLS, DNS, Proxies, Downloads"
ms.reviewer: dili, Johnny.Xu, v-shaywood
ms.date: 07/01/2025
---

# Unexpected SmartScreen block or warning on website

When you visit a website in Microsoft Edge, the [Microsoft Defender SmartScreen](/windows/security/operating-system-security/virus-and-threat-protection/microsoft-defender-smartscreen) might unexpectedly blocks or display a warning if it determines the site is potentially unsafe. This article describes the criteria used by SmartScreen to determine if a site is potentially unsafe, as well as how to resolve a site being incorrectly marked as unsafe.

## Symptoms

When visiting a website, Microsoft Edge displays a warning page indicating that the site has been reported as unsafe.

<!-- TODO: Ask SME for an image of just the warning page, without any buttons or menus highlighted -->

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

If a site fails the checks of these dimensions it will be marked as unsafe.

## Solution

### You are the website owner

1. Select **Report that this site doesn't contain (malware/phishing) threats** under the **More information** header on the block page, or select **Report as safe or unsafe** in the **Suspicious site** dropdown on a warning page.

   :::image type="content" source="./media/unexpected-block-warning/report-site-safe.png" alt-text="Screenshot of a SmartScreen block page":::

   <!-- Ask SME for screenshot of a warning page as well -->

1. Wait for a confirmation email from the SmartScreen Reputation Group:

   :::image type="content" source="./media/unexpected-block-warning/smartscreen-team-reply.png" alt-text="Screenshot of the SmartScreen Reputation Group reply email.":::

1. If the issue is urgent or you need a response after the Reputation Group's investigation, reply to the email from the Reputation Group with your concerns.

### You are not the website owner

1. Reach out to the website owner and recommend that they report the issue using the steps in [You are the website owner](#you-are-not-the-website-owner).

1. Both the site owner and you can report the issue using the [WDSI file submission portal](https://www.microsoft.com/en-us/wdsi/filesubmission). When prompted for user type, select **Enterprise customer**.

### Prevent your site from being blocked

To reduce the likelihood of SmartScreen blocking your site:

1. Enable _HTTPS_ and use a valid certificate.
2. Block iframe loading of unknown third-party content.
3. Use _Content Security Policy (CSP)_ and other secure response headers.
4. Regularly scan for WebShells, trojans, and suspicious uploaded files.
5. Maintain _domain reputation_ and avoid frequent changes to hosting or DNS.

## Related content

- [Microsoft Defender for Endpoint demonstrations](/defender-endpoint/defender-endpoint-demonstrations)
- [SmartScreen URL reputation demonstration](/defender-endpoint/defender-endpoint-demonstration-smartscreen-url-reputation)
