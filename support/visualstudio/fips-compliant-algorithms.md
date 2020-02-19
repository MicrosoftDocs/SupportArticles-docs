---
title: Configure FIPS-compliant cryptography
description: Explains how to configure the negotiation of stronger, FIPS-compliant cryptography in Windows by enabling certain security settings.
ms.date: 02/19/2020
ms.prod-support-area-path: Developer Tools
---
# "System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing" security setting effects in Windows XP and in later versions of Windows

**Applies to**: Windows

_Original version:_ &nbsp; XP, Vista, Server 2008, 7  
_Original KB number:_ &nbsp; 811833

The United States Federal Information Processing Standard (FIPS) defines security and interoperability requirements for computer systems that are used by the U.S. federal government.

## FIPS 140 standard

The FIPS 140 standard defines approved cryptographic algorithms. The FIPS 140 standard also sets forth requirements for key generation and for key management. The National Institute of Standards and Technology (NIST) uses the Cryptographic Module Validation Program (CMVP) to determine whether a particular implementation of a cryptographic algorithm is compliant with the FIPS 140 standard. An implementation of a cryptographic algorithm is considered FIPS 140-compliant only if it has been submitted for and has passed NIST validation. An algorithm that has not been submitted cannot be considered FIPS-compliant even if the implementation produces identical data as a validated implementation of the same algorithm.

