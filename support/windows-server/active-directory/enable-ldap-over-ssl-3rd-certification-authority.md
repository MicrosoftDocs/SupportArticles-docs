---
title: Enable Lightweight Directory Access Protocol (LDAP) over Secure Sockets Layer (SSL)
description: Describes how to enable LDAP over SSL with a third-party certification authority.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Active Directory\LDAP configuration and interoperability, csstroubleshoot
---
# Enable LDAP over SSL with a third-party certification authority

This article describes how to enable Lightweight Directory Access Protocol (LDAP) over Secure Sockets Layer (SSL) with a third-party certification authority.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 321051

## Summary

The LDAP is used to read from and write to Active Directory. By default, LDAP traffic is transmitted unsecured. You can make LDAP traffic confidential and secure by using SSL/Transport Layer Security (TLS) technology. You can enable LDAP over SSL (LDAPS) by installing a properly formatted certificate from either a Microsoft certification authority (CA) or a non-Microsoft CA according to the guidelines in this article.

There's no user interface for configuring LDAPS. Installing a valid certificate on a domain controller permits the LDAP service to listen for, and automatically accept, SSL connections for both LDAP and global catalog traffic.

## Requirements for an LDAPS certificate

To enable LDAPS, you must install a certificate that meets the following requirements:

- The LDAPS certificate is located in the Local Computer's Personal certificate store (programmatically known as the computer's MY certificate store).  
  > [!NOTE]
  > If there is a certificate in the NT Directory Services (NTDS) store, DC use the certificate in the NTDS store instead.

- A private key that matches the certificate is present in the Local Computer's store and is correctly associated with the certificate. The private key must *not* have strong private key protection enabled.

- The Enhanced Key Usage extension includes the Server Authentication (1.3.6.1.5.5.7.3.1) object identifier (also known as OID).

- The Active Directory fully qualified domain name of the domain controller (for example, dc01.contoso.com) must appear in one of the following places:
  
  - The Common Name (CN) in the Subject field.
  - DNS entry in the Subject Alternative Name extension.

- The certificate was issued by a CA that the domain controller and the LDAPS clients trust. Trust is established by configuring the clients and the server to trust the root CA to which the issuing CA chains.

- Use the Schannel cryptographic service provider (CSP) to generate the key.

## Create the certificate request

Any utility or application that creates a valid PKCS #10 request can be used to form the SSL certificate request. Use Certreq to form the request.

Certreq.exe requires a text instruction file to generate an appropriate X.509 certificate request for a domain controller. You can create this file by using your preferred ASCII text editor. Save the file as an .inf file to any folder on your hard drive.

To request a Server Authentication certificate that is suitable for LDAPS, follow these steps:

1. Create the .inf file. Following is an example .inf file that can be used to create the certificate request.

    > ;----------------- request.inf -----------------  
    >
    > [Version]
    >
    > Signature="$Windows NT$
    >
    > [NewRequest]
    >
    > Subject = "CN=\<DC fqdn>" ; replace with the FQDN of the DC  
    KeySpec = 1  
    KeyLength = 1024  
    ; Can be 1024, 2048, 4096, 8192, or 16384.  
    ; Larger key sizes are more secure, but have  
    ; a greater impact on performance.  
    Exportable = TRUE  
    MachineKeySet = TRUE  
    SMIME = False  
    PrivateKeyArchive = FALSE  
    UserProtected = FALSE  
    UseExistingKeySet = FALSE  
    ProviderName = "Microsoft RSA SChannel Cryptographic Provider"  
    ProviderType = 12  
    RequestType = PKCS10  
    KeyUsage = 0xa0
    >
    > [EnhancedKeyUsageExtension]
    >
    > OID=1.3.6.1.5.5.7.3.1 ; this is for Server Authentication
    >
    > ;-----------------------------------------------

    Cut and paste the sample file into a new text file named *Request.inf*. Provide the fully qualified DNS name of the domain controller in the request.

    Some third-party certification authorities may require additional information in the Subject parameter. Such information includes an e-mail address (E), organizational unit (OU), organization (O), locality, or city (L), state or province (S), and country or region (C). You can append this information to the Subject name (CN) in the Request.inf file. For example:

    > Subject="E=admin@contoso.com, CN=\<DC fqdn\>, OU=Servers, O=Contoso, L=Redmond, S=Washington, C=US."

