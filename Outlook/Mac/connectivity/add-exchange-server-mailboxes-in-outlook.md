---
title: Add Exchange Server mailboxes in the new Outlook for Mac
description: Discusses how to opt in to the beta channel for Insider builds, add email accounts for on-premises Exchange Server mailboxes in the new Outlook for Mac, and provide feedback.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Mac
  - CI 186045
  - CSSTroubleshoot
ms.reviewer: pawankap, meerak, v-trisshores
search.appverid: 
  - MET150
appliesto: 
  - Outlook for Microsoft 365 for Mac
  - Outlook 2021 for Mac
  - Outlook 2019 for Mac
ms.date: 02/07/2024
---

# Add Exchange Server mailboxes in the new Outlook for Mac

In the new Outlook for Mac, you can add email accounts for Microsoft Exchange Server mailboxes. The new feature is unsupported and still in development. To beta test the new functionality, your environment must meet the following requirements:

- The on-premises mailboxes must be in Exchange Server 2016 or a later version.

- Communication between the new Outlook for Mac client and Exchange Server must use either [NTLM](/exchange/client-developer/exchange-web-services/authentication-and-ews-in-exchange#ntlm-authentication) or [Basic](/exchange/client-developer/exchange-web-services/authentication-and-ews-in-exchange#basic-authentication) authentication.

  > Note: The new Outlook for Mac doesn't support Kerberos or Certificate authentication. For more information about currently supported Exchange Server features in the new Outlook for Mac, see [Supported features for Exchange on-premises](https://support.microsoft.com/en-us/office/the-new-outlook-for-mac-6283be54-e74d-434e-babb-b70cefc77439#bkmk_exchangeonprem).

- Outlook or Office must be licensed through a volume license, or an enterprise or business Microsoft 365 subscription plan.

- Outlook or Office must be downloaded from the Microsoft 365 portal ([https://office.com](https://office.com/)).

  Note: The Outlook and Office versions that are downloaded from the Apple App Store don't support the new functionality.

After these requirements are met, [opt in to the beta channel](https://insider.microsoft365.com/join/Mac), and then install the latest beta channel release for the Outlook for Mac client.

To add an Exchange Server mailbox in the new Outlook for Mac, see [Add an email account to Outlook](https://support.microsoft.com/office/add-an-email-account-to-outlook-6e27792a-9267-4aa4-8bb6-c84ef146101b?ui=en-us&rs=en-us&ad=us#PickTab=macOS).

To [report issues or provide feedback](https://support.microsoft.com/office/contact-support-within-outlook-for-mac-d0410177-8e65-4487-93f7-206a3a3d71a8), select **Contact Support** from the **Help** menu in the Outlook for Mac client.
