---
title: Support policy and known issues for ADMT
description: Learn Support policy and known issues for Active Directory Migration Tool.
ms.date: 11/17/2022
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: gipauli, arrenc, herbertm, clfish, kaushika
ms.custom: sap:active-directory-migration-tool-admt, csstroubleshoot
ms.subservice: active-directory
---
# Support policy and known issues for Active Directory Migration Tool

This article discusses information about the current level of support for Active Directory Migration Tool (ADMT) on current Windows Client and Windows Server operating systems. This article also lists known issues that administrators might experience when they try to migrate user profiles, security principals, passwords, or security identifier history (sIDHistory) data between Active Directory domains and forests.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4089459

## Microsoft support by operating system

ADMT was released as a free download to support the migration to Windows 2000/Windows Server 2003-era operating systems.  

ADMT hasn't been updated to support the following operating systems:

- Windows 11
- Windows 10
- Windows 8.1
- Windows Server 2022
- Windows Server 2019
- Windows Server 2016
- Windows Server 2012 R2

When you run ADMT on operating systems that aren't supported, you might experience the following known issues:

- ADMT can't migrate user profiles from operating systems that are later than Windows 7 or Windows Server 2008 R2 to other operating systems. ADMT also can't migrate user profiles to operating systems that are later than Windows 7 or Windows Server 2008 R2 from older operating systems.
- ADMT isn't compatible with the secure defaults that modern operating systems use.
- ADMT hasn't been tested together with later versions of Microsoft SQL Server. If you use ADMT in such circumstances, you might see incompatibilities or other issues.

> [!IMPORTANT]  
> Your experience in using ADMT depends on many factors, including the Windows version that you are migrating from and the Windows version that you are migrating to. Use the tool at your own risk.

## Commercial Windows support case policy

Microsoft handles support cases for ADMT issues completely on a "best effort" basis. Support cases might not be escalated to the product teams. Microsoft can't guarantee that issues will be resolved.

## Code-level support policy

The ADMT 3.2 code base has been deprecated. Microsoft has officially halted any development on the ADMT code base. ADMT isn't eligible for security fixes, bug fixes, or design changes.

## Common support scenarios and known issues

This section lists the most common issues that you might experience when you use ADMT.

> [!IMPORTANT]  
> Many of these issues occur because of changes that have improved the functionality or security of Windows. Some solutions to these issues involve making temporary changes to Windows that nullify these improvements. Use these solutions at your own risk.

### ADMT won't run on devices that have Windows Defender Credential Guard enabled

**Issue**: You see errors that resemble the following:

> Failed to move source object CN=User1. Verify that the caller's account is not marked sensitive and therefore cannot be delegated. hr=0x8009030e. No credentials are available in the security package.

**Solution**: Temporarily disable Credential Guard on the ADMT server.

> [!IMPORTANT]  
> Consult your security team before you change the Credential Guard configuration. Back up the ADMT server before you make any changes.

The [Manage Windows Defender Credential Guard](/windows/security/identity-protection/credential-guard/credential-guard-manage) topic provides a script that disables Credential Guard. In addition to running the script, disable the **Computer Configuration\\Administrative Templates\\System\\Device Guard\\Secure Launch Configuration** Group Policy Object (GPO). Otherwise, the computer will re-enable Credential Guard the next time that it starts.

> [!NOTE]  
> On devices that run Windows Server 2022, Credential Guard is enabled if the GPO that's described here is set to **Not Configured**.

### Domain controllers can't use unconstrained delegation

**Issue**: During the migration process, ADMT requires that domain controllers use [unconstrained delegation](/defender-for-identity/security-assessment-unconstrained-kerberos). This practice is no longer allowed or recommended.

**Solution**: Install and run ADMT apps on the target domain controller. This configuration removes the need for delegation.

### Modern apps don't start for a user who uses a migrated user profile

**Issue**: When you use ADMT 3.2 to migrate a user profile to a Windows Client computer, and then you run the Security Translation wizard to update the profile, modern applications don't run. These apps include both built-in apps (such as the Windows Start menu and Search) and apps that are installed from the Windows Store.

Intra-forest migrations are most at risk for this behavior. This is because intra-forest migrated user accounts can't be restored to the original source domain.

**Solution**: After you complete the migration, uninstall the modern apps, and then reinstall them from the Windows Store.

