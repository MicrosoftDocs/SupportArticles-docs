---
title: Security identifiers in Windows
description: Lists well-known security identifiers in Windows operating systems. Also lists additional built-in groups that are created when a domain controller is added to the domain.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: User, computer, group, and object management
ms.technology: windows-server-active-directory
---
# Well-known security identifiers in Windows operating systems

This article provides information about well-known SIDs in all versions of Windows.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 243330

## Summary

A security identifier (SID) is a unique value of variable length that is used to identify a security principal (such as a security group) in Windows operating systems. SIDs that identify generic users or generic groups is well known. Their values remain constant across all operating systems.

This information is useful for troubleshooting issues that involve security. It's also useful for troubleshooting display issues in the Windows access control list (ACL) editor. Windows tracks a security principal by its SID. To display the security principal in the ACL editor, Windows resolves the SID to its associated security principal name.

> [!NOTE]
> This article describes circumstances under which the ACL editor displays a security principal SID instead of the security principal name.

Over time, this set of well-known SIDs has grown. The tables in this article organize these SIDs according to which version of Windows introduced them.

## Well-known SIDs (all versions of Windows)

All versions of Windows use the following well-known SIDs.

|SID|Name|Description|
|---|---|---|
|S-1-0|Null Authority|An identifier authority.|
|S-1-0-0|Nobody|No security principal.|
|S-1-1|World Authority|An identifier authority.|
|S-1-1-0|Everyone|A group that includes all users, even anonymous users, and guests. Membership is controlled by the operating system.<br/><br/> **Note** <br/>By default, the Everyone group no longer includes anonymous users on a computer that is running Windows XP Service Pack 2 (SP2).|
|S-1-2|Local Authority|An identifier authority.|
|S-1-2-0|Local|A group that includes all users who have logged on locally.|
|S-1-3|Creator Authority|An identifier authority.|
|S-1-3-0|Creator Owner|A placeholder in an inheritable access control entry (ACE). When the ACE is inherited, the system replaces this SID with the SID for the object's creator.|
|S-1-3-1|Creator Group|A placeholder in an inheritable ACE. When the ACE is inherited, the system replaces this SID with the SID for the primary group of the object's creator. The primary group is used only by the POSIX subsystem.|
|S-1-3-4|Owner Rights|A group that represents the current owner of the object. When an ACE that carries this SID is applied to an object, the system ignores the implicit READ_CONTROL and WRITE_DAC permissions for the object owner.|
|S-1-4|Non-unique Authority|An identifier authority.|
|S-1-5|NT Authority|An identifier authority.|
|S-1-5-1|Dialup|A group that includes all users who have logged on through a dial-up connection. Membership is controlled by the operating system.|
|S-1-5-2|Network|A group that includes all users that have logged on through a network connection. Membership is controlled by the operating system.|
|S-1-5-3|Batch|A group that includes all users that have logged on through a batch queue facility. Membership is controlled by the operating system.|
|S-1-5-4|Interactive|A group that includes all users that have logged on interactively. Membership is controlled by the operating system.|
|S-1-5-5-X-Y|Logon Session|A logon session. The X and Y values for these SIDs are different for each session.|
|S-1-5-6|Service|A group that includes all security principals that have logged on as a service. Membership is controlled by the operating system.|
|S-1-5-7|Anonymous|A group that includes all users that have logged on anonymously. Membership is controlled by the operating system.|
|S-1-5-9|Enterprise Domain Controllers|A group that includes all domain controllers in a forest that uses an Active Directory directory service. Membership is controlled by the operating system.|
|S-1-5-10|Principal Self|A placeholder in an inheritable ACE on an account object or group object in Active Directory. When the ACE is inherited, the system replaces this SID with the SID for the security principal who holds the account.|
|S-1-5-11|Authenticated Users|A group that includes all users whose identities were authenticated when they logged on. Membership is controlled by the operating system.|
|S-1-5-12|Restricted Code|This SID is reserved for future use.|
|S-1-5-13|Terminal Server Users|A group that includes all users that have logged on to a Terminal Services server. Membership is controlled by the operating system.|
|S-1-5-14|Remote Interactive Logon|A group that includes all users who have logged on through a terminal services logon.|
|S-1-5-17|IUSR|An account that is used by the default Internet Information Services (IIS) user.|
|S-1-5-18|Local System|A service account that is used by the operating system.|
|S-1-5-19|NT Authority|Local Service|
|S-1-5-20|NT Authority|Network Service|
|S-1-5-21-*domain*-500|Administrator|A user account for the system administrator. By default, it's the only user account that is given full control over the system.|
|S-1-5-21-*domain*-501|Guest|A user account for people who don't have individual accounts. This user account doesn't require a password. By default, the Guest account is disabled.|
|S-1-5-21-*domain*-502|KRBTGT|A service account that is used by the Key Distribution Center (KDC) service.|
|S-1-5-21-*domain*-512|Domain Admins|A global group whose members are authorized to administer the domain. By default, the Domain Admins group is a member of the Administrators group on all computers that have joined a domain, including the domain controllers. Domain Admins is the default owner of any object that is created by any member of the group.|
|S-1-5-21-*domain*-513|Domain Users|A global group that, by default, includes all user accounts in a domain. When you create a user account in a domain, it's added to this group by default.|
|S-1-5-21-*domain*-514|Domain Guests|A global group that, by default, has only one member, the domain's built-in Guest account.|
|S-1-5-21-*domain*-515|Domain Computers|A global group that includes all clients and servers that have joined the domain.|
|S-1-5-21-*domain*-516|Domain Controllers|A global group that includes all domain controllers in the domain. New domain controllers are added to this group by default.|
|S-1-5-21-*domain*-517|Cert Publishers|A global group that includes all computers that are running an enterprise certification authority. Cert Publishers are authorized to publish certificates for User objects in Active Directory.|
|S-1-5-21-*root_domain*-518|Schema Admins|A universal group in a native-mode domain; a global group in a mixed-mode domain. The group is authorized to make schema changes in Active Directory. By default, the only member of the group is the Administrator account for the forest root domain.|
|S-1-5-21-*root_domain*-519|Enterprise Admins|A universal group in a native-mode domain; a global group in a mixed-mode domain. The group is authorized to make forest-wide changes in Active Directory, such as adding child domains. By default, the only member of the group is the Administrator account for the forest root domain.|
|S-1-5-21-*domain*-520|Group Policy Creator Owners|A global group that is authorized to create new Group Policy objects in Active Directory. By default, the only member of the group is Administrator.|
|S-1-5-21-*domain*-526|Key Admins|A security group. The intention for this group is to have delegated write access on the `msdsKeyCredentialLink` attribute only. The group is intended for use in scenarios where trusted external authorities (for example, Active Directory Federated Services) are responsible for modifying this attribute. Only trusted administrators should be made a member of this group.|
|S-1-5-21-*domain*-527|Enterprise Key Admins|A security group. The intention for this group is to have delegated write access on the `msdsKeyCredentialLink` attribute only. The group is intended for use in scenarios where trusted external authorities (for example, Active Directory Federated Services) are responsible for modifying this attribute. Only trusted administrators should be made a member of this group.|
|S-1-5-21-*domain*-553|RAS and IAS Servers|A domain local group. By default, this group has no members. Servers in this group have Read Account Restrictions and Read Logon Information access to User objects in the Active Directory domain local group.|
|S-1-5-32-544|Administrators|A built-in group. After the initial installation of the operating system, the only member of the group is the Administrator account. When a computer joins a domain, the Domain Admins group is added to the Administrators group. When a server becomes a domain controller, the Enterprise Admins group also is added to the Administrators group.|
|S-1-5-32-545|Users|A built-in group. After the initial installation of the operating system, the only member is the Authenticated Users group. When a computer joins a domain, the Domain Users group is added to the Users group on the computer.|
|S-1-5-32-546|Guests|A built-in group. By default, the only member is the Guest account. The Guests group allows occasional or one-time users to log on with limited privileges to a computer's built-in Guest account.|
|S-1-5-32-547|Power Users|A built-in group. By default, the group has no members. Power users can create local users and groups; modify and delete accounts that they have created; and remove users from the Power Users, Users, and Guests groups. Power users also can install programs; create, manage, and delete local printers; and create and delete file shares.|
|S-1-5-32-548|Account Operators|A built-in group that exists only on domain controllers. By default, the group has no members. By default, Account Operators have permission to create, modify, and delete accounts for users, groups, and computers in all containers and organizational units of Active Directory except the `Builtin` container and the Domain Controllers OU. Account Operators don't have permission to modify the Administrators and Domain Admins groups, nor do they have permission to modify the accounts for members of those groups.|
|S-1-5-32-549|Server Operators|A built-in group that exists only on domain controllers. By default, the group has no members. Server Operators can log on to a server interactively; create and delete network shares; start and stop services; back up and restore files; format the hard disk of the computer; and shut down the computer.|
|S-1-5-32-550|Print Operators|A built-in group that exists only on domain controllers. By default, the only member is the Domain Users group. Print Operators can manage printers and document queues.|
|S-1-5-32-551|Backup Operators|A built-in group. By default, the group has no members. Backup Operators can back up and restore all files on a computer, regardless of the permissions that protect those files. Backup Operators also can log on to the computer and shut it down.|
|S-1-5-32-552|Replicators|A built-in group that is used by the File Replication service on domain controllers. By default, the group has no members. Don't add users to this group.|
|S-1-5-32-582|Storage Replica Administrators|A built-in group that grants complete and unrestricted access to all features of Storage Replica.|
|S-1-5-64-10|NTLM Authentication|An SID that is used when the NTLM authentication package authenticated the client.|
|S-1-5-64-14|`SChannel` Authentication|An SID that is used when the `SChannel` authentication package authenticated the client.|
|S-1-5-64-21|Digest Authentication|An SID that is used when the Digest authentication package authenticated the client.|
|S-1-5-80|NT Service|An NT Service account prefix.|
||||

