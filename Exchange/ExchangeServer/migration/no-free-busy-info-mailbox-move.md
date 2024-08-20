---
title: Can't see Free/Busy info after a mailbox moves to Exchange 2013 or 2016
description: Describes an issue that occurs after Outlook mailboxes are migrated from Exchange 2010 to Exchange 2013 or 2016. Outlook can't see Free/Busy data.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Clients and Mobile\Issue with autodiscover
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jonrude, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# No Free/Busy information after a mailbox moves from Exchange 2010 to Exchange 2013 or Exchange 2016

_Original KB number:_ &nbsp;3196518

## Symptoms

When Microsoft Outlook mailboxes are moved to Microsoft Exchange Server 2013 or Exchange Server 2016, users can no longer see the free/busy information.

This issue occurs in the following scenario:

- The user's mailbox is moved to Exchange Server 2013 or Exchange Server 2016.
- After the mailbox is moved and the user tries to look up the free/busy information for another user in the organization, they see hash marks instead of the expected time blocks.
- Outlook eventually succeeds in looking up the free/busy information if the user waits for 12 hours or longer.

## Cause

After the mailbox move is complete, Exchange Server 2013 or Exchange Server 2016 continues to proxy the EWS request to Exchange Server 2010. Exchange Server 2010 responds with a 302 redirect back to Exchange Server 2013 or Exchange Server 2016 (depending on the upgrade).

## Resolution

To resolve this issue, run the following commands to restart the Autodiscover Application Pool and the Exchange Web Services Application Pool on the Exchange Server 2013 or Exchange Server 2016 servers:

```powershell
Restart-WebAppPool MSExchangeAutodiscoverAppPool
```

```powershell
Restart-WebAppPool MSExchangeServicesAppPool
```

## More information

When this issue occurs, the HTTPProxy\EWS logs contain the information like this one:

```console
2016-09-20T13:07:56.303Z,<ID>,15,1,466,33,{ID},Ews,mail.fabrikam.com,/EWS/exchange.asmx,,Negotiate,true,FABRIKAM\user8,,Sid~S-1-5-21-,Microsoft Office/15.0 (Windows NT 6.1; Microsoft Outlook 15.0.4859; Pro),192.168.17.103,E16SRV01,500,500,,POST,Proxy,E14SRV01.fabrikam.com,14.03.0123.000,IntraForest,WindowsIdentity,,,,679,629,,,3,0,,0,,0,,0,0,,0,10,0,0,0,0,4,0,0,1,0,0,7,0,5,2,2,5,10,,,,BeginRequest=2016-09-20T13:07:56.288Z;CorrelationID=<empty>;ProxyState-Run=None;DownLevelTargetRandomHashing=0/2;ClientAccessServer=E14SRV01.fabrikam.com;ResolveCasLatency=0;FEAuth=BEVersion-1937997947;ProxyToDownLevel=True;RoutingEntry=DatabaseGuid:<GUID>%40fabrikam.com%40fabrikam.com Server:E16SRV01.fabrikam.com+1937937997@0;BeginGetRequestStream=2016-09-20T13:07:56.288Z;OnRequestStreamReady=2016-09-20T13:07:56.288Z;MailboxServerByServerGuard_E14SVR1.fabrikam.com=1;MailboxServerByForestGuard_fabrikam.com=1;TotalMailboxServerGuard=1;BeginGetResponse=2016-09-20T13:07:56.288Z;OnResponseReady=2016-09-20T13:07:56.303Z;EndGetResponse=2016-09-20T13:07:56.303Z;ProxyState-Complete=ProxyResponseData;SharedCacheGuard=0;EndRequest=2016-09-20T13:07:56.303Z;S:ServiceCommonMetadata.Cookie=,WebExceptionStatus=ProtocolError;ResponseStatusCode=500;
```
