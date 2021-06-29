---
title: Skype for Business Online users can't manage voice mail or customize greeting
description: Describes an issue that prevents a Skype for Business Online voice mail user who doesn't have an Exchange Online mailbox from managing voice mails or voice mail greetings. Provides a workaround.
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

# Skype for Business Online users can't manage voice mail or customize a greeting

## Problem 

Consider the following scenario:

- You're assigned a license for Skype for Business Online, Cloud PBX, or PSTN calling, but you don't have a license for Exchange Online (Plan 2) or later.    
- You can receive calls from Enterprise Voice or your Skype for Business phone number.   
- By default, if the call isn't answered after 20 seconds, Azure Voice Mail accepts the call.   

In this scenario, you can't retrieve your voice mail by using the Skype for Business client. Additionally, you can't configure your voice mail setup. This includes creating a voice mail greeting.

## Workaround 

Voice mails and voice mail greetings are included in Cloud PBX and stored in an Exchange Online mailbox. A license for Exchange Online (Plan 2) or later is required.

To work around this issue, you can set the Simultaneously Ring feature for your calls to a phone number that already has voice mail, such as a mobile phone number. When the Simultaneously Ring feature is configured, and a call is made to your Skype for Business phone number, it will ring simultaneously for the phone numbers that you have specified. If you don't answer the call, voice mail will accept the call, based on the wait time that's configured for your Skype for Business phone number. For more information about Simultaneously Ring, see [Call forwarding and simultaneously ring](https://support.office.com/article/call-forwarding-and-simultaneously-ring-967d9aaf-3fed-448b-ab96-40bbc9a11a20 ). 

## More information

For more information, see the following Microsoft websites: 
 
- [Voice Message Services](/office365/servicedescriptions/exchange-online-service-description/voice-message-services?f=255&mspperror=-2147217396)    
- [Here's what you get with Cloud PBX](https://support.office.com/article/here-s-what-you-get-with-cloud-pbx-bc9756d1-8a2f-42c4-98f6-afb17c29231c)    
- [Setting up Cloud PBX voicemail](https://support.office.com/article/setting-up-cloud-pbx-voicemail-ea946bcb-0835-4aa3-baeb-92745956706a?ui=en-us&rs=en-us&ad=us)    
- [https://go.microsoft.com/fwlink/?linkid=2003907](https://go.microsoft.com/fwlink/?linkid=2003907)    

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).