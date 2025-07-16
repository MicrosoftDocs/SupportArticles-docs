---
title: 403 Forbidden and you can't see free/busy information at organization level
description: Discusses 403 Forbidden error when you view organization-wide free/busy information.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sharing\Issue viewing Free Busy
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jmartin, excontent, message, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2010 Enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# 403: Forbidden error when you try to view organization-wide free/busy information in Exchange

_Original KB number:_ &nbsp;3082946

## Summary

When you try to view organization-wide free/busy information, the attempt fails and generates a **403: Forbidden** error.

For example, you have Forest A on a server that's running Microsoft Exchange 2007 and Forest B on a server that's running Exchange Server 2013 or Exchange Server 2010. In this situation, a user in Forest A can't see the free/busy information of a user in Forest B. Additionally, the following event is logged in the event log on the source server:

```console
Log Name:      Application

Source:        MSExchange Availability

Date:          Date

Event ID:      4002

Task Category: Availability Service

Level:         Error

Keywords:      Classic

User:          N/A

Computer:      <Computer Name>

Description:

Process <Process ID>[w3wp.exe:/LM/W3SVC/1/ROOT/EWS-1-130778800910201315]: Proxy request CrossForest from
Requester:S-1-5-21-1016748826-3068013645-1401187561-1105 to https://<ONLINE_URL>/EWS/Exchange.asmx failed.
Caller SIDs: . The exception returned is Microsoft.Exchange.InfoWorker.Common.Availability.ProxyWebRequestProcessingException:
System.Net.WebException: The request failed with HTTP status 403: Forbidden.
```

On the destination server, the following entry is logged in the Internet Information Service (IIS) log, under the W3SVC1 directory:

```console
IIS Logs:  2015-06-08 04:19:25 <IP Address> POST /EWS/Exchange.asmx &CorrelationID=<empty>;&ClientId=JQJLGECZ0MGEHVVWEBZG&cafeReqId=9f422915-0721-48ce-b2c6-4406d2c1b49d; 443 domain\serviceaccount <IP Address> ASProxy/CrossForest/EmailDomain/EXCH/08.03.0083.000 - 403 0 0 718
```

On the server that is running Exchange Server 2013, the following entry is logged in the HTTPProxy log:

```console
WebExceptionStatus=ProtocolError;ResponseStatusCode=403;WebException=System.Net.WebException: The remote server returned an error: (403) Forbidden.    at System.Net.HttpWebRequest.EndGetResponse(IAsyncResult asyncResult)    at Microsoft.Exchange.HttpProxy.ProxyRequestHandler.<>c__DisplayClass2c.<OnResponseReady>b__2b();
```

On the Mailbox server, the following entry is logged in the IIS log, under the W3SVC2 directory:

```console
2015-06-08 04:16:29 <IP Address> POST /EWS/Exchange.asmx - 444 domain\serviceaccount 10.152.152.166 ASProxy/CrossForest/EmailDomain/EXCH/08.03.0083.000 403 0 0 233
```

On the Mailbox server, the following entry is logged in the EWS log:

```console
AuthError=User not allowed to access EWS;,FaultInnerException=Microsoft.Exchange.Services.Core.Types.ServiceAccessDeniedException: Access is denied. Check credentials and try again.;ExceptionHandlerBase_ProvideFault_FaultException=System.ServiceModel.FaultException: Access is denied. Check credentials and try again.    at Microsoft.Exchange.Services.Wcf.MessageInspectorManager.InternalAfterReceiveRequest(Message& request  IClientChann
```

## Cause

This problem occurs because EWS is blocked on Forest B at the organization level. Forest B allows only selected applications to access EWS. EWS isn't allowed for cross-forest free/busy requests.

To check the organization configuration, run the following command:

```powershell
Get-Organizationconfig | fl *ews*
```  

## Resolution

To enable cross-forest free/busy requests at the organization level, you have to add the User agent to the EWS Allow list. For example, in the situation that's described in the "Summary" section, add the following User agent path.

> [!NOTE]
> This information is taken from IIS logs on the destination server.

*ASProxy/CrossForest/EmailDomain/EXCH/08.03.0083.00*

Then, run the following command:

```powershell
Set-OrganizationConfig -EwsAllowList "ASProxy/CrossForest/EmailDomain/EXCH/08.03.0083.000","TestApp","app1"
```
