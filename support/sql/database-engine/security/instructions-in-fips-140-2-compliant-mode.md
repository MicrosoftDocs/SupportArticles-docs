---
title: Instructions in FIPS 140-2-compliant mode
description: This article describes FIPS 140-2 and how to use SQL Server 2008 in the FIPS 140-2-compliant mode.
ms.date: 11/11/2020
ms.custom: sap:Security Issues
---
# Instructions for using SQL Server 2008 in FIPS 140-2-compliant mode

This article describes FIPS 140-2 and how to use SQL Server 2008 in the FIPS 140-2-compliant mode.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 955720

## Introduction

This article discusses Federal Information Processing Standard (FIPS) 140-2 instructions and how to use Microsoft SQL Server 2008 in FIPS 140-2-compliant mode.

> [!NOTE]
> The terms "FIPS 140-2-compliant," "FIPS 140-2 compliance," and "FIPS 140-2-compliant mode" are defined here for use and clarity. These terms are not recognized or defined government terms. The United States and Canadian governments recognize the validation of cryptographic modules against standards like FIPS 140-2 and not the use of them in a specified or conformant manner. In this article, we define "FIPS 140-2-compliant," "FIPS 140-2 compliance," and "FIPS 140-2-compliant mode" to mean that SQL Server 2008 uses only FIPS 140-2-validated instances of algorithms and hashing functions in all instances in which encrypted or hashed data is imported or exported to SQL Server 2008. Additionally, these terms mean that SQL Server 2008 will manage keys in a secure manner as required of FIPS 140-2-validated cryptographic modules. The key management process also includes both the key generation and key storage functionalities.

## What is FIPS

FIPS means Federal Information Processing Standards. FIPS are standards that are developed by two government bodies. One is the National Institute of Standards and Technology in the United States. The other is the Communications Security Establishment in Canada. FIPS are standards that are either recommended or mandated for use in federal (either United States or Canadian) government-operated IT systems.

## What is FIPS 140-2

FIPS 140-2 is a statement of the "Security Requirements for Cryptographic Modules." It specifies which encryption algorithms and which hashing algorithms can be used and how encryption keys are to be generated and managed. Some hardware, software, and processes can be FIPS 140-2 validated by an approved validation lab. Some of them can also be described as FIPS 140-2-compliant as the term is defined in this article.

## What is the difference between an application that is "FIPS 140-2-compliant" and an application that is "FIPS 140-2-validated"

You can configure SQL Server 2008 to run as a FIPS 140-2-compliant application. To do this, you must run SQL Server 2008 on an operating system that uses a FIPS 140-2-validated Cryptographic Service Provider or that provides a cryptographic module that has been validated. The difference between compliance and validation is not subtle. Algorithms can be validated. Realize that it is insufficient to use algorithms from the approved lists in FIPS 140-2. You must use instances of algorithms that have been FIPS 140-2 validated. Validation requires testing and verification by a government-approved evaluation lab. Windows Server 2008, Windows Server 2003, and Windows XP contain the approved cryptographic modules, and the modules, including the specific instances of the algorithms, have been lab tested and government validated.

## What applications can be FIPS 140-2-compliant

All applications that perform encryption or hashing and that run on a validated version of a Windows Cryptographic Service Provider can be compliant if they use only the validated instances of the approved algorithms. These applications must also comply with key generation and key management requirements either by using a Windows key function or by meeting the key generation and key management requirements in the application. Additionally, in some cases, noncompliant algorithms, or processes are allowed in a FIPS 140-2-compliant application. For example, data may be encrypted by using a noncompliant algorithm if, in this encrypted form, the data remains within the application, that is, the data is not exported in this form, or if the data is further encrypted (wrapped) using a FIPS-compliant algorithm.

## Does this mean that SQL Server 2008 is always FIPS 140-2-compliant

No. It means that SQL Server 2008 can be configured to run in FIPS 140-2-compliant mode.

## How can SQL Server 2008 be configured to use a FIPS 140-2-validated cryptographic module

- Operating system requirements

  You must install SQL Server 2008 on a Windows Server 2008-based computer, a Windows Vista-based computer, a Windows Server 2003-based computer, or a Windows XP-based computer.

