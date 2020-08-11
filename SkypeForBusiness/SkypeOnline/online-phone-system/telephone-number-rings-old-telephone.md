---
title: Telephone number still rings old telephone number
description: Describes an issue in which the time and date for a local number port order request have passed but the telephone number continues to ring the old telephone. Provides a solution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: Landerl, corbinm, jasco, cbland
appliesto:
- Skype for Business Online
---

# The telephone number still rings the old telephone after the time and date for a local number port order request in Skype for Business Online have passed

## Problem

Consider the following scenario:

- A new local number port order request was submitted in Skype for Business Online.   
- The request was accepted for a date and time.    
- The specific date and time have passed.   

In this scenario, the telephone number continues to ring the old telephone instead of ringing the new destination. For example, the new destination could be the Skype for Business client, a mobile device, or an IP phone for the user.

## More Information 

This is an expected experience when a new local number port order request is submitted. As soon as the new local number port order request is accepted by the carrier, the telephone numbers are available in the Skype for Business Online admin center. Microsoft Office 365 administrators should assign the telephone numbers to users before the porting of the new local number is complete. 

When a port order is submitted and accepted by the carrier from which the numbers are being transferred, the carrier will agree to a Firm Order Commitment (FOC) date. Porting requests will be executed after the FOC date. The FOC date becomes the soonest date that the transfer might occur. Depending on the carrier, a local number porting request could take several days or weeks to complete. 

For more information, go to the following Microsoft websites: 

- [Transfer phone numbers to Office 365](https://support.office.com/article/transfer-phone-numbers-over-to-skype-for-business-online-47b3af8e-4171-4dec-8333-c956f108664e)   
- [Assign, change, or remove a phone number for a user](https://support.office.com/article/assign-change-or-remove-a-phone-number-for-a-user-91089761-cb87-4119-885b-3713840dd9f7)   

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).