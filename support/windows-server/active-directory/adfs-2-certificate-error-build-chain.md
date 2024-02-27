---
title: ADFS 2.0 certificate error
description: Discusses that a certificate-related change in AD FS 2.0 causes certificate, SSL, and trust errors and triggers an Event 133 error. Provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-federation-services-ad-fs, csstroubleshoot
---
# ADFS 2.0 certificate error: An error occurred during an attempt to build the certificate chain

This article helps to fix ADFS 2.0 certificate error during an attempt to build the certificate chain.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3044974

## Summary

Most Active Directory Federated Services (AD FS) 2.0 problems belong to one of the following main categories. This article contains step-by-step instructions to troubleshoot certificate problems.  

- [Connectivity problems (KB 3044971)](https://support.microsoft.com/help/3044971)  
- [ADFS service problems (KB 3044973)](https://support.microsoft.com/help/3044973)  
- [Certificate problems (KB 3044974)](https://support.microsoft.com/help/3044974)  
- [Authentication problems (KB 3044976)](https://support.microsoft.com/help/3044976)  
- [Claim rules problems (KB 3044977)](https://support.microsoft.com/help/3044977)  

## Symptoms

- This issue starts after an AD FS certificate is changed or replaced.
- The program stops accepting the token that is issued by AD FS.
- AD FS returns one of the following errors when it receives a signed request or response, or if it tries to encrypt a token that is to be issued to a Rely Party Application:  

  - Event ID 316  
        An error occurred during an attempt to build the certificate chain for the relying party trust signing certificate.
  - Event ID 315  
        An error occurred during an attempt to build the certificate chain for the claims provider trust signing certificate.
  - Event ID 317  
        An error occurred during an attempt to build the certificate chain for the relying party trust encryption certificate.  

- The following certificate-related event IDs are logged in AD FS event log:  

  - Event ID 133  
    Description: During processing of the Federation Service configuration, the element 'serviceIdentityToken' was found to have invalid data. The private key for the certificate that was configured couldn't be accessed. The following are the values of the certificate:Element: serviceIdentityToken
  - Event ID 385  
    AD FS 2.0 detected that one or more certificates in the AD FS 2.0 configuration database need to be updated manually.
  - Event ID 381  
    An error occurred during an attempt to build the certificate chain for configuration certificate.
  - Event ID 102  
    There was an error in enabling endpoints of the Federation Service.  
    Additional Data  
    Exception details:  
    System.ArgumentNullException: Value cannot be null.  
    Parameter name: certificate  
  - Event ID: 387  
    AD FS 2.0 detected that one or more of the certificates specified in the Federation Service were not accessible to the service account used by the AD FS 2.0 Windows Service.  
    User Action: Ensure that the AD FS service account has read permissions on the certificate private keys.  
    Additional Details:  
    Token-signing certificate with thumbprint 'xxxxxxxx'

## Resolution

To resolve this problem, follow these steps in the order given. These steps will help you to determine the cause of the problem. Make sure that you check whether the problem is resolved after every step.

### Step 1: Check for private keys  

Check whether all AD FS certificates (Service communications, token-decrypting, and token-signing) are valid and have a private key associated with them. Also, make sure that the certificate is within its validity period.

:::image type="content" source="media/adfs-2-certificate-error-build-chain/check-the-certificate.png" alt-text="Screenshot of the Certificate window showing the validity period.":::

#### Where to find the certificates

- For Service communications certificates:  

    1. On the AD FS server, click **Start**, click Run, type MMC.exe, and then press Enter.
    2. In the **Add/Remove Snap-in** dialog box, click **OK**.
    3. On the **Certificates snap-in** screen, click the **Computer account** certificate store.  

        :::image type="content" source="media/adfs-2-certificate-error-build-chain/open-certificate-store.png" alt-text="Screenshot of the Certificate snap-in window with Computer account selected.":::

    4. To view the properties of the Service Communications certificate, expand **Certificate (Local Computer)**, expand **Personal**, and then click **Certificates**.  

- For token-signing and token-decrypting certificates:  

  - If the certificates are self-signed certificates that are added by ADFS server by default, Logon interactively on the ADFS server using the ADFS Service account, and check the user's certificate store (certmgr.msc).
  - If the certificated are from a certificate authority (CA), configured by ADFS admins post disabling the AutoCertificateRollover, then you should be able to find it under the ADFS server's certificate store.

### Step 2: Make sure that the certificates are not using a Cryptographic Next Generation (CNG) private key  

Certificates that use the CNG private key are not supported for Token Signing and Token Decryption. If AD FS generated the self-signed certificate, that certificate does not use CNG. For a certificate that is issued by a CA, make sure that the certificate is not CNG-based.

If the CA template is using any of the listed cryptographic service providers, the certificate that is issued by this CA is not supported by the AD FS server.

### Step 3: Check whether SSL binding of the Service communication certificates in IIS is bound to port 443

#### How to check and fix

1. Start IIS Manager. To do it, click **Start**, click **Administrative Tools**, and then click **Internet Information Services (IIS) Manager**.
2. Click the server name, and then expand the Sites folder.
3. Locate your website (typically, it is known as "Default Web Site"), and then select it.
4. On the **Actions** menu on the right side, click **Bindings**. Make sure that the https biding type is bound to port 443. Otherwise, click **Edit** to change the port.

    :::image type="content" source="media/adfs-2-certificate-error-build-chain/site-bindings.png" alt-text="Screenshot of the Site Bindings window which shows that the https biding type is bound to port 443.":::

### Step 4: Make sure that service communication certificate is valid, trusted, and passes a revocation check  

#### How to check  

1. Open AD FS 2.0 Management.
2. Expand **Service**, click **Certificate**, right-click the service communications certificate, and then click **View certificate**.
3. In the details pane, click **Copy to file**, and save the file as Filename.cer.
4. At a command prompt, run the following command to determine whether the service communication certificate is valid:

    ```console
    Run 'Certutil -verify -urlfetch certificate.CER > cert_cerification.txt'
    ```  

5. Open the output file that is created above "cert_verification.txt."
6. Go to the end of the file, and check whether it includes the following for a successful revocation test:  

    >Leaf certificate revocation check passed  
    CertUtil: -verify command completed successfully.

7. If the file indicates that the revocation checks failed or that the revocation server was offline, check the log to determine which certificate in the certificate chain could not be verified.

    Check whether any AIA or CDP path failed. In a scenario in which multiple paths are specified under one type of file, both paths should be marked as verified.

   >---------------- Certificate AIA ----------------  
    Verified "Certificate (0)" Time: 0  
    [0.0] `http://www.contoso.com/pki/mswww(6).crt`  
    >
    >Failed "AIA" Time: 0  
    Error retrieving URL: The server name or address could not be resolved 0x80072ee7 (WIN32: 12007)  
    `http://corppki/aia/mswww(6).crt`  
    >
    >---------------- Certificate CDP ----------------  
    Verified "Base CRL (5a)" Time: 0  
    [0.0] `http://mscrl.contoso.com/pki/crl/mswww(6).crl`  
    >
    >Verified "Base CRL (5a)" Time: 0  
    [1.0] `http://crl.contoso.com/pki/crl/mswww(6).crl`
    >
    >Failed "CDP" Time: 0  
    Error retrieving URL: The server name or address could not be resolved 0x80072ee7 (WIN32: 12007)  
    `http://corppki/crl/mswww(6).crl`  

    Collecting a network trace may help if any of the AIA or CDP or OCSP path is unavailable.

8. If the log entry indicates that the certificate is revoked, you must request another certificate that is valid and is not revoked.

### Step 5: Make sure that the ADFS service accounts has the Read permission for the private key of the ADFS certificates

#### How to check the read permission

1. On the AD FS server, click **Start**, click **Run**, enter MMC.exe, and then press Enter.
2. In the **Add/Remove Snap-in** dialog box, click **OK**.
3. In the Console Root window, click **Certificates (Local Computer)** to view the computer certificate stores.
4. Right-click the AD FS service, point to **All Tasks**, and then click **Manage private keys**.
5. Check whether the AD FS account has the Read permission.

    :::image type="content" source="media/adfs-2-certificate-error-build-chain/ad-fs-account-permission.png" alt-text="Screenshot of the permission window which shows that the AD FS account has the Read permission.":::

### Step 6: Check whether ADFS AutoCertificateRollover feature is enabled for token-signing and token-decrypting certificates

#### How to check ADFS AutoCertificateRollover feature

- If AutoCertificateRollover is disabled, the token-signing and token-decrypting certificates will not be renewed automatically. Before these certificates expire, make sure that a new certificate is added to the AD FS configuration. Otherwise, the relying party will not trust the token that is issued by the AD FS server.
- If AutoCertificateRollover is enabled, new token-signing and token-decrypting certificates will be generated 20 days before the expiration of the old certificates. The new certificates will obtain Primary status five days after they are generated. After the new set of certificates is generated, make sure that the same information is updated on the relying party and claim provider trusts.  

For more information about the AD FS AutoCertificateRollover feature, see the following TechNet topics:

[AD FS 2.0: How to Enable and Immediately Use AutoCertificateRollover](/archive/technet-wiki/1424.ad-fs-2-0-how-to-enable-and-immediately-use-autocertificaterollover)  

### Step 7: Add the federation service name in the certificate SAN  

If the certificate has the SAN (Subject Alternative Name) attribute enabled, the federation service name should also be added in the SAN of the certificate, together with other names. For more information, see [SSL Certificate Requirements](https://msdn.microsoft.com/library/azure/dn832693.aspx).

### Step 8: Check service account permissions for the (CN=\<GUID>,CN=ADFS,CN=Microsoft,CN=Program Data,DC=\<Domain>,DC=\<COM>) certificate sharing container  

#### How to check and fix service account permission

1. On a domain controller (DC), open Adsiedit.msc.
2. Connect to the Default naming context.
3. Locate **CN=\<GUID>,CN=ADFS,CN=Microsoft,CN=Program Data,DC=\<Domain>,DC=\<COM>**.

    > [!NOTE]
    > In this container name, the parameters in brackets represent the actual values. An example of a GUID is "62b8a5cb-5d16-4b13-b616-06caea706ada."  

4. Right-click the GUID, and then click **Properties**. If there is more than one GUID, follow these steps:  

    1. Start Windows PowerShell on the server that is running the AD FS service.
    2. Run the following command:  

        ```powershell
        Add-PSSnapin microsoft.adfs.powershellGet-ADFSProperties
        ```  

    3. Locate the GUID of the running AD FS service under **CertificateShareingContainer**.  

5. Make sure that the ADFS service account has the Read, Write, and "Create All child objects" permissions granted to this object and to all descendent object.

### Step 9: Check claims providers and relying parties for certificate updates

If the token-signing and token-decrypting certificates have changed, make sure that the claims providers and relying parties are updated to have the new certificates. If the claims providers and relying parties are not updated, they cannot trust the AD FS service.  

- After the change is made, share the Federationmetadata.xml with the claims provider and the relying party.
- The claims provider and the relying party might require only that the new token-signing and token-decrypting certificates (without a private key) are updated in the federation trust on their end.

### Step 10: Check for a signed request and response from the claims provider or relying party

The signed request and response might be received by the AD FS server from the claims provider or the relying party. In this scenario, the AD FS server may check the validity of the certificate that is used for signing and fail. AD FS also checks the validity of the certificate that is related to the relying party that is used to send an encrypted token to the AD FS server.

#### Scenarios

- AD FS 2.0 receives a signed SAML-P request that is sent by a relying party.

    > [!NOTE]
    > Requiring signing of sign-in requests is a configurable option. To set this requirement for a relying party trust, use the **RequireSignedSamlRequests** parameter together with the Set-ADFSRelyingPartyTrust cmdlet.
- AD FS 2.0 receives a signed SAML sign-out request from the relying party. In this scenario, the signout request must be signed.
- AD FS 2.0 receives a sign-out request from a claims provider, and encrypts a sign-out request for the relying party. In this scenario, the claims provider initiates the sign-out.
- AD FS 2.0 issues an encrypted token for a relying party.
- AD FS 2.0 receives an issued token from a claims provider.
- AD FS 2.0 receives a signed SAML sign-out request from a claims provider. In this scenario, the signout request must be signed.

#### What to check to resolve the issue

- Make sure that the claims provider trust's signing certificate is valid and has not been revoked.
- Make sure that AD FS 2.0 can access the certificate revocation list if the revocation setting doesn't specify "none" or a "cache only" setting.

    > [!NOTE]
    > You can use Windows PowerShell cmdlets for AD FS 2.0 to configure the following revocation settings:  
    >
    > - **SigningCertificateRevocationCheck** parameter of the Set-ADFSClaimsProviderTrust or Set-ADFSRelyingPartyTrust cmdlet
    > - **EncryptionCertificateRevocationCheck** parameter of the Set-ADFSRelyingPartyTrust or Set-ADFSClaimsProviderTrust cmdlet  

For more information, see [Troubleshooting certificate problems with AD FS 2.0.](https://technet.microsoft.com/library/adfs2-troubleshooting-certificate-problems%28v=ws.10%29.aspx)
