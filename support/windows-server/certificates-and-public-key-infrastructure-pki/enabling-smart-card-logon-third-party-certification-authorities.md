---
title: Enabling smart card logon
description: Provides some guidelines for enabling smart card logon with third-party certification authorities.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, slight
ms.custom: sap:smart-card-logon, csstroubleshoot
---
# Guidelines for enabling smart card logon with third-party certification authorities

This article provides some guidelines for enabling smart card logon with third-party certification authorities.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 281245

## Summary

You can enable a smart card logon process with Microsoft Windows 2000 and a non-Microsoft certification authority (CA) by following the guidelines in this article. Limited support for this configuration is described later in this article.

## More information

### Requirements

Smart Card Authentication to Active Directory requires that Smartcard workstations, Active Directory, and Active Directory domain controllers be configured properly. Active Directory must trust a certification authority to authenticate users based on certificates from that CA. Both Smartcard workstations and domain controllers must be configured with correctly configured certificates.

As with any PKI implementation, all parties must trust the Root CA to which the issuing CA chains. Both the domain controllers and the smartcard workstations trust this root.

#### Active Directory and domain controller configuration

- Required: Active Directory must have the third-party issuing CA in the NTAuth store to authenticate users to active directory.
- Required: Domain controllers must be configured with a domain controller certificate to authenticate smartcard users.
- Optional: Active Directory can be configured to distribute the third-party root CA to the trusted root CA store of all domain members using the Group Policy.

#### Smartcard certificate and workstation requirements

- Required: All of the smartcard requirements outlined in the "Configuration Instructions" section must be met, including the text formatting of the fields. Smartcard authentication fails if they are not met.
- Required: The smartcard and private key must be installed on the smartcard.

### Configuration instructions

1. Export or download the third-party root certificate. How to obtaining the party root certificate varies by vendor. The certificate must be in Base64 Encoded X.509 format.
2. Add the third-party root CA to the trusted roots in an Active Directory Group Policy object. To configure Group Policy in the Windows 2000 domain to distribute the third-party CA to the trusted root store of all domain computers:
   1. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.
   2. In the left pane, locate the domain in which the policy you want to edit is applied.
   3. Right-click the domain, and then click **Properties**.
   4. Click the **Group Policy** tab.
   5. Click the **Default Domain Policy Group Policy** object, and then click **Edit**. A new window opens.
   6. In the left pane, expand the following items:
      - **Computer Configuration**
      - **Windows Settings**
      - **Security Settings**
      - **Public Key Policy**
   7. Right-click **Trusted Root Certification Authorities**.
   8. Select **All Tasks**, and then click **Import**.
   9. Follow the instructions in the wizard to import the certificate.
   10. Click **OK**.
   11. Close the **Group Policy** window.
