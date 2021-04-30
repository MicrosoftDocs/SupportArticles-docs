---
title: Integrated Unblock screen not displayed when smart card PIN is blocked
description: Provides several methods to resolve the issue which Integrated Unblock screen is not displayed when smart card PIN is blocked.
ms.date: 04/30/2021
author: v-lianna
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, takondo, mitsuchi, jamesxia
ms.prod-support-area-path: Smart card logon
ms.technology: windows-client-user-profiles
---
# Integrated Unblock screen is not displayed when smart card PIN is blocked

_Applies to:_ &nbsp;Windows 10  

Assume that the [Allow Integrated Unblock screen to be displayed at the time of logon](/windows/security/identity-protection/smart-cards/smart-card-group-policy-and-registry-settings#allow-integrated-unblock-screen-to-be-displayed-at-the-time-of-logon) group policy is enabled in Windows 10. After several failed logon attempts by using an incorrect PIN, the smart card is blocked, and you receive the following error message:

> The smart card is blocked. Please contact your administrator for instructions on how to unblock your smart card.

In this scenario, the Integrated Unblock screen is not displayed.
To fix this issue, use one of the following methods and then try to sign in to Windows by using the blocked smart card again.

- Restart the computer.
- Sign in to Windows by using other methods (such as username and password).
- Sign in to Windows by using another account and then sign out.
- Sign in to another computer by using the blocked smart card.
