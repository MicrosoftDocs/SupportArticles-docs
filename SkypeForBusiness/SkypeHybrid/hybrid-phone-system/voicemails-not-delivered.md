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

**Third-party disclaimer information**

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

The information and the solution in this document represent the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft does not specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article does not describe. Because Microsoft must respond to changing market conditions, this information should not be interpreted to be a commitment by Microsoft. Microsoft cannot guarantee or endorse the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.

Microsoft makes no warranties and excludes all representations, warranties, and conditions whether express, implied, or statutory. These include but are not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition, merchantability, and fitness for a particular purpose, with regard to any service, solution, product, or any other materials or information. In no event will Microsoft be liable for any third-party solution that this article mentions.
