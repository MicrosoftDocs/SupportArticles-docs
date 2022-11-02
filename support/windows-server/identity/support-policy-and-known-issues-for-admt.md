---
title: Support policy and Known Issues for Active Directory Migration Tool
description: Learn Support policy and Known Issues for Active Directory Migration Tool.
ms.date: 11/9/2022
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: gipauli, arrenc, herbertm, clfish, kaushika
ms.custom: sap:active-directory-migration-tool-admt, csstroubleshoot
ms.technology: windows-server-active-directory
---
# Support policy and known issues for Active Directory Migration Tool

This article describes information about the current level of support for Active Directory Migration Tool (ADMT) on current Windows Client and Windows Server operating systems. This article also lists known issues that administrators may encounter when they attempt to migrate user profiles, security principals, passwords, or sIDHistory data between Active Directory domains and forests.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4089459

## Microsoft support by operating system

ADMT was released as a free download to support the migration to Windows 2000 and Windows Server 2003-era operating systems.  

ADMT has not been updated to support the following operating systems:

- Windows 11
- Windows 10
- Windows 8.1
- Windows Server 2022
- Windows Server 2019
- Windows Server 2016
- Windows Server 2012 R2

You may encounter the following known issues when you run ADMT on operating systems that are not supported:

- ADMT can't migrate user profiles from operating systems that are newer than Windows 7 or Windows Server 2008 R2 to other operating systems. You also can't migrate user profiles to operating systems that are newer than Windows 7 or Windows Server 2008 R2 from older operating systems.
- ADMT isn't compatible with the secure defaults that modern operating systems use.
- ADMT hasn't been tested together with newer versions of SQL Server. If you use ADMT in such circumstances, you may see incompatibilities or issues.

> [!NOTE]  
> Your experience with ADMT depends on many factors, including the Windows version that you are migrating from and the Windows version that you are migrating to. Use the tool at your own risk.

## Support information

### Commercial Windows support

Microsoft addresses support cases for ADMT issues completely on a "best effort" basis. Support cases may not be escalated to the product teams. Microsoft can't guarantee that issues will be resolved.

### Code-level support

The ADMT 3.2 code base has been deprecated. Microsoft has officially halted any development on the ADMT code base. ADMT isn't eligible for security fixes, bug fixes, or design changes.

## Common support scenarios and known issues

This section lists the most common issues that you may experience while using ADMT.

### You can't run ADMT on devices that have Windows Defender Credential Guard enabled

**Issue**: You see errors that resemble the following:

> Failed to move source object 'CN=User1. Verify that the caller's account is not marked sensitive and therefore cannot be delegated. hr=0x8009030e. No credentials are available in the security package.

**Solution**: Temporarily disable Credential Guard on the ADMT server.

> [!IMPORTANT]  
> Please consult your security team before making  changes to Credential Guard. Back up the ADMT server before you make any changes.

[Manage Windows Defender Credential Guard](/windows/security/identity-protection/credential-guard/credential-guard-manage) provides a script that disables Credential Guard In addition to running the script, disable the **Computer Configuration\\Administrative Templates\\System\\Device Guard\\Secure Launch Configuration** group policy object (GPO).
Otherwise, the computer will re-enable Credential Guard the next time it restarts.

> [!NOTE]  
> On devices that run Windows Server 2022, version 2H, Credential Guard is enabled when the GPO described previously is set to **Not Configured**.

### Domain controllers cannot use unconstrained delegation

**Issue**: ADMT requires Domain Controllers to use unconstrained delegation during the migration process. This practice is no longer allowed or recommended.

**Solution**: Install and run ADMT apps on the target Domain Controller. This configuration removes the need for delegation.

### Modern apps fail to start after user profile migration

**Issue**: 
Modern applications (both built-in, such as Windows Start menu and Search, and installed from the Windows Store) fail to start on Windows Client computers if security translation in ADMT 3.2 has been run against the user’s profile.

Intra-forest migrations are most at risk because intra-forest migrated user accounts cannot be restored back to the original source domain.

**Solution**: Post-migration, remove then re-install Modern applications installed from the Windows Store.

### Security translation resets file associations

**Issue**: After running ADMT security translations in Add mode, file associations are reset to default if the source user logs in before the target user logs in. File associations in Windows 10 are protected against unwanted modifications by using a hash that is stored in the registry along with each customized association. The user SID is one piece of data that is used to produce this hash. When a user is migrated to a new domain, the new user account receives a new SID so the file association hashes must be updated

**Solution**: The source user account should be disabled immediately following the migration, which will prevent the source user from logging in and generating the scenario described in this article.

### Objects that have child objects are not migrated

**Issue**: ADMT fails to migrate objects with the following error in the migration error log if the object being migrated contains a child object:

> ERR2:7422 Failed to move source object CN=\<_object name_>. hr=0x8007208c The operation cannot be performed because child objects exist. This operation can only be performed on a child object.

A few examples of child objects that block migration include but are not limited to the following:

- Citrix SSOSecret and SSOConfig
- Exchange Active Sync
- Microsoft Dynamic GP
- TermSrvLicensing

**Solution**: You would have to delete the leaf object such as the Exchange ActiveSync object. Otherwise, there is no known workaround.

### Computer migration fails on devices with custom suffixes

**Issue**: ADMT fails the post-migration check when verifying the domain membership of the migrated computer during an inter-forest migration. The errors include:

> ERR2:7711 Unable to retrieve the DNS hostname for the migrated computer 'workstation1.contoso.com'. The ADSI property cannot be found in the property cache. (hr=0x8000500d) Post-check will be retried on the computer 'workstation1'

> ERR2:7709 Post-check failed on the computer 'workstation1.contoso.com'

> ERR2:7675 Unable to verify the migrated computer 'workstation1' belongs to the domain 'tailspintoys.com'. Access is denied. (hr=0x80070005)

The computers are configured to retain their primary DNS suffix when the domain membership changes. This is visible in the user interface as a selected **Change primary DNS suffix when domain membership changes** checkbox.

**Solution**: Try one of the following methods:

- After you join the computer, remove the SPNs from the account in the source domain. Deleting the computer account in the old domain is also an option.

  OR

- Set the machine to **SyncDomainWithMembership=1** which is equivalent of enabling **Change primary DNS suffix when domain membership changes**. It would then register SPNs matching the new domain and not conflict anymore.

### ADMT 3.2 fails to start if TLS 1.0 is disabled on the SQL Server database host

**Issue**: ADMT 3.2 fails to start and displays SSL Security errors if TLS 1.0 has been disabled on devices hosting the SQL DB instance, even if the SQL instance is local to the server that ADMT is installed on. ADMT fails to start with on-screen error:

> The system cannot find the file specified.

**Solution**: Temporarily, enable TLS 1.0 on the ADMT server. ADMT works even if TLS 1.0 is disabled on the Domain Controller.

### Password Export Server (PES) fails if LSA Protection is enabled

**Issue**: Password migration fails with the error "Unable to establish a session with the password export server. The RPC server is unavailable."

**Solution**: ADMT Password Migration only works with LSA protection disabled.

> [!NOTE]  
> Please work with your security team before making the changes to LSA Protection and take the backup of the server before any changes.

### Local profiles are not migrated

**Issue**: Local profiles do not get migrated when Security Translation wizard is run in ADMT 3.2. Local user accounts are correctly migrated.

**Solution**: This behavior is by design.
