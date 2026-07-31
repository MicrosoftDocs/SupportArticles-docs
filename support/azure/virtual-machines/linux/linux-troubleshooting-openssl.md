---
title: Troubleshoot OpenSSL issues on Linux
description: Troubleshoot OpenSSL issues on Azure Linux VMs, including certificate trust errors, TLS version mismatches, and cipher failures. Start diagnosing and fixing them.
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.collection: linux
ms.topic: troubleshooting
ms.date: 07/31/2026
ms.custom: sap:VM Admin - Linux (Guest OS), Issue with SSL
ms.reviewer: divargas, scotro, mabicca
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
---

# Troubleshoot OpenSSL issues on Linux

**Applies to:** Linux virtual machines

## Summary

OpenSSL is a widely used cryptographic library that provides tools for implementing secure communication by using Transport Layer Security (TLS) and Secure Sockets Layer (SSL). It's the default TLS implementation on most Linux distributions running in Azure.

This article explains how to troubleshoot common OpenSSL-related issues, including certificate trust problems, unsupported protocol versions, and cipher negotiation failures.

## What is OpenSSL?

OpenSSL is a cryptographic toolkit that provides the following capabilities:

- TLS and SSL protocol implementations
- Cryptographic primitives such as RSA (Rivest–Shamir–Adleman), ECC (Elliptic Curve Cryptography), and AES (Advanced Encryption Standard)
- X.509 certificate and private key management
- Command-line utilities for diagnostics and testing

Although alternatives such as LibreSSL, BoringSSL, and Bouncy Castle exist, OpenSSL remains the most commonly used TLS implementation on Linux.

## Common OpenSSL use cases

Use OpenSSL to perform tasks such as:

- Creating a certificate authority (CA).
- Generating private keys and certificate signing requests (CSRs).
- Inspecting certificates and certificate chains.
- Converting certificates between PEM (Privacy Enhanced Mail), DER (Distinguished Encoding Rules), and PKCS#12 (Public‑Key Cryptography Standards) formats.
- Testing TLS connectivity and cipher negotiation.

## Basic OpenSSL example commands

### Display the OpenSSL configuration directory

```bash
sudo openssl version -d
```

### Inspect a certificate

```bash
sudo openssl x509 -in /etc/ssl/certs/SUSE.pem -noout -text
```

## Understand X.509 certificates

An X.509 certificate is a digital certificate that uses public key infrastructure (PKI) to verify a system or service identity.

Common certificate fields include:

- **Version**: X.509 standard version
- **Serial number**: Unique identifier assigned by the certificate authority
- **Signature algorithm**: Algorithm used to sign the certificate
- **Issuer**: Certificate authority that issued the certificate
- **Validity period**: Time range during which the certificate is valid
- **Subject**: Entity that the certificate represents
- **Subject Public Key Info**: Public key and associated algorithm

Example output:

```output
Version: 3 (0x2)
Serial Number: 5c:...:ee
Signature Algorithm: sha256WithRSAEncryption
Issuer: C = DE, ST = Bavaria, L = Nuremberg, O = SUSE, OU = Public Cloud, CN = SUSE
Validity
    Not Before: Mar 30 15:06:11 2023 GMT
    Not After : Mar 27 15:06:11 2033 GMT
Subject: C = DE, ST = Bavaria, L = Nuremberg, O = SUSE, OU = Public Cloud, CN = SUSE
Subject Public Key Info:
    Public Key Algorithm: rsaEncryption
    RSA Public-Key: (4096 bit)
X509v3 Basic Constraints: critical
    CA:TRUE
```

## Capture TLS handshakes by using tcpdump

You can capture TLS handshakes by using `tcpdump` to understand what is occurring at the network level.

```bash
sudo tcpdump -i eth0 -nn -s0 -v host <server-ip> and port 443
```

Example output:

```output
No  Time  Source       Destination   Protocol Length Info
1   34    10.0.0.6     51.141.11.221  TLSv1.3  589    Client Hello
2   34    51.141.11.221 10.0.0.6     TCP      72     443 → 36760 [ACK]
3   34    51.141.11.221 10.0.0.6     TLSv1.3  2558   Server Hello, Change Cipher Spec, Application Data
5   34    10.0.0.6     51.141.11.221  TLSv1.3  152    Change Cipher Spec, Application Data
```

```bash
sudo tcpdump -i eth0 -nnvXSs 0 port 443
```

## List supported ciphers

```bash
sudo openssl ciphers -v | column -t
```
## Identify supported protocols and ciphers for a service:

### Test for TLS 1.2

```bash
openssl s_client -connect microsoft.com:443 -tls1_2
```

### Test for TLS 1.3

```bash
openssl s_client -connect microsoft.com:443 -tls1_3
```

### Script to test supported TLS protocol versions

1. Create an empty script file.
```bash
sudo touch test-tls-versions.sh
```

1. Open the new file with your favorite editor and paste these contents in it.
```bash
#!/bin/bash
HOST=$1
PORT=$2

for v in ssl2 ssl3 tls1 tls1_1 tls1_2 tls1_3; do
    echo "Testing $v..."
    echo | openssl s_client -connect ${HOST}:${PORT} -${v} 2>&1 | \
        grep -E "Protocol|Cipher|Verify|New|CONNECTED" || echo "Not supported"
    echo
done
```

1. Set the file with proper executable permissions.
```bash
sudo chmod +x test-tls-versions.sh
```

1. Run the script with the host and port you want to test with.
```bash
$ ./test-tls-versions.sh example.com 443
```

Example output:

```output
Testing ssl2...
Not supported

Testing ssl3...
Not supported

Testing tls1...
CONNECTED(00000005)
New, (NONE), Cipher is (NONE)
Protocol: TLSv1.3
Verify return code: 0 (ok)

Testing tls1_1...
CONNECTED(00000005)
New, (NONE), Cipher is (NONE)
Protocol: TLSv1.3
Verify return code: 0 (ok)

Testing tls1_2...
CONNECTED(00000005)
New, TLSv1.2, Cipher is ECDHE-RSA-AES256-GCM-SHA384
Protocol: TLSv1.2
    Protocol  : TLSv1.2
    Cipher    : ECDHE-RSA-AES256-GCM-SHA384
    Verify return code: 0 (ok)

Testing tls1_3...
CONNECTED(00000005)
New, TLSv1.3, Cipher is TLS_AES_256_GCM_SHA384
Protocol: TLSv1.3
Verify return code: 0 (ok)
```

## Troubleshoot common OpenSSL scenarios

### Scenario 1: Missing root CA certificate

This issue occurs when the CA bundle on the client is outdated.

#### Identify the issue

When using the command below to test the endpoint you're having issues with, you will see errors similar to the following:
```bash
openssl s_client -connect example.com:443 -showcerts | grep -i verify
```

Example output:

```output
verify error:num=20:unable to get local issuer certificate
verify return code: 64 (certificate not trusted)
```

#### Solution 

1. Update CA bundle

Ubuntu or SUSE:
```bash
sudo update-ca-certificates
```

Red Hat:
```bash
sudo update-ca-trust
```

2. Verify the output again by running the following command:
```bash
openssl s_client -connect example.com:443 -showcerts | grep -i verify
```

Example output:

```output
Verify return code: 0 (ok)
```

### Scenario 2: Server supports only legacy TLS versions

A legacy server supports outdated TLS versions that modern Linux clients disable by default.

#### Identify the issue

1. Error during curl test
```bash
curl -v https://example.com
```

Example output:

```output
curl: (35) error:1408F10B:SSL routines:ssl3_get_record:wrong version number
```

2. Error during openssl test
```bash
openssl s_client -connect example.com:443
```

Example output:

```output
tlsv1 alert protocol version
```

3. Error during openssl test
```bash
openssl s_client -connect example.com:443
```

Example output:

```output
CONNECTED(00000003)
140735232496784:error:1425F102:SSL routines:ssl_choose_client_version:unsupported protocol
```

#### Solution 

Check with the application vendor or service provider for instructions on enabling TLS 1.2 or 1.3 support, and then verify the supported versions from the client:

1. Verify TLS 1.2 support
```bash
openssl s_client -connect example.com:443 -tls1_2
```

1. Look for the protocol line to make sure it shows TLSv1.2

Example output:

```output
...
...
SSL-Session:
    Protocol  : TLSv1.2
    Cipher    : ECDHE-ECDSA-CHACHA20-POLY1305
    Session-ID: EBCEC4E2CE4D10D1910679DBECEFA3E8399B580C396AD076FEFFCEE5B3D9FB32
    Session-ID-ctx:
    Master-Key: 9E335A27CED3A5D04F8E0FD79E18E32C3912616DF62463FACB269A72F4DB4B510AE459A11AEF415D1888D3B30AC1B880
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 64800 (seconds)
    TLS session ticket:
    0000 - 51 f7 7a 08 d1 82 25 58-b5 91 28 11 c5 58 6d c7   Q.z...%X..(..Xm.
    0010 - 54 ef 49 ab 95 39 b6 21-92 a2 1a a4 7e ca 91 e4   T.I..9.!....~...
    0020 - 69 18 6d 7a 91 c2 b1 fc-4f de 39 ce 29 28 e9 32   i.mz....O.9.)(.2
    0030 - 85 91 22 4a af 25 38 ba-48 d3 5b 5d 2d c1 c1 36   .."J.%8.H.[]-..6
    0040 - ab de b6 1a fa 68 72 68-73 d2 97 03 99 8f 34 5e   .....hrhs.....4^
    0050 - d3 ea ab 1f 6b 1d 03 5e-de 12 7e c2 a2 43 60 af   ....k..^..~..C`.
    0060 - 7f ff a3 1c b6 c0 f1 59-e3 71 0d 79 64 d2 a7 f2   .......Y.q.yd...
    0070 - aa dc f0 02 9a a4 73 38-7b e9 e8 af 19 1f d9 5e   ......s8{......^
    0080 - be f2 d3 cc 07 ef e6 ef-06 d0 ae 81 c4 f0 a3 47   ...............G
    0090 - 43 25 12 30 58 0e 15 b0-39 81 b4 5b 23 8f 3c 2b   C%.0X...9..[#.<+
    00a0 - 0b ba 6f 48 0e d3 7f 5e-72 d7 4c 8f 12 ec 98 29   ..oH...^r.L....)
    00b0 - 1c 55 07 71 35 bf c7 7a-0a 05 cf fd 1c b9 35 35   .U.q5..z......55

    Start Time: 1777669922
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
    Extended master secret: yes
```

1. Verify TLS 1.3 support
```bash
openssl s_client -connect example.com:443 -tls1_3
```

1. Look for the protocol line to make sure it shows TLSv1.3

Example output:

```output
...
...
---
New, TLSv1.3, Cipher is TLS_AES_256_GCM_SHA384
Protocol: TLSv1.3
Server public key is 256 bit
This TLS version forbids renegotiation.
Compression: NONE
Expansion: NONE
No ALPN negotiated
Early data was not sent
Verify return code: 0 (ok)
```

### Scenario 3: Client supports only legacy TLS versions

Older Linux systems can't negotiate TLS versions required by modern services.

#### Identify the issue

1. SSL Handshake failure
```bash
openssl s_client -connect example.com:443
```

Example output:

```output
CONNECTED(00000003)
140735232496784:error:14094410:SSL routines:ssl3_read_bytes:sslv3 alert handshake failure:s3_pkt.c:1493:SSL alert number 40
...
...
```

1. No protocols available
```bash
openssl s_client -connect example.com:443
```

Example output:

```output
...
140735232496784:error:140A90A1:SSL routines:ssl_ctx_set_options:no protocols available
...
```

1. Unsupported protocol
```bash
openssl s_client -connect example.com:443
```

Example output:

```output
CONNECTED(00000003)
140735232496784:error:1425F102:SSL routines:ssl_choose_client_version:unsupported protocol
...
```

#### Solution

Upgrade the operating system. Most Linux vendors don't support installing OpenSSL from source.

For Red Hat, see:
[Upgrade your Red Hat release](/troubleshoot/azure/virtual-machines/linux/leapp-upgrade-process-rhel-7-and-8?tabs=rhel7-rhel8)

For SUSE Enterprise Linux, see: 
[Upgrade your SUSE Enterprise Linux release](/troubleshoot/azure/virtual-machines/linux/linux-upgrade-sles)

For Ubuntu, see:
[Upgrade your Ubuntu release](https://ubuntu.com/server/docs/how-to/software/upgrade-your-release/)

To verify the issue is fixed after the OS upgrade:

1. Run OpenSSL to check.
```bash
openssl s_client -connect example.com:443 | grep -i verify
```

1. Look for the ***verify return*** codes to make sure they're ***ok*** in the output of the command.
   
Example output:
```output
Verify return code: 0 (ok)
    Verify return code: 0 (ok)
```

### Scenario 4: Certificate interception by a network device

Certificate validation errors can occur when proxies, firewalls, or load balancers intercept TLS traffic.

#### How to identify this issue

1. Unknown CA error
```bash
openssl s_client -connect example.com:443
```

Example output:

```output
...
140735232496784:error:14094418:SSL routines:ssl3_read_bytes:tlsv1 alert unknown ca:s3_pkt.c:1493:SSL alert number 48
Alert (Level: Fatal, Description: Unknown CA)
...
```

This error indicates one of the following problems:

- Proxy / Firewall intercepting the TLS request
- The client certificate is signed by a CA that the server doesn't trust

1. No peer certificate available or no client certificate CA names sent
```bash
openssl s_client -connect example.com:443
```

Example output:

```output
CONNECTED(00000003)
140735232496784:error:1408F10B:SSL routines:ssl3_get_record:wrong version number:s3_pkt.c:365:
---
no peer certificate available
---
No client certificate CA names sent
---
SSL handshake has read 7 bytes and written 305 bytes
Verification: OK
```

This error indicates one of the following problems:

- A proxy returning an HTTP 302 or 407
- Firewalls injecting banners
- Load balancer misconfigured for TLS passthrough

1. Unable to get local issuer certificate
```bash
openssl s_client -connect example.com:443
```

Example output:

```output
CONNECTED(00000003)
depth=0 CN = proxy.company.local
verify error:num=20:unable to get local issuer certificate
verify return code: 21 (unable to verify the first certificate)
---
Certificate chain
 0 s:/CN=proxy.company.local
   i:/CN=Corporate-Proxy-Root-CA
-----BEGIN CERTIFICATE-----
[intercepted certificate]
-----END CERTIFICATE-----
---
SSL handshake has read 1234 bytes and written 305 bytes
```

This error indicates one of the following problems:

- The common name (CN) doesn't match the real site. In this case, it shows `proxy.company.local` and not `example.com` as used in the command.
- Verification fails with `num=20` or `num=21`


#### Solution

1. Validate the certificate chain from the client side

Use `microsoft.com` as an example to show the full output.
```bash
openssl s_client -connect microsoft.com:443 -showcerts
```

Example output:

```output
CONNECTED(00000005)
depth=3 C=US, O=DigiCert Inc, OU=www.digicert.com, CN=DigiCert Global Root G2
verify return:1
depth=2 C=US, O=Microsoft Corporation, CN=Microsoft TLS RSA Root G2
verify return:1
depth=1 C=US, O=Microsoft Corporation, CN=Microsoft TLS G2 RSA CA OCSP 02
verify return:1
depth=0 C=US, ST=WA, L=Redmond, O=Microsoft Corporation, CN=microsoft.com
verify return:1
---
Certificate chain
 0 s:C=US, ST=WA, L=Redmond, O=Microsoft Corporation, CN=microsoft.com
   i:C=US, O=Microsoft Corporation, CN=Microsoft TLS G2 RSA CA OCSP 02
   a:PKEY: RSA, 2048 (bit); sigalg: sha384WithRSAEncryption
   v:NotBefore: Apr 15 22:05:11 2026 GMT; NotAfter: Oct 12 22:05:11 2026 GMT
-----BEGIN CERTIFICATE-----
MIIZATCCFumgAwIBAgITQQAR9AHxgWC9gKADIQAAABH0ATANBgkqhkiG9w0BAQwF
ADBXMQswCQYDVQQGEwJVUzEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9u
MSgwJgYDVQQDEx9NaWNyb3NvZnQgVExTIEcyIFJTQSBDQSBPQ1NQIDAyMB4XDTI2
MDQxNTIyMDUxMVoXDTI2MTAxMjIyMDUxMVowZDELMAkGA1UEBhMCVVMxCzAJBgNV
BAgTAldBMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29y
cG9yYXRpb24xFjAUBgNVBAMTDW1pY3Jvc29mdC5jb20wggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCv1zoejyGvdN/rr86OSFZ35uN4jTP7i0bkNY9VmW9y
1p5H+YTI42VSj7vGGcePE3NmzULwqk/xIfPCnyFF+ibeTYyRCLl1vnWOQAXrXBBp
coYD5G8Ixh788WMAO+gUe0AU1cOwdzo3cMugTHUmGLySIwnz9b5erVYTJhZPADke
1+Ilag9Y/zhEs7D2PD4HC2VW7yasQHjrk0Xxb+ZZQNNqOLvrzlF1Tadj+F5iur/a
LTFx3bD1iIrG0m4oAeuVoatpYAO0nsqotewb7Q9zfvnshmvVrwzG/v7sAR3GWAJh
Fcn/GSawE6Zg512NozGRC+4oNq96vJn2w7m/q4q7GF4hAgMBAAGjghS3MIIUszCC
AX8GCisGAQQB1nkCBAIEggFvBIIBawFpAHcA2AlVO5RPev/IFhlvlE+Fq7D4/F6H
VSYPFdEucrtFSxQAAAGdkzaBYgAABAMASDBGAiEAq7qgJzo6kL4wr3lU8Rx8z2Mw
h3+S6nJ69hoskCCVsDMCIQDpkdSDHz+eUAlUyRkm3RG1RUBngmyc+Q9Kppq4vsve
VwB2AMIxfldFGaNF7n843rKQQevHwiFaIr9/1bWtdprZDlLNAAABnZM2gQ4AAAQD
AEcwRQIhALVtj2jO2MLTefWZes+KASb7TUBz9oiZ9YR3+jp3cS/PAiBfumlhjZbm
urmg2MJ0+xDB4BjohO1kier4tKOy5NmPFQB2AMijxH/Hs625NWsBP2p6Em3jOk5D
pcZG+ZetOXWZHc+aAAABnZM2gXIAAAQDAEcwRQIhANDnbFDa1AkWradkzwtNZzF5
qbkR/ZiH03kUAQmnUdeSAiBGk+AmHCTS2XbHwklIv2f/2llaU8z996hiWdattIGe
xjAbBgkrBgEEAYI3FQoEDjAMMAoGCCsGAQUFBwMBMDwGCSsGAQQBgjcVBwQvMC0G
JSsGAQQBgjcVCIe91xuB5+tGgoGdLo7QDIfw2h1dg+nDZ4K0o0wCAWQCASAwggEL
BggrBgEFBQcBAQSB/jCB+zBhBggrBgEFBQcwAoZVaHR0cDovL3d3dy5taWNyb3Nv
ZnQuY29tL3BraW9wcy9jZXJ0cy9NaWNyb3NvZnQlMjBUTFMlMjBHMiUyMFJTQSUy
MENBJTIwT0NTUCUyMDAyLmNydDBnBggrBgEFBQcwAoZbaHR0cDovL2NhaXNzdWVy
cy5taWNyb3NvZnQuY29tL3BraW9wcy9jZXJ0cy9NaWNyb3NvZnQlMjBUTFMlMjBH
MiUyMFJTQSUyMENBJTIwT0NTUCUyMDAyLmNydDAtBggrBgEFBQcwAYYhaHR0cDov
L29uZW9jc3AubWljcm9zb2Z0LmNvbS9vY3NwMB0GA1UdDgQWBBS9fFFn61RLmzHJ
ENhdvUmVX3/B2zAOBgNVHQ8BAf8EBAMCBaAwgg/zBgNVHREEgg/qMIIP5oINbWlj
cm9zb2Z0LmNvbYIPcy5taWNyb3NvZnQuY29tghBnYS5taWNyb3NvZnQuY29tghFh
ZXAubWljcm9zb2Z0LmNvbYIRYWVyLm1pY3Jvc29mdC5jb22CEWdydi5taWNyb3Nv
ZnQuY29tghFodXAubWljcm9zb2Z0LmNvbYIRbWFjLm1pY3Jvc29mdC5jb22CEW1r
Yi5taWNyb3NvZnQuY29tghFwbWUubWljcm9zb2Z0LmNvbYIRcG1pLm1pY3Jvc29m
dC5jb22CEXJzcy5taWNyb3NvZnQuY29tghFzYXIubWljcm9zb2Z0LmNvbYIRdGNv
Lm1pY3Jvc29mdC5jb22CEmZ1c2UubWljcm9zb2Z0LmNvbYISaWVhay5taWNyb3Nv
ZnQuY29tghJtYWMyLm1pY3Jvc29mdC5jb22CEm1jc3AubWljcm9zb2Z0LmNvbYIS
b3Blbi5taWNyb3NvZnQuY29tghJzaG9wLm1pY3Jvc29mdC5jb22CEnNwdXIubWlj
cm9zb2Z0LmNvbYITaXRwcm8ubWljcm9zb2Z0LmNvbYITbWFuZ28ubWljcm9zb2Z0
LmNvbYITbXVzaWMubWljcm9zb2Z0LmNvbYITcHltZXMubWljcm9zb2Z0LmNvbYIT
c3RvcmUubWljcm9zb2Z0LmNvbYIUYWV0aGVyLm1pY3Jvc29mdC5jb22CFGFsZXJ0
cy5taWNyb3NvZnQuY29tghRkZXNpZ24ubWljcm9zb2Z0LmNvbYIUZ2FyYWdlLm1p
Y3Jvc29mdC5jb22CFGdpZ2phbS5taWNyb3NvZnQuY29tghRtc2N0ZWMubWljcm9z
b2Z0LmNvbYIUb25saW5lLm1pY3Jvc29mdC5jb22CFHN0cmVhbS5taWNyb3NvZnQu
Y29tghVhZmZsaW5rLm1pY3Jvc29mdC5jb22CFWNvbm5lY3QubWljcm9zb2Z0LmNv
bYIVZGV2ZWxvcC5taWNyb3NvZnQuY29tghVkb21haW5zLm1pY3Jvc29mdC5jb22C
FWV4YW1wbGUubWljcm9zb2Z0LmNvbYIVbWFkZWlyYS5taWNyb3NvZnQuY29tghVt
c2RuaXN2Lm1pY3Jvc29mdC5jb22CFW1zcHJlc3MubWljcm9zb2Z0LmNvbYIVd3d3
LmFlcC5taWNyb3NvZnQuY29tghV3d3cuYWVyLm1pY3Jvc29mdC5jb22CFXd3d2Jl
dGEubWljcm9zb2Z0LmNvbYIWYnVzaW5lc3MubWljcm9zb2Z0LmNvbYIWZW1wcmVz
YXMubWljcm9zb2Z0LmNvbYIWbGVhcm5pbmcubWljcm9zb2Z0LmNvbYIWbXNkbndp
a2kubWljcm9zb2Z0LmNvbYIWb3Blbm5lc3MubWljcm9zb2Z0LmNvbYIWcGlucG9p
bnQubWljcm9zb2Z0LmNvbYIWc25hY2tib3gubWljcm9zb2Z0LmNvbYIWc3BvbnNv
cnMubWljcm9zb2Z0LmNvbYIWc3RhdGlvbnEubWljcm9zb2Z0LmNvbYIXYWlzdG9y
aWVzLm1pY3Jvc29mdC5jb22CF2NvbW11bml0eS5taWNyb3NvZnQuY29tghdjcmF3
bG1zZG4ubWljcm9zb2Z0LmNvbYIXaW90c2Nob29sLm1pY3Jvc29mdC5jb22CF21l
c3Nlbmdlci5taWNyb3NvZnQuY29tghdtaW5lY3JhZnQubWljcm9zb2Z0LmNvbYIY
YmFja29mZmljZS5taWNyb3NvZnQuY29tghhlbnRlcnByaXNlLm1pY3Jvc29mdC5j
b22CGGlvdGNlbnRyYWwubWljcm9zb2Z0LmNvbYIYcGludW5ibG9jay5taWNyb3Nv
ZnQuY29tghhyZXJvdXRlNDQzLm1pY3Jvc29mdC5jb22CGWNvbW11bml0aWVzLm1p
Y3Jvc29mdC5jb22CGWV4cGxvcmUtc21iLm1pY3Jvc29mdC5jb22CGWV4cHJlc3Np
b25zLm1pY3Jvc29mdC5jb22CGW9uZGVybmVtZXJzLm1pY3Jvc29mdC5jb22CGXRl
Y2hhY2FkZW15Lm1pY3Jvc29mdC5jb22CGXRlcnJhc2VydmVyLm1pY3Jvc29mdC5j
b22CGmNvbW11bml0aWVzMi5taWNyb3NvZnQuY29tghpjb25uZWN0ZXZlbnQubWlj
cm9zb2Z0LmNvbYIaZGF0YXBsYXRmb3JtLm1pY3Jvc29mdC5jb22CGmVudHJlcHJl
bmV1ci5taWNyb3NvZnQuY29tghpoeGQucmVzZWFyY2gubWljcm9zb2Z0LmNvbYIa
bXNwYXJ0bmVyaXJhLm1pY3Jvc29mdC5jb22CGm15ZGF0YWhlYWx0aC5taWNyb3Nv
ZnQuY29tghpvZW1jb21tdW5pdHkubWljcm9zb2Z0LmNvbYIacmVhbC1zdG9yaWVz
Lm1pY3Jvc29mdC5jb22CGnd3dy5mb3Jtc3Byby5taWNyb3NvZnQuY29tghtmdXR1
cmVkZWNvZGVkLm1pY3Jvc29mdC5jb22CG3VwZ3JhZGVjZW50ZXIubWljcm9zb2Z0
LmNvbYIcbGVhcm5hbmFseXRpY3MubWljcm9zb2Z0LmNvbYIcb25saW5lbGVhcm5p
bmcubWljcm9zb2Z0LmNvbYIdYnVzaW5lc3NjZW50cmFsLm1pY3Jvc29mdC5jb22C
HWNsb3VkLWltbWVyc2lvbi5taWNyb3NvZnQuY29tgh1zdHVkZW50cGFydG5lcnMu
bWljcm9zb2Z0LmNvbYIeYW5hbHl0aWNzcGFydG5lci5taWNyb3NvZnQuY29tgh5i
dXNpbmVzc3BsYXRmb3JtLm1pY3Jvc29mdC5jb22CHmV4cGxvcmUtc2VjdXJpdHku
bWljcm9zb2Z0LmNvbYIea2xlaW51bnRlcm5laG1lbi5taWNyb3NvZnQuY29tgh5w
YXJ0bmVyY29tbXVuaXR5Lm1pY3Jvc29mdC5jb22CH2V4cGxvcmUtbWFya2V0aW5n
Lm1pY3Jvc29mdC5jb22CH2lubm92YXRpb25jb250ZXN0Lm1pY3Jvc29mdC5jb22C
H3BhcnRuZXJpbmNlbnRpdmVzLm1pY3Jvc29mdC5jb22CH3Bob2VuaXhjYXRhbG9n
dWF0Lm1pY3Jvc29mdC5jb22CH3N6a29seXByenlzemxvc2NpLm1pY3Jvc29mdC5j
b22CH3d3dy5wb3dlcmF1dG9tYXRlLm1pY3Jvc29mdC5jb22CIHN1Y2Nlc3Npb25w
bGFubmluZy5taWNyb3NvZnQuY29tgiJsdW1pYWNvbnZlcnNhdGlvbnN1ay5taWNy
b3NvZnQuY29tgiNzdWNjZXNzaW9ucGxhbm5pbmd1YXQubWljcm9zb2Z0LmNvbYIk
YnVzaW5lc3Ntb2JpbGl0eWNlbnRlci5taWNyb3NvZnQuY29tgiVza3lwZWFuZHRl
YW1zLmZhc3R0cmFjay5taWNyb3NvZnQuY29tgid3d3cubWljcm9zb2Z0ZGxhcGFy
dG5lcm93Lm1pY3Jvc29mdC5jb22CKGNvbW1lcmNpYWxhcHBjZXJ0aWZpY2F0aW9u
Lm1pY3Jvc29mdC5jb22CKXd3dy5za3lwZWFuZHRlYW1zLmZhc3R0cmFjay5taWNy
b3NvZnQuY29tgiJjZW9jb25uZWN0aW9ucy5ldmVudC5taWNyb3NvZnQuY29tghhi
aXo0YWZyaWthLm1pY3Jvc29mdC5jb22CFmNhc2hiYWNrLm1pY3Jvc29mdC5jb22C
Gnd3dy5jYXNoYmFjay5taWNyb3NvZnQuY29tghN2aXNpby5taWNyb3NvZnQuY29t
ghdpbnNpZGVtc3IubWljcm9zb2Z0LmNvbYIfZGV2ZWxvcGVydmVsb2NpdHlhc3Nl
c3NtZW50LmNvbYIjd3d3LmRldmVsb3BlcnZlbG9jaXR5YXNzZXNzbWVudC5jb22C
CmdlYXJzNS5jb22CDnd3dy5nZWFyczUuY29tghR3d3cuZ2VhcnN0YWN0aWNzLmNv
bYIQZ2VhcnN0YWN0aWNzLmNvbYIRbTEyLm1pY3Jvc29mdC5jb22CDHNlZWluZ2Fp
LmNvbYIYeW91cmNob2ljZS5taWNyb3NvZnQuY29tghltdnRkLmV2ZW50cy5taWNy
b3NvZnQuY29tghVpbWFnaW5lLm1pY3Jvc29mdC5jb22CEG1pY3Jvc29mdC5jb20u
YXWCFHd3dy5taWNyb3NvZnQuY29tLmF1ghZkeW5hbWljcy5taWNyb3NvZnQuY29t
ghtwb3dlcnBsYXRmb3JtLm1pY3Jvc29mdC5jb22CF3Bvd2VyYXBwcy5taWNyb3Nv
ZnQuY29tghtwb3dlcmF1dG9tYXRlLm1pY3Jvc29mdC5jb22CIHBvd2VydmlydHVh
bGFnZW50cy5taWNyb3NvZnQuY29tghhwb3dlcnBhZ2VzLm1pY3Jvc29mdC5jb22C
H3Rlc3QuaWRlYXMuZmFicmljLm1pY3Jvc29mdC5jb22CEXNkcy5taWNyb3NvZnQu
Y29tghVwcGUuc2RzLm1pY3Jvc29mdC5jb22CG3d3dy5taWNyb3NvZnQzNjVjb3Bp
bG90LmNvbYIQd3d3LmpjbGFyaXR5LmNvbYIbdGVjaGlubm92YXRvcnNzcG90bGln
aHQuY29tgh93d3cudGVjaGlubm92YXRvcnNzcG90bGlnaHQuY29tggpjb3BpbG90
LmFpghVnZXRsaWNlbnNpbmdyZWFkeS5jb22CGXd3dy5nZXRsaWNlbnNpbmdyZWFk
eS5jb22CFGpwbi5kZWx2ZS5vZmZpY2UuY29tghRhdXMuZGVsdmUub2ZmaWNlLmNv
bYIUaW5kLmRlbHZlLm9mZmljZS5jb22CFGtvci5kZWx2ZS5vZmZpY2UuY29tghZj
b2JyYS5tZS5taWNyb3NvZnQuY29tghd3d3cuYnVzaW5lc3NjZW50cmFsLmNvbYIT
YnVzaW5lc3NjZW50cmFsLmNvbYIcbXNhaWRhdGFzdHVkaW8ub2ZmaWNlcHBlLm5l
dIIaaWRlYXMuZmFicmljLm1pY3Jvc29mdC5jb22CDHd3dy5jcHQubGlua4IIY3B0
LmxpbmuCDHlhcnAuZG90Lm5ldIITbWljcm9zb2Z0c3RyZWFtLmNvbYIXd3d3Lm1p
Y3Jvc29mdHN0cmVhbS5jb22CF3dlYi5taWNyb3NvZnRzdHJlYW0uY29tghNkaXNj
b3Zlci5jb3BpbG90LmFpggtjb3BpbG90LmNvbYIPd3d3LmNvcGlsb3QuY29tghRk
aXNjb3Zlci5jb3BpbG90LmNvbYIbcmVzZWFyY2hmb3J1bS5taWNyb3NvZnQuY29t
gh9jZG4udGVjaGNvbW11bml0eS5taWNyb3NvZnQuY29tMAwGA1UdEwEB/wQCMAAw
gfEGA1UdHwSB6TCB5jCB46CB4KCB3YZsaHR0cDovL3d3dy5taWNyb3NvZnQuY29t
L3BraW9wcy9jcmwvcGFydGl0aW9uL01pY3Jvc29mdCUyMFRMUyUyMEcyJTIwUlNB
JTIwQ0ElMjBPQ1NQJTIwMDJfUGFydGl0aW9uMDAwNDYuY3Jshm1odHRwOi8vY3Js
Mi5taWNyb3NvZnQuY29tL3BraW9wcy9jcmwvcGFydGl0aW9uL01pY3Jvc29mdCUy
MFRMUyUyMEcyJTIwUlNBJTIwQ0ElMjBPQ1NQJTIwMDJfUGFydGl0aW9uMDAwNDYu
Y3JsMGYGA1UdIARfMF0wCAYGZ4EMAQICMFEGDCsGAQQBgjdMg30BATBBMD8GCCsG
AQUFBwIBFjNodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL0RvY3MvUmVw
b3NpdG9yeS5odG0wHwYDVR0jBBgwFoAUuC8zpnxRT38fLdXIFUI4pLIOjy8wEwYD
VR0lBAwwCgYIKwYBBQUHAwEwDQYJKoZIhvcNAQEMBQADggIBAI4zQFJo9O9FSr27
2NT2gQWTthjlrrkSKlOFtG9LrduY3Xmp0DVJcZDJjnEYaf6SFt2m//wxmeZJ+weK
u3u4DXEsnqHHLeuZBlwH3DpDQAQi/m6wC/ld2JhN4JLzXQCez35XRGf0x7QBrcUy
Gdlvcfpu9Hf/xSyjMl/jFp0UPUUxkrnrrrwxovwrB1PPQItuOU+nreL11AkNXhIU
ITKlrMfpP3kjtVoZyKyY9skvlfy6UyUYGlK9Rf3MEDC8/WhUtwxuwtI+j5EfqcDR
sXLOiBQXrr7WhqXNtGY5fXA7mLSr/IatNNIcddcuK5kqFwIVC3F23lXoJrDb3xFx
LIkGEr710ssVrwJGBx5ERPAaStNlD0/57gZQRn/LOKPMVSjwSJhEIzLOdoF5wh2Y
Jf+0mDDgW2bLDF5TAz8D5qSxmGTIKJT4loSnbTYYrgzc6MX5q7kPwqAqjyEaBm6e
t/RTENEjJ8sufzuLBz3SUQegM6HTMRB87s/09wNgBMyhKm3sCCLWZKjFVS9SND7W
OSy2PGhoER83vHkyZILnJeQIQ+IMnTCfmy1HN5qQ4JUKTcoMA8+hcTSdNOM5qLGr
Gf100aK0sqka50Wga6z8EjUrLijz1+GTfkP37k/MLUoN13ugPSjOcWdcGfTcEKEL
de2gzNb91Tn7TxKvzGYf4EM55WZy
-----END CERTIFICATE-----
 1 s:C=US, O=Microsoft Corporation, CN=Microsoft TLS G2 RSA CA OCSP 02
   i:C=US, O=Microsoft Corporation, CN=Microsoft TLS RSA Root G2
   a:PKEY: RSA, 4096 (bit); sigalg: sha384WithRSAEncryption
   v:NotBefore: Aug  1 20:03:00 2025 GMT; NotAfter: Jun  3 20:03:00 2029 GMT
-----BEGIN CERTIFICATE-----
MIIHuDCCBaCgAwIBAgITMwAAAAxJZKFvRCA7IgAAAAAADDANBgkqhkiG9w0BAQwF
ADBRMQswCQYDVQQGEwJVUzEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9u
MSIwIAYDVQQDExlNaWNyb3NvZnQgVExTIFJTQSBSb290IEcyMB4XDTI1MDgwMTIw
MDMwMFoXDTI5MDYwMzIwMDMwMFowVzELMAkGA1UEBhMCVVMxHjAcBgNVBAoTFU1p
Y3Jvc29mdCBDb3Jwb3JhdGlvbjEoMCYGA1UEAxMfTWljcm9zb2Z0IFRMUyBHMiBS
U0EgQ0EgT0NTUCAwMjCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALFf
yY9swhGdLUa31wstRz9z5Kg7nDbxaCBFQF5wYUrMSZceyBaSsy13mG08dhwgisMv
DGOfv69rBwYah+MKkNaUAN7gHXT1xc44NZMg+QhaZqjbsyA0nUOFRRIIF3ClrguD
qttEyOtoR1WahF3ZqRjCUoahH2JAZa7U81468pFe21rbtaROBWKY7N0Voa+FJ8ZL
rDKswmimzMnSfTdrxhCQBXkivGPm2X7ZwxCMknFtfeJ2FD0Ki8sjYBC4GBl2xOKh
dtoBzYO9Ae3YGK9XQu4Nha6pkhh5ywEzxk6CbETWKfTPxlF+4ZFi+Iyo6tr5QKBY
yHhumjrUQOdQGMmZHupCPme+dwWLnBsIthM85cE8p4yir0mhkUVlMZgDwPUhu8QP
3x4DFqW+OHlq2puE5aOXX4d3ypb/u1H47yEkwuK1fDl7ROViyRaIHNsTIuz4trEc
AFVOPpZ63AwFHI3jXiMALVv/4lWAQYU2lTD1mZO3buY0RbwzlYZzCimVwZdX1dbu
n8F0w8WgYj530r1tEONpi36oUbDYSsNBvqhP2mrDWCUWHFk8rQ113LE/VRzRdguI
56IxJQN7UUxZKzf+lSRUQqu6J1874QcvdqDAy8t2kR6dpuf9SkDi1I+hPbqGRJ1p
2Bkji1+hg+VlV4tN1nykYypkQ1RHhS8EsKrBL0o/AgMBAAGjggKBMIICfTAOBgNV
HQ8BAf8EBAMCAYYwEAYJKwYBBAGCNxUBBAMCAQAwHQYDVR0OBBYEFLgvM6Z8UU9/
Hy3VyBVCOKSyDo8vMBMGA1UdIAQMMAowCAYGZ4EMAQICMBMGA1UdJQQMMAoGCCsG
AQUFBwMBMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIAQwBBMBIGA1UdEwEB/wQIMAYB
Af8CAQAwHwYDVR0jBBgwFoAU3pGGSLehMVkx8UtfB6nciHnaqHYwgasGA1UdHwSB
ozCBoDCBnaCBmqCBl4ZJaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9j
cmwvTWljcm9zb2Z0JTIwVExTJTIwUlNBJTIwUm9vdCUyMEcyLmNybIZKaHR0cDov
L2NybDIubWljcm9zb2Z0LmNvbS9wa2lvcHMvY3JsL01pY3Jvc29mdCUyMFRMUyUy
MFJTQSUyMFJvb3QlMjBHMi5jcmwwggEQBggrBgEFBQcBAQSCAQIwgf8wYwYIKwYB
BQUHMAKGV2h0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvY2VydHMvTWlj
cm9zb2Z0JTIwVExTJTIwUlNBJTIwUm9vdCUyMEcyJTIwLSUyMHhzaWduLmNydDBp
BggrBgEFBQcwAoZdaHR0cDovL2NhaXNzdWVycy5taWNyb3NvZnQuY29tL3BraW9w
cy9jZXJ0cy9NaWNyb3NvZnQlMjBUTFMlMjBSU0ElMjBSb290JTIwRzIlMjAtJTIw
eHNpZ24uY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vb25lb2NzcC5taWNyb3NvZnQu
Y29tL29jc3AwDQYJKoZIhvcNAQEMBQADggIBACGusqgM8zXYTiHTNvrDXqobFI9g
GF1dNgkZIizyNNI8EMiG/fq7bhDwbokxZH2xDIfoNgtGI8r88DX8dQV3aUm07IKW
lu/qV9VJO8gF5/GyxHrgxCvW/IXBoJNnHGLyCWH6rJjuwG3cGIPYplNMUfRnyGCk
SYR1qcRW0Dx5OTh/JlrXAy7/UJIBU9COSAlKv1APr49CYz4iYl25la+tEonWkVE2
qZHrnRuCxyOR7mYlQWKIzdkQVnChmsvzjEjgkW3qv4dHGvanfUeKlou+t0tm4MB7
rm2wmTV4ydACIEzKDnV40wNz7JFHAgJ6KtGDk8KfhIk1Nn2iRPxzo34EIBWL9uuU
E6C3le07w3Z1LoABEJ2vYMKPFVUwG7v4A1+Y5QQtGrGs9NrpHA6QGOkOypPIyHp/
hoZ2Gp3WkyN5UXNDKJIGmE/clGQt86/K3MqZ9RiwwnHYM0+IO/KTinNTSbW+ZhMg
Fxki/Ug55kLA33b4T+cT6HUXWr5yM9iLAW3oyxTIhld1nD5esMt70bNF7WgLW0AA
txkxhDYDmKQ3oyHrrGPZWLz4N7wxHCZbyHbDgjCyiPYujpqsQ6fxthalQtkV6ycu
GLP2sZhSv89myfSgfHkwtcr7bRL0my0R94CXneQhqcXG3undRwlgikU9gfiuTaZG
h8VmoQHGVMiqVtXE
-----END CERTIFICATE-----
 2 s:C=US, O=Microsoft Corporation, CN=Microsoft TLS RSA Root G2
   i:C=US, O=DigiCert Inc, OU=www.digicert.com, CN=DigiCert Global Root G2
   a:PKEY: RSA, 4096 (bit); sigalg: sha384WithRSAEncryption
   v:NotBefore: May 21 00:00:00 2025 GMT; NotAfter: Jun 19 23:59:59 2029 GMT
-----BEGIN CERTIFICATE-----
MIIFiTCCBHGgAwIBAgIQCwxrLEZpF7BHc8ZH1K/AyDANBgkqhkiG9w0BAQwFADBh
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
d3cuZGlnaWNlcnQuY29tMSAwHgYDVQQDExdEaWdpQ2VydCBHbG9iYWwgUm9vdCBH
MjAeFw0yNTA1MjEwMDAwMDBaFw0yOTA2MTkyMzU5NTlaMFExCzAJBgNVBAYTAlVT
MR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xIjAgBgNVBAMTGU1pY3Jv
c29mdCBUTFMgUlNBIFJvb3QgRzIwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIK
AoICAQDf6oufR+EoEHGvQdYZ25JX3mur5i7erTpgg7cTmKxbuTILe+ufcidrXUCr
vhgGk7IN0hLtuHT1fy/qqBeU9jMWV4reIHwh3bfarN5OZLBazUt18+8CZE3tUtqj
jwTokfjX+z8Z/U5FOV7oKcPW8mevswCUwY3h8EoYmDn6wAmEM0EFAwWr9HXhU6Uh
klxETOZgV6SQApfH1diTBDJK7YVR7dbFuqA/Noovb0w5qARpIoQ7dRT32T60qdAH
QTiBfkZIHegZ5nC4oKoY3XK/fn21bE4ZcBGEBBOB1GL9nGvxHN3/7Kfg5seNMUu/
8mszzNGMtv6xG6NKqF8OfzF2OD8HR2wBqKylFNqCsF8fbLyJGsASKst7lx8oLjEW
ilNMdWb5fQHWwmCqZY8xnnLLzJst5UQZk1erbo7C2S5lsHIt56HDoX5JHVln1gnU
GBJtwJVFeMnxYGrk9u4GJDtzSloRwj6XYcB47u8TpzDiSjgt7lgXEyC3NirfCzK0
wjixkd0SsEW2fMCxHWKhnd1xEhWWAZ0KCfWx3bPZ4DhCNPZptsOvFnP+1EP4Q+RY
+U+z8+zWPZQ6QDgVqwyG0GTOGmPohJRVCVq2BLbRPpoVx2QRgNAbgg5N/0WesmUH
JR/bmsjG7NZbhVAEnxzLXSCCZ5554t/o8uhvxCByMIblnXUnNQIDAQABo4IBSzCC
AUcwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQU3pGGSLehMVkx8UtfB6nciHna
qHYwHwYDVR0jBBgwFoAUTiJUIBiV5uNu5g/6+rkS7QYXjzkwDgYDVR0PAQH/BAQD
AgGGMBMGA1UdJQQMMAoGCCsGAQUFBwMBMHYGCCsGAQUFBwEBBGowaDAkBggrBgEF
BQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEAGCCsGAQUFBzAChjRodHRw
Oi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRHbG9iYWxSb290RzIuY3J0
MEIGA1UdHwQ7MDkwN6A1oDOGMWh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdp
Q2VydEdsb2JhbFJvb3RHMi5jcmwwEwYDVR0gBAwwCjAIBgZngQwBAgIwDQYJKoZI
hvcNAQEMBQADggEBAAu8tCs3dMVLpzYCNsav4RPMipqXG/zjRIzuVADl5EEaRvAL
djT/mVViNaqtipwMWmLMQ8DL6kodvWsdr7EZJWac93luWyWAJIGFx3ktNV9CCXjt
n+Jl1cQgUIIQj2o67RiOSImrpgn44YD8BnUWJyVaj7g6cGwYR/Bj9FMO2RU1IPOR
PRMBoOL6JAhFVnfRZ6kxQtBX/xomvsVD2FepY/+v8zrY9ntLEKKXoc9mvmdnCfm1
TOerGSu/Ij193sb372M4LN1WxPkJUtrf44hv1W1r9whBL44+hjGf8XxK9dZhpEZG
KO9XurBvktjSdyXte6YpzjtyeRHU4KdUbTUrpHo=
-----END CERTIFICATE-----
 3 s:C=US, O=DigiCert Inc, OU=www.digicert.com, CN=DigiCert Global Root G2
   i:C=US, O=DigiCert Inc, OU=www.digicert.com, CN=DigiCert Global Root G2
   a:PKEY: RSA, 2048 (bit); sigalg: sha256WithRSAEncryption
   v:NotBefore: Aug  1 12:00:00 2013 GMT; NotAfter: Jan 15 12:00:00 2038 GMT
-----BEGIN CERTIFICATE-----
MIIDjjCCAnagAwIBAgIQAzrx5qcRqaC7KGSxHQn65TANBgkqhkiG9w0BAQsFADBh
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
d3cuZGlnaWNlcnQuY29tMSAwHgYDVQQDExdEaWdpQ2VydCBHbG9iYWwgUm9vdCBH
MjAeFw0xMzA4MDExMjAwMDBaFw0zODAxMTUxMjAwMDBaMGExCzAJBgNVBAYTAlVT
MRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5j
b20xIDAeBgNVBAMTF0RpZ2lDZXJ0IEdsb2JhbCBSb290IEcyMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuzfNNNx7a8myaJCtSnX/RrohCgiN9RlUyfuI
2/Ou8jqJkTx65qsGGmvPrC3oXgkkRLpimn7Wo6h+4FR1IAWsULecYxpsMNzaHxmx
1x7e/dfgy5SDN67sH0NO3Xss0r0upS/kqbitOtSZpLYl6ZtrAGCSYP9PIUkY92eQ
q2EGnI/yuum06ZIya7XzV+hdG82MHauVBJVJ8zUtluNJbd134/tJS7SsVQepj5Wz
tCO7TG1F8PapspUwtP1MVYwnSlcUfIKdzXOS0xZKBgyMUNGPHgm+F6HmIcr9g+UQ
vIOlCsRnKPZzFBQ9RnbDhxSJITRNrw9FDKZJobq7nMWxM4MphQIDAQABo0IwQDAP
BgNVHRMBAf8EBTADAQH/MA4GA1UdDwEB/wQEAwIBhjAdBgNVHQ4EFgQUTiJUIBiV
5uNu5g/6+rkS7QYXjzkwDQYJKoZIhvcNAQELBQADggEBAGBnKJRvDkhj6zHd6mcY
1Yl9PMWLSn/pvtsrF9+wX3N3KjITOYFnQoQj8kVnNeyIv/iPsGEMNKSuIEyExtv4
NeF22d+mQrvHRAiGfzZ0JFrabA0UWTW98kndth/Jsw1HKj2ZL7tcu7XUIOGZX1NG
Fdtom/DzMNU+MeKNhJ7jitralj41E6Vf8PlwUHBHQRFXGU7Aj64GxJUTFy8bJZ91
8rGOmaFvE7FBcf6IKshPECBV1/MUReXgRPTqh5Uykw7+U0b6LJ3/iyK5S9kJRaTe
pLiaWN0bfVKfjllDiIGknibVb63dDcY3fe0Dkhvld1927jyNxF1WW6LZZm6zNTfl
MrY=
-----END CERTIFICATE-----
---
Server certificate
subject=C=US, ST=WA, L=Redmond, O=Microsoft Corporation, CN=microsoft.com
issuer=C=US, O=Microsoft Corporation, CN=Microsoft TLS G2 RSA CA OCSP 02
---
No client certificate CA names sent
Peer signing digest: SHA256
Peer signature type: rsa_pss_rsae_sha256
Peer Temp Key: ECDH, prime256v1, 256 bits
---
SSL handshake has read 11421 bytes and written 1981 bytes
Verification: OK
---
New, TLSv1.3, Cipher is TLS_AES_256_GCM_SHA384
Protocol: TLSv1.3
Server public key is 2048 bit
This TLS version forbids renegotiation.
Compression: NONE
Expansion: NONE
No ALPN negotiated
Early data was not sent
Verify return code: 0 (ok)
---
---
Post-Handshake New Session Ticket arrived:
SSL-Session:
    Protocol  : TLSv1.3
    Cipher    : TLS_AES_256_GCM_SHA384
    Session-ID: A2992682FFC404AD616469C86CA7562D1C2A51524CFA80B97636CB6A0EFC1A6D
    Session-ID-ctx:
    Resumption PSK: 8858B828ABC974E1E3F62DA5BCEEDE280B80CAAEC0C290F3BBA445DEA366FE52F893451869B38B41FDB9295DD0551B5C
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 36000 (seconds)
    TLS session ticket:
    0000 - 57 53 54 2d 30 35 30 31-54 31 33 3a 31 35 20 20   WST-0501T13:15
    0010 - 64 26 01 5b d2 1d be 3f-3c 26 33 13 ef 94 37 f5   d&.[...?<&3...7.
    0020 - cd 54 73 9b da a5 6e cb-7d f0 62 92 6d 5f fe ac   .Ts...n.}.b.m_..
    0030 - 88 a8 bf aa 8b 83 4b d2-0f 31 71 2b b6 a4 77 9b   ......K..1q+..w.
    0040 - 20 12 74 4e 46 fb f6 73-45 4f ab 6a f0 ef fe 3b    .tNF..sEO.j...;
    0050 - d1 c4 6b 27 85 12 8d 7c-7e d7 3a 28 a7 a7 43 59   ..k'...|~.:(..CY
    0060 - 8f 99 c6 14 07 43 77 d4-63 44 3b 39 98 f6 cf e3   .....Cw.cD;9....
    0070 - 88 ba 25 ad ec af c9 b0-fc da 63 2e e1 9f 53 a6   ..%.......c...S.
    0080 - e3 f6 ab 1b 93 c6 3d e2-26 c4 ce 10 3c db 54 a1   ......=.&...<.T.
    0090 - 30 26 7c 86 f0 05 41 4c-ec ee f9 99 b6 02 6d de   0&|...AL......m.
    00a0 - 56 7b af 01 83 5c b8 16-80 51 c9 d4 7d a2 29 18   V{...\...Q..}.).
    00b0 - 21 c2 c8 b3 24 49 b1 58-44 ed bf 36 21 ed 3a 80   !...$I.XD..6!.:.
    00c0 - 65 e1 c8 7f 6b 7b 9a 25-9c ce 79 7b b7 9a c6 cf   e...k{.%..y{....
    00d0 - b6 4f a3 b1 31 b3 59 24-3f 8c c0 54 fb 7e 1f 17   .O..1.Y$?..T.~..
    00e0 - 63 e0 ad 3f 51 c7 97 6c-36 90 31 4c ef 05 47 02   c..?Q..l6.1L..G.

    Start Time: 1777670135
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
    Extended master secret: no
    Max Early Data: 0
---
read R BLOCK
---
Post-Handshake New Session Ticket arrived:
SSL-Session:
    Protocol  : TLSv1.3
    Cipher    : TLS_AES_256_GCM_SHA384
    Session-ID: CC4A6E172A0FDDF0BAFDBC221883C92DE5E74BB95191AF85B301FC3F70276380
    Session-ID-ctx:
    Resumption PSK: D646BE4CC9587A318D6AEB8C78582207F2EBF6BB856AD014BC42663E62BFD767FA9769070D3839F8EB07073EDC652C89
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 36000 (seconds)
    TLS session ticket:
    0000 - 57 53 54 2d 30 35 30 31-54 31 33 3a 31 35 20 20   WST-0501T13:15
    0010 - 39 02 f1 72 06 84 c2 77-34 e4 e8 e7 70 6d fd 57   9..r...w4...pm.W
    0020 - 32 35 29 24 e3 62 8f 62-e7 df 9d 85 f7 44 80 d6   25)$.b.b.....D..
    0030 - fa 84 08 a4 00 22 7b 56-e8 6e df fa 1f 79 95 12   ....."{V.n...y..
    0040 - b2 00 48 50 1b 25 95 42-e2 ea 13 fd a0 c9 ff a0   ..HP.%.B........
    0050 - 3a 78 03 2d de ca bb 3d-bb b7 e8 35 19 3a d1 66   :x.-...=...5.:.f
    0060 - 86 ba 0d 32 ee bd c7 b8-7a b4 47 ca 4a 91 55 fd   ...2....z.G.J.U.
    0070 - de 86 c2 8c 9b ed e6 ad-63 cd fd 44 b7 ab 11 f9   ........c..D....
    0080 - fc 32 a7 1c 60 3d 43 56-04 ad e8 29 b0 1a ee 50   .2..`=CV...)...P
    0090 - 8a d4 11 0c 7d 77 da eb-36 da c8 44 c0 7d 04 b7   ....}w..6..D.}..
    00a0 - d5 88 39 ac a7 6a d9 fd-57 b4 a4 e5 13 ed 68 87   ..9..j..W.....h.
    00b0 - 93 74 56 5a f8 f6 b9 11-40 7f a4 86 6c db 98 b7   .tVZ....@...l...
    00c0 - dc 82 3f 11 9e e8 7f 36-ac fd 76 ef 13 4b 7b 9f   ..?....6..v..K{.
    00d0 - 47 21 1d fb 58 ca 23 1c-20 c4 b6 b1 41 88 c9 cb   G!..X.#. ...A...
    00e0 - df af 6f d1 cb c6 60 ec-7f fb cc 80 36 40 d7 7f   ..o...`.....6@..

    Start Time: 1777670135
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
    Extended master secret: no
    Max Early Data: 0
```

The output indicates the negotiated protocol and, most importantly, that the verify return code is 0 (ok).

1. Update CA bundle

Ubuntu or SUSE:
```bash
sudo update-ca-certificates
```

Red Hat:
```bash
sudo update-ca-trust
```
1. Validate everything by running
```bash
openssl s_client -connect example.com:443 -showcerts
```

The result should be similar to the example, showing the negotiated protocol and that the verify return code is 0 (ok).

> [!NOTE]
> If the steps provided aren't helpful, you need to:
> Check if the certificate requires installation of intermediate certificates. If it's a non-Microsoft certificate, contact the vendor.
> Use [Azure User Defined Routes (UDRs)](/azure/virtual-network/virtual-networks-udr-overview?source=docs#user-defined-routes) to pass the traffic directly to the destination to test and confirm that this is the issue.
> Check with your firewall or proxy vendor on how to disable TLS inspection for the resource being affected.
> Check with your firewall or proxy vendor on how to install their certificates on your clients to avoid errors.


[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
