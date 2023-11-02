---
title: Use SQL 2016 in FIPS 140-2-compliant mode
description: This article discusses the FIPS 140-2 instructions and how to use SQL Server2016 in FIPS 140-2-compliant mode.
ms.date: 02/17/2020
ms.custom: sap:Security Issues
---

# Use SQL Server 2016 and later versions in FIPS 140-2-compliant mode

This article introduces the FIPS 140-2 instructions and how to use SQL Server2016 in FIPS 140-2-compliant mode.

_Original product version:_ &nbsp; SQL Server 2016 and later
_Original KB number:_ &nbsp; 4014354

> [!NOTE]
> - The terms "FIPS 140-2 compliant," "FIPS 140-2 compliance," and "FIPS 140-2-compliant mode" are defined here for use and clarity. These terms are not recognized or defined government terms. The United States and Canadian governments recognize the validation of cryptographic modules against standards like FIPS 140-2 instead of using cryptographic modules in a specified or conformant manner.
>
>   In this article, we use FIPS 140-2-compliant, FIPS 140-2 compliance, and FIPS 140-2-compliant mode to mean that SQL Server 2016 and later versions
use only FIPS 140-2-validated instances of algorithms and hashing functions in all instances in which encrypted or hashed data is imported to or exported from SQL Server 2016 and later versions. Additionally, this means that SQL Server 2016 and later versons will manage keys in a secure manner, as is required of FIPS 140-2-validated cryptographic modules. The key-management process also includes both key generation and key storage.
> - We use "certified" here to mean that the instance of the algorithm is FIPS 140-2 validated or that the operating system contains FIPS140-2-validated instances of algorithms.

## What is FIPS?

Federal Information Processing Standard (FIPS) is a standard developed by the following two government bodies:

- The National Institute of Standards and Technology (NIST) in the United States
- The Communications Security Establishment (CSE) in Canada

FIPS standards are either recommended or mandated for use in federal government-operated IT systems in the United States and Canada.

## What is FIPS 140-2?

FIPS 140-2 is a statement that's titled "Security Requirements for Cryptographic Modules." It specifies which encryption algorithms and which hashing algorithms can be used and how encryption keys are to be generated and managed. Some hardware, software, and processes that contain the algorithms can be considered FIPS 140-2 certified, and other hardware, software, and processes that call the correct algorithms can be considered FIPS 140-2 compliant.

## What's the difference between being FIPS 140-2 compliant and being FIPS 140-2 certified?

SQL Server 2016 and later versions can be configured and run in a manner that is compliant with FIPS 140-2. To configure SQL Server 2016 and later versions in this manner, it must run on an operating system that is FIPS 140-2 certified or that provides cryptographic modules that are certified. The difference between compliance and certification is not subtle. Algorithms can be certified. It is insufficient to use an algorithm just because it is listed on the approved lists in FIPS 140-2. Instead, you must use an instance of such an algorithm that is certified. This means the instance is government-validated. Certification requires testing and verification by a U. S. or Canadian government-approved evaluation lab. Windows Server 2012 and later versions, and Windows 8 and later versions contain the certified instance of each allowed algorithm. Most importantly, a call to each of these algorithms provides only the certified instance.

## Which applications can be FIPS 140-2 compliant?

All applications that perform encryption or hashing and that run on a certified version of Windows can be compliant by using only the certified instances of the approved algorithms and by complying with the key-generation and key-management requirements. This requires either using the Windows function for key generation and key management or complying with key-generation and key-management requirements within the application. Areas in a FIPS-compliant application may exist where noncompliant algorithms or processes are enabled. For example, some internal processes that stay in the system and some external data that's slated to be additionally encrypted by a certified algorithm instance are allowed.

## Are SQL Server 2016 and later versions always FIPS 140-2 compliant?

No. SQL Server 2016 and later versions can be FIPS 140-2 compliant because it can be configured and run so that it uses only the FIPS 140-2-certified algorithm instances. Additionally, these instances are called by using CryptoAPI or CGN for encryption or by hashing in every instance where FIPS 140-2compliance is required.

