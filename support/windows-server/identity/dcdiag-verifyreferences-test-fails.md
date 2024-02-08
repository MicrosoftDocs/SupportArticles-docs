---
title: DCDiag VerifyReferences test fails
description: Provides a solution to an error that occurs when you use the DFSR service to replicate the sysvol folder.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, harsur, rolandw, justintu, arrenc
ms.custom: sap:active-directory-replication, csstroubleshoot
ms.subservice: active-directory
---
# DCDiag VerifyReferences test fails when you use DFSR to replicate SYSVOL

This article provides a solution to an error that occurs when you use the Distributed File System Replication (DFSR) service to replicate the sysvol folder.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3110032

## Symptoms

Consider the following scenario:

- You use the Distributed File System Replication (DFSR) service to replicate the sysvol folder.
- All domain controllers (DC) are running Windows Server 2008 R2 or a later version.
- You run the Domain Controller Diagnostics Tool (DCDiag) to generate a report about the replication.

In this scenario, DCDiag returns the following error message:

> failed test VerifyReferences

The DCDiag report contains the following entry:

```console
Problem: Missing Expected Value
Base Object: CN=<DCNAME>,OU=Domain Controllers,DC=<DOMAIN>,DC=<COM>
Base Object Description: "DC Account Object"
Value Object Attribute Name: frsComputerReferenceBL
Value Object Description: "SYSVOL FRS Member Object"
Recommended Action: See Knowledge Base Article: Q312862
```

When this problem occurs, DCDiag validates the reference object for DFSR. Also, the NT File Replication Service (NTFRS) stops.

## Cause

This problem occurs because there's no File Replication Service (FRS) reference in the Active Directory database under the domain controller object when DFSR is used for sysvol replication. Instead, there's only an object for DFSR.

This logic isn't included in earlier versions of DCDiag, such as DCDiag for Windows Server 2008 or DCDiag installed together with Windows Server 2003 Support Tools. So these versions search for the FRS member reference, and it generates a false error in DCDiag.

## Resolution

To resolve this problem, run Dcdiag.exe from `%windir%\System32`. This folder contains the latest version of DCDiag in Windows 2008 and Windows 2008 R2. By running the latest version of DCDiag, the sysvol replication will pass the VerifyReferences test.

Instead, if the Windows Support Tools suite is installed on Windows Server 2008 R2, uninstall it. Which resolves the problem and lets you run Dcdiag.exe from any location.

## More information

Even if you use the latest DCDiag releases, the error that is mentioned in the [Symptoms](#symptoms) section may still occur if the msDFSR-Flags attribute in the CN=\<DCNAME>,OU=Domain Controllers,DC=\<DOMAIN>,DC=\<COM> line in the DCDiag entry is missing or doesn't match one of the following flags:

- Redirected phase: msDFSR-Flags on CN=dfsr-LocalSettings is 0x20 (32 dez)  
- Eliminated phase: msDFSR-Flags on CN=dfsr-LocalSettings is 0x30 (48 dez)

In this case, DCDiag assumes falsely that the File Replication Service (FRS) is still configured for SYSVOL, and it tries to verify FRS objects and attributes in an Active Directory database that doesn't exist. So you can expect the verification to fail.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
