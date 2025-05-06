---
title: Microsoft 365 Apps activation limits
description: Describes Microsoft 365 Apps activation limits.
author: helenclu
ms.reviewer: vikkarti
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - SubscriptionAndLicensing\Office apps install/activate issues due to subscription/licensing
  - CSSTroubleshoot
  - CI 157762
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 02/11/2025
---

# Microsoft 365 Apps activation limits

When you try to activate Microsoft 365 apps, you might encounter an error message stating that you’ve already activated Microsoft 365 Apps on the maximum number of devices, and have no further activations left.

Try the following troubleshooting methods to solve the problem.

**Note** Some of these troubleshooting methods can only be performed by a Microsoft 365 admin. If you aren’t an admin, see  [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)
<br/><br/>

With a single license, you can install Microsoft 365 Apps on up to 5 devices. For more information about licensing, see [Overview of licensing and activation in Microsoft 365 Apps](/deployoffice/overview-licensing-activation-microsoft-365-apps).  

## Remove unused devices

Go to https://myaccount.microsoft.com/device-list and sign in with the same account you’re using to activate Microsoft 365 Apps. Remove any unused devices.  

<a name='check-azure-active-directory-azure-ad'></a>

## Check Microsoft Entra ID

1. Go to the [Microsoft 365 admin center](https://admin.microsoft.com).

1. Select **Microsoft Entra ID** > **Users** and then select the account that received the error.

1. Select **Devices**.

1. Remove unused devices from the list.

1. Try activating Microsoft 365 Apps again.

## Reset Microsoft 365 activation state

See [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).

## Check Shared Computer Activation (SCA)  

If you're using SCA, see the following articles:

- [Overview of shared computer activation for Microsoft 365 Apps](/deployoffice/overview-shared-computer-activation)
- [Microsoft 365 Apps Shared Computer Activation issues](./shared-computer-activation.md)
