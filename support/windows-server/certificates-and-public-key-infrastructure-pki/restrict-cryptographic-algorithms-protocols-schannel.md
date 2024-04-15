---
title: Restrict cryptographic algorithms and protocols
description: Discusses how to restrict the use of certain cryptographic algorithms and protocols in Schannel.dll.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Certificates and Public Key Infrastructure (PKI)\Transport Layer Security (TLS) or Schannel (SSL), csstroubleshoot
---
# Restrict the use of certain cryptographic algorithms and protocols in Schannel.dll

This article describes how to restrict the use of certain cryptographic algorithms and protocols in the Schannel.dll file. This information also applies to independent software vendor (ISV) applications that are written for the Microsoft Cryptographic API (CAPI).

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 245030

> [!NOTE]
> This article applies to Windows Server 2003 and earlier versions of Windows. For registry keys that apply to Windows Server 2008 and later versions of Windows, see the [TLS Registry Settings](/windows-server/security/tls/tls-registry-settings).

## Summary

The following cryptographic service providers (CSPs) that are included with Windows NT 4.0 Service Pack 6 were awarded the certificates for FIPS-140-1 crypto validation.

- Microsoft Base Cryptographic Provider (Rsabase.dll)
- Microsoft Enhanced Cryptographic Provider (Rsaenh.dll) (non-export version)

Microsoft TLS/SSL Security Provider, the Schannel.dll file, uses the CSPs that are listed here to conduct secure communications over SSL or TLS in its support for Internet Explorer and Internet Information Services (IIS).

You can change the Schannel.dll file to support Cipher Suite 1 and 2. However, the program must also support Cipher Suite 1 and 2. Cipher Suites 1 and 2 are not supported in IIS 4.0 and 5.0.

This article contains the necessary information to configure the TLS/SSL Security Provider for Windows NT 4.0 Service Pack 6 and later versions. You can use the Windows registry to control the use of specific SSL 3.0 or TLS 1.0 cipher suites with respect to the cryptographic algorithms that are supported by the Base Cryptographic Provider or the Enhanced Cryptographic Provider.

> [!NOTE]
> In Windows NT 4.0 Service Pack 6, the Schannel.dll file does not use the Microsoft Base DSS Cryptographic Provider (Dssbase.dll) or the Microsoft DS/Diffie-Hellman Enhanced Cryptographic Provider (Dssenh.dll).

## Cipher suites

Both SSL 3.0 and TLS 1.0 (RFC2246) with INTERNET-DRAFT _56-bit Export Cipher Suites For TLS draft-ietf-tls-56-bit-ciphersuites-00.txt_ provide options to use different cipher suites. Each cipher suite determines the key exchange, authentication, encryption, and MAC algorithms that are used in an SSL/TLS session. When you use RSA as both key exchange and authentication algorithms, the term **RSA** appears only one time in the corresponding cipher suite definitions.

The Windows NT 4.0 Service Pack 6 Microsoft TLS/SSL Security Provider supports the following SSL 3.0-defined CipherSuite when you use the Base Cryptographic Provider or the Enhanced Cryptographic Provider:

|SSL 3.0|Cipher suite|
|---|---|
|SSL_RSA_EXPORT_WITH_RC4_40_MD5|`{ 0x00,0x03 }`|
|SSL_RSA_WITH_RC4_128_MD5|`{ 0x00,0x04 }`|
|SSL_RSA_WITH_RC4_128_SHA|`{ 0x00,0x05 }`|
|SSL_RSA_EXPORT_WITH_RC2_CBC_40_MD5|`{ 0x00,0x06 }`|
|SSL_RSA_WITH_DES_CBC_SHA|`{ 0x00,0x09 }`|
|SSL_RSA_WITH_3DES_EDE_CBC_SHA|`{ 0x00,0x0A }`|
|SSL_RSA_EXPORT1024_WITH_DES_CBC_SHA|`{ 0x00,0x62 }`|
|SSL_RSA_EXPORT1024_WITH_RC4_56_SHA|`{ 0x00,0x64 }`|
  
