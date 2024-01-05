---
title: Windows 10 Enterprise breaks delegation
description: Provides a workaround for an issue where Windows 10 Enterprise breaks delegation.
ms.date: 01/04/2024
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.reviewer: mastewa, jopilov, prmadhes, v-sidong
---
# Windows 10 Enterprise breaks delegation

## Symptoms

You can't use linked servers or websites that delegate credentials to SQL Server in Windows 10.

## Cause

Windows 10 Enterprise has a feature called [Credential Guard](/windows/security/identity-protection/credential-guard/). This feature prevents you from using credentials in full delegation scenarios.

## Workaround

To work around this issue, use constrained delegation instead. If full delegation is required, disable [Credential Guard](/windows/security/identity-protection/credential-guard/) in Group Policy.

## Implications

If you use Windows 10 Enterprise with [Credential Guard](/windows/security/identity-protection/credential-guard/) enabled on a network, you must switch all the servers from using full delegation to using constrained delegation.

If you try to run SQL Server Integration Services (SSIS) packages in SSISDB from a remote system, such as a client machine, via SQL Server Management Studio, the execution fails. The architecture of SSIS prevents it from being used with constrained delegation. Launching the jobs from a local SQL Agent should be fine as long as the back-end databases don't use [linked servers](/sql/relational-databases/linked-servers/linked-servers-database-engine).

## More information

If the client edition is Windows 10 Enterprise and the [Credential Guard](/windows/security/identity-protection/credential-guard/) feature is enabled, you can't use full delegation (trust this user for delegation to any service). You can only use constrained delegation. A common symptom is that you can delegate in Windows 7 and 8, but not in Windows 10.

Applications break if they require:

- Kerberos DES encryption support
- Kerberos unconstrained or full delegation
- Extracting the Kerberos TGT
- NTLMv1
