---
title: Windows 10 Enterprise breaks delegation
description: Provides a workaround for an issue where a Windows 10 Enterprise breaks delegation.
ms.date: 01/04/2024
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.reviewer: mastewa, jopilov, prmadhes, v-sidong
---
# Windows 10 Enterprise breaks delegation

## Symptoms

You can't use linked servers or web sites that delegate credentials to SQL Server in Windows 10. Windows 7 and Windows 8 users don't have the issue.

## Cause

Windows 10 Enterprise edition has a feature called [Credential Guard](/windows/security/identity-protection/credential-guard/). This feature prevents the user credentials from being used in full delegation scenarios.

## Workaround

To resolve this issue, use constrained delegation instead. If full delegation is required, disable [Credential Guard](/windows/security/identity-protection/credential-guard/) in group policy.

## Implications

Any network where you have even one Windows 10 Enterprise user with [Credential Guard](/windows/security/identity-protection/credential-guard/) enabled must switch all the servers from full delegation to constrained delegation.

If you try to execute SSIS packages in SSISDB from a remote system, such as a client machine via SQL Server Management Studio, the execution fails. SSIS's architecture prevents it from being used with constrained delegation. Launching the jobs from a local SQL Agent should be fine as long as the back-end databases don't use [linked servers](/sql/relational-databases/linked-servers/linked-servers-database-engine).

## More information

If the client is Windows 10 Enterprise edition and the [Credential Guard](/windows/security/identity-protection/credential-guard/) feature is enabled, you can't use full delegation (Trust this user for delegation to any service). You can only use constrained delegation. One common symptom is that Windows 7 and 8 users can delegate, but Windows 10 users can't.

Applications break if they require:

- Kerberos DES Encryption Support
- Kerberos unconstrained or full delegation
- Extracting the Kerberos TGT
- NTLMv1