2. Create the request file by running the following command at the command prompt:

    ```console
    certreq -new request.inf request.req
    ```

    A new file called *Request.req* is created. It's the base64-encoded request file.

3. Submit the request to a CA. You can submit the request to a Microsoft CA or to a third-party CA.

4. Retrieve the certificate that's issued, and then save the certificate as Certnew.cer in the same folder as the request file by following these steps:

    1. Create a new file called *Certnew.cer*.
    2. Open the file in Notepad, paste the encoded certificate into the file, and then save the file.

    > [!NOTE]
    > The saved certificate must be encoded as base64. Some third-party CAs return the issued certificate to the requestor as base64-encoded text in an e-mail message.

5. Accept the issued certificate by running the following command at the command prompt:

    ```console
    certreq -accept certnew.cer
    ```

6. Verify that the certificate is installed in the computer's Personal store by following these steps:

    1. Start Microsoft Management Console (MMC).
    2. Add the Certificates snap-in that manages certificates on the local computer.
    3. Expand **Certificates (Local Computer)**, expand **Personal**, and then expand **Certificates**. A new certificate should exist in the Personal store. In the **Certificate Properties** dialog box, the intended purpose displayed is **Server Authentication**. This certificate is issued to the computer's fully qualified host name.

7. Restart the domain controller.

For more information about creating the certificate request, see the following Advanced Certificate Enrollment and Management white paper. To view this white paper, see [Advanced Certificate Enrollment and Management](/previous-versions/windows/it-pro/windows-server-2003/cc782583(v=ws.10)).

## Verify an LDAPS connection

After a certificate is installed, follow these steps to verify that LDAPS is enabled:

1. Start the Active Directory Administration Tool (Ldp.exe).
2. On the **Connection** menu, click **Connect**.
3. Type the name of the domain controller to which you want to connect.
4. Type *636* as the port number.
5. Click **OK**.

    RootDSE information should print in the right pane, indicating a successful connection.

## Possible issues

- Start TLS extended request

    LDAPS communication occurs over port TCP 636. LDAPS communication to a global catalog server occurs over TCP 3269. When connecting to ports 636 or 3269, SSL/TLS is negotiated before any LDAP traffic is exchanged.

- Multiple SSL certificates

    Schannel, the Microsoft SSL provider, selects the first valid certificate that it finds in the local computer store. If there are multiple valid certificates available in the local computer store, Schannel may not select the correct certificate.

- Pre-SP3 SSL certificate caching issue

    If an existing LDAPS certificate is replaced with another certificate, either through a renewal process or because the issuing CA has changed, the server must be restarted for Schannel to use the new certificate.

## Improvements

The original recommendation in this article was to put certificates in the Local Machine's Personal store. Although this option is supported, you can also put certificates in the NTDS Service's Personal certificate store in Windows Server 2008 and in later versions of Active Directory Domain Services (AD DS). For more information about how to add the certificate to the NTDS service's Personal certificate store, see [Event ID 1220 - LDAP over SSL](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd941846(v=ws.10)).

AD DS preferentially looks for certificates in this store over the Local Machine's store. This makes it easier to configure AD DS to use the certificate that you want it to use. It's because there might be multiple certificates in the Local Machines Personal store, and it can be difficult to predict which one is selected.

AD DS detects when a new certificate is dropped into its certificate store and then triggers an SSL certificate update without having to restart AD DS or restart the domain controller.

A new rootDse operation that's named renewServerCertificate can be used to manually trigger AD DS to update its SSL certificates without having to restart AD DS or restart the domain controller. This attribute can be updated using adsiedit.msc, or by importing the change in LDAP Directory Interchange Format (LDIF) using ldifde.exe. For more information on using LDIF to update this attribute, see [renewServerCertificate](/openspecs/windows_protocols/ms-adts/4cf26e43-ae0b-4823-b00c-18205ab78065).

Finally, if a Windows Server 2008 or a later version domain controller finds multiple certificates in its store, it will random chose one of these certificates.

All these work for Windows Server 2008 AD DS and for 2008 Active Directory Lightweight Directory Services (AD LDS). For AD LDS, put certificates into the Personal certificate store for the service that corresponds to the AD LDS instance instead of for the NTDS service.
