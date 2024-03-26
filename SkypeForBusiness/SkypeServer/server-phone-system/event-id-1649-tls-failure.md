---
title: Event ID 1649 - A TLS failure occurred
description: Describes a TLS failure that occurred because the remote server disconnected while TLS negotiation was in progress.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Lync Server 2013
ms.date: 03/31/2022
---

# Event ID 1649 - A TLS failure occurred because the remote server disconnected while TLS negotiation was in progress.

## Summary

```adoc
Log Name: Application 
Source: MSExchange Unified Messaging 
Date: 13/03/2014 14:25:38 
Event ID: 1649 
Task Category: UMCallRouter 
Level: Warning 
Keywords: Classic 
User: N/A 
Computer: 
Description: 
The Microsoft Exchange Unified Messaging Call Router service failed to exchange the required certificates with an IP gateway to enable Transport Layer Security (TLS). Please check that the gateway is configured to operate in the correct security mode. If the gateway is required to operate in TLS mode, check that the certificates being used are correct. More information: "A TLS failure occurred because the remote server disconnected while TLS negotiation was in progress. The error code = 0x80131500 and the message = Unknown error (0x80131500).". Remote certificate: (). Remote end point: . Local end point: . 
Event Xml: 
<Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event"> 
<System> 
<Provider Name="MSExchange Unified Messaging" /> 
```

```adoc
<EventID Qualifiers="32772">1649</EventID> 
<Level>3</Level> 
<Task>8</Task> 
<Keywords>0x80000000000000</Keywords> 
<TimeCreated SystemTime="2014-03-13T14:25:38.000000000Z" /> 
<EventRecordID>2047317</EventRecordID> 
<Channel>Application</Channel> 

<Security /> 
</System> 
<EventData> 
<Data>A TLS failure occurred because the remote server disconnected while TLS negotiation was in progress. The error code = 0x80131500 and the message = Unknown error (0x80131500).</Data> 
<Data> 
</Data> 
<Data> 
</Data> 
</EventData> 
</Event> 
```

We see that Lync server finds the Exchange server and umdialplan but get a TLS error when the call gets reroutes to third call manager that pulls up the auto attendant setting.

## Workaround

So recommendation is: 

1. Change the dial plan to use wildcard and change UM service startup mode to use TLS
1. Reassign the certificate on server to set FQDN as subject name but unable to assign the cert on UM and UM call router service. unable to delete the old certificate 
1. Disabled the Startup mode to use TCP 4) Now remove the old cert and assigned a new certificate for UM & UM callrouterservice 
1. Assign the certificate with UM services 
1. Change start up mode back to TLS

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
