---
title: 500 Server Internal error and calls to Subscriber Access or Auto Attendant fail
description: You receive a 500 Server Internal error message and a fast busy signal, and calls to Subscriber Access or Auto Attendant fail after you migrate contact objects to Skype for Business Server 2019. Provides a workaround.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business Server 2019
ms.date: 03/31/2022
---

# "500 Server Internal" error and calls to Subscriber Access or Auto Attendant fail after moving contact objects to Skype for Business Server 2019

## Symptoms

After you migrate Subscriber Access or Auto Attendant contact objects to Skype for Business Server 2019 by using the **Move-CsExUmContact** cmdlet, calls to these numbers fail and experience a fast busy signal. 

Additionally, a "500 Server Internal" error entry is logged in the calling client's UCCAPI log file.

```adoc
SIP/2.0 500 Server Internal Error
 ms-user-logon-data: RemoteUser
 Authentication-Info: TLS-DSK qop="auth", opaque="E0B06A27", srand="BEE78D63", snum="294", rspauth="d273a9ff5d8c43edec26a19af80f9dcd383ad509b385292d60f0c5685b5151e65a050c6971c5a92af59bc9cc1050f3cb", targetname="NASEAPOOLFE01.contoso.com", realm="SIP Communications Service", version=4
 Via: SIP/2.0/TLS 192.168.1.190:58350;received=192.168.1.1;ms-received-port=58350;ms-received-cid=1D5400
 From: "Calvin Zink"<sip:calz@treyresearch.net>;tag=02cf1a118c;epid=11c6105a5a
 To: <sip:seaautoattendant@treyresearch.net>;tag=5A2FCD175386029A12ECE5FB6E248424
 Call-ID: fd8c35c4bf9c41999f72bac2ddbacec4
 CSeq: 1 INVITE
 ms-telemetry-id: 283648AE-90DB-5E43-A0F5-EFDF55BD7E81
 ms-diagnostics: 15000;reason="Unable to read the user properties publication for the user or contact object.";source="NASEAPOOLFE01.CONTOSO.COM";appName="ExumRouting"
 Server: ExumRouting/7.0.0.0
 Content-Length: 0 
```

## Cause

This problem occurs because of an emerging issue in Skype for Business Server 2019. 

## Workaround

To work around this problem, move the Subscriber Access or Auto Attendant contact objects to Skype for Business Server 2015 or an earlier supported topology server by using the **Move-CsExUmContact** cmdlet. 

> [!NOTE]
> You don't have to run **exchucutil.ps1** again when you move Subscriber Access or Auto Attendant contact objectsin a configured topology. 

## References

[Move Exchange Unified Messaging Contact objects](/lyncserver/move-exchange-unified-messaging-contact-objects)

## Status

Microsoft is aware of this problem and is currently investigating it.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
