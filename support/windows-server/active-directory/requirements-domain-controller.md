---
title: Requirements for domain controller
description: Describes the requirements that you need to fulfill to issue a domain controller certificate from a third-party certification authority (CA).
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, slight
ms.custom: sap:dcpromo-and-the-installation-of-domain-controllers, csstroubleshoot
---
# Requirements for domain controller certificates from a third-party CA

This article describes the requirements that you need to fulfill to issue a domain controller certificate from a third-party certification authority (CA).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 291010

## Summary

For more information about the requirements for a Windows Server 2008 R2 domain controller certificate from a third-party CA, see [Updated requirements for a Windows Server 2008 R2 domain controller certificate from a 3rd party CA](https://social.technet.microsoft.com/wiki/contents/articles/3824.updated-requirements-for-a-windows-server-2008-r2-domain-controller-certificate-from-a-3rd-party-ca.aspx).

## Support

- Currently, Microsoft supports the use of third-party domain controller certificates with smart card sign-in only.
- Currently, Microsoft doesn't support the use of certificates from third-party CAs to support SMTP (Simple Mail Transfer Protocol) replication between domain controllers.
- Third-party CAs don't support the automatic enrollment and renewal of domain controller or computer certificates.

## Requirements

- You can manually issue a certificate to a domain controller. The certificate for the domain controller must meet the following specific format requirements:
  - The certificate must have a CRL distribution-point extension that points to a valid certificate revocation list (CRL).
  - Optionally, the certificate Subject section should contain the directory path of the server object (the distinguished name), for example:  
      CN=server1.northwindtraders.com OU=Domain Controllers DC=northwwindtraders DC=com

  - The certificate Key Usage section must contain:  
      Digital Signature, Key Encipherment

  - Optionally, the certificate Basic Constraints section should contain:  
      [Subject Type=End Entity, Path Length Constraint=None]

  - The certificate Enhanced Key Usage section must contain:
    - Client Authentication (1.3.6.1.5.5.7.3.2)
    - Server Authentication (1.3.6.1.5.5.7.3.1)
  - The certificate Subject Alternative Name section must contain the Domain Name System (DNS) name. If SMTP replication is used, the certificate Subject Alternative Name section must also contain the globally unique identifier (GUID) of the domain controller object in the directory. For example:  
      Other Name: 1.3.6.1.4.1.311.25.1 = ac 4b 29 06 aa d6 5d 4f a9 9c 4c bc b0 6a 65 d9 DNS Name=server1.northwindtraders.com

    - The certificate template must have an extension that has the basic metabolic panel (BMP) data value **DomainController**.

      > [!NOTE]
      > The **dsstore.exe -dcmon** command does not recognize the certificate without one of these extensions.
    - You must use the Schannel cryptographic service provider (CSP) to generate the key.
- The domain controller certificate must be installed in the local computer's certificate store.

## Sample certificate

```console
X509 Certificate:
Version: 3
Serial Number: 61497f5e000000000006
Signature Algorithm:
    Algorithm ObjectId: 1.2.840.113549.1.1.5  sha1RSA
    Algorithm Parameters:
    05 00                                              ..
Issuer:
    CN=TestCA
    DC=northwindtraders
    DC=com

NotBefore: 2/12/2001 3:57 PM
NotAfter: 7/10/2001 10:24 AM

Subject:
    CN=TEST-DC1
    OU=Domain Controllers
    DC=northwindtraders
    DC=com

Public Key Algorithm:
    Algorithm ObjectId: 1.2.840.113549.1.1.1  RSA
    Algorithm Parameters:
    05 00                                              ..
Public Key Length: 1024 bits
Public Key: UnusedBits = 0
    0000  30 81 89 02 81 81 00 b1  c8 84 ce ea 5c da 96 23
    0010  4b d5 07 d7 27 f3 76 1f  d3 0f 23 3f 8b fa 8b 68
    0020  34 09 47 4a f5 33 41 77  86 d2 d3 a7 34 19 5c 49
    0030  43 bf 5a 3c 25 a3 77 69  54 ad 84 af 20 b2 c2 f6
    0040  40 f7 82 7f b9 b0 db cb  db 76 7c 13 54 8e 3b 5e
    0050  9e 92 a2 42 8d 97 db 07  06 cc 5d 7a 95 9f 7f 8b
    0060  c1 69 7b 0a 6a e7 8f fa  6b c4 60 23 d4 03 88 45
    0070  83 61 2e b2 af a2 f9 69  e2 84 d9 95 01 c4 88 eb
    0080  89 16 5a 4d a4 34 27 02  03 01 00 01
Certificate Extensions: 9
    1.2.840.113549.1.9.15: Flags = 0, Length = 37
    SMIME Capabilities
        [1]SMIME Capability
             Object ID=1.2.840.113549.3.2
             Parameters=02 02 00 80
        [2]SMIME Capability
             Object ID=1.2.840.113549.3.4
             Parameters=02 02 00 80
        [3]SMIME Capability
             Object ID=1.3.14.3.2.7
        [4]SMIME Capability
             Object ID=1.2.840.113549.3.7

    2.5.29.15: Flags = 0, Length = 4
    Key Usage
        Digital Signature, Key Encipherment (a0)

    2.5.29.37: Flags = 0, Length = 16
    Enhanced Key Usage
        Client Authentication (1.3.6.1.5.5.7.3.2)
        Server Authentication (1.3.6.1.5.5.7.3.1)

    1.3.6.1.4.1.311.20.2: Flags = 0, Length = 22
    Certificate Template Name
        DomainController

    2.5.29.14: Flags = 0, Length = 16
    Subject Key Identifier
        a8 20 ce 65 63 3e cd a1 c8 77 97 44 fa 28 43 71 17 e3 6e 84

    2.5.29.35: Flags = 0, Length = 18
    Authority Key Identifier
        KeyID=44 b8 25 f8 d9 53 c5 96 e1 8c 14 d5 e4 5e 33 3a fc 22 7b e7

    2.5.29.31: Flags = 0, Length = f8
    CRL Distribution Points
        [1]CRL Distribution Point
             Distribution Point Name:
                  Full Name:
                       URL=http://test-dc1.northwindtraders.com/CertEnroll/TestCA.crl
                       URL=ldap:///CN=TestCA,CN=test-dc1,CN=CDP,CN=Public%20Key%20Services,CN=Services,CN=Configuration,DC=northwindtraders,DC=com?certificateRevocationList?base?objectClass=cRLDistributionPoint

    1.3.6.1.5.5.7.1.1: Flags = 0, Length = 10a
    Authority Information Access
        [1]Authority Info Access
             Access Method=Certification Authority Issuer (1.3.6.1.5.5.7.48.2)
             Alternative Name:
                  URL=http://test-dc1.northwindtraders.com/CertEnroll/test-dc1.northwindtraders.com_TestCA.crt
        [2]Authority Info Access
             Access Method=Certification Authority Issuer (1.3.6.1.5.5.7.48.2)
             Alternative Name:
                  URL=ldap:///CN=TestCA,CN=AIA,CN=Public%20Key%20Services,CN=Services,CN=Configuration,DC=northwindtraders,DC=com?cACertificate?base?objectClass=certificationAuthority

    2.5.29.17: Flags = 0, Length = 3d
    Subject Alternative Name
        Other Name:
             1.3.6.1.4.1.311.25.1=04 10 96 8e ea d7 ee ba bc 42 81 db 4f 92 f5 88 db 4a
        DNS Name=test-dc1.northwindtraders.com

Signature Algorithm:
    Algorithm ObjectId: 1.2.840.113549.1.1.5  sha1RSA
    Algorithm Parameters:
    05 00
```

## How to determine the domain controller GUID

Start Ldp.exe and locate the domain-naming context. Double-click the name of the domain controller that you want to view. The list of attributes for that object contains "Object GUID" followed by a long number. The number is the GUID for that object.
