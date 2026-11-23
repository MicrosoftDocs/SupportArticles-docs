---
title: Can't Sign in to Teams for Mac after macOS Upgrade
description: Provides information about an issue with signing in to Teams after upgrading to macOS 15.3.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Clients\Mac Desktop
  - CI 3757
  - CSSTroubleshoot
ms.reviewer: sasingh, huversee, meerak
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 02/10/2025
---

# Can't sign in to Teams for Mac after macOS upgrade

## Summary

After upgrading to macOS 15.3, users who have the Company Portal app installed might be unable to sign in to Microsoft Teams for Mac or use Teams features. The upgrade can disrupt the Enterprise Single Sign-On (SSO) extension for some users. Restart the Mac to work around the authentication issue.

## Symptoms

On a device that's running Microsoft Teams for Mac and that has the Company Portal app installed, if you upgrade to macOS version 15.3, you experience issues when you try to sign in to Teams or use Teams features. Additionally, the following banner appears in Teams:

:::image type="content" source="./media/teams-sign-in-issues-after-os-upgrade/restart-banner.png" border="false" alt-text="Screenshot of the banner that recommends device restart.":::

This problem occurs in the following situations:

- You try to sign in to Teams after the upgrade.

- You're already signed in to Teams during the upgrade.

## Cause

This problem occurs because the [macOS upgrade prevents the Enterprise Single Sign-On (SSO) extension framework from working correctly for some users](/entra/identity-platform/apple-sso-plugin#important-update-on-macos-153-and-ios-1811-impacting-enterprise-sso).
 
## Resolution

To work around the authentication issues, restart your macOS device.