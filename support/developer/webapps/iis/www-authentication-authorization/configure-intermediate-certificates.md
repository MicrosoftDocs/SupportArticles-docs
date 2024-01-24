---
title: Configure intermediate certificates in Internet Information Services (IIS)
description: Describes how to configure intermediate certificates on a computer that's running IIS for server authentication.
ms.date: 03/27/2020
ms.custom: sap:WWW authentication and authorization
ms.reviewer: Mlaing, lprete
ms.topic: how-to
ms.technology: www-authentication-authorization
---
# Configure intermediate certificates on a computer that's running IIS for server authentication

This article describes how to configure intermediate certificates on a computer that's running IIS for server authentication.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 954755

## Summary

When a client computer tries to establish server-authenticated Secure Sockets Layer (SSL) connections with an IIS Web server, it validates the server certificate chain. To complete this certificate validation successfully, the intermediate certificates in the server certificate chain must be configured correctly on the server. Otherwise, the server authentication may fail. It also applies to any program that uses SSL or Transport Layer Security (TLS) for authentication.

## Impact

Client computers can't connect to the server that's running IIS. Because the servers don't have the intermediate certificates configured correctly, the client computers can't authenticate these servers.

We recommend that you correctly configure the intermediate certificates on the server.

## Technical details

X.509 certificate validation consists of several phases, including certificate path discovery and path validation.

As part of certificate path discovery, the intermediate certificates must be located to build the certificate path up to a trusted root certificate. An intermediate certificate is useful to determine if a certificate was ultimately issued by a valid root certification authority (CA). These certificates can be obtained from the cache or the certificate store on the client computer. Servers can also provide the information to the client computer.

In the SSL negotiation, the server certificate is validated on the client. In this case, the server provides the certificates to the client computer, together with the intermediate issuing certificates that the client computer uses to build the certificate path. The complete certificate chain, except for the root certificate, is sent to the client computer.

A certificate chain of a configured server authentication certificate is built in the local computer context. In this way, IIS determines the set of certificates that it sends to clients for TLS/SSL. To configure the intermediate certificates correctly, add them to the intermediate CA certificate store in the local computer account on the server.

Assume that a server operator installs an SSL certificate together with the relevant issuing CA certificates. When the SSL certificate is renewed later, the server operator must ensure the intermediate issuing certificates are updated at the same time.

## Configure intermediate certificates

1. Open the Certificates Microsoft Management Console (MMC) snap-in. To do it, follow these steps:
    1. At a command prompt, type *Mmc.exe*.
    2. If you aren't running the program as the built-in Administrator, you'll be prompted for permission to run the program. In the **Windows Security** dialog box, click **Allow**.
    3. On the **File** menu, select **Add/Remove Snap-in**.
    4. In the **Add or Remove Snap-ins** dialog box, select the **Certificates** snap-in in the **Available snap-ins** list. Then select **Add** > **OK**.
    5. In the **Certificates snap-in** dialog box, select **Computer account**, and then select **Next**.
    6. In the **Select computer** dialog box, select **Finish**.
    7. In the **Add or Remove Snap-ins** dialog box, select **OK**.
2. To add an intermediate certificate, follow these steps:
    1. In the Certificates MMC snap-in, expand **Certificates**, right-click **Intermediate Certification Authorities**, point to **All Tasks**, and then select **Import**.
    2. In the **Certificate Import Wizard**, select **Next**.
    3. In the **File to Import** page, type the file name of the certificate that you want to import in the **File name** box. Then select **Next**.
    4. Select **Next**, and then complete the **Certificate Import Wizard**.

## References

For more information about how the `CryptoAPI` function builds certificate chains and validates revocation status, visit [Troubleshooting Certificate Status and Revocation](/previous-versions/tn-archive/cc700843(v=technet.10)).