## SIDs added by Windows Server 2003 and later versions

When you add a domain controller that runs Windows Server 2003 or a later version to a domain, Active Directory adds the security principals in the following table.

> [!NOTE]
> The Windows ACL editor may not display these security principles by name. Active Directory doesn't resolve these SIDs to their corresponding names until the [PDC Emulator FSMO Role](/openspecs/windows_protocols/ms-adts/f96ff8ec-c660-4d6c-924f-c0dbbcac1527) transfers to or is seized by a domain controller that runs Windows Server 2003 or later.

|SID|Name|Description|
|---|---|---|
|S-1-3-2|Creator Owner Server|This SID isn't used in Windows 2000.|
|S-1-3-3|Creator Group Server|This SID isn't used in Windows 2000.|
|S-1-5-8|Proxy|This SID isn't used in Windows 2000.|
|S-1-5-15|This Organization|A group that includes all users from the same organization. Only included with AD accounts and only added by a Windows Server 2003 or later domain controller.|
|S-1-5-32-554|Builtin\Pre-Windows 2000 Compatible Access|An alias added by Windows 2000. A backward compatibility group that allows read access on all users and groups in the domain.|
|S-1-5-32-555|Builtin\Remote Desktop Users|An alias. Members in this group are granted the right to log on remotely.|
|S-1-5-32-556|Builtin\Network Configuration Operators|An alias. Members in this group can have some administrative privileges to manage configuration of networking features.|
|S-1-5-32-557|Builtin\Incoming Forest Trust Builders|An alias. Members of this group can create incoming, one-way trusts to this forest.|
|S-1-5-32-558|Builtin\Performance Monitor Users|An alias. Members of this group have remote access to monitor this computer.|
|S-1-5-32-559|Builtin\Performance Log Users|An alias. Members of this group have remote access to schedule logging of performance counters on this computer.|
|S-1-5-32-560|Builtin\Windows Authorization Access Group|An alias. Members of this group have access to the computed tokenGroupsGlobalAndUniversal attribute on User objects.|
|S-1-5-32-561|Builtin\Terminal Server License Servers|An alias. A group for Terminal Server License Servers. When Windows Server 2003 Service Pack 1 is installed, a new local group is created.|
|S-1-5-32-562|Builtin\Distributed COM Users|An alias. A group for COM to provide computer-wide access controls that govern access to all call, activation, or launch requests on the computer.|
||||

