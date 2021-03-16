---
title: Voicemail messages are not delivered in Teams or Skype for Business client
description: Voicemails are not delivered or voicemails don't appear in Skype for Business or Teams client even though they're delivered in email clients. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: skype-for-business-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business
- Microsoft Teams
---

# Voicemail messages are not delivered in Teams or Skype for Business client

## Symptoms

You experience one of the following symptoms.

### Symptom 1

Voicemails are not delivered at all (in Outlook clients and the Skype for Business or Teams client). Only voicemails from internal users are delivered. Voicemails that are created by calling from PSTN endpoints (that is, regular telephone calls) are not delivered.

### Symptom 2

Voicemails are delivered to email clients (such as Outlook), but don't appear in the Skype for Business or Teams client.

## Resolution

### For Symptom 1

To resolve this issue, check whether you have any Exchange mail flow rules (also known as transport rules) enabled or you use a third-party email system (such as Gmail).

#### For Exchange mail flow rules

These rules may affect delivery of email messages. Cloud Voice Mail (CVM) service now supports mail flow rules. For example, rules can be enabled to mark email messages that have MP3 attachments as SPAM. This means that voicemails are filtered out before they arrive in the Inbox. Therefore, check whether any such rules are enabled, and then change them accordingly. Voicemails email notification will arrive with SPF fail, if a mail flow rule analyzes the SPF as fail, the email will make what the mail flow rule desires.

#### For third-party email systems

Third-party email systems are not supported. For more information, see [Set up Phone System voicemail](https://docs.microsoft.com/microsoftteams/set-up-phone-system-voicemail?toc=/skypeforbusiness/toc.json&bc=/skypeforbusiness/breadcrumb/toc.json).

The primary issue that affects third-party email systems is that the **FROM** address is formatted for PSTN calls in a non–RFC-compliant manner. However, the Skype for Business or Teams client filters messages depending on the formatting of the **FROM** field. To fix this issue, you can change the mail protection filter of the third-party email system to use the "P1 sender address" instead (which is formatted correctly), and then enable these kinds of email messages to pass through.

### For Symptom 2

A recent change (made in October 2018) requires one additional step when you configure Exchange on-premises support. The email item class is stripped when it's delivered through SMTP. To prevent this behavior from occurring, you must set up the connector correctly. The Skype for Business and Teams client shows voicemails only if the class is correct.

> ![NOTE]
> Teams users with on-premises Exchange mailboxes are able to use voicemail with Teams and receive voicemail messages in Outlook, but voicemail messages are not available 
to view or play within the Teams client.

## Workaround

### For Symptom 1

Add the Cloud Service IP addresses listed below in an SPF record. Alternatively, create a transport rule to bypass the spam filtering for Cloud Voicemail coming from them.

|APAC (Asia Pacific)|NOAM (North America)|EMEA (Europe, Middle-East and Africa)|
|:---:|:---:|:---:|
|52.114.7.28|52.114.128.68|52.114.75.27|
|52.114.15.0|52.114.159.40|52.114.76.82|
|52.114.7.29|52.114.128.18|52.114.76.83|
|52.114.15.1|52.114.159.41|52.114.75.28|
|

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
