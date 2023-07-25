---
title: Error 0x80090022 NTE_SILENT_CONTEXT when CEP/CES autoenrollment using KBR fails
description: Helps resolve the issue in which Certificate Enrollment Policy Web Service (CEP) and Certificate Enrollment Web Service (CES) autoenrollment using key-based renewal (KBR) fails on non-domain-joined clients, and you receive error 0x80090022 NTE_SILENT_CONTEXT.
ms.date: 07/03/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, milanmil, v-lianna
ms.custom: sap:certificates-and-public-key-infrastructure-pki, csstroubleshoot
ms.technology: windows-server-security
---
# Error 0x80090022 NTE_SILENT_CONTEXT when CEP/CES autoenrollment using KBR fails on non-domain-joined clients

This article helps resolve the issue in which Certificate Enrollment Policy Web Service (CEP) and Certificate Enrollment Web Service (CES) autoenrollment using key-based renewal (KBR) fails on non-domain-joined clients, and you receive error "0x80090022 NTE_SILENT_CONTEXT."

You configure the CEP/CES on non-domain-joined clients for Username Password initial enrollment, and certificate KBR. For more information about the configuration, see [Configuring Certificate Enrollment Web Service for certificate key-based renewal on a custom port](/windows-server/identity/solution-guides/certificate-enrollment-certificate-key-based-renewal).

Initial certificate enrollment using *certlm.msc* and authenticating with the username and password of the AD account works, but the KBR renewal fails. The renewal fails when it's triggered using autoenrollment and when it's executed manually using the `certreq -machine -q -enroll -cert <thumbprint> renew` cmdlet.

During the KBR certificate renewal, you received error "0x80090022 (-2146893790 NTE_SILENT_CONTEXT)" from the *CertEnroll.log* file:

```output
2032.4155.0:<DateTime>: 0x0 (WIN32: 0): https://ws2019cepces.contoso.lab/KeyBasedRenewal_ADPolicyProvider_CEP_Certificate/service.svc/CEP
…
https://ws2019cepces.contoso.lab/KeyBasedRenewal_ADPolicyProvider_CEP_UsernamePassword/service.svc/CEP
…
3002.676.0:<DateTime>: 0x803d0013 (-2143485933 WS_E_ENDPOINT_FAULT_RECEIVED)
3002.690.0:<DateTime>: 0x803d0013 (-2143485933 WS_E_ENDPOINT_FAULT_RECEIVED): A message containing a fault was received from the remote endpoint. 0x803d0013 (-2143485933 WS_E_ENDPOINT_FAULT_RECEIVED)
3002.744.0:<DateTime>: 0x803d0013 (-2143485933 WS_E_ENDPOINT_FAULT_RECEIVED): https://ws2019cepces.contoso.lab/KeyBasedRenewal_ADPolicyProvider_CEP_Certificate/service.svc/CEP
…
2032.1371.0:<DateTime>: 0x80090022 (-2146893790 NTE_SILENT_CONTEXT)
450.201.0:<DateTime>: 0x1 (WIN32: 1 ERROR_INVALID_FUNCTION): Error
450.202.0:<DateTime>: 0x825a0044 (-2108030908)
450.219.0:<DateTime>: 0x0 (WIN32: 0): Local system
…
450.219.0:<DateTime>: 0x2 (WIN32: 2 ERROR_FILE_NOT_FOUND): Provider could not perform the action since the context was acquired as silent. 0x80090022 (-2146893790 NTE_SILENT_CONTEXT)
```

Here are the possible causes of the issue:

- Misleading error "0x80090022 NTE_SILENT_CONTEXT" is reported on the client machine where CEP/CES KBR renewal takes place.
- Unsupported validity or renewal period in certificate templates designed for client certificates.

## Misleading error "0x80090022 NTE_SILENT_CONTEXT" is reported on the client machine where CEP/CES KBR renewal takes place

The error reported in the certificate enrollment user interface is "0x80090022 NTE_SILENT_CONTEXT." However, the relevant error is "0x803d0013 WS_E_ENDPOINT_FAULT_RECEIVED" that was previously reported in the *CertEnroll.log* file.

The confusion is caused by the [higher priority](/windows-server/identity/solution-guides/certificate-enrollment-certificate-key-based-renewal#configure-the-client-computer) of the certificate_CES endpoint. The certificate_CES endpoint executes first (the certificate_CES endpoint must work in KBR renewal scenario) and after that the initial username_password_CES takes place as a fallback. The username_password_CES endpoint requires the user input, which isn't expected to work. Then the error "0x80090022 NTE_SILENT_CONTEXT" occurs.

It means, the error "0x803d0013 WS_E_ENDPOINT_FAULT_RECEIVED" is the relevant error that needs to be further investigated.

Here are the possible causes for error "0x803d0013 WS_E_ENDPOINT_FAULT_RECEIVED":

- Ports for Remote Procedure Call (RPC) or Distributed Component Object Model (DCOM) connectivity are blocked between CES and the certification authority (CA) server.
- Ports for RPC or DCOM connectivity are blocked between the CA server and domain controllers.
- There are configuration issues with CEP/CES applications that are hosted by Internet Information Services (IIS).

    The configuration issues can be resolved by adding `<serviceHostingEnvironment multipleSiteBindingsEnabled="true"/>` to the `<system.serviceModel>` section of the *Web.config* file.

## Unsupported validity period or renewal period in the certificate template designed for client certificates

For the certificate autoenrollment to work properly, make sure to set the certificate template validity period to at least five days and the renewal period to at least one day.