> [!NOTE]
> Neither SSL_RSA_EXPORT1024_WITH_DES_CBC_SHA nor SSL_RSA_EXPORT1024_WITH_RC4_56_SHA is defined in SSL 3.0 text. However, several SSL 3.0 vendors support them. This includes Microsoft.

Windows NT 4.0 Service Pack 6 Microsoft TLS/SSL Security Provider also supports the following TLS 1.0-defined CipherSuite when you use the Base Cryptographic Provider or Enhanced Cryptographic Provider:

|TLS 1.0|Cipher suite|
|---|---|
|TLS_RSA_EXPORT_WITH_RC4_40_MD5|`{ 0x00,0x03 }`|
|TLS_RSA_WITH_RC4_128_MD5|`{ 0x00,0x04 }`|
|TLS_RSA_WITH_RC4_128_SHA|`{ 0x00,0x05 }`|
|TLS_RSA_EXPORT_WITH_RC2_CBC_40_MD5|`{ 0x00,0x06 }`|
|TLS_RSA_WITH_DES_CBC_SHA|`{ 0x00,0x09 }`|
|TLS_RSA_WITH_3DES_EDE_CBC_SHA|`{ 0x00,0x0A }`|
|TLS_RSA_EXPORT1024_WITH_DES_CBC_SHA|`{ 0x00,0x62 }`|
|TLS_RSA_EXPORT1024_WITH_RC4_56_SHA|`{ 0x00,0x64 }`|
  
> [!NOTE]
> A cipher suite that is defined by using the first byte 0x00 is non-private and is used for open interoperable communications. Therefore, the Windows NT 4.0 Service Pack 6 Microsoft TLS/SSL Security Provider follows the procedures for using these cipher suites as specified in SSL 3.0 and TLS 1.0 to make sure of interoperability.

## Schannel-specific registry keys

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

> [!NOTE]
> Any changes to the contents of the **CIPHERS** key or the **HASHES** key take effect immediately, without a system restart.

### SCHANNEL key

