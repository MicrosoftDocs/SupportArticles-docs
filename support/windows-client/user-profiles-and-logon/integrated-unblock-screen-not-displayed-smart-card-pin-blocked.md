---
title: Integrated Unblock screen not displayed when smart card PIN is blocked
description: Provides several methods to resolve the issue which Integrated Unblock screen is not displayed when smart card PIN is blocked.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, takondo, mitsuchi, jamesxia
ms.custom: sap:smart-card-logon, csstroubleshoot
---
# Integrated Unblock screen not displayed when smart card PIN is blocked

_Applies to:_ &nbsp; Windows 10

Assume that the [**Allow Integrated Unblock screen to be displayed at the time of logon**](/windows/security/identity-protection/smart-cards/smart-card-group-policy-and-registry-settings#allow-integrated-unblock-screen-to-be-displayed-at-the-time-of-logon) group policy is enabled in Windows 10. After several failed logon attempts because of an incorrect PIN, the smart card is blocked and you receive this error message:

> The smart card is blocked. Please contact your administrator for instructions on how to unblock your smart card.

In this scenario, the Integrated Unblock screen isn't displayed.

To fix this issue, use one of the following methods and then try again to sign in to Windows by using the blocked smart card.

- Restart the computer.
- Use another method to sign in to Windows (such as username and password).
- Use another account to sign in to Windows and then sign out.
- Use the blocked smart card to sign in to another computer.
