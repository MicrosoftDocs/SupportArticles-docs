---
title: Total number of phone numbers exceeds the number of PSTN Calling licenses
description: Explains that you can reserve more phone numbers than you have user licenses for in the Skype for Business admin center.
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
ms.reviewer: landerl, jasco, corbinm, lynnroe, cbland
appliesto:
- Skype for Business Online
---

# Total number of phone numbers exceeds the number of PSTN Calling licenses

## Symptoms

Assume that you have 100 licenses for PSTN Calling in a Skype for Business Online environment. Because you’ve acquired more than 100 phone numbers for your organization, you appear to require additional licenses.

## More Information

This behavior is by design. In a Skype for Business Online environment, you can acquire more phone numbers than you have licenses for.

To determine how many phone numbers you can reserve, add 10 percent onto the number of licenses that you hold, and then add 10. That is, use **N** + .10(**N**) + 10 = **R**, where **N** = the number of licenses that you hold, and **R** = the number of phone numbers that you can reserve.

For example, if you have 100 PSTN Calling licenses, you can reserve 120 phone numbers. This assumes that you have not already acquired some phone numbers for those 100 users.

## More Information

For more information about how to reserve phone numbers, see [Getting phone numbers for your users](https://support.office.com/article/getting-phone-numbers-for-your-users-aa2ec464-3481-4bbb-8c14-e13e18093df5).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
