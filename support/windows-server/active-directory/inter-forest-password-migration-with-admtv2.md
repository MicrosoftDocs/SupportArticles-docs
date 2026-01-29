---
title: Troubleshoot intra-forest password migrations
description: Discusses how to troubleshoot common problems associated with the inter-forest password migration operation.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, willgloy
ms.custom:
- sap:active directory\active directory migration tool (admt)
- pcy:WinComm Directory Services
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# How to Troubleshoot Inter-Forest Password Migration with ADMT

This article discusses the dependencies and troubleshooting steps for common problems associated with the *inter* -forest password migration operation.

_Applies to:_ &nbsp; Windows Server, all supported versions
_Original KB number:_ &nbsp; 322981

## Summary

If you perform intra-forest migrations by using the Active Directory Migration Tool (ADMT), no special configuration is needed to maintain user passwords, sIDHistory, and object globally unique identifiers (GUIDs) during the move operation.

However, if you use ADMT to perform inter-forest password migration when you clone user accounts, this operation relies on dependencies that the administrator must configure. This article discusses the dependencies and troubleshooting steps for common problems associated with this operation.

Warning: ADMT has accumulated several security problems, some in particular affecting cross-forest migration as the use of PES is affected: <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info] target=_blank>Support policy and known issues for Active Directory Migration Tool</a>

### Configuration

Beyond basic configuration, ADMT requires the following dependencies when used to perform inter-forest password migration:

- The RestrictAnonymous value on the target domain controller should be set to 0 during the migration.

- Read permissions on the Pre-Windows 2000 Compatible Access group should be set to
 **CN=Server,CN=System,DC={targetdom},DC={tld}**.

- The following registry key should be configured on the Password Export Server: HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\LSA\AllowPasswordExport = 1 

- The Password Export Server must be restarted after the registry is edited.

- The Everyone group should be a member of the Pre-Windows 2000 Compatible Access group in the target domain during the migration. This action is blocked by Active Directory Users and Computers. To add the Everyone group, run the following command: NET LOCALGROUP "PRE-WINDOWS 2000 COMPATIBLE ACCESS" EVERYONE /ADD 

- Run this command to make the following group a member of the Pre-Windows 2000 Compatible Access group: NET LOCALGROUP "PRE-WINDOWS 2000 COMPATIBLE ACCESS" "ANONYMOUS LOGON" /ADD 

### Troubleshooting

The following are some of the more common error messages and their resolutions:

- Unable to establish a session with the password export server. The target server \\SERVER does not have an encryption key for source domain {SRCDOM}.
This error may be caused by one of the following configuration problems:

- The Password Export Server has not been configured with the Password Migration DLL and an encryption key for the target server.

-or-

- The encryption key was created and installed, but ADMT is running on a different computer than the computer that created the encryption key. Password Migration encryption keys are valid per-computer instead of per-domain.

- WRN1:7557 Failed to copy the password for {user}. A strong password has been generated instead. Unable to copy password. Access is denied.
If this error message appears in the Migration.log file, verify the following:

- The following registry key value is set on the target domain controllers: HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\LSA\RestrictAnonymous = 0 

- Pre-Windows 2000 Compatible Access has Read and Enumerate Entire SAM Domain permissions on the object, as follows: CN=Server,CN=System,DC={TargetDomain},DC={tld} 

- W1:7557 Failed to copy the password for {User}. A strong password has been generated instead. Unable to copy password. The RPC server is unavailable.
This error message typically indicates a failure to resolve names. Verify that Domain Name System (DNS) and NetBIOS (WINS) name resolution is working correctly for both domains.
