---
title: Use X509CertificateValidator with WCF
description: This article provides a guide to enable customers to use an X509CertificateValidator while they work with an IIS hosted WCF service and self-signed certificates.
ms.date: 04/17/2020
ms.reviewer: piyushjo, fabianm
ms.topic: how-to
---
# Use a custom X509CertificateValidator with an IIS hosted WCF service and self-signed client certificate

This article describes how to use a custom `X509CertificateValidator` with a Microsoft Internet Information Services (IIS) hosted Windows Communication Foundation (WCF) service and self-signed client certificate.

_Original product version:_ &nbsp; Windows Communication Foundation  
_Original KB number:_ &nbsp; 2480671

## Summary

You configure a WCF service to use a client certificate for Secure Sockets Layer (SSL) authentication. You want to use a custom [X509CertificateValidator](/dotnet/api/system.identitymodel.selectors.x509certificatevalidator) to validate the client certificates in the application-layer (WCF service), not on the Operating System (OS) layer.

WCF 3.5 SP1 doesn't allow usage of custom `X509CertificateValidators` without installing a hotfix at all. In .NET 4 Windows Communication Foundation, a custom `X509CertificateValidator` can be used only when the certificate could be validated successfully in the OS layer - especially it wouldn't be possible to use self-signed client certificates without installing them in the *Trusted Root Certification Authorities* certificate store (can be thousands of different certificates).

## How to do

To enable this scenario, the following steps are necessary:

1. Set registry key `SendTrustedIssuerList` to **0** (DWORD) in registry. See [TLS/SSL Tools and Settings](/previous-versions/windows/it-pro/windows-server-2003/cc776467(v=ws.10)) for some more details.

    By default SChannel (the OS component used to establish SSL connections) is sending a list of trusted issuers to the client during the SSL handshake. It's done to allow the application on the client side to make it easier for the user to choose which certificate should be used. By default SChannel is sending a list of all certificates (actually the thumbprints) installed in the *Trusted Certification Authorities* certificate store. You could reduce this list by specifying a TCL (trusted certificate list). For example, to require clients to use their Smart Card certificates you would create a certificate trust list (CTL) which only contains the root certificate for the Certificate Authority (CA) issuing these smart card certificates. For more information about how to create a CTL, see [Security in Microsoft IIS](https://www.informit.com/articles/article.aspx?p=101750&seqNum=5).

    If you want to allow usage of client certificates, which you can't validate in the server OS (for example self-signed and not installed in *Trusted Root Certification Authorities* store), you need to set the value for `SendTrustedIssuerList` in `HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL` to **0**. In this case, the server doesn't send a list of trusted issuers to the client and the client will allow the user to use any available client certificate.

    > [!WARNING]
    > The `SendTrustedIssuerList` is a machine-wide key. When changing it all applications (Virtual Directories) using client certificate authentication are affected.

    This step is only necessary when it isn't possible to also validate the client certificate in the OS layer.

2. Override `OnGlobalPreBeginRequest` event in the HyperText Transfer Protocol (HTTP) module used by IIS (only necessary when the WCF service is hosted in IIS).

    Only after doing the modifications described in step 1, the client is actually sending a certificate. Before you applied this change, you would see error messages that the client didn't send a certificate (even when you set a certificate on `System.Net.HttpWebRequest` or in Internet Explorer). When the request arrives at the server side, the SChannel component is always doing a certificate validation when establishing the SSL connection. The return code of this certificate validation is passed up the stack to the callers. When your WCF service is hosted in IIS, IIS is checking the return code of the SChannel certificate validation and is terminating the request with error code 403 (Access Denied) in an early stage of the HTTP pipeline. The only way to avoid this behavior in IIS at the moment is to override the `OnGlobalPreBeginRequest` event in the HTTP pipeline. It's one of the few extension points in IIS, which can only be used with native code - no managed (.NET) code. The documentation for `OnGlobalPreBeginRequest` can be found on [CGlobalModule::OnGlobalPreBeginRequest Method](/iis/web-development-reference/native-code-api-reference/cglobalmodule-onglobalprebeginrequest-method).

    This step is only necessary when it isn't possible to also validate the client certificate in the OS layer.

3. Install WCF QFE to specify custom `X509CertificateValidator`.

    WCF originally used the SChannel result code to validate client certificates, too. If the return code was **0** (successful), authentication was allowed and a hard-coded [X509CertificateValidator](/dotnet/api/system.identitymodel.selectors.x509certificatevalidator) was used with validation mode set to `X509CertificateValidationMode.None` ([X509CertificateValidationMode Enum](/dotnet/api/system.servicemodel.security.x509certificatevalidationmode)). Which means it wasn't possible to use any other WCF `X509CertificateValidationMode` like `Peer`, `Chain`, or `Custom` for client certificates when using security mode Transport.

    In .NET 4, this issue was fixed and the fix was also backported .NET 3.5 SP1. After applying the hotfix mentioned below, you're able to override the validation behavior only when specifying `X509CertificateValidationMode.Custom`. If you want to use something like `X509CertificateValidationMode.PeerTrust` or `PeerOrChainTrust`, you will need to create a custom, which is reusing the default validator for the targeted validation mode. This limitation is applied to avoid breaking changes. The configuration for a custom `X509CertificateValidator` would look like:

    ```xml
    <serviceCredentials>
        <clientCertificate>
            <authentication certificateValidationMode="Custom" customCertificateValidatorType="Samples.MyCertificateValidator, Samples" />
        </clientCertificate>
    </serviceCredentials>
    ```

    This step is only necessary when using .NET Framework 3.5 SP1 (not for .NET 4).
