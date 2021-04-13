---
title: Access Denied when you connect to Office 365
description: Describes a scenario in which users are repeatedly prompted to enter their credentials or they receive an "Access Denied" error message when they try to connect to Office 365 from a rich client application. Provides a resolution.
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office 365
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-maqiu
appliesto:
- Office 365 User and Domain Management
---

# "Access Denied", or user is repeatedly prompted for credentials when connecting to Office 365

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem

When users try to access a Microsoft Office 365 resource from a rich client application such as Microsoft Outlook or Microsoft Lync, one of the following symptoms occurs:

- Users are repeatedly prompted to enter their credentials.
- Users receive the **Access Denied** error.

## Solution

> [!TIP]
> To diagnose and automatically fix several common Office sign-in issues, you can download and run the [Microsoft Support and Recovery Assistant](https://aka.ms/SaRA-OfficeSignInScenario).

To fix this problem, reset the user's password. To do this, follow these steps:

1. Open a web browser, browse to the Office 365 portal ([https://portal.office.com](https://portal.office.com/)), and then sign in by using the user's expired credentials.
2. When you're prompted, enter a new Office 365 password for the user. Make sure that the password meets the criteria for Office 365.

## References

For information about related issues, see the following articles:

- [How to troubleshoot non-browser apps that can't sign in to Office 365, Azure, or Intune](https://support.microsoft.com/help/2637629)
- [A federated user is repeatedly prompted for credentials during sign-in to Office 365, Azure, or Intune](https://support.microsoft.com/help/2461628)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
