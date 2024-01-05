---
title: Visual C++ Redistributable installed with SQL Server alerts end of life or obsolete
description: Provides a resolution for an issue where a Microsoft Visual C++ Redistributable installed with SQL Server is flagged as end of life or obsolete software components.
ms.date: 01/04/2024
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.reviewer: sureshka, v-sidong
---
# Windows 10 Enterprise Breaks Delegation

## Symptoms

Windows 10 users complain they can no longer use linked servers or web sites that delegate credentials to SQL Server. Windows 7 and 8 users are okay.

## Cause and Workaround

Windows 10 Enterprise Edition has a feature called Credential Guard. This feature prevents the user credentials from being used in full delegation scenarios. 
To resolve this issue, constrained delegation must be used instead.
If full delegation is required, then credential guard must be disabled in group policy.

## More information

If the client is Windows 10 Enterprise Edition and the Credential Guard feature is turned on, then you will not be able to use full delegation (Trust this user for delegation to any service). You can only use constrained delegation. One common symptom is that Windows 7/8 users can delegate, but Windows 10 users cannot.
In Windows 10 Enterprise there is a new feature called Credential Guard: (Credential Guard overview - Windows Security | Microsoft Learn)   As per documentation (Credential Guard overview - Windows Security | Microsoft Learn).
Applications will break if they require:

- Kerberos DES Encryption Support
- Kerberos unconstrained/full delegation
- Extracting the Kerberos TGT
- NTLMv1

## Implications

Any network where you have even one Windows 10 Enterprise user with Credential Guard enabled will have to switch all the servers from full to constrained delegation to constrained delegation.
Executing SSIS packages in SSIDB from a remote system, e.g. a client machine via SQL Server Management Studio will fail. SSIS's architecture prevents it from being used with constrained delegation. Launching the jobs from (a local) SQL Agent should be fine as long as the back-end databases do not themselves use Linked Servers.