For more information about how Microsoft products and libraries comply with the FIPS 140 standard, see [FIPS 140-2 Validation](https://technet.microsoft.com/library/cc750357.aspx).

In some scenarios, an application may use unapproved algorithms or processes while the application operates in a FIPS-compliant mode. For example, the use of unapproved algorithms may be allowed in the following scenarios:

- When some internal processes stay within the computer
- When some external data is to be additionally encrypted by a FIPS-compliant implementation

## Security setting effects in Windows XP and later versions

In Windows XP and in later versions of Windows, if you enable the following security setting either in the Local Security Policy or as part of Group Policy, you inform applications that they should only use cryptographic algorithms that are FIPS 140 compliant and in compliance with FIPS approved modes of operation:

### System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing

This policy is only advisory to applications. Therefore, if you enable the policy, it does not make sure that all applications will comply. The following areas in the operating system will be affected by this setting:

- This setting causes the Schannel security package and all applications that build on the Schannel security package to negotiate only the Transport Layer Security (TLS) 1.0 protocol. If this setting is enabled on a server that is running IIS, only Web browsers that support TLS 1.0 can connect. If this setting is enabled on a client, all Schannel clients, such as Microsoft Internet Explorer, can only connect to servers that support the TLS 1.0 protocol. For a list of cipher suites supported when the setting is enabled see the Cipher Suites in Schannel topic.

   For more information, click the following article number to view the article in the Microsoft Knowledge Base:

   [811834](https://support.microsoft.com/help/811834) Cannot visit SSL sites after you enable FIPS compliant cryptography

- This setting also affects Terminal Services in Windows Server 2003 and in later versions of Windows. The effect depends on whether TLS is being used for server authentication.

   If TLS is being used for server authentication, this setting causes only TLS 1.0 to be used.

   By default, if TLS is not being used, and this setting is not enabled on the client or on the server, the Remote Desktop Protocol (RDP) channel between the server and the client is encrypted by using the RC4 algorithm with a 128-bit key length.

   After you enable this setting on a Windows Server 2003-based computer, the following is true:

  - The RDP channel is encrypted by using the 3DES algorithm in Cipher Block Chaining (CBC) mode with a 168-bit key length.

  - The SHA-1 algorithm is used to create message digests.

  - Clients must use the RDP 5.2 client program or a later version to connect.

   For more information about how to configure terminal services, click the following article number to view the article in the Microsoft Knowledge Base:

   [814590](https://support.microsoft.com/help/814590) How to enable and to configure Remote Desktop for Administration in Windows Server 2003

- Windows XP clients that use the RDP 5.2 client program and later versions of RDP can connect to Windows Server 2003, Windows Vista, or Windows Server 2008 computers when you enable this option. However, remote desktop connections to Windows XP computers fail when you enable this option on either the client or the server.

- Windows clients that have the FIPS setting enabled cannot connect to Windows 2000 terminal services.

- This setting affects the encryption algorithm that is used by Encrypting File System (EFS) for new files. Existing files are unaffected and continue to be accessed by using the algorithms with which they were originally encrypted.

  > [!NOTE]
  > By default, EFS on Windows XP RTM uses the DESX algorithm. If you enable this setting, EFS uses 168-bit 3DES encryption.
  >
  > By default, in Windows XP Service Pack 1 (SP1), in later Windows XP service packs, and in Windows Server 2003, EFS uses the Advanced Encryption Standard (AES) algorithm with a 256-bit key length. However, EFS uses the kernel-mode AES implementation. This implementation is not FIPS-validated on these platforms. If you enable the FIPS setting on these platforms, the operating system uses the 3DES algorithm with a 168-bit key length.
  >
  > In Windows Vista and in Windows Server 2008, EFS uses the AES algorithm with 256-bit keys. If you enable this setting, AES-256 will be used.
  >
  > FIPS local policy does not affect password key encryption.

- Microsoft .NET Framework applications such as Microsoft ASP.NET only allow for using algorithm implementations that are certified by NIST to be FIPS 140 compliant. Specifically, the only cryptographic algorithm classes that can be instantiated are those that implement FIPS-compliant algorithms. The names of these classes end in **CryptoServiceProvider** or **Cng**. Any attempt to create an instance of other cryptographic algorithm classes, such as classes with names ending in **Managed**, cause an InvalidOperationException exception to occur. Additionally, any attempt to create an instance of a cryptographic algorithm that is not FIPS compliant, such as MD5, also causes an InvalidOperationException exception.

- If the FIPS setting is enabled, verification of ClickOnce applications fails unless the client computer has one of the following installed:
  - The .NET Framework 3.5 or a later version of the .NET Framework
  
  - The .NET Framework 2.0 Service Pack 1 or a later service pack
  
  > [!NOTE]
  >
  > With Visual Studio 2005, ClickOnce applications cannot be built on or published from a FIPS-required computer. However, if the computer has the .NET Framework 2.0 SP2, which is included with the .NET Framework 3.5 SP1, Visual Studio 2005 can publish Winforms/WPF applications.
  >
  > With Visual Studio 2008, ClickOnce applications cannot be built or published unless Visual Studio 2008 SP1 or a later version of Visual Studio is installed.

- By default, in Windows Vista and in Windows Server 2008, the BitLocker Drive Encryption feature uses 128-bit AES encryption together with an additional diffuser. When this setting is enabled, BitLocker uses 256-bit AES encryption without a diffuser. Additionally, recovery passwords are not created or backed up to the Active Directory directory service. Therefore, you cannot recover from lost PINs or from system changes by typing in a recovery password at the keyboard. Instead of using a recovery password, you may back up a recovery key on a local drive or on a network share. To use the recovery key, put the key on a USB device. Then, plug the device into the computer.

- In Windows Vista SP1 and later versions of Windows Vista, and in Windows Server 2008, only members of the Cryptographic Operators group can edit the crypto settings in the IPsec policy of the Windows Firewall.

  > [!NOTE]
  >
  > After you enable or disable the System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing security setting, you must restart your application, such as Internet Explorer, for the new setting to take effect.
  >
  > This security setting affects the following registry value in Windows Server 2008 and in Windows Vista:
  >
  > `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\FIPSAlgorithmPolicy\Enabled`
  >
  > This registry value reflects the current FIPS setting. If this setting is enabled, the value is 1. If this setting is disabled, the value is 0.

- This security setting affects the following registry value in Windows Server 2003 and in Windows XP:

   `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\FIPSAlgorithmPolicy`

   This registry value reflects the current FIPS setting. If this setting is enabled, the value is 1. If it is disabled, the value is 0.