- Windows system administration requirements

  You must enable FIPS mode before you start SQL Server 2008. This is because SQL Server 2008 reads the FIPS setting at startup. To enable FIPS, follow these steps.

  - For Windows Server 2008 and Windows Vista

    1. Use administrative credentials to log on to the computer.
    2. If you are using Windows Server 2008, click **Start**, click **Run**, type gpedit.msc, and then press ENTER. The Local Group Policy Editor opens. If you are using a Windows Vista-based computer, click **Start**, type gpedit.msc in the **Start Search** box, and then press ENTER.
    3. In the Local Group Policy Editor, double-click **Windows Settings** under the **Computer Configuration** node, and then double-click **Security Settings**.
    4. Under the **Security Settings** node, double-click **Local Policies**, and then click **Security Options**.
    5. In the details pane, double-click **System cryptography: Use FIPS-compliant algorithms for encryption, hashing, and signing**.
    6. In the **System cryptography: Use FIPS-compliant algorithms for encryption, hashing, and signing** dialog box, click **Enabled**, and then click **OK** to close the dialog box.
    7. Close the Local **Group Policy Editor**.

  - For Windows Server 2003 and Windows XP

    1. Use administrative credentials to log on to the computer.
    1. Click **Start**, click **Run**, type *gpedit.msc*, and then press **ENTER**.
    1. In the **Group Policy** window, double-click **Windows Settings** under the **Computer Configuration** node, and then double-click **Security Settings**.
    1. Under the **Security Settings** node, double-click **Local Policies**, and then click **Security Options**.
    1. In the details pane, double-click **System cryptography: Use FIPS-compliant algorithms for encryption, hashing, and signing**.
    1. In the **System cryptography: Use FIPS-compliant algorithms for encryption, hashing, and signing** dialog box, click **Enabled**, and then click **OK** to close the dialog box.
    1. Close the **Group Policy** window.

## SQL Server 2008 administrator notes

- When the SQL Server 2008 service detects that FIPS mode is enabled at startup, SQL Server 2008 logs the following message in the SQL Server error log:

  > Service Broker transport is running in FIPS compliance mode

  Additionally, the following message may be logged in the Application log:

  > Database Mirroring transport is running in FIPS compliance mode

  To verify that the server is running in FIPS mode, locate these messages.

- To obtain dialog security between services, the encryption process will use the FIPS-certified instance of the Advanced Encryption Standard (AES) if the FIPS mode is enabled. If the FIPS mode is disabled, the encryption process uses RC4.

- When you configure a Service Broker endpoint in FIPS mode, you must specify AES for the Service Broker. If the endpoint is configured to RC4, SQL Server generates an error. Therefore, the transport layer does not start.

## How does SQL Server 2008 operate in FIPS 140-2-compliant mode

- If FIPS mode in Windows is turned on and if the user has no choice about whether to encrypt or hash data and how it will be done, SQL Server 2008 operates in FIPS 140-2-compliant mode. SQL Server 2008 will use the CryptoAPI and will use only the validated instances of the algorithms.

- If FIPS mode is turned on and if the user has a choice of whether to use encryption, SQL Server 2008 will either allow for only FIPS 140-2-compliant encryption or it will not allow for any encryption.

- Important information for developers

  If you write your own code for encryption or hashing, you must use only the CryptoAPI. You must specify only the algorithms that are allowed by FIPS 140-2. Specifically, use only the Triple Data Encryption Standard (3DES) or AES for encryption and only SHA-1 for hashing. You can use the following keywords in SQL Server 2008 for the respective FIPS 140-2-validated algorithms:

  - DESX(Three-key triple DES)
  - Triple-DES(Two-key triple DES)
  - TRIPLE_DES_3KEY(Three-key triple DES)
  - TRIPLE_DES_2KEY(Two-key triple DES)

  > [!NOTE]
  > Selecting DESX does not provide a DESX algorithm in SQL Server 2005 or in SQL Server 2008. In both cases, selecting DESX provides a validated instance of Three-key triple DES.

- Important information for developers

  SQL Server 2008 supports an Enterprise Key management (EKM) feature that enables the management of cryptographic keys on a separate third-party hardware storage module (HSM). To operate in FIPS 140-2-compliant mode and to use EKM, one of the following two conditions must be true:

  - The external cryptographic module must be FIPS 140-2 validated.
  - Some of algorithms that are used by the cryptographic module must be FIPS 140-2 validated. Use only those instances of validated algorithms when FIPS 140-2-based encryption or decryption is required for importing or exporting data to or from SQL Server.
  
  Additionally, data that will be encrypted or decrypted by the external cryptographic module must be passed in encrypted form by using a FIPS 140-2-validated instance.

## What is the effect of running SQL Server 2008 in FIPS 140-2-compliant mode

- Use of stronger encryption may have a small effect on performance for those processes where less strong encryption is allowed when the process is not operating as FIPS 140-2-compliant.

- Selection of encryption for SSIS (UseEncryption=True) will generate an error message that the available encryption is incompatible with FIPS compliance and is not allowed. In other words, no encryption of the message process is performed.

- Use of encryption together with legacy Data Transformation Services (DTS) is not FIPS 140-2-compliant. For DTS, the FIPS mode in Windows is not checked. To remain compliant, you must not select encryption.

- Most SQL Server 2008 encryption and hashing processes already use a FIPS 140-2-validated cryptographic module. Therefore, if you run an application in FIPS 140-2-compliant mode when FIPS mode is turned on in Windows, there is little or no effect on the use or performance of the application.

## Third-party disclaimer

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
