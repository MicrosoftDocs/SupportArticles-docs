---
title: Calls to an international phone number fail
description: Discusses an issue that triggers a number not in service error when a user dials an international phone number in Skype for Business Online. A resolution is provided.
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
appliesto:
- Skype for Business Online
---

# Calls to an international phone number fail when you use Cloud PBX with PSTN International Calling

## Problem

When you dial an international phone number by using Cloud PBX with PSTN International Calling in Skype for Business Online (formerly Lync Online), you experience one of the following symptoms: 

- Your call isn't completed successfully, and you may receive an error message. For example, when a user makes a call to Australia by using the +61 02 **XXXXXXXX** phone number format, the call fails with the "number not in service" error.    
- The following details are recorded in the UCCAPI logs from the Mediation server:

    ```adoc
    Error message: SIP/2.0 404 Not Found
    Reason: Gateway responded with 404 Not Found (User Not Found)   
    ```

## Solution
These issues occur because the user is leaving the trunk code of 0 (zero) in the phone number sequence. This causes an invalid phone number to be passed to the PSTN when you use the Office 365 Skype for Business Online PSTN International calling service.  

With Skype for Business on-premises deployments, administrators frequently configure normalization rules to handle different dialing behaviors of users. However, when you use the Cloud, international phone numbers must be dialed in the format of + **(Country Code)****(Area Code)****(Local Number)**. In the earlier example, the phone number should be dialed using the following format: +61 2 **XXXXXXXX**. 

## More Information

Depending on the particular PSTN calling infrastructure and telephone carrier, users are accustomed to dialing numbers that include the 0 (zero). Administrators remove this number in the dialing sequence elsewhere in the telephone infrastructure before it's passed to the carrier. Currently, there's no way to strip or normalize the phone number before it's passed to the PSTN when you use the PSTN international calling feature in Skype for Business Online.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
