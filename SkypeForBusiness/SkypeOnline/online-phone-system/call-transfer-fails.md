---
title: Call transfer fails when you use Skype for Business Cloud Connector Edition
description: Describes an issue that triggers a “Cannot complete the transfer” error when you try to transfer a call to another number in Skype for Business Cloud Connector Edition.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
ms.reviewer:  landerl, nmurav, zhengni, jastark, lynnroe, cbland, kristinw, corbinm, yoren
appliesto:
- Skype for Business Online
---

# Call transfer fails when you use Skype for Business Cloud Connector Edition

## Problem

Consider the following scenario. 

- Your Office 365 user account is configured to use Cloud PBX.   
- You have an active PSTN call using the Skype for Business client on Windows, where the voice for this call uses Skype for Business Cloud Connector Edition. 
- You start a transfer to another phone number by selecting or entering the phone number from a list of suggested phone numbers on the transfer menu.    

In this scenario, the other phone number rings, and you can answer the transferred call, but you hear no audio. Additionally, the client window of the existing active PSTN call shows the following error: 

"Cannot complete the transfer."

## Solution

This is a known issue in Cloud Connector Edition versions that are earlier than 1.3.8. To resolve this issue, upgrade to Cloud Connector Edition version 1.3.8 or later.

## More Information

For more information about how to transfer a call, see the following Microsoft website:

[Transfer a Skype for Business call](https://support.office.com/article/transfer-a-skype-for-business-call-f9f312a3-ccc9-4215-86e8-8928b2df1f97)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
