---
title: Test-CsFederatedPartner fails
description: The Test-CsFederatedPartner Lync Server PowerShell cmdlet fails with the use of Office Communicatione Server 2007 R2 Edge Servers
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.reviewer: shailenv
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Lync Server 2010 Enterprise Edition
  - Lync Server 2010 Standard Edition
  - Lync Server 2013
ms.date: 03/31/2022
---

# Lync Server PowerShell cmdlet Test-CsFederatedPartner fails

## Symptoms

- An Office Communications 2007 R2 Edge Server pool is functional with the Lync Server front end server deployment   
- The Test-CsFederatedPartner PowerShell cmdlet fails displaying the following 
error in the Lync Server Management Shell console:

    ```adoc  
    Test-CsFederatedPartner : A 504 (Server time-out) response was received from the network and the operation failed. See the exception details for more information. At line:1 char:24 + Test-CsFederatedPartner <<<< -TargetFqdn ocsedge.contoso.com -Domain fabrikam.com -ProxyFqdn accessedge.fabrikam.com + CategoryInfo : OperationStopped: (:) [Test-CsFederatedPartner],FailureResponseException + FullyQualifiedErrorId : WorkflowNotCompleted,Microsoft.Rtc.Management.SyntheticTransactions.TestFederatedPartnerCmdlt
   ```

## Cause

The example listed below forces the addition of the SIP extension ms-edge-route to be added to the Lync Server SIP OPTIONS Request:

```powershell
Test-CsFederatedPartner -TargetFqdn ocsedge.contoso.com -Domain fabrikam.com -ProxyFQDN accessedge.fabrikam.com
```

The Office Communications Server 2007 R2 Edge Server is not designed to recognize the addition of the ms-edge-route SIP extension in the ROUTE header of the Lync Server SIP OPTIONS Request

## Resolution

Use the Lync Server PowerShell cmdlet Test-CsFederatedPartner without adding the -ProxyFqdn parameter. See the example listed below:

```powershell
Test-CsFederatedPartner -TargetFqdn ocsedge.contoso.com -Domain fabrikam.com
```

## More Information

For more details on the Test-CsFederatedPartner Lync Server PowerShell cmdlet:

[Test-CsFederatedPartner](/powershell/module/skype/Test-CsFederatedPartner)

Using the Test-CsFederatedPartner Lync Server PowerShell cmdlet with the -ProxyFQDN parameter as described in the Cause section of this article will provide the results similar to the information listed below in the Office Communications Server 2007 R2 Edge Server SipStack logging:

```adoc
TL_INFO(TF_PROTOCOL) [0]06E4.0EB4::01/18/2012-05:00:43.101.00005386 (SIPStack,SIPAdminLog::TraceProtocolRecord:SIPAdminLog.cpp(125))$$begin_record
Trace-Correlation-Id: 2003888399
Instance-Id: 0000C23F
Direction: incoming;source="internal edge";destination="external edge"
Peer: lyncservr.contoso.com:61182
Message-Type: request
Start-Line: OPTIONS sip:Options_User@fabrikam.com SIP/2.0
To: <sip:Options_User@fabrikam.com>
CSeq: 1 OPTIONS
Call-ID: 017b06f397b14886bba5edf97ea206bd
MAX-FORWARDS: 70
VIA: SIP/2.0/TLS 10.10.10.10:61182;branch=z9hG4bK6de49c9a
ROUTE: <sip:accessedge.fabrikam.com;transport=tls;lr>;ms-edge-route
CONTACT: <sip:lyncserver.contoso.com;transport=Tls>
CONTENT-LENGTH: 0
USER-AGENT: RTCC/4.0.0.0
Message-Body: -
$$end_record
```

The SIP OPTIONS Request listed above that includes the Lync Server ms-edge-route SIP extension in the ROUTE header will provide error information that is similar to what is listed below in the Office Communications Server 2007 R2 Edge Server SipStack logging:

```adoc
TL_ERROR(TF_COMPONENT) [0]0860.0CDC::01/18/2012-05:07:42.622.000d0b31 (SIPStack,CSIPRequest::GetNextHopByRouteHeader:SIPRequest.cpp(2440))( 00000000028FDD70 ) Exit - route headers from untrusted source. Result 0xC3E93C5E(SIPPROXY_E_ROUTING)
LogType: diagnostic
Severity: warning
Text: Cannot process Route headers from a non-trusted source, or with first Route field in the set not matching the connection on which the request arrived
Result-Code: 0xc3e93c5e SIPPROXY_E_ROUTING
SIP-Start-Line: OPTIONS sip:Options_User@fabrikam.com SIP/2.0
SIP-Call-ID: c00bc6180f284b948be61febf274d05e
SIP-CSeq: 1 OPTIONS
$$end_record
```

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).