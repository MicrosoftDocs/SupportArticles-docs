---
title: Devices can't obtain SCEP certificates
description: Describes an issue in which devices can't obtain SCEP certificates from the NDES server and return error 80094800 and Event ID 31.
ms.date: 05/18/2020
ms.prod-support-area-path: Configure certificates
---
# 0x80094800 error and Event ID 31 when devices fail to receive SCEP certificates

This article fixes an issue in which devices can't obtain Simple Certificate Enrollment Protocol (SCEP) certificates from the Network Device Enrollment Service (NDES) server.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4488562

## Symptoms

Devices can't obtain SCEP certificates from the NDES server. Additionally, the following errors are logged:

- In **Failed Requests** on the Certificate Authority (CA):

    > Request Status Code:  
    > "The requested certificate template is not supported by this CA. 0x80094800 (-2146875392 CERTSRV_E_UNSUPPORTED_CERT_TYPE)"  
    >
    > Request Disposition Message:  
    > "The request was for a certificate template that is not supported by the Active Directory Certificate Services Policy: \<Template name in the client request>"

- In the Application log on the NDES server:

    > Log Name:      Application  
    > Source:        Microsoft-Windows-NetworkDeviceEnrollmentService  
    > Event ID:      31  
    > Level:         **Error**  
    > User:          CONTOSO\SVC_NDES  
    > Computer:      NDES1.contoso.com  
    > Description:  
    > **The Network Device Enrollment Service cannot submit the certificate request (The requested certificate template is not supported by this CA.).  0x80004005**  
    > Event Xml:
    > \<Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event">  
    >  \<EventData Name="**EVENT_MSCEP_FAIL_SUBMIT**">  
    >    \<Data Name="ErrorCode">**The requested certificate template is not supported by this CA.**\</Data>  
    >    \<Data Name="ErrorMessage">**0x80004005**\</Data>  
    >  \</EventData>  
    >\</Event>

## Cause

This issue occurs if the template name on the NDES server doesn't match the name on the CA.

In this situation, you have to use a friendly name instead of the template name for the template.

## Resolution

To fix this issue, follow these steps:

1. Make sure that the registry values in the following registry subkey map to the certificate template name correctly:

   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\MSCEP`

   Registry values:

   - `SignatureTemplate`
   - `EncryptionTemplate`
   - `GeneralPurposeTemplate`

   The following is an example that shows an incorrect value for `SignatureTemplate`:

   :::image type="content" source="./media/devices-receive-scep-certificates-error-0x80094800/value.png" alt-text="Screenshot of incorrect value for SignatureTemplate." border="false":::

2. Restart the Intune Connector Service on the NDES server.
