---
title: Microsoft and SIP response codes
description: A combination of Microsoft and SIP response codes can help identify the cause of call failures and provide detailed descriptions of errors and actions that you can take.
ms.date: 3/27/2023
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: CI166247,CSSTroubleshoot
ms.reviewer: rishire
---

# Microsoft and SIP response codes

This article lists combinations of Microsoft and SIP response codes, the corresponding error messages, and actions that you can take.

## 549002 504 Unable to deliver INVITE: TlsTransport is not connected, State=Disconnected

- Microsoft response code: **549002**
- SIP response code: **504**
- Error message: **Unable to deliver INVITE: TlsTransport is not connected, State=Disconnected**
- Suggested actions:  
  - Check if the Session Border Controller (SBC) is functional.
  - Check if the SBC is reachable through the specific IP and port. Also check your firewall settings to make sure that connection to SBC isn't blocked.

## 549002 504 Unable to deliver INVITE: Invalid Request/Response line

- Microsoft response code: **549002**
- SIP response code: **504**
- Error message: **Unable to deliver INVITE: Invalid Request/Response line**
- Suggested actions:  
  Make sure that requests and responses include SIP version "SIP/2.0" in the Request-URI, Via Header, and other relevant headers. For more information, see [Direct Routing - SIP protocol](/microsoftteams/direct-routing-protocols-sip)

## 569002 504 Unable to deliver INVITE: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond

- Microsoft response code: **569002**
- SIP response code: **504**
- Error message: **Unable to deliver INVITE: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond**
- Suggested actions:  
  - Check if the SBC is functional.
  - Check if the SBC is reachable through the specific IP and port. Also check your firewall settings to make sure that connection to SBC isn't blocked.

## 569002 504 Unable to deliver INVITE: No connection could be made because the target machine actively refused it

- Microsoft response code: **569002**
- SIP response code: **504**
- Error message: **Unable to deliver INVITE: No connection could be made because the target machine actively refused it**
- Suggested actions:  
  - Check if the SBC is functional.
  - Check if the SBC is reachable through the specific IP and port. Also check your firewall settings to make sure that connection to SBC isn't blocked.

## 569002 504 Unable to deliver INVITE: TlsTransport is not connected, State=Disconnected

- Microsoft response code: **569002**
- SIP response code: **504**
- Error message: **Unable to deliver INVITE: TlsTransport is not connected, State=Disconnected**
- Suggested actions:  
  - Check if the SBC is functional.
  - Check if the SBC is reachable through the specific IP and port. Also check your firewall settings to make sure that connection to SBC isn't blocked

## 569002 504 Unable to deliver INVITE: outgoing TLS negotiation failed; HRESULT=0x80096004

- Microsoft response code: **569002**
- SIP response code: **504**
- Error message: **Unable to deliver INVITE: outgoing TLS negotiation failed; HRESULT=0x80096004**
- Suggested actions:  
  - Check if the SBC is functional.
  - Check if the SBC is reachable through the specific IP and port. Also check your firewall settings to make sure that connection to SBC isn't blocked.

## 569002 504 Unable to deliver INVITE: outgoing TLS negotiation failed; Wrong target principal name configured. HRESULT=0x80090322 CERT_E_WRONG_USAGE

- Microsoft response code: **569002**
- SIP response code: **504**
- Error message: **Unable to deliver INVITE: outgoing TLS negotiation failed; Wrong target principal name configured. HRESULT=0x80090322 CERT_E_WRONG_USAGE**
- Suggested actions:  
  Request a certificate that's signed by one of the public root certification authorities that are listed in [Public trusted certificate for the SBC](/microsoftteams/direct-routing-plan#public-trusted-certificate-for-the-sbc).

## 569002 504 Unable to deliver INVITE: TLS decryption failed; HRESULT=590615

- Microsoft response code: **569002**
- SIP response code: **504**
- Error message: **Unable to deliver INVITE: TLS decryption failed; HRESULT=590615**
- Suggested actions:  
  This error indicates that the TLS context, which is responsible for encrypting and decrypting SIP signaling messages, has expired and can no longer be used for secure communication. Work with the SBC vendor to troubleshoot the TLS context expiration issue.

## 569002 504 Unable to deliver ACK: outgoing TLS negotiation failed; Wrong target principal name configured. HRESULT=0x80090322 CERT_E_WRONG_USAGE

- Microsoft response code: **569002**
- SIP response code: **504**
- Error message: **Unable to deliver ACK: outgoing TLS negotiation failed; Wrong target principal name configured. HRESULT=0x80090322 CERT_E_WRONG_USAGE**
- Suggested actions:  
  Request a certificate that's signed by one of the public root certification authorities that are listed in [Public trusted certificate for the SBC](/microsoftteams/direct-routing-plan#public-trusted-certificate-for-the-sbc).

## 569002 504 Unable to deliver ACK: No connection could be made because the target machine actively refused it

- Microsoft response code: **569002**
- SIP response code: **504**
- Error message: **Unable to deliver ACK: No connection could be made because the target machine actively refused it.**
- Suggested actions:  
  - Check if the SBC is functional.
  - Check if the SBC is reachable through the specific IP and port. Also check your firewall settings to make sure that connection to SBC isn't blocked.

## 569003 504 Unable to deliver INVITE: outgoing TLS negotiation failed; HRESULT=0x80090326

- Microsoft response code: **569003**
- SIP response code: **504**
- Error message: **Unable to deliver INVITE: outgoing TLS negotiation failed; HRESULT=0x80090326**
- Suggested actions:  
  Verify that the SBC certificate is signed by a trusted certificate authority (CA) and hasn't expired. For more information, see [TLS connection issues](/microsoftteams/troubleshoot/phone-system/direct-routing/sip-options-tls-certificate-issues#tls-connection-issues).

## 569008 504 Unable to deliver INVITE: Outgoing TLS negotiation failed. Remote certificate expired; HRESULT=0x80090328 SEC_E_CERT_EXPIRED

- Microsoft response code: **569008**
- SIP response code: **504**
- Error message: **Unable to deliver INVITE: Outgoing TLS negotiation failed. Remote certificate expired; HRESULT=0x80090328 SEC_E_CERT_EXPIRED**
- Suggested actions:  
  Renew the SBC certificate.

  **Note:** When you renew the SBC certificate, you must remove the TLS connections that were established from the SBC to Microsoft with the old certificate and re-establish them with the new certificate. Doing so will ensure that certificate expiration warnings aren't triggered in the Microsoft Teams admin center. To remove the old TLS connections, restart the SBC during a time frame that has low traffic such as a maintenance window. If you can't restart the SBC, contact the vendor for instructions to force the closure of all old TLS connections.
