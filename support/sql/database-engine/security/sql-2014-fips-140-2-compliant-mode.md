---
title: Use SQL 2014 in FIPS 140-2-compliant mode
description: Discusses Federal Information Processing Standard Publication 140-2 (FIPS 140-2) instructions and how to use Microsoft SQL Server 2014 in the FIPS 140-2-compliant mode.
ms.date: 02/17/2020
ms.custom: sap:Security Issues
---
# Instructions for using SQL Server 2014 in the FIPS 140-2-compliant mode

This article discusses the instructions for Federal Information Processing Standard Publication 140-2 (FIPS 140-2) and how to use Microsoft SQL Server 2014 in the FIPS 140-2-compliant mode.

_Original product version:_ &nbsp; SQL Server 2014  
_Original KB number:_ &nbsp; 3141890


> [!NOTE]
> - The terms "FIPS 140-2–compliant," "FIPS 140-2 compliance," and "FIPS 140-2–compliant mode" are defined here for use and clarity. These terms are not recognized or defined government terms. The United States and Canadian governments recognize the validation of cryptographic modules against standards such as FIPS 140-2 but not the use of cryptographic modules in a specified or conformant manner. In this article, we use "FIPS 140-2–compliant," "FIPS 140-2 compliance," and "FIPS 140-2–compliant mode" in the sense that SQL Server 2014 uses only FIPS 140-2-validated instances of algorithms and hashing functions in all instances in which encrypted or hashed data is imported to or exported from SQL Server 2014. Additionally, this means that SQL Server 2014 manages keys in a secure manner, as required of FIPS 140-2-validated cryptographic modules. The key-management process also includes both key generation and key storage.
>
> - We use "certified" here to mean that the instance of the algorithm is FIPS 140-2–validated or that the operating system contains FIPS 140-2–validated instances of algorithms.

## What is FIPS?

Federal Information Processing Standard (FIPS) is a standard developed by the following two government bodies:

- The National Institute of Standards and Technology (NIST) in the United States
- The Communications Security Establishment (CSE) in Canada

FIPS standards are recommended or mandated for use in federal-government-operated IT systems in the United States and Canada.

## What is FIPS 140-2?

FIPS 140-2 is a statement that is titled "Security Requirements for Cryptographic Modules." It specifies which encryption algorithms and which hashing algorithms can be used and how encryption keys are to be generated and managed. Some hardware, software, and processes that contain the algorithms can be considered FIPS 140-2 certified. Other hardware, software, and processes that call the correct algorithms can be FIPS 140-2–compliant.

## What is the difference between FIPS 140-2–compliant and FIPS 140-2 certified?

SQL Server 2014 can be configured and run in a manner that is compliant with FIPS 140-2. To configure SQL Server 2014 in this manner, SQL Server 2014 must run on an operating system that is FIPS 140-2 certified or on an operating system that provides cryptographic modules that are certified.

The difference between compliance and certification is not subtle. Algorithms can be certified. It is insufficient to use an algorithm just because it is listed on the approved lists in FIPS 140-2. Instead, you have to use an instance of such an algorithm that is certified. This means that the instance is government validated. Certification requires testing and verification by a United States or Canadian government-approved evaluation lab. Windows Server 2012 and later versions and also Windows 8 and later versions contain the certified instance of each allowed algorithms. Most important, a call to each of these algorithms provides only the certified instance.

## Which application products can be FIPS 140-2–compliant?

All applications that perform encryption or hashing and that run on a certified version of Windows can be compliant by using only the certified instances of the approved algorithms and by complying with the key-generation and key-management requirements. You can do this by one of the following methods:

- By using the Windows function for key generation and key management
- By complying with key-generation and key-management requirements within the application

Be aware that a FIPS-compliant application may contain areas in which noncompliant algorithms or processes are enabled. For example, some internal processes that stay within the system and some external data that is to be additionally encrypted by a certified algorithm instance are allowed.

## Is SQL Server 2014 always FIPS 140-2–compliant?

No. SQL Server 2014 can be FIPS 140-2 compliant because it can be configured and run in such a way that it uses only the FIPS 140-2-certified algorithm instances that are called by using CryptoAPI for encryption or by hashing in every instance in which FIPS 140-2 compliance is required.

