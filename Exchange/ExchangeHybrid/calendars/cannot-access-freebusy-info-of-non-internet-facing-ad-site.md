---
title: Cannot access free/busy of non-Internet-facing AD site
description: Describes an issue in which users who have mailboxes in Exchange Online cannot access free/busy information of users who have mailboxes in a non-Internet-facing Active Directory site in a hybrid environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: santoshp, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Exchange Online users cannot access free/busy information of users in a non-Internet-facing Active Directory site

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

_Original KB number:_ &nbsp; 3057905

## Symptoms

Consider the following scenario:

- You have a hybrid deployment of Microsoft Exchange Online and on-premises Microsoft Exchange Server.
- The hybrid environment has two Active Directory sites.
- One Active Directory site is Internet-facing, and the other site is non-Internet-facing.

In this scenario, users who have mailboxes in Exchange Online cannot access free/busy information of on-premises users who have mailboxes in the non-Internet-facing Active Directory site.

Additionally, an event ID 4002 entry that resembles the following is logged in the Application log every time that an Exchange Online mailbox in the Internet-facing site makes an availability request to an on-premises mailbox in the non-Internet-facing site.

> Log Name: Application  
Source: MSExchange Availability  
Event ID: 4002  
Task Category: Availability Service  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: \<InternetfacingServer>.domain.com  
Description:  
Process 6424: ProxyWebRequest CrossSite from `UserA@contoso.mail.onmicrosoft.com` to `https://<FQDN of non-Internet-facing Exchange>:443/ews/exchange.asmx failed`.
Caller SIDs: WSSecurity. The exception returned is  
Microsoft.Exchange.InfoWorker.Common.Availability.ProxyWebRequestProcessingException:  
System.Net.WebException: The underlying connection was closed: An unexpected error occurred on a receive.  
---> System.IO.IOException: Unable to read data from the transport connection: An existing connection  
was forcibly closed by the remote host. ---> System.Net.Sockets.SocketException: An existing connection  
was forcibly closed by the remote host  
 at System.Net.Sockets.Socket.EndReceive(IAsyncResult asyncResult)  
 at System.Net.Sockets.NetworkStream.EndRead(IAsyncResult asyncResult)  
 --- End of inner exception stack trace ---  
 at System.Net.Security._SslStream.EndRead(IAsyncResult asyncResult)  
 at System.Net.TlsStream.EndRead(IAsyncResult asyncResult)  
 at System.Net.PooledStream.EndRead(IAsyncResult asyncResult)  
 at System.Net.Connection.ReadCallback(IAsyncResult asyncResult)  
 --- End of inner exception stack trace ---  
 at System.Web.Services.Protocols.WebClientAsyncResult.WaitForResponse()  
 at System.Web.Services.Protocols.WebClientProtocol.EndSend(IAsyncResult asyncResult,  
Object& internalAsyncState, Stream& responseStream)  
 at System.Web.Services.Protocols.SoapHttpClientProtocol.EndInvoke(IAsyncResult asyncResult)  
 at Microsoft.Exchange.InfoWorker.Common.Availability.Proxy.Service.EndGetUserAvailability(IAsyncResult asyncResult)  
 at Microsoft.Exchange.InfoWorker.Common.Availability.FreeBusyApplication.EndProxyWebRequest(ProxyWebRequest proxyWebRequest, QueryList queryList, Service service, IAsyncResult asyncResult)  
 at Microsoft.Exchange.InfoWorker.Common.Availability.ProxyWebRequest.EndInvoke(IAsyncResult asyncResult)  
 at Microsoft.Exchange.InfoWorker.Common.Availability.AsyncWebRequest.EndInvokeWithErrorHandling():\<No response>. The request information is
ProxyWebRequest type = CrossSite, url = `https://FQDN` of Non-Internet facing Exchange>:443/ews/exchange.asmx  
Mailbox list = \<User B>`SMTP:UserB@fabrikam.com`, Parameters: windowStart = *DateTime*, windowEnd = *DateTime*, MergedFBInterval = 30, RequestedView = Detailed. ---> System.Net.WebException: The underlying connection was closed: An unexpected error occurred on  
a receive. ---> System.IO.IOException: Unable to read data from the transport connection: An existing connection was forcibly closed by the remote host. ---> System.Net.Sockets.SocketException: An existing connection was forcibly closed by the remote host  
 at System.Net.Sockets.Socket.EndReceive(IAsyncResult asyncResult)  
 at System.Net.Sockets.NetworkStream.EndRead(IAsyncResult asyncResult)  
 --- End of inner exception stack trace ---  
 at System.Net.Security._SslStream.EndRead(IAsyncResult asyncResult)  
 at System.Net.TlsStream.EndRead(IAsyncResult asyncResult)  
 at System.Net.PooledStream.EndRead(IAsyncResult asyncResult)  
 at System.Net.Connection.ReadCallback(IAsyncResult asyncResult)  
 --- End of inner exception stack trace ---  
 at System.Web.Services.Protocols.WebClientAsyncResult.WaitForResponse()  
 at System.Web.Services.Protocols.WebClientProtocol.EndSend(IAsyncResult asyncResult, Object& internalAsyncState, Stream& responseStream)  
 at System.Web.Services.Protocols.SoapHttpClientProtocol.EndInvoke(IAsyncResult asyncResult)  
 at Microsoft.Exchange.InfoWorker.Common.Availability.Proxy.Service.EndGetUserAvailability(IAsyncResult asyncResult)  
 at Microsoft.Exchange.InfoWorker.Common.Availability.FreeBusyApplication.EndProxyWebRequest (ProxyWebRequest proxyWebRequest, QueryList queryList, Service service, IAsyncResult asyncResult)  
 at Microsoft.Exchange.InfoWorker.Common.Availability.ProxyWebRequest.EndInvoke(IAsyncResult asyncResult)  
 at Microsoft.Exchange.InfoWorker.Common.Availability.AsyncWebRequest.EndInvokeWithErrorHandling()  
 --- End of inner exception stack trace ---  
 . Name of the server where exception originated: \<Host name of Internet-facing site>.

Make sure that the Active Directory site or forest that contains the user's mailbox has at least one local server that is running Exchange Server that is also running the Availability service. Turn up logging for the Availability service, and then test basic network connectivity.

## Cause

The certificate that's used to create the federation with Exchange Online is not installed on the Exchange servers in the non-Internet-facing site.

## Resolution

Export the federation certificates from the Internet-facing Exchange servers, and then import them to the non-Internet-facing Exchange servers.

## More information

For more information about how to export certificates in Exchange Server, see the following resources:

- [Import-ExchangeCertificate](/powershell/module/exchange/import-exchangecertificate?view=exchange-ps&preserve-view=true)
- [Export-ExchangeCertificate](/powershell/module/exchange/export-exchangecertificate?view=exchange-ps&preserve-view=true)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
