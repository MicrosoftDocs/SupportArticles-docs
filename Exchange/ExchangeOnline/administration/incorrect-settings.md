---
title: Can't connect to Exchange Online because of incorrect service settings
description: Describes a scenario in which Microsoft 365 users who connect to Exchange Online by using incorrect hardcoded service settings will not be able to connect to the service after July8, 2015 when these settings are discontinued. Provides a solution.
author: cloud-writer
ms.author: meerak
ms.topic: troubleshooting
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Microsoft 365 users can't connect to Exchange Online because of incorrect service settings

## Problem

Microsoft 365 users in your organization who connect to Exchange Online by using incorrect hardcoded service settings (or IP addresses) will be unable to connect to the service after these outdated service settings are discontinued on July 8, 2015. (The original date was June 26, 2015).

The services for which users may be using incorrect settings include the following:

- Autodiscover: A feature that's used to automatically discover server names for connectivity
- Exchange ActiveSync (EAS): A protocol that's used by email client applications on mobile devices
- POP3 and IMAP4: Protocols that are used by email client applications on desktop and mobile devices
- SMTP: Protocol that's used for sending email messages

If users continue to use the outdated, hardcoded service settings, they will be unable to connect to the service after July 8, 2015. Use the information that's provided in this article to make sure that these settings are set correctly for users in your organization.

## Solution

The following table lists the features, protocols, and expected server settings that must be set, and provides links to the articles that contain instructions to configure these settings.

|Feature and protocol|Port|Server name(correct configuration)|References|
|-|-|-|-|
|Autodiscover (CName Record)|443|autodiscover.outlook.com|[Create DNS records at any DNS hosting provider for Microsoft 365](https://support.office.com/article/create-dns-records-at-any-dns-hosting-provider-for-office-365-7b7b075d-79f9-4e37-8a9e-fb60c1d95166)|
|Exchange ActiveSync (EAS)|443|outlook.office365.com|[Set up a mobile device to synchronize with your account](https://support.office.com/article/set-up-a-mobile-device-to-synchronize-with-your-account-c9139caf-01ab-41a0-827c-3c06ee569ed3)|
|POP3|995|outlook.office365.com|[POP and IMAP account settings](https://support.office.com/article/settings-for-pop-and-imap-access-for-office-365-for-business-or-microsoft-exchange-accounts-7fc677eb-2491-4cbc-8153-8e7113525f6c)|
|IMAP4|993|outlook.office365.com|[POP and IMAP account settings](https://support.office.com/article/settings-for-pop-and-imap-access-for-office-365-for-business-or-microsoft-exchange-accounts-7fc677eb-2491-4cbc-8153-8e7113525f6c)|
|SMTP|587|smtp.office365.com|[POP and IMAP account settings](https://support.office.com/article/settings-for-pop-and-imap-access-for-office-365-for-business-or-microsoft-exchange-accounts-7fc677eb-2491-4cbc-8153-8e7113525f6c); [How to set up a multifunction device or application to send email using Microsoft 365 or Office 365](/Exchange/mail-flow-best-practices/how-to-set-up-a-multifunction-device-or-application-to-send-email-using-microsoft-365-or-office-365)|

Windows uses a file that's named Hosts to map hostnames to IP addresses. This file is checked before DNS is used to resolve a server name. If the Hosts file on a Windows computer has an entry for any of the server names in the table, and if the entry is associated with a hardcoded IP address, DNS is not used to resolve that server name. Make sure that you reset the Hosts file on all such systems that may be experiencing the issue that's documented in this article.

For more information about how to reset the hosts file, see the following Microsoft Knowledge Base article:

[972034](https://support.microsoft.com/help/972034) How can I reset the Hosts file back to the default?

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).