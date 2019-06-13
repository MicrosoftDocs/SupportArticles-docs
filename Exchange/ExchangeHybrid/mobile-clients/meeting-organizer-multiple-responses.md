---
title: Meeting organizer receives multiple responses from an attendee
description: Fixes an issue in which the organizer of a meeting receives multiple meeting responses from an attendee.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: exchange-server-it-pro
ms.topic: article
ms.author: v-six
---

# Meeting organizer receives multiple responses from an attendee

## Symptoms

The organizer of a meeting receives multiple meeting responses from an attendee. An analysis of the IIS logs shows multiple MeetingResponse commands from the user's device. These commands resemble the following:

```asciidoc
2015-11-18 13:48:57 10.0.1.161 POST /Microsoft-Server-ActiveSync/Proxy/default.eas User=jmartin@contoso.com
&DeviceId=VBHDCRCR131BJBUID1MORNING&DeviceType=iPhone&Cmd=MeetingResponse&Log=PrxFrom:10.0.1.161_V160_Ver1:160
_HH:eas.contoso.com_SmtpAdrs:jmartin%40contoso.com_Fet:6014_Pk:4016830080_DevOS:iOS+9.2+13C71_As:AllowedG
_Mbx:CLT-E16-MBX1.contoso.com_Throttle:0 
```

## Cause

This issue occurs because the attendee responded to an instance of a recurring meeting by using an iOS 9.x device. The device does not correctly parse the response from the server that is running Exchange Server. Therefore, the server continues to send the meeting response. 

## Resolution

To resolve this issue, apply the iOS 9.3 update. Apple has documented the issue in the following article in the Apple Knowledge Base:  

[Download iOS 9.0 - 9.3.5 Information](https://support.apple.com/kb/dl1842)  

> [!NOTE]
> The referenced article mentions the fix for this issue in bullet item 6 in the "Enterprise bug fixes" section for iOS 9.3. 

## More information

> [!NOTE]
> The information in this article that is related to analyzing IIS logs applies only to customers who are using Exchange on-premises. It does not apply to Exchange Online customers because they cannot access their IIS logs. For Exchange Online, we highly recommend that you make sure that all users who have iOS devices are using the latest available version of the operating system.     
 
You can use the following Log Parser Studio query to identify users who are affected by this issue: 

```asciidoc
/* Query to find MeetingResponse commands by user device */ SELECT COUNT(*) As Hits, EXTRACT_VALUE(cs-uri-query,'DeviceType') AS DeviceType, EXTRACT_VALUE(cs-uri-query,'DeviceId') AS DeviceId, REPLACE_STR(TO_STRING(EXTRACT_PREFIX(EXTRACT_SUFFIX(cs-uri-query, 0, '_SmtpAdrs:'), 0, '_')), '%40', '@') As User, EXTRACT_VALUE(cs-uri-query,'Cmd') AS Cmd FROM '[LOGFILEPATH]' WHERE cs-uri-stem LIKE '%Active%' AND Cmd LIKE '%MeetingResponse%' GROUP BY DeviceType,DeviceId,Cmd,User ORDER BY HitsDESC
```

**Third-party information disclaimer**  

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.