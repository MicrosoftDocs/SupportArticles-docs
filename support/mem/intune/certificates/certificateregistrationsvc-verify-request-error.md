---
title: Troubleshoot HTTP 500 error on SCEP requests in Intune
description: Fixes an issue in which the certificate registration point (CRP) application pool returns HTTP 500 error messages and the request can't be verified.
ms.date: 09/09/2021
search.appverid: MET150
ms.custom: sap:Device protection
ms.reviewer: kaushika, joelste, intunecic, alra
---
# HTTP 500 errors on CertificateRegistrationSvc verify request in Intune

This article fixes errors when you configure and assign a Simple Certificate Enrollment Protocol (SCEP) certificate profile in Microsoft Intune.

## Symptoms

After you configure and assign a SCEP certificate profile in Intune, you experience the following problems:

- Targeted devices do not receive a certificate.
- The certificate profile shows a status of **Failed** in the Microsoft Intune admin center.
- Incoming SCEP requests generate **HTTP 500** error entries in the IIS logs on the computer that's running the Microsoft Intune NDES Connector. These entries resemble the following:

    > *DateTime* *IPAddress* GET /certsrv/mscep/mscep.dll operation=GetCACert&message=SCEP%20Authority 443 -IPAddress profiled/1.0+CFNetwork/975.0.3+Darwin/18.2.0 - 200 0 0 0  
    > *DateTime* *IPAddress* GET /certsrv/mscep/mscep.dll operation=GetCACaps&message=SCEP%20Authority 443 -IPAddressprofiled/1.0+CFNetwork/975.0.3+Darwin/18.2.0 - 200 0 0 15  
    > *DateTime* *IPAddress* POST /CertificateRegistrationSvc/Certificate/VerifyRequest - 443 -IPAddressNDES_Plugin - 500 0 0 359  
    > *DateTime* *IPAddress* GET /certsrv/mscep/mscep.dll operation=GetCACert&message=SCEP%20Authority 443 -IPAddressprofiled/1.0+CFNetwork/975.0.3+Darwin/18.2.0 - 200 0 0 189  
    > *DateTime* *IPAddress* GET /certsrv/mscep/mscep.dll operation=GetCACaps&message=SCEP%20Authority 443 -IPAddressprofiled/1.0+CFNetwork/975.0.3+Darwin/18.2.0 - 200 0 0 15  
    > *DateTime* *IPAddress* POST /CertificateRegistrationSvc/Certificate/VerifyRequest - 443 -IPAddressNDES_Plugin - 500 0 0 375

    > [!NOTE]
    > By default, the IIS logs are located at `\inetpub\logs\LogFiles\W3SVC1\`.

- The System event log on the computer that's running the Microsoft Intune NDES Connector contains an Event ID 5009 warning that includes the following:

    > A process serving application pool 'SCEP' terminated unexpectedly. The process id was '\<ProcessID\>'. The process exit code was '0x0000374'.

- The Application event Log on the computer that's running the Microsoft Intune NDES Connector contains an Event ID 1310 warning that includes error code 3007 and the following:

    > A compilation error has occurred.

## Cause

This issue can occur if the **Write** permission is missing for the account that's used to run the `CertificateRegistrationSvc` application pool (for example, the Network Service account) in the `C:\Windows\Temp` folder.

> [!NOTE]
> Because the verify requests are processed by the Intune cloud service, this issue may occur only when using the legacy certificate connector instead of the new connector.

:::image type="content" source="media/certificateregistrationsvc-verify-request-error/event-1310.png" alt-text="Screenshot of Event ID 1310 warning in Application Event Log.":::

## Resolution

To fix this issue, add the Network Service account that has the **Write** permission to the `C:\Windows\Temp` folder.

Additionally, make sure that there are no other policies that will remove the **Write** permission after it's added. Otherwise, the problem will recur.