Start Registry Editor (Regedt32.exe), and then locate the following registry key:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL`  

### SCHANNEL\Protocols subkey

To enable the system to use the protocols that will not be negotiated by default (such as TLS 1.1 and TLS 1.2), change the DWORD value data of the **DisabledByDefault** value to **0x0** in the following registry keys under the **Protocols** key:

- `SCHANNEL\Protocols\TLS 1.1\Client`
- `SCHANNEL\Protocols\TLS 1.1\Server`
- `SCHANNEL\Protocols\TLS 1.2\Client`
- `SCHANNEL\Protocols\TLS 1.2\Server`

> [!WARNING]
> The **DisabledByDefault** value in the registry keys under the **Protocols** key does not take precedence over the **grbitEnabledProtocols** value that is defined in the `SCHANNEL_CRED` structure that contains the data for an Schannel credential.

### SCHANNEL\Ciphers subkey

The **Ciphers** registry key under the **SCHANNEL** key is used to control the use of symmetric algorithms such as DES and RC4. The following are valid registry keys under the **Ciphers** key.

Create the SCHANNEL Ciphers subkey in the format: `SCHANNEL\(VALUE)\(VALUE/VALUE)`

**RC4 128/128**

  Ciphers subkey: `SCHANNEL\Ciphers\RC4 128/128`

  This subkey refers to 128-bit RC4.

  To allow this cipher algorithm, change the DWORD value data of the **Enabled** value to **0xffffffff**. Or, change the DWORD value data to **0x0**. If you do not configure the **Enabled** value, the default is enabled. This registry key does not apply to an exportable server that does not have an SGC certificate.

  Disabling this algorithm effectively disallows the following values:

- SSL_RSA_WITH_RC4_128_MD5
- SSL_RSA_WITH_RC4_128_SHA
- TLS_RSA_WITH_RC4_128_MD5
- TLS_RSA_WITH_RC4_128_SHA

**Triple DES 168**

  Ciphers subkey: `SCHANNEL\Ciphers\Triple DES 168`

  This registry key refers to 168-bit Triple DES as specified in ANSI X9.52 and Draft FIPS 46-3. This registry key does not apply to the export version.

  To allow this cipher algorithm, change the DWORD value data of the **Enabled** value to **0xffffffff**. Or, change the DWORD data to **0x0**. If you do not configure the **Enabled** value, the default is enabled.

  Disabling this algorithm effectively disallows the following values:

- SSL_RSA_WITH_3DES_EDE_CBC_SHA
- SSL_DHE_DSS_WITH_3DES_EDE_CBC_SHA
- TLS_RSA_WITH_3DES_EDE_CBC_SHA
- TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA

  > [!NOTE]
  > For the versions of Windows that releases before Windows Vista, the key should be **Triple DES 168/168**.

**RC2 128/128**

  Ciphers subkey: `SCHANNEL\Ciphers\RC2 128/128`

  This registry key refers to 128-bit RC2. It does not apply to the export version.

  To allow this cipher algorithm, change the DWORD value data of the **Enabled** value to **0xffffffff**. Otherwise, change the DWORD value data to **0x0**. If you do not configure the **Enabled** value, the default is enabled.

**RC4 64/128**

  Ciphers subkey: `SCHANNEL\Ciphers\RC4 64/128`

  This registry key refers to 64-bit RC4. It does not apply to the export version (but is used in Microsoft Money).

  To allow this cipher algorithm, change the DWORD value data of the **Enabled** value to **0xffffffff**. Otherwise, change the DWORD value data to **0x0**. If you do not configure the **Enabled** value, the default is enabled.

**RC4 56/128**

  Ciphers subkey: `SCHANNEL\Ciphers\RC4 56/128`

  This registry key refers to 56-bit RC4.

  To allow this cipher algorithm, change the DWORD value data of the Enabled value to **0xffffffff**. Otherwise, change the DWORD value data to **0x0**. If you do not configure the **Enabled** value, the default is enabled.

  Disabling this algorithm effectively disallows the following value:

- TLS_RSA_EXPORT1024_WITH_RC4_56_SHA

**RC2 56/128**

  Ciphers subkey: `SCHANNEL\Ciphers\RC2 56/128`

  This registry key refers to 56-bit RC2.

  To allow this cipher algorithm, change the DWORD value data of the **Enabled** value to **0xffffffff**. Otherwise, change the DWORD value data to **0x0**. If you do not configure the **Enabled** value, the default is enabled.

**DES 56**

  Ciphers subkey: `SCHANNEL\Ciphers\DES 56/56`

  This registry key refers to 56-bit DES as specified in FIPS 46-2. Its implementation in the Rsabase.dll and Rsaenh.dll files is validated under the FIPS 140-1 Cryptographic Module Validation Program.

  To allow this cipher algorithm, change the DWORD value data of the **Enabled** value to **0xffffffff**. Otherwise, change the DWORD value data to **0x0**. If you do not configure the **Enabled** value, the default is enabled.

  Disabling this algorithm effectively disallows the following values:

- SSL_RSA_WITH_DES_CBC_SHA
- TLS_RSA_WITH_DES_CBC_SHA

**RC4 40/128**

  Ciphers subkey: `SCHANNEL\Ciphers\RC4 40/128`

  This registry key refers to 40-bit RC4.

  To allow this cipher algorithm, change the DWORD value data of the **Enabled** value to **0xffffffff**. Otherwise, change the DWORD value data to **0x0**. If you do not configure the **Enabled** value, the default is enabled.

  Disabling this algorithm effectively disallows the following values:

- SSL_RSA_EXPORT_WITH_RC4_40_MD5
- TLS_RSA_EXPORT_WITH_RC4_40_MD5

**RC2 40/128**

  Ciphers subkey: `SCHANNEL\Ciphers\RC2 40/128`

  This registry key refers to 40-bit RC2.

  To allow this cipher algorithm, change the DWORD value data of the **Enabled** value to **0xffffffff**. Otherwise, change the DWORD value data to **0x0**. If you do not configure the **Enabled** value, the default is enabled.

  Disabling this algorithm effectively disallows the following values:

- SSL_RSA_EXPORT_WITH_RC2_CBC_40_MD5
- TLS_RSA_EXPORT_WITH_RC2_CBC_40_MD5

**NULL**

  Ciphers subkey: `SCHANNEL\Ciphers\NULL`

  This registry key means no encryption. By default, it is turned off.

  To turn off encryption (disallow all cipher algorithms), change the DWORD value data of the **Enabled** value to **0xffffffff**. Otherwise, change the DWORD value data to **0x0**.

**Hashes**

Ciphers subkey: `SCHANNEL/Hashes`

  The **Hashes** registry key under the **SCHANNEL** key is used to control the use of hashing algorithms such as SHA-1 and MD5. The following are valid registry keys under the **Hashes** key.

**MD5**

  Ciphers subkey: `SCHANNEL\Hashes\MD5`

  To allow this hashing algorithm, change the DWORD value data of the **Enabled** value to the default value **0xffffffff**. Otherwise, change the DWORD value data to **0x0**.

  Disabling this algorithm effectively disallows the following values:

- SSL_RSA_EXPORT_WITH_RC4_40_MD5
- SSL_RSA_WITH_RC4_128_MD5
- SSL_RSA_EXPORT_WITH_RC2_CBC_40_MD5
- TLS_RSA_EXPORT_WITH_RC4_40_MD5
- TLS_RSA_WITH_RC4_128_MD5
- TLS_RSA_EXPORT_WITH_RC2_CBC_40_MD5

**SHA**

  Ciphers subkey: `SCHANNEL\Hashes\SHA`

  This registry key refers to Secure Hash Algorithm (SHA-1), as specified in FIPS 180-1. Its implementation in the Rsabase.dll and Rsaenh.dll files is validated under the FIPS 140-1 Cryptographic Module Validation Program.

  To allow this hashing algorithm, change the DWORD value data of the **Enabled** value to the default value **0xffffffff**. Otherwise, change the DWORD value data to **0x0**.

  Disabling this algorithm effectively disallows the following values:

- SSL_RSA_WITH_RC4_128_SHA
- SSL_RSA_WITH_DES_CBC_SHA
- SSL_RSA_WITH_3DES_EDE_CBC_SHA
- SSL_RSA_EXPORT1024_WITH_DES_CBC_SHA
- SSL_RSA_EXPORT1024_WITH_RC4_56_SHA
- TLS_RSA_WITH_RC4_128_SHA
- TLS_RSA_WITH_DES_CBC_SHA
- TLS_RSA_WITH_3DES_EDE_CBC_SHA
- TLS_RSA_EXPORT1024_WITH_DES_CBC_SHA
- TLS_RSA_EXPORT1024_WITH_RC4_56_SHA

**KeyExchangeAlgorithms**

  Ciphers subkey: `SCHANNEL/KeyExchangeAlgorithms`

  The **KeyExchangeAlgorithms** registry key under the **SCHANNEL** key is used to control the use of key exchange algorithms such as RSA. The following are valid registry keys under the **KeyExchangeAlgorithms** key.

**PKCS**

  Ciphers subkey: `SCHANNEL\KeyExchangeAlgorithms\PKCS`

  This registry key refers to the RSA as the key exchange and authentication algorithms.

  To allow RSA, change the DWORD value data of the **Enabled** value to the default value **0xffffffff**. Otherwise, change the DWORD data to **0x0**.

  Disabling RSA effectively disallows all RSA-based SSL and TLS cipher suites supported by the Windows NT4 SP6 Microsoft TLS/SSL Security Provider.

## FIPS 140-1 cipher suites

You may want to use only those SSL 3.0 or TLS 1.0 cipher suites that correspond to FIPS 46-3 or FIPS 46-2 and FIPS 180-1 algorithms provided by the Microsoft Base or Enhanced Cryptographic Provider.

In this article, we refer to them as FIPS 140-1 cipher suites. Specifically, they are as follows:

- SSL_RSA_WITH_DES_CBC_SHA
- SSL_RSA_WITH_3DES_EDE_CBC_SHA
- SSL_RSA_EXPORT1024_WITH_DES_CBC_SHA
- TLS_RSA_WITH_DES_CBC_SHA
- TLS_RSA_WITH_3DES_EDE_CBC_SHA
- TLS_RSA_EXPORT1024_WITH_DES_CBC_SHA

To use only FIPS 140-1 cipher suites as defined here and supported by Windows NT 4.0 Service Pack 6 Microsoft TLS/SSL Security Provider with the Base Cryptographic Provider or the Enhanced Cryptographic Provider, configure the DWORD value data of the **Enabled** value in the following registry keys to **0x0**:

- `SCHANNEL\Ciphers\RC4 128/128`
- `SCHANNEL\Ciphers\RC2 128/128`
- `SCHANNEL\Ciphers\RC4 64/128`
- `SCHANNEL\Ciphers\RC4 56/128`
- `SCHANNEL\Ciphers\RC2 56/128`
- `SCHANNEL\Ciphers\RC4 40/128`
- `SCHANNEL\Ciphers\RC2 40/128`
- `SCHANNEL\Ciphers\NULL`
- `SCHANNEL\Hashes\MD5`

And configure the DWORD value data of the **Enabled** value in the following registry keys to **0xffffffff**:

- `SCHANNEL\Ciphers\DES 56/56`
- `SCHANNEL\Ciphers\Triple DES 168/168` (not applicable in export version)
- `SCHANNEL\Hashes\SHA`
- `SCHANNEL\KeyExchangeAlgorithms\PKCS`

### Master secret computation by using FIPS 140-1 cipher suites

The procedures for using the FIPS 140-1 cipher suites in SSL 3.0 differ from the procedures for using the FIPS 140-1 cipher suites in TLS 1.0.

In SSL 3.0, the following is the definition master_secret computation:

In TLS 1.0, the following is the definition master_secret computation:

where:

Selecting the option to use only FIPS 140-1 cipher suites in TLS 1.0:

Because of this difference, customers may want to prohibit the use of SSL 3.0 even though the allowed set of cipher suites is limited to only the subset of FIPS 140-1 cipher suites. In that case, change the DWORD value data of the Enabled value to 0x0 in the following registry keys under the **Protocols** key:

- `SCHANNEL\Protocols\SSL 3.0\Client`
- `SCHANNEL\Protocols\SSL 3.0\Server`

> [!WARNING]
> The **Enabled** value data in these registry keys under the **Protocols** key takes precedence over the **grbitEnabledProtocols** value that is defined in the `SCHANNEL_CRED` structure that contains the data for a Schannel credential. The default **Enabled** value data is **0xffffffff**.

## Examples of registry files

Two examples of registry file content for configuration are provided in this section of the article. They are Export.reg and Non-export.reg.

In a computer that is running Windows NT 4.0 Service Pack 6 with the exportable Rasbase.dll and Schannel.dll files, run Export.reg to make sure that only TLS 1.0 FIPS cipher suites are used by the computer.

In a computer that is running Windows NT 4.0 Service Pack 6 that includes the non-exportable Rasenh.dll and Schannel.dll files, run Non-export.reg to make sure that only TLS 1.0 FIPS cipher suites are used by the computer.

For the Schannel.dll file to recognize any changes under the **SCHANNEL** registry key, you must restart the computer.

To return the registry settings to default, delete the **SCHANNEL** registry key and everything under it. If these registry keys are not present, the Schannel.dll rebuilds the keys when you restart the computer.
