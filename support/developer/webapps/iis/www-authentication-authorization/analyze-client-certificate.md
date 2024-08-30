---
title: Read and analyze a client certificate
description: This article introduces how to read some of the interesting features of a certificate.
ms.date: 03/24/2020
ms.custom: sap:WWW Authentication and Authorization\SSL client certificates and certificate mapping
ms.reviewer: cirvin
ms.topic: how-to
---
# Read and analyze a client certificate

This article introduces how to read some of the interesting features of a certificate. In the event that you need to analyze the contents of a certificate file, see [Tools to Create, View, and Manage Certificates](/windows/win32/seccrypto/tools-to-create-view-and-manage-certificates).

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 216831

## Certificate file

After you dump the contents of a certificate, you'll have a file that looks similar to the following:

```console
PKCS7 Message Certificates:
================ Begin Nesting Level 1 ================
X509 Certificate:
Version: 3
Serial Number: 25f51e4e0000115a
Signature Algorithm:
  Algorithm ObjectId: 1.2.840.113549.1.1.4
  Algorithm Parameters:
05 00 ..
Issuer: CN=MS CertSrv Test Group CA, OU=Windows NT, O=Microsoft, L=Redmond, S=WA, C=US
NotBefore: 10/23/1998 3:33 PM
NotAfter: 10/23/1999 3:33 PM
Subject: CN=Name (Signing), OU=IASG, O=Microsoft, L=Redmond,
         S=WA, C=US, E=name@domain.com
Public Key Algorithm:
  Algorithm ObjectId: 1.2.840.113549.1.1.1
  Algorithm Parameters:
05 00 ..
PublicKey: UnusedBits=0
30 48 02 41 00 d4 c1 0e 6f 0b 86 54 b8 9b 08 de 0H.A....o..T....
41 87 b5 e8 62 83 a6 42 a6 63 de 5a 9e cc 17 f6 A...b..B.c.Z....
72 95 52 1f 56 7a 95 ad 33 f0 8e c2 e8 c6 d4 95 r.R.Vz..3.......
0d ce c4 7a 1a f3 10 28 ca 15 46 4e 48 52 8c 89 ...z...(..FNHR..
87 f8 5d 0d 1b 02 03 01 00 01 ..].......
Certificate Extensions: 6
  2.5.29.15: Flags = 0(), Length = 4
     Key Usage
     Digital Signature, Key Encipherment, Data Encipherment, Key Agreement(B8)
 2.5.29.37: Flags = 0(), Length = c
     Enhanced Key Usage
         Client Authentication(1.3.6.1.5.5.7.3.2)

2.5.29.35: Flags = 0(), Length = a9
 Authority Key Identifier
     KeyID=2A58 2026 5B9F CFB1 E328 F42A EA4D F8CA 19CB F3C4
     Certificate Issuer: Directory Address:
             CN=MS CertSrv Test Group CA
             OU=Windows NT
             O=Microsoft
             L=Redmond
             S=WA
             C=US
     Certificate SerialNumber=1113 6100 AA00 2B86 11D2 5EF8 DDA0 99B4

2.5.29.31: Flags = 0(), Length = 91
    CRL Distribution Points
    [1]CRL Distribution Point Distribution Point Name:
    Full Name:
    URL=http://CERTSRV/CertSrv/CertEnroll/MS CertSrv Test Group CA.crl
    [2]CRL Distribution Point Distribution Point Name:
    Full Name:
    URL=file://\\CERTSRV\CertSrv\CertEnroll\MS CertSrv Test Group CA.crl
2.5.29.19: Flags = 0(), Length = 2
    Basic Constraints
        Subject Type=End Entity Path Length Constraint=None
1.3.6.1.5.5.7.1.1: Flags = 0(), Length = 56
    Authority Information Access
        [1]Authority Info Access
    AccessMethod=Certification Authority Issuer(1.3.6.1.5.5.7.48.2)
    Alternative Name:
    URL=http://CERTSRV/CertSrv/CertEnroll/CERTSRV_MS CertSrv Test Group CA.crt
Non-root Certificate
```

> [!NOTE]
> This certificate is modified in order to fit in this window.

## Analyze the certificate

Some of the interesting parts of the certificate include the following:

- PKCS7 Message

    PKCS is a message format for cryptographic messages designed by RSA. For more information, see [RSA Security Web site](https://www.rsa.com).
- X509 Certificate

    This is the standard format of a certificate.
- Version

    Version 3.0 is the current version.
- Serial Number

    This is a number unique to the entity that issued the certificate.

    > [!NOTE]
    > It is possible for two issuers to use the same serial number, but it is rare.
- Signature Algorithm

    The *ObjectID* or *OID* is a number used to define an algorithm, application, body part type, character set, external parameter, or message type, among other things. In this example, 1.2.840.113549.1.1.4 means the MD5 hash algorithm. You can get a list of crypto-related OIDs from the `WinCrypt.h` header file that ships with VC++.
- Issuer

    It's the entity that created the certificate.
- NotBefore/NotAfter

    This is the date range within which the certificate is valid.
- Subject

    Who does this certificate belong to?
- Public Key Algorithm

    1.2.840.113549.1.1.1 means the public key was generated using the RSA algorithm.
- Public Key

    This is the actual data around which this certificate focuses; it's the public key itself.
- Certificate extensions

    These are optional, and only version 3.0 certificates support them. They include *Key Usage* (what can the public key be used for?), *Enhanced Key Usage* (similar to the previous), *Authority Key Identifier* (data used by the issuer to identify this certificate), *CRL Distribution Point* (where to find information about whether this certificate has been revoked or not).
