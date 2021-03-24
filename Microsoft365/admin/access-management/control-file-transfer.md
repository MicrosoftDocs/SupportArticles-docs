---
title: Turn off file transfers in the Office app
description: Describes how to restrict the use of the File Transfer feature by blocking URLs or IP addresses.  
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm 
audience: ITPro 
ms.topic: article
ms.prod: office 365 
localization_priority: Normal
ms.custom: 
- CI 115363
- CSSTroubleshoot
ms.reviewer: vikkarti
appliesto:
- Office Mobile
search.appverid: MET150
---
# Control the File Transfer feature in the Office app

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Introduction

The File Transfer feature in the Microsoft Office app lets you send files from your mobile device to your computer, and receive files from your computer or device. For more information about the feature, see [Transfer files in the Office app for Android and iOS](https://support.office.com/article/transfer-files-in-the-office-app-for-android-and-ios-76e6a127-4af0-454a-83e3-1eee0d0877f5).

> [!NOTE]
> You can transfer only locally stored, non-managed data from a mobile phone to the desktop. You can't transfer Intune-protected, organization-managed, or cloud files. The File Transfer feature follows the policies for Intune Mobile Application Management (MAM) that are applied on the Office app.

## Turn off File Transfer

In certain scenarios, you may want to restrict the use of the File Transfer feature in your environment. To turn off the feature for your organization, use one of the following methods.

### Method 1: Block URLs

Block the following URLs:

- filetransfer-prod-griffin-*.cloudapp.net
- transfer.office.com
- filetransfer.trafficmanager.net

> [!NOTE]
> In some settings, you cannot block `https://transfer.office.com/` because it's part of the allowed *.office.com class of URLs. This is not a concern because `https://transfer.office.com/` redirects to one of the other URLs that are mentioned in the list. If you post the blocking, your users in the organizational firewalls will be unable to use this feature for sending or receiving files.

### Method 2: Block IP addresses

Depending on how the firewall is configured, you may have to block the following IP addresses:

- 13.76.241.194
- 52.184.64.21
- 65.52.31.49
- 70.37.107.67
- 52.169.19.3

## References

- [Support Tip: How to enable Intune app protection policies with the Office mobile](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-how-to-enable-intune-app-protection-policies-with/ba-p/1045493)
- [How to: Require approved client apps for cloud app access with Conditional Access](/azure/active-directory/conditional-access/app-based-conditional-access)
- [Require approved client app](/azure/active-directory/conditional-access/concept-conditional-access-grant#require-approved-client-app)