For more information about this issue, see [Windows App cannot start after ADMT 3.2 security translation runs in Windows 8, Windows 8.1 and Windows 10](windows-app-cant-start.md).

### Security translation resets file associations

**Issue**: You migrate a user profile, and then you run the security translation wizard in Add mode. When you sign in to the computer for the first time after the migration, you use the original (source) user credentials instead of the migrated (target) user credentials. The file associations reset to their default values, and any custom associations are lost.

In Windows 10, a custom file association is protected from unwanted modifications by using a hash that's based in part on the user's security identifier (SID). The custom file association and the hash are stored in the registry. When the user is migrated to a new domain, the new user account receives a new SID. All file association hashes must be updated accordingly.

**Solution**: As soon as the migration finishes, disable the source user account. This action prevents the issue from occurring.

### Objects that have child objects aren't migrated

**Issue**: When ADMT tries to migrate an object that has a child object, the migration fails, and ADMT logs the following entry in the migration error log:

> **Error 7422**: Failed to move source object CN=\<_object name_>. hr=0x8007208c The operation cannot be performed because child objects exist. This operation can only be performed on a child object.

A few examples of child objects that block migration include, but aren't limited to, the following:

- Exchange Active Sync
- Microsoft Dynamic GP
- TermSrvLicensing
- Citrix SSOSecret and SSOConfig

**Solution**: You have to delete the child object (also known as a leaf object) in order to migrate the parent object. For example, you would have to delete the Exchange ActiveSync object. Otherwise, there's no known workaround.

### Computer migration fails on devices that have custom DNS suffixes

**Issue**: During an inter-forest migration, you migrate computers that are configured to retain their primary DNS suffix when their domain membership changes. The ADMT post-migration check fails when ADMT tries to verify the domain membership of the migrated computer. The error messages resemble the following examples:

> **Error 7711**: Unable to retrieve the DNS hostname for the migrated computer 'workstation1.contoso.com'. The ADSI property cannot be found in the property cache. (hr=0x8000500d) Post-check will be retried on the computer 'workstation1'

> **Error 7709**: Post-check failed on the computer 'workstation1.contoso.com'

> **Error 7675**: Unable to verify the migrated computer 'workstation1' belongs to the domain 'tailspintoys.com'. Access is denied. (hr=0x80070005)

To check this configuration, open the **System** properties on the computer. To do this, select **Start** > **Settings** > **About** > **Advanced system settings** > **Computer Name** > **Change** > **More**. If **Change primary DNS suffix when domain membership changes** isn't selected, the computer is affected by this issue.

**Solution**: Try one of the following methods:

- **Manual configuration**. After you join the computer to the target domain, remove the SPNs from the account in the source domain. Alternatively, you can delete the computer account in the source domain.

- **Answer file configuration**. Use [SyncDomainWithMembership](/windows-hardware/customize/desktop/unattend/microsoft-windows-workstationservice-syncdomainwithmembership). You can set `SyncDomainWithMembership` to **1**. This is the equivalent of enabling **Change primary DNS suffix when domain membership changes**. Then during migration, the computer registers SPNs that match the new domain and doesn't conflict anymore.

### ADMT 3.2 doesn't start if TLS 1.0 is disabled on the SQL Server database host

**Issue**: On a device that hosts a SQL Server database, ADMT 3.2 doesn't start, and it displays SSL Security errors if TLS 1.0 was disabled. This occurs even if ADMT is installed on the same computer as the SQL Server instance. The error message resembles the following:

> The system cannot find the file specified.

**Solution**: On the computer on which ADMT is installed, temporarily enable TLS 1.0. ADMT works even if TLS 1.0 is disabled on the domain controller.

> [!IMPORTANT]  
> Consult your security team before you enable TLS 1.0.

### Password Export Server (PES) fails if LSA Protection is enabled

**Issue**: Password migration fails and generates an error message that resembles the following:

> Unable to establish a session with the password export server. The RPC server is unavailable.

**Solution**: ADMT Password Migration works only if LSA protection is disabled.

> [!IMPORTANT]  
> Consult your security team before you change the LSA Protection configuration. Back up the computer before you make any changes.

### Local profiles aren't migrated

**Issue**: When you run ADMT 3.2 and the Security Translation wizard, ADMT migrates local user accounts but not local profiles.

**Solution**: This behavior is by design.

## More information

ADMT is available for download at [Active Directory Migration Tool version 3.2](https://microsoft.com/download/details.aspx?id=56570).
