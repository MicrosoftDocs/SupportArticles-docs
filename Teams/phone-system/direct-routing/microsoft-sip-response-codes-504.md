---
title: SIP 504 and Microsoft response codes
description: Lists combinations of Microsoft response code and the SIP 504 error, and provides actions to resolve the errors.
ms.date: 11/22/2024
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Calling (PSTN)\Direct Routing
  - CI173631
  - CI2384
  - CSSTroubleshoot
ms.reviewer: teddygyabaah
---

# SIP response code 504

This article provides troubleshooting information for various combinations of the SIP 504 error and Microsoft response codes.

## 549002 504 Unable to deliver INVITE: TlsTransport is not connected, State=Disconnected

- Microsoft response code: **549002**
- SIP response code: **504**
- Suggested actions:  
  - Check whether the Session Border Controller (SBC) is functional.
  - Check whether the SBC is reachable through the specific IP and port. Also, check your firewall settings to make sure that connection to SBC isn't blocked.

## 549002 504 Unable to deliver INVITE: Invalid Request/Response line

- Microsoft response code: **549002**
- SIP response code: **504**
- Suggested actions:  
  - Make sure that requests and responses include SIP version "SIP/2.0" in the Request-URI, Via header, and other relevant headers. For more information, see [Direct Routing - SIP protocol](/microsoftteams/direct-routing-protocols-sip).

## 549018 504 Unable to deliver INVITE: Invalid Request/Response line

- Microsoft response code: **549018**
- SIP response code: **504**
- Suggested actions:
  - Check the SBC configuration to determine why it sends an invalid or unsupported SIP message format to Microsoft and fix any misconfiguration.

    **Note**: This error might be represented by a slightly different phrase that's associated with the response code.

## 569002 504 Unable to deliver INVITE: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond

- Microsoft response code: **569002**
- SIP response code: **504**
- Suggested actions:  
  - Check whether the SBC is functional.
  - Check whether the SBC is reachable through the specific IP and port. Also, check your firewall settings to make sure that connection to SBC isn't blocked.

## 569002 504 Unable to deliver INVITE: No connection could be made because the target machine actively refused it

- Microsoft response code: **569002**
- SIP response code: **504**
- Suggested actions:  
  - Check whether the SBC is functional.
  - Check whether the SBC is reachable through the specific IP and port. Also, check your firewall settings to make sure that connection to SBC isn't blocked.

## 569002 504 Unable to deliver INVITE: outgoing TLS negotiation failed; HRESULT=0x80096004

- Microsoft response code: **569002**
- SIP response code: **504**
- Suggested actions:  
  - Check whether the SBC is functional.
  - Check whether the SBC is reachable through the specific IP and port. Also, check your firewall settings to make sure that connection to SBC isn't blocked.

## 569002 504 Unable to deliver INVITE: outgoing TLS negotiation failed; Wrong target principal name configured. HRESULT=0x80090322 CERT_E_WRONG_USAGE

- Microsoft response code: **569002**
- SIP response code: **504**
- Suggested actions:  
  - Request a certificate that's signed by one of the public root certification authorities that are listed in [Public trusted certificate for the SBC](/microsoftteams/direct-routing-plan#public-trusted-certificate-for-the-sbc).

## 569002 504 Unable to deliver INVITE: TLS decryption failed; HRESULT=590615

- Microsoft response code: **569002**
- SIP response code: **504**
- Suggested actions:  
  - The TLS context is responsible for encrypting and decrypting SIP signaling messages. This error indicates that the TLS context is expired and can no longer be used for secure communication. Work with the SBC vendor to troubleshoot the TLS context expiration issue.

## 569002 504 Unable to deliver ACK: outgoing TLS negotiation failed; Wrong target principal name configured. HRESULT=0x80090322 CERT_E_WRONG_USAGE

- Microsoft response code: **569002**
- SIP response code: **504**
- Suggested actions:  
  - Request a certificate that's signed by one of the public root certification authorities that are listed in [public trusted certificate for the SBC](/microsoftteams/direct-routing-plan#public-trusted-certificate-for-the-sbc).

## 569002 504 Unable to deliver ACK: No connection could be made because the target machine actively refused it

- Microsoft response code: **569002**
- SIP response code: **504**
- Suggested actions:  
  - Check whether the SBC is functional.
  - Check whether the SBC is reachable through the specific IP and port. Also, check your firewall settings to make sure that connection to SBC isn't blocked.

## 569003 504 Unable to deliver INVITE: outgoing TLS negotiation failed; HRESULT=0x80090326

- Microsoft response code: **569003**
- SIP response code: **504**
- Suggested actions:  
  - Verify that the SBC certificate is signed by a trusted certificate authority (CA) and isn't expired. For more information, see [TLS connection issues](./sip-options-tls-certificate-issues.md#tls-connection-issues).

## 569008 504 Unable to deliver INVITE: Outgoing TLS negotiation failed. Remote certificate expired; HRESULT=0x80090328 SEC_E_CERT_EXPIRED

- Microsoft response code: **569008**
- SIP response code: **504**
- Suggested actions:  
  - Renew the SBC certificate.

  **Note:** When you renew the SBC certificate, you must remove the TLS connections that were established from the SBC to Microsoft by using the old certificate, and re-establish them by using the new certificate. Doing this will make sure that certificate expiration warnings aren't triggered in the Microsoft Teams admin center. To remove the old TLS connections, restart the SBC during a timeframe that has low traffic, such as a maintenance window. If you can't restart the SBC, contact the vendor for instructions to force the closure of all old TLS connections.

## 569009 504 Unable to deliver INVITE: outgoing TLS negotiation failed; HRESULT=0x80090325 SEC_E_UNTRUSTED_ROOT

- Microsoft response code: **569009**
- SIP response code: **504**
- Suggested actions:  
  - Request a certificate that's signed by one of the public root certification authorities that are listed in [public trusted certificate for the SBC](/microsoftteams/direct-routing-plan#public-trusted-certificate-for-the-sbc).

  If you have multiple TLS profiles, check that you're using a profile that has the correct certificate when you connect to the Direct Routing interface. If you have multiple TLS profiles on the SBC, make sure that you select a profile that's signed by using a certificate that's trusted by Direct Routing.

## 569015 504 Unable to deliver INVITE: No such host is known

- Microsoft response code: **569015**
- SIP response code: **504**
- Suggested actions:
  - Determine why the FQDN of the SBC can’t be resolved through DNS, and fix the issue.

## 569016 504 Unable to deliver INVITE/ACK: The requested name is valid, but no data of the requested type was found

- Microsoft response code: **569016**
- SIP response code: **504**
- Suggested actions:  
  - Check the DNS settings to make sure that the correct DNS record types (A or AAAA) are configured.

    **Note**: This error might be represented by a slightly different phrase that's associated with the response code. This error indicates that a DNS record is found, typically a TXT record that's added for domain verification when you set up the SBC, but it's not an A or AAAA record.

## 569018 504 Unable to deliver INVITE: Invalid Request/Response line

- Microsoft response code: **569018**
- SIP response code: **504**
- Suggested actions:
  - Check the SBC configuration to determine why it sends an invalid or unsupported SIP message format to Microsoft and fix any misconfiguration.

    **Note**: This error might be represented by a slightly different phrase that’s associated with the response code.
