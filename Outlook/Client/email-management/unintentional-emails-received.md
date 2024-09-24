---
title: Receiving email messages not intended for you
description: Fixes an issue in which you receive an email message that wasn't intended for you.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Data Protection and Security\SPAM or phish
  - Outlook for Windows
  - Outlook for Mac
  - CI 118817
  - CSSTroubleshoot
ms.reviewer: abarglo
appliesto: 
  - Outlook 2019
  - Outlook 2019 for Mac
  - Outlook for Microsoft 365
  - Outlook 2016 for Mac
  - Outlook 2016
  - Outlook 2013
  - Outlook on the web
  - Outlook.com
  - Outlook for iOS
  - Outlook for Android
search.appverid: MET150
ms.date: 01/30/2024
---
# Unintentional emails received in Outlook

When you use a Microsoft Outlook client to connect to a Microsoft Exchange Server mailbox, you receive an email message that wasn't intended for you. Also, you might not know the sender of the email message.

These unintentional messages appear in your Inbox if the following events occurred:

1. The sender inadvertently added a special character to the **To**, **Cc**, or **Bcc** field in the message. Some examples of special characters are the exclamation mark (!), apostrophe ('), and number sign (#).
1. When the Outlook client tries to resolve the recipient that's represented by the special character, it finds a match in one of the Active Directory (AD) attributes that are set for your user account. These include the following attributes:

    - Office
    - Telephone number
    - Home
    - Mobile

1. The Outlook client updates the special character to your user account, and sends the email message to you.

To prevent this erroneous matching, look for and [remove the special character from the affected AD attribute](/azure/active-directory/fundamentals/active-directory-users-profile-azure-portal#to-add-or-change-profile-information) for your user account, and wait until the change is replicated to all servers. You must have administrator permissions to update the AD attribute.

**Note:** If the Outlook client doesn't find a match for the special character in any of the AD attributes that it uses for name resolution, it will display an error message to the sender that states that the name can't be resolved. In this case, the email message is not sent.