## How can SQL Server 2014 be configured to be FIPS 140-2–compliant?

### Operating system requirement

Install SQL Server 2014 on a server that is based on one of the following operating systems:

- Windows Server 2012
- Windows Server 2012 R2
- Windows 8
- Windows 8.1
- Windows 10

### Windows system administration requirement

The FIPS mode must be set before SQL Server 2014 is started. SQL Server reads the setting at startup. To set the FIPS mode, follow these steps:

1. Log on to Windows as a Windows system administrator.
2. Click **Start**.
3. Click **Control Panel**.
4. Click **Administrative Tools**. (You may have to switch toLarge Icons for the next step.)
5. Click **Local Security Policy**. TheLocal Security Settings window appears.
6. In the navigation pane, click**Local Policies**, and then click **Security Options**.
7. In the right-side pane, double-click **System cryptography: Use FIPS–compliant algorithms for encryption, hashing, and signing**.
8. In the dialog box that appears, click **Enabled**, and then click **Apply**.
9. Click **OK**.
10. Close the Local Security Settings window.

### SQL Server administrator requirement

When the SQL Server service (when an endpoint is configured for either Service Broker or Database Mirroring) detects that the FIPS mode is enabled at startup, SQL Server logs the following message in the SQL Server error log:

> Service Broker transport is running in FIPS compliance mode.

Additionally, you may find the following message logged in the Windows event log:

> Database Mirroring transport is running in FIPS–compliance mode.

You can verify that the server is running in the FIPS mode by looking for these messages.

- For dialog security (between services), the encryption uses the FIPS-certified instance of Advanced Encryption Standard (AES) if the FIPS mode is enabled. If the FIPS mode is disabled, the encryption uses RC4.

- When you configure a service broker endpoint in the FIPS mode, the administrator must specify "AES" for the service broker. If the endpoint is configured to RC4, SQL Server will generate an error. Therefore, the transport layer won't start.

## How is SQL Server 2014 operated in FIPS 140-2–compliant mode?

- With the FIPS mode in Windows turned on, in all areas in which the user has no choice about whether to encrypt or hash and about how it will be done, SQL Server 2014 will run in compliance with FIPS 140-2. (SQL Server 2014 will use CryptoAPI in Windows and will use only the certified instances of the algorithms.)

- With the FIPS mode in Windows turned on, in all areas in which the user has a choice of whether to use encryption, SQL Server 2014 will either enable only FIPS 140-2–compliant encryption or won't enable any encryption.

- **Important information for software developers**: in all areas in which the developer or the user writes their own code for encryption or hashing, they must be instructed to use only CryptoAPI (and therefore only the certified instances) and to specify only the algorithms that are allowed by FIPS 140-2. For the official National Institute of Standards and Technology (NIST) list of FIPS 140-2 approved cryptographic algorithms, go to Annexes A, C, and D in [Cryptographic Module Validation Program](https://csrc.nist.gov/Projects/Cryptographic-Module-Validation-Program).

## What is the effect of running SQL Server 2014 in FIPS 140-2–compliant mode?

- The use of stronger encryption may have a small effect on performance for those processes for which less strong encryption is allowed when the process is not operating as FIPS 140-2–compliant.

- The selection of encryption for SSIS (UseEncryption=True) will generate an error message that states that the available encryption is incompatible with FIPS compliance and are not allowed. In other words, no encryption of the message process is performed.

- The use of encryption together with legacy DTS isn't compliant with FIPS 140-2. For DTS, the FIPS mode in Windows is not checked. Therefore, it's the responsibility of the user to select no encryption to remain compliant.

- Because most SQL Server 2014 encryption and hashing processes are already FIPS 140-2–compliant, running at full compliance (that is, with the FIPS mode in Windows turned on) will have little or no effect on the use or performance of the product.

## Where can I learn more about FIPS 140-2?

For more information about the FIPS 140-2 standard, see the following NIST publication:

[Security Requirements For Cryptographic Modules](https://csrc.nist.gov/publications/fips/fips140-2/fips1402.pdf)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
