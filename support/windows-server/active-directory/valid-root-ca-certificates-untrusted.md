---
title: Valid root CA certificates are untrusted
description: Root CA certificates distributed using GPO might appear sporadically as untrusted. This article provides a workaround for this issue.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, milanmil, philh, herbertm
ms.custom: sap:active-directory-certificate-services, csstroubleshoot
---
# Valid root CA certificates distributed using GPO might intermittently appear as untrusted

This article provides a workaround for an issue where valid root CA certificates that are distributed by using GPO appear as untrusted.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4560600

## Symptoms

> [!IMPORTANT]
> Untrusted root Certificate Authority (CA) certificate problems can be caused by numerous PKI configuration issues. This article illustrates only one of the possible causes of untrusted root CA certificate.

Various applications that use certificates and Public Key Infrastructure (PKI) might experience intermittent problems, such as connectivity errors, once or twice per day/week. These problems occur because of failed verification of end entity certificate. Affected applications might return different connectivity errors, but they will all have untrusted root certificate errors in common. Below is an example of such an error:

|Hex|Decimal|Symbolic|Text version|
|---|---|---|---|
|0x800b0109|-2146762487|(CERT_E_UNTRUSTEDROOT)|A certificate chain processed, but terminated in a root certificate|

Any PKI-enabled application that uses [CryptoAPI System Architecture](/windows/win32/seccrypto/cryptoapi-system-architecture) can be affected with an intermittent loss of connectivity, or a failure in PKI/Certificate dependent functionality. As of April 2020, the list of applications known to be affected by this issue includes, but aren't likely limited to:

- Citrix
- Remote Desktop Service (RDS)
- Skype
- Web browsers

Administrators can identify and troubleshoot untrusted root CA certificate problems by inspecting the **CAPI2 Log**.

Focus your troubleshooting efforts on **Build Chain/Verify Chain Policy** errors within the CAPI2 log containing the following signatures. For example:

> Error *\<DateTime>* CAPI2 11 Build Chain  
> Error *\<DateTime>* CAPI2 30 Verify Chain Policy
>
> Result A certificate chain processed, but terminated in a root certificate which is not trusted by the trust provider.  
> [value] 800b0109

## Cause

Untrusted root CA certificate problems might occur if the root CA certificate is distributed using the following Group Policy (GP):

**Computer Configuration** > **Windows Settings** > **Security Settings** > **Public Key Policies** > **Trusted Root Certification Authorities**

### Root cause details

When distributing the root CA certificate using GPO, the contents of `HKLM\SOFTWARE\Policies\Microsoft\SystemCertificates\Root\Certificates` will be deleted and written again. This deletion is by design, as it's how the GP applies registry changes.

Changes in the area of the Windows registry that's reserved for root CA certificates will notify the [Crypto API component](/windows/win32/api/wincrypt/nf-wincrypt-certcontrolstore) of the client application. And the application will start synchronizing with the registry changes. The synchronization is how the applications are kept up-to-date and made aware of the most current list of valid root CA certificates.

In some scenarios, Group Policy processing will take longer. For example, many root CA certificates are distributed via GPO (similar with many **Firewall** or **`Applocker`** policies). In these scenarios, the application might not receive the complete list of trusted root CA certificates.

Because of this reason, end entity certificates that chain to those missing root CA certificates will be rendered as untrusted. And various certificate-related problems will start to occur. This problem is intermittent, and can be temporarily resolved by reenforcing GPO processing or reboot.

If the root CA certificate is published using alternative methods, the problems might not occur, due to the afore-mentioned situation. 

## Workaround

Microsoft is aware of this issue and is working to improve the certificate and Crypto API experience in a future version of Windows.

To address this issue, avoid distributing the root CA certificate using GPO. It might include targeting the registry location (such as `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SystemCertificates\Root\Certificates`) to deliver the root CA certificate to the client.

When storing root CA certificate in a different, physical, root CA certificate store, the problem should be resolved.

### Examples of alternative methods for publishing root CA certificates

**Method 1:**  Use the command-line tool `certutil` and root the CA certificate stored in the file *rootca.cer*:

```console
certutil -addstore root c:\tmp\rootca.cer
```  

> [!NOTE]
> This command can be executed only by local admins, and it will affect only single machine.

**Method 2:** Start certlm.msc (the certificates management console for local machine) and import the root CA certificate in the **Registry** physical store.

:::image type="content" source="media/valid-root-ca-certificates-untrusted/root-ca-certificate-in-registry.png" alt-text="Screenshot of the certificates management console in which Certificates under Registry is selected.":::

> [!NOTE]
> The certlm.msc console can be started only by local administrators. Also, the import will affect only single machine.

**Method 3:** Use GPO preferences to publish the root CA certificate as described in [Group Policy Preferences](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn581922%28v=ws.11%29)

To publish the root CA certificate, follow these steps:

1. Manually import the root certificate on a machine by using the `certutil -addstore root c:\tmp\rootca.cer` command (see Method 1).
2. Open GPMC.msc on the machine that you've imported the root certificate.
3. Edit the GPO that you would like to use to deploy the registry settings in the following way:
    1. Edit the **Computer Configuration > Group Policy Preferences > Windows Settings > Registry >** path to the root certificate.
    2. Add the root certificate to the GPO as presented in the following screenshot.
4. Deploy the new GPO to the machines where the root certificate needs to be published.

    :::image type="content" source="media/valid-root-ca-certificates-untrusted/deploy-gpo-to-target-machine.png" alt-text="Screenshot of the Group Policy Management Editor window with the root certificate selected.":::

Any other method, tool, or client management solution that distributes root CA certificates by writing them into the location `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SystemCertificates\ROOT\Certificates` will work.

## References

- [Certutil tool](/windows-server/administration/windows-commands/certutil)
- [Certificate Stores](/windows-hardware/drivers/install/local-machine-and-current-user-certificate-stores)
- [System Store Locations](/windows/win32/seccrypto/system-store-locations)
- [Group Policy Preferences](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn581922(v=ws.11))
- [CertControlStore Crypto API](/windows/win32/api/wincrypt/nf-wincrypt-certcontrolstore)
