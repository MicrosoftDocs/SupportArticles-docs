---
title: You can't use Kerberos unconstrained delegation in certain versions of Windows
description: Provides a workaround for an issue where you can't use Kerberos unconstrained delegation in certain versions of Windows.
ms.date: 01/16/2024
ms.custom: sap:Security Issues
ms.reviewer: mastewa, jopilov, prmadhes, v-sidong
---
# You can't use Kerberos unconstrained delegation in certain versions of Windows

> [!NOTE]
>
> - This article applies to Windows 10, Windows 11, Windows Server 2016, Windows Server 2019, and Windows Server 2022.
> - Full delegation is also known as "Kerberos unconstrained delegation".

## Symptoms

You can't use linked servers or websites that delegate credentials to SQL Server in Windows 10, Windows Server 2016, and later versions. When testing connection to a linked server, you see an error like [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).


## Implications

If you use Windows 10, Windows Server 2016, or a later version with [Credential Guard](/windows/security/identity-protection/credential-guard/) enabled on a network, you must switch all the servers from using full delegation to using constrained delegation.

If you try to run SQL Server Integration Services (SSIS) packages in SSISDB from a remote system, such as a client machine, via SQL Server Management Studio, the execution fails. The architecture of SSIS prevents it from being used with constrained delegation. Launching the jobs from a local SQL Agent should be fine as long as the back-end databases don't use [linked servers](/sql/relational-databases/linked-servers/linked-servers-database-engine).

## Cause

Windows 10, Windows Server 2016, and later versions have a feature called [Credential Guard](/windows/security/identity-protection/credential-guard/). This feature prevents you from using credentials in full delegation scenarios.

## Workaround

To work around this issue, use constrained delegation instead. If full delegation is required, disable [Credential Guard](/windows/security/identity-protection/credential-guard/) in Group Policy.

## More information

If you use Windows 10, Windows Server 2016, or a later version with the [Credential Guard](/windows/security/identity-protection/credential-guard/) feature enabled, you can't use full delegation (trust this user for delegation to any service). You can only use constrained delegation.

Applications break if they require:

- Kerberos DES encryption support
- Kerberos unconstrained or full delegation
- Extracting the Kerberos TGT
- NTLMv1

For more information about the considerations and known issues when using [Credential Guard](/windows/security/identity-protection/credential-guard/), see [known issues](/windows/security/identity-protection/credential-guard/considerations-known-issues).
