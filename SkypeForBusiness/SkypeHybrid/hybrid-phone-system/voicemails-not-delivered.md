---
title: Voicemail messages aren't delivered in Teams or Skype for Business client
description: Voicemails aren't delivered, or voicemails don't appear in Skype for Business or Teams client even though they're delivered in email clients. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: skype-for-business-itpro
ms.topic: article
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business
- Microsoft Teams
---

# Voicemail messages aren't delivered in Teams or Skype for Business client

## Symptom 1

Voicemails aren't delivered at all (in Outlook clients and the Skype for Business or Teams client). 

## Resolution for Symptom 1

To resolve this issue, check whether you have any Exchange mail flow rules (also known as transport rules) enabled, or you use a third-party email system (such as Gmail).

#### Exchange mail flow rules

These rules may affect delivery of email messages. Cloud Voice Mail (CVM) service now supports mail flow rules. For example, rules can be enabled to mark email messages that have MP3 attachments as SPAM. It means that voicemails are filtered out before they arrive in the Inbox. Therefore, check whether any such rules are enabled, and then change them accordingly. Voicemail notifications with SPF failures will be delivered to Exchange, but mail flow rules that anlyze the SPF failures may prevent delivery of these messages to the user's mailbox and therefore won't be available in any endpoint. 

#### Third-party email systems

Third-party email systems aren't supported. For more information, see [Set up Phone System voicemail](/microsoftteams/set-up-phone-system-voicemail?bc=%2fskypeforbusiness%2fbreadcrumb%2ftoc.json&toc=%2fskypeforbusiness%2ftoc.json).

The primary issue that affects third-party email systems is that the **FROM** address is formatted for PSTN calls in a non–RFC-compliant manner. However, the Skype for Business or Teams client filters messages depending on the formatting of the **FROM** field. To fix this issue, you can change the mail protection filter of the third-party email system to use the "P1 sender address" instead (which is formatted correctly), and then enable these kinds of email messages to pass through.

## Workaround for Symptom 1

Add the Cloud Service IP addresses listed below in an SPF record. Alternatively, create a transport rule to bypass the spam filtering for Cloud Voicemail coming from them.

|APAC (Asia Pacific)|NOAM (North America)|EMEA (Europe, Middle-East and Africa)|
|:---:|:---:|:---:|
|52.114.7.28|52.114.128.68|52.114.75.27|
|52.114.15.0|52.114.159.40|52.114.76.82|
|52.114.7.29|52.114.128.18|52.114.76.83|
|52.114.15.1|52.114.159.41|52.114.75.2## Symptom 2

Voicemails are delivered to email clients (such as Outlook), but don't appear in the Skype for Business or Teams client. Only voicemails from internal users are delivered. Voicemails that are created by calling from PSTN endpoints (that is, regular telephone calls) are not delivered.

## Symptom 2

Voicemails are delivered to email clients (such as Outlook), but don't appear in the Skype for Business or Teams client.

## Resolution For Symptom 2

### Exchange Email Connector

A recent change (made in October 2018) requires one additional step when you configure Exchange on-premises support. The email item class is stripped when it's delivered through SMTP. To prevent this behavior from occurring, you must set up the connector correctly. The Skype for Business and Teams client shows voicemails only if the class is correct.

> [!NOTE]
> - Teams users with on-premises Exchange mailboxes can use voicemail with Teams and receive voicemail messages in Outlook, but voicemail messages aren't available 
to view or play within the Teams client.
> - Voicemail messages protected with Rights Management Services will be viewable in Teams, but can only be played using the Outlook Web client (OWA), and transcriptions can only be read in either Outlook or OWA. 

### Exchange mail flow rules

Exchange mail flow rules can also impact availability of messages in Skype for Business or Teams. If changes are made to headers, the messages won't be available in the voicemail folder used by these clients for retrieval. If voicemail messages are visible in Outlook but not Teams, the problem is likely caused by changes to the message content preventing the messages from being deposited in the voicemail folder. To investigate, use [MFCMAPI from Github](https://github.com/stephenegriffin/mfcmapi/releases) to view the contents of the user's Outlook **Voice Mail** folder. 

> [!NOTE]
> The bit version of MFCMAPI must match the bit version of Outlook

To access the **Voice Mail** folder, open MFCMAPI, open the user's Outlook mailbox from the MFCMAPI Quick Start menu, and then expand the **`Root Container\Finder`** folder. 

> [!NOTE]
> Third-party spam, or antivirus filtering solutions can also modify voicemail headers that will result in voicemails not being available in the voicemail folder. 

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
