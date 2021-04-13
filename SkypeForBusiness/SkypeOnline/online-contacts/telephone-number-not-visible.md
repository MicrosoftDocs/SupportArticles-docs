---
title: Telephone number isn't visible or appears in an unexpected format
description: Describes an issue in which the user's telephone number isn't visible or appears in an unexpected format in Microsoft Lync. Provides a resolution.
author: Norman-sun
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-swei
ms.reviewer: v-ernord, dahans
ms.custom: CSSTroubleshoot
appliesto: 
- Skype for Business Online
---

# The telephone number isn't visible in the Lync contact card or appears in an unexpected format

## Problem

An administrator changes a user's telephone number through the Microsoft Office 365 portal or in the on-premises Active Directory Domain Services (AD DS). After 24 hours, the change isn't visible in the Microsoft Lync contact card for the user, or the telephone number appears in an unexpected format.

## Solution

To resolve this issue, change the telephone number in the Office 365 portal or the on-premises AD DS so that it follows the E.164 format. For example, +14255550100.

If you're using Directory Synchronization together with an on-premises AD DS, populate the telephoneNumberattribute that uses the E.164 formatted telephone number, and let the attribute sync to Microsoft Office 365.

> [!NOTE]
> It can take up to 24 hours for changes that you make in the portal or on-premises to be visible in a user's Lync contact card.

## More information

This occurs because the telephone number wasn't entered by using the E.164 format. Numbers in the E.164 format typically start with a plus sign (+) prefix that's followed by a maximum of fifteen digits. For example, the E.164 format for the United States telephone number 555-0100 that has an area code of 425 is +14255550100.

If a telephone number isn't entered by using E.164 format in the Office 365 portal or in the on-premises AD DS, it won't replicate to the Lync address book or it may appear in an unexpected format. 

> [!NOTE]
> Unexpected formatting can also occur when a user has an Outlook contact who has the same number as the Lync contact. This data can sometimes be merged and results in an unexpected format. Disabling Personal Information Manager (PIM) integration can help locate the source of such an occurrence. The recommended action is to remove or change the Outlook contact to match the Lync contact information.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).