## SIDs added by Windows Server 2008 and later versions

When you add a domain controller that runs Windows Server 2008 or a later version to a domain, Active Directory adds the security principals in the following table.

> [!NOTE]
> The Windows ACL editor may not display these security principles by name. Active Directory doesn't resolve these SIDs to their corresponding names until the PDC emulator FSMO role transfers to or is seized by a domain controller that runs Windows Server 2008 or later.

|SID|Name|Description|
|---|---|---|
|S-1-2-1|Console Logon|A group that includes users who are logged on to the physical console.<br/><br/> **Note** <br/>Added in Windows 7 and Windows Server 2008 R2.|
|S-1-5-21-*domain*-498|Enterprise Read-only Domain Controllers|A universal group. Members of this group are read-only domain controllers in the enterprise.|
|S-1-5-21-*domain*-521|Read-only Domain Controllers|A global group. Members of this group are read-only domain controllers in the domain.|
|S-1-5-21-*domain*-571|Allowed RODC Password Replication Group|A domain local group. Members in this group can have their passwords replicated to all read-only domain controllers in the domain.|
|S-1-5-21-*domain*-572|Denied RODC Password Replication Group|A domain local group. Members in this group can't have their passwords replicated to any read-only domain controllers in the domain.|
|S-1-5-32-569|Builtin\Cryptographic Operators|A built-in local group. Members are authorized to perform cryptographic operations.|
|S-1-5-32-573|Builtin\Event Log Readers|A built-in local group. Members of this group can read event logs from local computer.|
|S-1-5-32-574|Builtin\Certificate Service DCOM Access|A built-in local group. Members of this group are allowed to connect to Certification Authorities in the enterprise.|
|S-1-5-80-0|NT Services\All Services|A group that includes all service processes that are configured on the system. Membership is controlled by the operating system.<br/><br/> **Note** <br/>Added in Windows Server 2008 R2.|
|S-1-5-80-0|All Services|A group that includes all service processes configured on the system. Membership is controlled by the operating system.<br/><br/> **Note** <br/>Added in Windows Vista and Windows Server 2008.|
|S-1-5-83-0|NT Virtual Machine\Virtual Machines|A built-in group. The group is created when the Hyper-V role is installed. Membership in the group is maintained by the Hyper-V Management Service (VMMS). This group requires the **Create Symbolic Links** right (S **eCreateSymbolicLinkPrivilege**), and also the **Log on as a Service** right (**SeServiceLogonRight**).<br/><br/> **Note** <br/>Added in Windows 8 and Windows Server 2012.|
|S-1-5-90-0|Window Manager\Window Manager Group|A built-in group that is used by the Desktop Window Manager (DWM). DWM is a Windows service that manages information display for Windows applications.<br/><br/> **Note** <br/>Added in Windows Vista.|
|S-1-16-0|Untrusted Mandatory Level|An untrusted integrity level.<br/> **Note** <br/>Added in Windows Vista and Windows Server 2008.|
|S-1-16-4096|Low Mandatory Level|A low integrity level.<br/><br/> **Note** <br/>Added in Windows Vista and Windows Server 2008.|
|S-1-16-8192|Medium Mandatory Level|A medium integrity level.<br/><br/> **Note** Added in Windows Vista and Windows Server 2008.|
|S-1-16-8448|Medium Plus Mandatory Level|A medium plus integrity level.<br/><br/> **Note** <br/>Added in Windows Vista and Windows Server 2008.|
|S-1-16-12288|High Mandatory Level|A high integrity level.<br/><br/> **Note** <br/>Added in Windows Vista and Windows Server 2008.|
|S-1-16-16384|System Mandatory Level|A system integrity level.<br/><br/> **Note** <br/>Added in Windows Vista and Windows Server 2008.|
|S-1-16-20480|Protected Process Mandatory Level|A protected-process integrity level.<br/><br/> **Note** <br/>Added in Windows Vista and Windows Server 2008.|
|S-1-16-28672|Secure Process Mandatory Level|A secure process integrity level.<br/><br/> **Note** <br/>Added in Windows Vista and Windows Server 2008.|
||||

