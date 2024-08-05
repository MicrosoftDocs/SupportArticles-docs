---
title: Intune iOS SCEP failure - no GetCACaps request generated in IIS logs
description: Troubleshoot SCEP/NDES failures on iOS devices when the IIS logs show that no GetCACaps request is generated.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Configure Devices - Windows\SCEP Certificates
ms.reviewer: kaushika
---
# iOS SCEP failure and no GetCACaps request is generated

This article gives troubleshooting steps to help resolve NDES/SCEP issues on iOS devices where IIS logs show that no **GetCACaps** request is generated.

## Symptoms

When troubleshooting NDES/SCEP issues, you check the IIS logs and see good (200 response) **GetCACerts** entries from iOS devices, but no **GetCACaps** request is generated.  In the device console logs, you also find the following errors:

> Desc   : The Registration Authority...s response is invalid.
> May 23 14:15:36 -iPhone profiled[150] &lt;Error&gt;:  SecTrustEvaluate  [leaf AnchorTrusted]
> May 23 14:15:42 -iPhone profiled[150] &lt;Notice&gt;: (Error) MC: Cannot retrieve SCEP identity: NSError:
> Desc   : The Registration Authority...s response is invalid

If you open the browser on the device and go to `https://<NDESurl>/?operation=GetCACaps` you may see an SSL failure. Most browsers will initially say something about the SSL cert is not trusted. In "More Details" you will see the error **ERROR_WINHTTP_SECURE_FAILURE**.

## Causes

This issue is typically caused by one of these two scenarios:

- The certificate uploaded to the Trusted Root profile in Intune that is linked to the SCEP profile is using a *different* certificate than the trusted root certificate installed on the NDES server. In other words, the root certificate is not really a root certificate, but rather is an intermediate certificate. This is the most common cause.

     > [!NOTE]
     > Android devices have a similar issue, but the error message is different.

- The signature algorithm of the Root or Intermediate certificate is not supported by the device or OS. Root or Intermediate Issuing CA Certs using are using Signature Algorithm RSASSA-PSS or SHA-1.

## Solution

Reissue new Root and Intermediate certificates with a supported (more extended) Signature algorithm, such as SHA256RSA.

> [!NOTE]
> You must redeploy the new root/intermediate certificates on the NDES server and make sure that any of the NDES-related certs are referencing the new trusted certs.