3. Add the third party issuing the CA to the NTAuth store in Active Directory.

   The smart card logon certificate must be issued from a CA that is in the NTAuth store. By default, Microsoft Enterprise CAs are added to the NTAuth store.
   - If the CA that issued the smart card logon certificate or the domain controller certificates is not properly posted in the NTAuth store, the smart card logon process does not work. The corresponding answer is "Unable to verify the credentials".
   - The NTAuth store is located in the Configuration container for the forest. For example, a sample location is as follows: LDAP://server1.name.com/CN=NTAuthCertificates,CN=Public Key Services,CN=Services,CN=Configuration,DC=name,DC=com

   - By default, this store is created when you install a Microsoft Enterprise CA. The object can also be created manually by using ADSIedit.msc in the Windows 2000 Support tools or by using LDIFDE. For more information, click the following article number to view the article in the Microsoft Knowledge Base:

     [295663](https://support.microsoft.com/help/295663) How to import third-party certification authority (CA) certificates into the Enterprise NTAuth store  

   - The relevant attribute is cACertificate, which is an octet String, multiple-valued list of ASN-encoded certificates.

     After you put the third-party CA in the NTAuth store, Domain-based Group Policy places a registry key (a thumbprint of the certificate) in the following location on all computers in the domain:

     HKEY_LOCAL_MACHINE\Software\Microsoft\EnterpriseCertificates\NTAuth\Certificates

     It is refreshed every eight hours on workstations (the typical Group Policy pulse interval).
4. Request and install a domain controller certificate on the domain controller(s). Each domain controller that is going to authenticate smartcard users must have a domain controller certificate.

   If you install a Microsoft Enterprise CA in an Active Directory forest, all domain controllers automatically enroll for a domain controller certificate. For more information about requirements for domain controller certificates from a third-party CA, click the following article number to view the article in the Microsoft Knowledge Base:

   [291010](https://support.microsoft.com/help/291010) Requirements for domain controller certificates from a third-party CA  

   > [!NOTE]
   > The domain controller certificate is used for Secure Sockets Layer (SSL) authentication, Simple Mail Transfer Protocol (SMTP) encryption, Remote Procedure Call (RPC) signing, and the smart card logon process. Using a non-Microsoft CA to issue a certificate to a domain controller may cause unexpected behavior or unsupported results. An improperly formatted certificate or a certificate with the subject name absent may cause these or other capabilities to stop responding.
5. Request a smart card certificate from the third-party CA.

   Enroll for a certificate from the third-party CA that meets the stated requirements. The method for enrollment varies by the CA vendor.

   The smart card certificate has specific format requirements:
   - The CRL Distribution Point (CDP) location (where CRL is the Certification Revocation List) must be populated, online, and available. For example:
  
       ```output
       [1]CRL Distribution Point  
       Distribution Point Name:  
       Full Name:  
       URL=http://server1.name.com/CertEnroll/caname.crl
       ```

   - Key Usage = Digital Signature
   - Basic Constraints [Subject Type=End Entity, Path Length Constraint=None] (Optional)
   - Enhanced Key Usage =
     - Client Authentication (1.3.6.1.5.5.7.3.2)  
(The client authentication OID) is only required if a certificate is used for SSL authentication.)
     - Smart Card Logon (1.3.6.1.4.1.311.20.2.2)  
   - Subject Alternative Name = Other Name: Principal Name= (UPN). For example:  
      UPN = user1@name.com  
      The UPN OtherName OID is: "1.3.6.1.4.1.311.20.2.3"  
      The UPN OtherName value: Must be ASN1-encoded UTF8 string

   - Subject = Distinguished name of user. This field is a mandatory extension, but the population of this field is optional.
6. There are two predefined types of private keys. These keys are **Signature Only(AT_SIGNATURE)** and **Key Exchange(AT_KEYEXCHANGE)**. Smartcard logon certificates must have a **Key Exchange(AT_KEYEXCHANGE)** private key type in order for smartcard logon to function correctly.
7. Install smartcard drivers and software to the smartcard workstation.

   Make sure that the appropriate smartcard reader device and driver software are installed on the smartcard workstation. It varies by smartcard reader vendor.
8. Install the third-party smartcard certificate to the smartcard workstation.

   If the smartcard was not already put into the smartcard user's personal store in the enrollment process in step 4, then you must import the certificate into the user's personal store. To do so:
   1. Open the Microsoft Management Console (MMC) that contains the Certificates snap-in.
   2. In the console tree, under Personal, click Certificates.
   3. On the All Tasks menu, click Import to start the Certificate Import Wizard.
   4. Click the file that contains the certificates that you are importing.

      > [!NOTE]
      > If the file that contains the certificates is a Personal Information Exchange (PKCS #12) file, type the password that you used to encrypt the private key, click to select the appropriate check box if you want the private key to be exportable, and then turn on strong private key protection (if you want to use this feature).

       > [!NOTE]
       > To turn on strong private key protection, you must use the Logical Certificate Stores view mode.
   5. Select the option to automatically put the certificate in a certificate store based on the type of certificate.
9. Install the third-party smartcard certificate onto the smartcard. This installation varies according to Cryptographic Service Provider (CSP) and by smartcard vendor. See the vendor's documentations for instructions.
10. Log on to the workstation with the smartcard.

### Possible issues

During smartcard logon, the most common error message seen is:

>The system could not log you on. Your credentials could not be verified.  

This message is a generic error and can be the result of one or more of below issues.

#### Certificate and configuration problems

- The domain controller has no domain controller certificate.
- The SubjAltName field of the smartcard certificate is badly formatted. If the information in the SubjAltName field appears as Hexadecimal / ASCII raw data, the text formatting is not ASN1 / UTF-8.
- The domain controller has an otherwise malformed or incomplete certificate.
- For each of the following conditions, you must request a new valid domain controller certificate. If your valid domain controller certificate has expired, you may renew the domain controller certificate, but this process is more complex and typically more difficult than if you request a new domain controller certificate.
  - The domain controller certificate has expired.
  - The domain controller has an untrusted certificate. If the NTAuth store does not contain the certification authority (CA) certificate of the domain controller certificate's issuing CA, you must add it to the NTAuth store or obtain a DC certificate from an issuing CA whose certificate resides in the NTAuth store.

  If the domain controllers or smartcard workstations do not trust the Root CA to which the domain controller's certificate chains, then you must configure those computers to trust that Root CA.

- The smartcard has an untrusted certificate. If the NTAuth store does not contain the CA certificate of the smartcard certificate's issuing CA, you must add it to the NTAuth store or obtain a smartcard certificate from an issuing CA whose certificate resides in the NTAuth store.

  If the domain controllers or smartcard workstations do not trust the Root CA to which the user's smartcard certificate chains, then you must configure those computers to trust that Root CA.

- The certificate of the smart card is not installed in the user's store on the workstation. The certificate that is stored on the smartcard must reside on the smartcard workstation in the profile of the user who is logging on with the smart card.

  > [!NOTE]
  > You do not have to store the private key in the user's profile on the workstation. It is only required to be stored on the smartcard.

- The correct smartcard certificate or private key is not installed on the smartcard. The valid smartcard certificate must be installed on the smartcard with the private key and the certificate must match a certificate stored in the smartcard user's profile on the smartcard workstation.
- The certificate of the smart card cannot be retrieved from the smartcard reader. It can be a problem with the smartcard reader hardware or the smartcard reader's driver software. Verify that you can use the smartcard reader vendor's software to view the certificate and the private key on the smartcard.
- The smartcard certificate has expired.
- No User Principal Name (UPN) is available in the SubjAltName extension of the smartcard certificate.
- The UPN in SubjAltName field of the smartcard certificate is badly formatted. If the information in the SubjAltName appears as Hexadecimal / ASCII raw data, the text formatting is not ASN1 / UTF-8.
- The smartcard has an otherwise malformed or incomplete certificate. For each of these conditions, you must request a new valid smartcard certificate and install it onto the smartcard and into the profile of the user on the smartcard workstation. The smartcard certificate must meet the requirements described earlier in this article, which include a correctly formatted UPN field in the SubjAltName field.

  If your valid smartcard certificate has expired, you may also renew the smartcard certificate, which is more complex and difficult than requesting a new smartcard certificate.

- The user does not have a UPN defined in their Active Directory user account. The user's account in the Active Directory must have a valid UPN in the userPrincipalName property of the smartcard user's Active Directory user account.
- The UPN in the certificate does not match the UPN defined in the user's Active Directory user account. Correct the UPN in the smartcard user's Active Directory user account or reissue the smartcard certificate so that the UPN value in the SubjAltName field the matches the UPN in smartcard users' Active Directory user account. We recommend that the smart card UPN matches the userPrincipalName user account attribute for third-party CAs. However, if the UPN in the certificate is the "implicit UPN" of the account (format samAccountName@domain_FQDN), the UPN does not have to match the userPrincipalName property explicitly.

#### Revocation checking problems

If the revocation checking fails when the domain controller validates the smart card logon certificate, the domain controller denies the logon. The domain controller may return the error message mentioned earlier or the following error message:

>The system could not log you on. The smartcard certificate used for authentication was not trusted.

> [!NOTE]
> Failing to find and download the Certificate Revocation List (CRL), an invalid CRL, a revoked certificate, and a revocation status of "unknown" are all considered revocation failures.

The revocation check must succeed from both the client and the domain controller. Make sure the following are true:

- Revocation checking is not turned off.

  Revocation check for the built-in revocation providers cannot be turned off. If a custom installable revocation provider is installed, it must be turned on.

- Every CA Certificate except the root CA in the certificate chain contains a valid CDP extension in the certificate.
- The CRL has a Next Update field and the CRL is up to date. You can check that the CRL is online at the CDP and valid by downloading it from Internet Explorer. You should be able to download and view the CRL from any of the HyperText Transport Protocol (HTTP) or File Transfer Protocol (FTP) CDPs in Internet Explorer from both the smartcard workstation(s) and the domain controller(s).  

Verify that each unique HTTP and FTP CDP that is used by a certificate in your enterprise is online and available.

To verify that a CRL is online and available from an FTP or HTTP CDP:

1. To open the Certificate in question, double-click on the .cer file or double-click the certificate in the store.
2. Click the Details tab, and select the **CRL Distribution Point** field.
3. In the bottom pane, highlight the full FTP or HTTP Uniform Resource Locator (URL) and copy it.
4. Open Internet Explorer and paste the URL into the Address bar.
5. When you receive the prompt, select the option to Open the CRL.
6. Make sure that there is a Next Update field in the CRL and the time in the Next Update field has not passed.

To download or verify that a Lightweight Directory Access Protocol (LDAP) CDP is valid, you must write a script or an application to download the CRL. After you download and open the CRL, make sure that there is a Next Update field in the CRL and the time in the Next Update field has not passed.

### Support

Microsoft Product Support Services does not support the third-party CA smart card logon process if it is determined that one or more of the following items contributes to the problem:

- Improper certificate format.
- Certificate status or revocation status not available from the third-party CA.
- Certificate enrollment issues from a third-party CA.
- The third-party CA cannot publish to Active Directory.
- A third-party CSP.

### Additional information

The client computer checks the domain controller's certificate. The local computer therefore downloads a CRL for the domain controller certificate into the CRL cache.

The offline logon process does not involve certificates, only cached credentials.

To force the NTAuth store to be immediately populated on a local computer instead of waiting for the next Group Policy propagation, run the following command to initiate a Group Policy update:

```console
  dsstore.exe -pulse  
```

You can also dump out the smart card information in Windows Server 2003 and in Windows XP by using the Certutil.exe -scinfo command.