## SIDs added by Windows Server 2012 and later versions

When you add a domain controller that runs Windows Server 2012 or a later version to a domain, Active Directory adds the security principals in the following table.

> [!NOTE]
> The Windows ACL editor may not display these security principles by name. Active Directory doesn't resolve these SIDs to their corresponding names until the PDC emulator FSMO role transfers to or is seized by a domain controller that runs Windows Server 2012 or later.

|SID|Name|Description|
|---|---|---|
|S-1-5-21-*domain*-522|Cloneable Domain Controllers|A global group. Members of this group that are domain controllers may be cloned.|
|S-1-5-32-575|Builtin\RDS Remote Access Servers|A built-in local group. Servers in this group enable users of RemoteApp programs and personal virtual desktops access to these resources. In Internet-facing deployments, these servers are typically deployed in an edge network. This group needs to be populated on servers running RD Connection Broker. RD Gateway servers and RD Web Access servers used in the deployment need to be in this group.|
|S-1-5-32-576|Builtin\RDS Endpoint Servers|A built-in local group. Servers in this group run virtual machines and host sessions where users RemoteApp programs and personal virtual desktops run. This group needs to be populated on servers running RD Connection Broker. RD Session Host servers and RD Virtualization Host servers used in the deployment need to be in this group.|
|S-1-5-32-577|Builtin\RDS Management Servers|A builtin local group. Servers in this group can perform routine administrative actions on servers running Remote Desktop Services. This group needs to be populated on all servers in a Remote Desktop Services deployment. The servers running the RDS Central Management service must be included in this group.|
|S-1-5-32-578|Builtin\Hyper-V Administrators|A built-in local group. Members of this group have complete and unrestricted access to all features of Hyper-V.|
|S-1-5-32-579|Builtin\Access Control Assistance Operators|A built-in local group. Members of this group can remotely query authorization attributes and permissions for resources on this computer.|
|S-1-5-32-580|Builtin\Remote Management Users|A built-in local group. Members of this group can access WMI resources over management protocols (such as WS-Management via the Windows Remote Management service). This applies only to WMI namespaces that grant access to the user.|
||||

## Capability SIDs

Windows 8 introduced [capability security identifiers (SIDs)](/windows/security/identity-protection/access-control/security-identifiers#capability-sids). A capability SID identifies a capability in a unique and immutable manner. A capability represents an unforgettable token of authority that grants access to resources (such as documents, a camera, locations, and so forth) to Universal Windows Applications. An app that has a capability is granted access to the associated resource. An app that doesn't have a capability is denied access to the resource.

All capability SIDs that the operating system is aware of are stored in the Windows registry in the following subkey:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SecurityManager\CapabilityClasses\AllCachedCapabilities`

This subkey also contains any capability SID that is added by first-party or third-party applications. All Capability SIDs begin at `S-1-15-3`.

> [!IMPORTANT]
> Active Directory doesn't resolve capability SIDs to names. This behavior is by design.

## References

- [Security identifiers](/windows/security/identity-protection/access-control/security-identifiers)
- [2.4.2.4 Well-Known SID Structures](/openspecs/windows_protocols/ms-dtyp/81d92bba-d22b-4a8c-908a-554ab29148ab)
- [AD DS Deployment](/windows-server/identity/ad-ds/deploy/ad-ds-deployment)
