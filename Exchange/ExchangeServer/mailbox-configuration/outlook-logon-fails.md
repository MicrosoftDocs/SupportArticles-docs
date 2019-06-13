---
title: Outlook logon fails after mailbox moves to Exchange 2013 or Exchange 2016
description: Describes an issue that occurs after mailboxes are migrated from Exchange 2010 to Exchange 2013 or 2016. Users can no longer log on, and they are prompted to quit and restart Outlook. However, they remain disconnected for up to 12 hours. A resolution is provided.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: exchange-powershell
ms.topic: article
ms.author: v-six
---

# Outlook logon fails after mailbox moves from Exchange 2010 to Exchange 2013 or Exchange 2016

## Symptoms

When mailboxes are moved to Exchange Server 2013 or Exchange Server 2016, users can no longer access those mailboxes.

This issue occurs in the following scenario:

- A user typically uses Outlook Anywhere to connect to his or her Exchange Server 2010 mailbox.   
- The user's mailbox is moved to Exchange Server 2013 or Exchange Server 2016.   
- After the mailbox is moved and the user tries to log on, he or she is prompted that “The Microsoft Exchange administrator has made a change that requires you quit and restart Outlook.”    
- After Outlook is restarted, the client remains disconnected for up to 12 hours.   

## Cause

After the mailbox move is completed, Exchange Server 2013 or 2016 continues to proxy the autodiscover request to Exchange Server 2010. Exchange Server 2010 responds with a 302 redirect back to Exchange Server 2013 or 2016 (depending on the upgrade).

## Resolution

To resolve this issue, restart the Autodiscover Application Pool on the Exchange Server 2013 or Exchange Server 2016 servers.

```powershell
Restart-WebAppPool MSExchangeAutodiscoverAppPool 
```

## More Information

In this scenario, the HTTPProxy\Autodiscover logs contain information that resembles the following:

```asciidoc
2015-06-16T16:01:23.845Z,d511bfef-a7e0-4e7d-beb8-6e6f8c0d2bd9,15,0,1044,21,,Autodiscover,autodiscover.fabrikam.de,
/autodiscover/pmcu9..fabrikam.de/autodiscover.xml,,Negotiate,true,FABRIKAM\pmcu9,fabrikam.de,
Smtp~pmcu9@fabrikam.de,Microsoft Office/15.0 (Windows NT 6.2; Microsoft Outlook 15.0.4569; Pro),192.168.2.115,
E15SRV1,302,302,,POST,Proxy,e14.fabrikam.local,14.03.0123.000,IntraForest,ExplicitLogon-SMTP,,,,349,201,1,,3,1,,0,
,0,,0,0,,0,24,0,1,0,0,16,0,0,0,0,0,21,0,17,4,4,7,24,,,,BeginRequest=2015-06-16T16:01:23.829Z;
CorrelationID=<empty>;ProxyState-Run=None;DownLevelTargetHash=0/1/2;ClientAccessServer=E14.fabrikam.local;
ResolveCasLatency=0;FEAuth=BEVersion-1937997947;ProxyToDownLevel=True;BeginGetRequestStream=2015-06-16T16:01:23.829Z;
OnRequestStreamReady=2015-06-16T16:01:23.829Z;BeginGetResponse=2015-06-16T16:01:23.829Z;
OnResponseReady=2015-06-16T16:01:23.845Z;EndGetResponse=2015-06-16T16:01:23.845Z;
ProxyState-Complete=ProxyResponseData;EndRequest=2015-06-16T16:01:23.845Z;,
```