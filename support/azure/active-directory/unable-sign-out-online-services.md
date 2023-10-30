---
title: Unable to sign out of online services that use Microsoft Entra ID
description: Describes a sign-out problem that occurs when you try to sign out of services that use Microsoft Entra ID. Provides a resolution.
ms.date: 07/06/2020
ms.reviewer: willfid
ms.service: active-directory
ms.subservice: aad-general
---
# Error when signing out of online services: Sorry, but we're having trouble signing you out

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2871385

## Symptoms

When you try to sign out of online services that use Microsoft Entra ID, you receive the following error message:

> Sorry, but we're having trouble signing you out

## Resolution

Use one of the following methods.

### Method 1

To sign out, close all web browsers.

### Method 2

Clear cookies from the web browser, and then try signing out again. The steps for doing this vary, depending on the browser that you're using. For more information, see the following resources:

- If you're using Internet Explorer, see [How to delete cookie files in Internet Explorer](https://support.microsoft.com/help/278835).
- If you're using Safari, go to the following Apple websites:
  - [Safari on Mac](https://support.apple.com/guide/safari/sfri11471/13.0/mac/10.15)
  - [Safari on iOS](https://support.apple.com/HT201265)
- If you're using Google Chrome, go to the following Google website: [Manage your cookies and site data](https://support.google.com/chrome/answer/95647?hl=en).
- If you're using Mozilla Firefox, go to the following Mozilla website: [Clear cookies and site data in Firefox](https://support.mozilla.org/en-US/kb/clear-cookies-and-site-data-firefox).

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.

## More information

This problem occurs if third-party cookies are turned on in your web browser. We do not recommend turning on the use of third-party cookies.

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
