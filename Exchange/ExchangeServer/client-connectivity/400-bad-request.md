---
title: HTTP 400 Bad Request when proxying HTTP requests from an Exchange Server
description: Describes a situation in which you receive an HTTP 400 Bad Request error message when proxying HTTP requests from an Exchange Server to a previous version of Exchange Server.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Standard
  - Exchange Server 2010 Enterprise
ms.date: 01/24/2024
ms.reviewer: v-six
---

# "HTTP 400 Bad Request" error when proxying HTTP requests from an Exchange Server to a previous version of Exchange Server

## Symptoms

When a user tries to proxy an HTTP request from a Microsoft Exchange Server 2016 server that is running client access service or a Microsoft Exchange Server 2013 Client Access server (CAS) to a previous version of Exchange Server, the user may receive the following error message: 

**This error (HTTP 400 Bad Request) means that Internet Explorer was able to connect to the web server, but the webpage could not be found because of a problem with the address.** 
 
Additionally, the HTTPERR logs on the Microsoft Exchange Server 2010 or Microsoft Exchange Server 2007 Client Access server may show one of the following for the HTTP resource the user was requesting: 

```asciidoc
2014-07-24 16:48:06 192.168.137.113 53335 192.168.137.110 443 HTTP/1.1 GET /owa/ 400 - RequestLength -

2014-07-24 16:48:06 192.168.137.113 53335 192.168.137.110 443 HTTP/1.1 GET /owa/ 400 - FieldLength - 
```

Also, you may see the following in the Exchange Server <**Exchange Server Install Path**>\Logging\HttpProxy\\<**Http resource**> logs on the Exchange Server 2013 Client Access server:
   
```asciidoc
2014-07-24T16:56:17.806Z,ddf5379e-4a97-4833-b331-36328b9f8b58,15,0,913,7,,Owa,outlook.Wingtiptoys.com,/owa/,,Negotiate,True,WINGTIPTOYS\user003,,Sid~S-1-5-21-3205615561-4199783494-2467053687-1128,Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET4.0C; .NET4.0E; .NET CLR 3.5.30729; .NET CLR 3.0.30729),192.168.137.113,WINGTIP-E2K13,400,400,,GET,Proxy,wingtip-e2k10.wingtiptoys.com,14.03.0123.000,IntraForest,WindowsIdentity-ServerCookie,Server~WINGTIP-E2K10.Wingtiptoys.com~1937997947~07/24/2014 17:01:18,,,0,342,1,,4,14,,0,,0,,0,0,,0,46.8744,0,,,,18,0,1,0,0,1,38,1,20,20,20,24,43,,,BeginRequest=2014-07-24T16:56:17.759Z;CorrelationID=<empty>;ProxyState-Run=None;ProxyToDownLevel=True;BeginGetResponse=2014-07-24T16:56:17.791Z;OnResponseReady=2014-07-24T16:56:17.806Z;EndGetResponse=2014-07-24T16:56:17.806Z;ProxyState-Complete=ProxyResponseData;EndRequest=2014-07-24T16:56:17.806Z;,WebExceptionStatus=ProtocolError;ResponseStatusCode=400;WebException=System.Net.WebException: The remote server returned an error: (400) Bad Request. at System.Net.HttpWebRequest.EndGetResponse(IAsyncResult asyncResult) at Microsoft.Exchange.HttpProxy.ProxyRequestHandler.<>c__DisplayClass2a.<OnResponseReady>b__28();  
```

## Cause

This issue may occur if the user is a member of many Active Directory groups. This issue may occur during the proxy process from Exchange Server 2016 or Exchange Server 2013 CAS to Exchange Server 2010 CAS. 

## Resolution

To fix this issue, use one of the following methods: 

- Reduce the number of Active Directory groups that are assigned to the user.    
- On every Exchange 2010 CAS, locate the following subkey:    
 
    **HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\HTTP\Parameters** 
 
- Under this subkey, increase the **MaxFieldLength** and **MaxRequestBytes** entries by using the values in the following table.

    |Value name   |Value type |  Value data  | Value base  |
    |-|-|-|-|
    | MaxFieldLength| DWORD| 65536| Decimal  |
    |MaxRequestBytes|DWORD|65536|Decimal |
    
    **Notes** 
     
    - This change requires a restart of the CAS.    
    - If the entries do not exist for **MaxFieldLength** and **MaxRequestBytes**, create the entries manually.    
 
## More Information

> [!IMPORTANT]
> Changing these registry keys might be extremely dangerous. Increasing the values allow larger HTTP packets to be sent to IIS, which in turn might cause Http.sys to use more memory and might increase vulnerability to malicious attacks.
 
- The recommended value for Exchange Server coexistence is 65536.

    > [!NOTE]
    > The value should be 65536 for Exchange Server. It should not be 65534, as indicated in [KB 2020943](https://support.microsoft.com/help/2020943). That setting is for Internet Information Services (IIS). This difference is because of additional requirements for Exchange Server.    
- In some cases, a **MaxFieldLength** value of 65536 may not fix the issue. If this occurs, we recommend that you reduce the size of the user's access token by removing groups instead of increasing the value.    
- Increasing the value of **MaxRequestBytes** to be greater 65536 has risks. Therefore, we do not recommend that you do this. These risks are discussed in detail in [KB 820129](https://support.microsoft.com/help/820129). This key is assigned a warning code of 1 to indicate a high risk for changing the default value.
