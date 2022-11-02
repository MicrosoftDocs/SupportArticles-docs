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

ADMT hasn't been updated to support the following operating systems:

- Windows 11
- Windows 10
- Windows 8.1
- Windows Server 2022
- Windows Server 2019
- Windows Server 2016
- Windows Server 2012 R2

You may encounter the following known issues when you run ADMT on operating systems that aren't supported:

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

### Domain controllers can't use unconstrained delegation

**Issue**: During the migration process, ADMT requires that domain controllers use unconstrained delegation. This practice is no longer allowed or recommended.

**Solution**: Install and run ADMT apps on the target domain controller. This configuration removes the need for delegation.

### Modern apps fail to start after you migrate a user profile

**Issue**: When you use ADMT 3.2 to migrate a user profile to a Windows Client computer and then run the Security Translation wizard to update the profile, modern applications don't run. These apps include both built-in apps (such as the Windows Start menu and Search) and apps that were installed from the Windows Store.

Intra-forest migrations are most at risk for this behavior, because intra-forest migrated user accounts can't be restored back to the original source domain.

**Solution**: After you complete the migration, uninstall the modern apps and then reinstall them from the Windows Store.

For more information about this issue, see [Windows App cannot start after ADMT 3.2 security translation runs in Windows 8, Windows 8.1 and Windows 10](windows-app-cant-start)

### Security translation resets file associations

**Issue**: You migrate a user profile and then run the security translation wizard in Add mode. When you sign in to the computer for the first time after the migration, you use the original (source) user credentials instead of the migrated (target) user credentials. The file associations reset to their default values, and any custom associations are lost.

In Windows 10, a custom file association is protected from unwanted modifications by using a hash that's based in part on the user's security identifier (SID). The custom file association and the hash are stored in the registry. When the user is migrated to a new domain, the new user account receives a new SID. All file association hashes must be updated accordingly.

**Solution**: As soon as the migration finishes, disable the source user account. This action prevents the issue from occurring.

### Objects that have child objects aren't migrated

**Issue**: When ADMT tries to migrate an object that has a child object, the migration fails and ADMT generates the following message in the migration error log:

> ERR2:7422 Failed to move source object CN=\<_object name_>. hr=0x8007208c The operation cannot be performed because child objects exist. This operation can only be performed on a child object.

A few examples of child objects that block migration include but aren't limited to the following:

- Citrix SSOSecret and SSOConfig
- Exchange Active Sync
- Microsoft Dynamic GP
- TermSrvLicensing

**Solution**: You have to delete the child object (also known as a leaf object) to migrate the parent object. For example, you would have to delete the Exchange ActiveSync object. Otherwise, there is no known workaround.

### Computer migration fails on devices that have custom DNS suffixes

**Issue**: During an inter-forest migration, you migrate computers that are configured to retain their primary DNS suffix when their domain membership changes. The ADMT post-migration check fails when ADMT tries to verify the domain membership of the migrated computer. The error messages resemble the following examples:

> ERR2:7711 Unable to retrieve the DNS hostname for the migrated computer 'workstation1.contoso.com'. The ADSI property cannot be found in the property cache. (hr=0x8000500d) Post-check will be retried on the computer 'workstation1'

> ERR2:7709 Post-check failed on the computer 'workstation1.contoso.com'

> ERR2:7675 Unable to verify the migrated computer 'workstation1' belongs to the domain 'tailspintoys.com'. Access is denied. (hr=0x80070005)

To check this configuration, open the **System** properties on the computer. To do this, select **Start** > **Settings** > **About** > **Advanced system settings** > **Computer Name** > **Change** > **More**. If **Change primary DNS suffix when domain membership changes** isn't selected, the computer is affected by this issue.

**Solution**: Try one of the following methods:

- **Manual configuration**. After you join the computer to the target domain, remove the SPNs from the account in the source domain. As an alternative, you can delete the computer account in the source domain.

- **Answer file configuration**. Use [SyncDomainWithMembership](/windows-hardware/customize/desktop/unattend/microsoft-windows-workstationservice-syncdomainwithmembership). Setting `SyncDomainWithMembership` to **1** is the equivalent of enabling **Change primary DNS suffix when domain membership changes**. Then during migration, the computer registers SPNs that match the new domain and doesn't conflict anymore.

### ADMT 3.2 fails to start if TLS 1.0 is disabled on the SQL Server database host

**Issue**: On a device that hosts a SQL Server database, ADMT 3.2 fails to start and displays SSL Security errors if TLS 1.0 has been disabled. This occurs even if ADMT is installed on the same computer as the SQL Server instance. The error message resembles the following:

> The system cannot find the file specified.

**Solution**: On the computer where ADMT is installed, temporarily enable TLS 1.0. ADMT works even if TLS 1.0 is disabled on the domain controller.

### Password Export Server (PES) fails if LSA Protection is enabled

**Issue**: Password migration fails and generates an error message that resembles the following:

> Unable to establish a session with the password export server. The RPC server is unavailable.

**Solution**: ADMT Password Migration only works if LSA protection is disabled.

> [!NOTE]  
> Before you make any changes to LSA Protection, back up the computer. Work with your security team to minimize potential issues.

### Local profiles aren't migrated

**Issue**: When you run ADMT 3.2 and the Security Translation wizard, ADMT migrates local user accounts but not local profiles.

**Solution**: This behavior is by design.
