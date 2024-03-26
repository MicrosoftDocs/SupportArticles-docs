---
title: Voicemail messages aren't delivered in Teams or Skype for Business client
description: Voicemails aren't delivered, or voicemails don't appear in Skype for Business or Teams client even though they're delivered in email clients. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business
  - Microsoft Teams
ms.date: 03/31/2022
---

# Voicemail messages aren't delivered in Teams or Skype for Business client

## Symptom 1

Voicemails aren't delivered at all (in Outlook clients and the Skype for Business or Teams client). 

## Resolution for symptom 1

To resolve this issue, check whether you have any Exchange mail flow rules (also known as transport rules) enabled, or you use a third-party email system (such as Gmail).

### Exchange mail flow rules

These rules may affect delivery of email messages. Cloud Voice Mail (CVM) service now supports mail flow rules. For example, rules can be enabled to mark email messages that have MP3 attachments as SPAM. It means that voicemails are filtered out before they arrive in the Inbox. Therefore, check whether any such rules are enabled, and then change them accordingly. Voicemail notifications with SPF failures will be delivered to Exchange, but mail flow rules that analyze the SPF failures may prevent delivery of these messages to the user's mailbox and therefore won't be available in any endpoint. 

### Third-party email systems

Third-party email systems aren't supported. For more information, see [Set up Phone System voicemail](/microsoftteams/set-up-phone-system-voicemail?bc=%2fskypeforbusiness%2fbreadcrumb%2ftoc.json&toc=%2fskypeforbusiness%2ftoc.json).

The primary issue that affects third-party email systems is that the **FROM** address is formatted for PSTN calls in a non–RFC-compliant manner. However, the Skype for Business or Teams client filters messages depending on the formatting of the **FROM** field. To fix this issue, you can change the mail protection filter of the third-party email system to use the "P1 sender address" instead (which is formatted correctly), and then enable these kinds of email messages to pass through.

## Workaround for symptom 1

Add the Cloud Service IP addresses listed at [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges#skype-for-business-online-and-microsoft-teams) in an SPF record. Alternatively, create a transport rule to bypass the spam filtering for Cloud Voicemail coming from them.

## Symptom 2

Voicemails are delivered to email clients (such as Outlook), but don't appear in the Teams or Skype for Business client. 

### Use Microsoft Remote Connectivity Analyzer to diagnose

Go to [Microsoft Remote Connectivity Analyzer for Teams](https://testconnectivity.microsoft.com/tests/teams), select **Teams Voicemail** to run the test.

If the Teams Voicemail test doesn't return any errors, but the Teams client isn't retrieving any or all voicemails that are received in email (for example, the Teams client may retrieve voicemails from internal callers, but not from external PSTN callers due to Exchange mail flow rules), try the following resolution.

## Resolution For symptom 2

### Exchange Client Access Rules

Make sure that there are no [Exchange Client Access Rules](/exchange/clients-and-mobile-in-exchange-online/client-access-rules/client-access-rules#client-access-rules-and-middle-tier-applications) that block access. 

### Exchange Web Access Rules

Make sure that there are no [Exchange Web Access Policies](/exchange/client-developer/exchange-web-services/how-to-control-access-to-ews-in-exchange) that block access. 

### Exchange Email Connector

A recent change (made in October 2018) requires one additional step when you configure Exchange on-premises support. The email item class is stripped when it's delivered through SMTP. To prevent this behavior from occurring, you must set up the connector correctly. The Skype for Business and Teams client shows voicemails only if the class is correct. For voicemail messages to show in the Teams client, the message class must be IPM.Note.Microsoft.Voicemail.UM.

> [!NOTE]
>
> - Teams users with on-premises Exchange mailboxes can use voicemail with Teams and receive voicemail messages in Outlook, but voicemail messages aren't available 
to view or play within the Teams client.
> - Voicemail messages protected with Rights Management Services won't be viewable in Teams, will be viewable in Outlook, but can only be played using the Outlook Web client (OWA), and transcriptions can only be read in either Outlook or OWA. 

### Exchange mail flow rules

Exchange mail flow rules can also impact availability of messages in Skype for Business or Teams. If changes are made to headers, the messages won't be available in the voicemail folder used by these clients for retrieval. If voicemail messages are visible in Outlook but not Teams, the problem is likely caused by changes to the message content preventing the messages from being deposited in the voicemail folder. To investigate, use [MFCMAPI from GitHub](https://github.com/stephenegriffin/mfcmapi/releases) to view the contents of the user's Outlook **Voice Mail** folder. 

> [!NOTE]
> The bit version of MFCMAPI must match the bit version of Outlook

To access the **Voice Mail** folder, open MFCMAPI, open the user's Outlook mailbox from the MFCMAPI Quick Start menu, and then expand the **`Root Container\Finder`** folder. 

> [!NOTE]
> Third-party spam, or antivirus filtering solutions can also modify voicemail headers that will result in voicemails not being available in the voicemail folder. 

**Third-party information disclaimer**

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

**Third-party contact disclaimer**

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.