## How can SQL Server 2016 and later versions be configured to be FIPS 140-2 compliant?

### Operating system requirements

You must install SQL Server 2016 and later versions on a host that's running one of the following [Windows clients and servers](/windows/security/threat-protection/fips-140-validation#modules-used-by-windows-clients).

### Windows system administration requirements

The FIPS mode must be set before SQL Server 2016 or a later version is started. SQL Server reads the setting at startup. To set the FIPS mode, follow these steps:

1. Log on to Windows as a Windows system administrator.
2. Select **Start**.
3. Select **Control Panel**.
4. Select **Administrative Tools**. (You may have to switch to large Icons for the next step.)
5. Select **Local Security Policy**. The **Local Security Settings** window appears.
6. In the navigation pane, select **Local Policies** > **Security Options**.
7. In the pane on the right, double-click **System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing**.
8. In the dialog box that appears, select **Enabled** > **Apply**.
9. Select **OK**.
10. Close the **Local Security Settings** window.

### SQL Server administrator requirement

When the SQL Server service (when an endpoint is configured for either Service Broker or Database Mirroring) detects that the FIPS mode is enabled at startup, SQL Server logs the following message in the SQL Server error log:

> Service Broker transport is running in FIPS compliance mode.

Additionally, you may find the following message logged in the Windows event log:

> Database Mirroring transport is running in FIPS compliance mode.

You can verify that the server is running in FIPS mode by looking for these messages.

> [!NOTE]
> - For dialog security (between services), the encryption process uses the FIPS-certified instance of AES if FIPS mode is enabled. If FIPS mode is disabled, the encryption process still uses AES.
> - When you configure a service broker endpoint in FIPS mode, the administrator must specify "AES" for the service broker. If the endpoint is configured to RC4, SQL Server generates an error. Therefore, the transport layer will not start.

## How are SQL Server 2016 and later versions operated in FIPS 140-2-compliant mode?

- With FIPS mode in Windows turned on, in all areas where the user has no choice about whether to encrypt or hash and how it will be done, SQL Server 2016 and later versions will run in compliance with FIPS 140-2. (SQL Server 2016 and later versions will use CryptoAPI in Windows and will use only the certified instances of the algorithms.)

- With FIPS mode in Windows turned on, in all areas where the user has a choice of whether to use encryption, SQL Server 2016 and later versions will either enable only FIPS 140-2 compliant encryption or won't enable any encryption.

- **Important information for software developers:** In all areas where the developer or user writes their own code for encryption or hashing, they must be instructed to use only CryptoAPI (and therefore only the certified instances) and to specify only the algorithms that are allowed by FIPS 140-2.For the official NIST list of FIPS 140-2 approved cryptographic algorithms, see Annexes A, C, and D in  [Cryptographic Module Validation Program](https://csrc.nist.gov/Projects/Cryptographic-Module-Validation-Program).

## What is the effect of running SQL Server 2016 or a later version in FIPS 140-2-compliant mode?

- When you use stronger encryption, it may have a small effect on performance for those processes for which less robust encryption is allowed when the process is not operating as FIPS 140-2 compliant.

- The selection of encryption for SSIS (UseEncryption=True) will generate an error that states that the available encryption is incompatible with FIPS compliance and are not allowed. In other words, no encryption of the message process is performed.

- When you use encryption together with legacy DTS, encryption isn't compliant with FIPS 140-2. For DTS, FIPS mode in Windows isn't checked. Therefore, it's the responsibility of the user to select no encryption to remain compliant.

- Because most SQL Server 2016 and later versions encryption and hashing processes are already FIPS 140-2 compliant, executing at full compliance (that is, with FIPS mode in Windows turned on) will have little or no effect on the use or on the performance of the application.

## Where can I learn more about FIPS 140-2?

For more information about FIPS 140-2, see [CMVP FIPS 140-2 Standards and Documents](https://csrc.nist.gov/Projects/cryptographic-module-validation-program/fips-140-2).

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft doesn't guarantee the accuracy of this third-party contact information.
