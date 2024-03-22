---
title: Troubleshoot when devices can't obtain SCEP certificates
description: Helps resolve an issue when devices can't obtain SCEP certificates from the NDES server and return error 80094800 and Event ID 31.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Configure Devices - Windows\SCEP Certificates
ms.reviewer: kaushika
---
# 0x80094800 error and Event ID 31 when devices fail to receive SCEP certificates

This article fixes an issue in which devices can't obtain Simple Certificate Enrollment Protocol (SCEP) certificates from the Network Device Enrollment Service (NDES) server.

## Symptoms

Devices can't obtain SCEP certificates from the NDES server. Additionally, the following errors are logged:

- In **Failed Requests** on the Certificate Authority (CA):

    > Request Status Code:  
    > "The requested certificate template is not supported by this CA. 0x80094800 (-2146875392 CERTSRV_E_UNSUPPORTED_CERT_TYPE)"  
    >
    > Request Disposition Message:  
    > "The request was for a certificate template that is not supported by the Active Directory Certificate Services Policy: \<Template name in the client request>"

- In the Application log on the NDES server:

    > Log Name:&nbsp;&nbsp;&nbsp;Application  
    > Source:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Microsoft-Windows-NetworkDeviceEnrollmentService  
    > Event ID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31  
    > Level:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Error**  
    > User:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CONTOSO\SVC_NDES  
    > Computer:&nbsp;&nbsp;&nbsp;&nbsp;NDES1.contoso.com  
    > Description:  
    > **The Network Device Enrollment Service cannot submit the certificate request (The requested certificate template is not supported by this CA.). 0x80004005**  
    > Event Xml:
    > \<Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event">  
    >&nbsp; \<EventData Name="**EVENT_MSCEP_FAIL_SUBMIT**">  
    >&nbsp;&nbsp;&nbsp; \<Data Name="ErrorCode">**The requested certificate template is not supported by this CA.**\</Data>  
    >&nbsp;&nbsp;&nbsp; \<Data Name="ErrorMessage">**0x80004005**\</Data>  
    >&nbsp; \</EventData>  
    >\</Event>

## Cause

This issue occurs if the template name on the NDES server doesn't match the name on the CA. In this situation, you have to use a friendly name instead of the template name for the template.

## Solution

To fix this issue, follow these steps:

1. Make sure that the registry values in the following registry subkey map to the certificate template name correctly:

   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\MSCEP`

   Registry values:

   - `SignatureTemplate`
   - `EncryptionTemplate`
   - `GeneralPurposeTemplate`

   The following is an example that shows an incorrect value for `SignatureTemplate`:

   :::image type="content" source="media/devices-receive-scep-certificates-error-0x80094800/signature-template-value.png" alt-text="Screenshot of an incorrect value for SignatureTemplate." border="false":::

2. Restart the Intune Connector Service on the NDES server.
