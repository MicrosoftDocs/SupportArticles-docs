---
title: FIPS 140-2 compliancy with Dynamics CRM 2011 Update Rollup 12
description: Describes Federal Information Processing Standard (FIPS) 140-2 compliancy in CRM 2011.
ms.reviewer: aaronric
ms.topic: article
ms.date: 
---
# FIPS 140-2 compliancy with Microsoft Dynamics CRM 2011 Update Rollup 12

This article describes the requirements for Federal Information Processing Standard (FIPS) 140-2 compliance with Microsoft Dynamics CRM 2011.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2784079

## Introduction

Federal Information Processing Standard (FIPS) 140 - Security Requirements for Cryptographic Modules [FIPS 140] is a U.S. Federal government standard that defines a minimum set of security requirements for products that implement cryptography. The standard is designed for cryptographic modules that are used to help secure sensitive, but unclassified information.

FIPS 140-1, the original working version of the standard, became official on January 11, 1994 and was in effect until May 25, 2002, when FIPS 140-2 became the mandatory standard for new products. Testing against the FIPS 140 standard is maintained by the Cryptographic Module Validation Program (CMVP), a joint effort between the National Institute of Standards (NIST) and the Communications Security Establishment of Canada (CSEC).

Microsoft Windows has a long history of participation in the CVMP under FIPS 140-2.

> [!NOTE]
> For more information about the details of Microsoft's participation in the program, see the Technical Article FIPS 140 Evaluation at [FIPS 140-2 Validation](/windows/security/threat-protection/fips-140-validation).

In most cases, the CMVP doesn't certify the whole application space, only the critical cryptographic service components. Therefore the specific modules that have successfully completed the testing program can claim to be **FIPS Certified**. All other higher layer applications that use these certified components can be said to be **FIPS compliant** or **Operating in FIPS mode** or **uses FIPS technology**.

## Requirements for FIPS 140-2 Compliance with Microsoft Dynamics CRM

Setting up a FIPS compliant operating environment requires running the following:

- Windows Server 2008 R2 SP1 x64
- Microsoft Dynamics CRM 2011 UR3 or a later version
- Microsoft SQL Server 2008 R2 x64

### Windows Server

The first step in configuring a FIPS 140-2 compliant operating environment is to configure the computer that is running Windows Server 2008 R2 SP1 x64 by enabling the FIPS security setting. To enable the Windows Server FIPS security setting either in the Local Security Policy or as part of Group Policy, follow these steps:

1. Using an account that has administrative credentials, log on to a computer that is running Windows Server 2008 R2 SP1 x64 on which any of the CRM Server roles are installed.
2. Click **Start**, click **Run**, type `gpedit.msc`, and then press ENTER.
3. In the Local Group Policy Editor, under the **Computer Configuration** node, double-click **Windows Settings**, and then double-click **Security Settings**.
4. Under the **Security Settings** node, double-click **Local Policies**, and then click **Security Options**.
5. In the details pane, double-click **System cryptography: Use FIPS-compliant algorithms for encryption, hashing, and signing**.
6. In the **System cryptography: Use FIPS-compliant algorithms for encryption, hashing, and signing** dialog box, click **Enabled**, and then click **OK** to close the dialog box.
7. Close the Local Group Policy Editor.

    For more information, see [FIPS 140-2 Validation](/windows/security/threat-protection/fips-140-validation).

### Microsoft SQL Server

When the SQL Server 2008 service detects that FIPS mode is enabled at startup, SQL Server 2008 logs the following message in the SQL Server error log:

> Service Broker transport is running in FIPS compliance mode

Additionally, the following message may be logged in the Application log:

> Database Mirroring transport is running in FIPS compliance mode

To make sure that the server is running in FIPS compliant mode, locate and verify the existence of the first (and possibly the second) message.

#### Special Considerations for Deployments with Windows Network Load Balancing

For Microsoft Dynamics CRM 2011 deployments with Windows Network Load Balancing (NLB), compliancy with FIPS 140-2 requires that configuration change to the .NET machine config.xml file on the CRM Web Servers.

To ensure FIPS compliancy for Microsoft Dynamics CRM 2011 implementations leveraging NLB, follow these steps:

1. Using an account that has administrative credentials, log on to a computer serving as the CRM Web Server.
2. Browse to the folder `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config`, and then open the file that is named machine.config.
3. In the file, under any existing \<mscorlib> .....\</mscorlib> elements, between the \</system.web> and the \</configuration> elements, add the following text:

    ```xml
    <mscorlib>
    <cryptographySettings>
    <cryptoNameMapping>
    <cryptoClasses>
    <cryptoClass
    SHA256CSP="System.Security.Cryptography.SHA256CryptoServiceProvider, System.Core, Version=4.0.0.0, Culture=neutral,
    PublicKeyToken=b77a5c561934e089" />
    <cryptoClass
    RijndaelCSP="System.Security.Cryptography.AesCryptoServiceProvider, System.Core, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" />
    </cryptoClasses>
    <nameEntry
    name="SHA256"
    class="SHA256CSP" />
    <nameEntry
    name="https://www.w3.org/2001/04/xmlenc#aes256-cbc"
    class="RijndaelCSP" />
    </cryptoNameMapping>
    </cryptographySettings>
    </mscorlib>
    ```

### Microsoft Dynamics CRM Email Router

Add registry value `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSCRM Email\MSCRMFIPSCompliance` = **1** (Dword) on Email Router server then install Email Router.

## More information

If the Microsoft Dynamics CRM 2011 platform is configured by using the procedures here, Microsoft Dynamics CRM 2011 will exclusively use FIPS Certified algorithms and components for all covered cryptographic functions and will therefore be operating in FIPS 140-2 compliant mode.
