---
title: Information about devices from Riverbed Technology that are configured as RODCs
description: Describes the information about devices from Riverbed Technology that are configured as RODCs.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, HerbertM, gregcamp, michikos, nedpyle
ms.custom: sap:Active Directory\User, computer, group, and object management, csstroubleshoot
---
# Information about devices from Riverbed Technology that are configured as RODCs

This article describes the information about devices from Riverbed Technology that are configured as RODCs.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3192506

## Summary  

Microsoft offers commercially reasonable support for its software. If we can't resolve a customer's problem when third-party software is involved, we'll request the involvement of the third-party vendor. Depending on the scenario, Microsoft Support might ask the customer to remove or reconfigure the component from the configuration to see whether the problem persists. If the problem is confirmed to be caused or greatly influenced by the third-party component, the component's vendor must be involved in helping to resolve the problem. This policy also applies to devices from Riverbed Technology, Inc.

## More information

Riverbed Technology, Inc. makes intermediate network devices that aim to optimize network traffic network by compressing and otherwise shaping traffic that travels over loaded WAN connections.

The devices can intercept end-user SMB sessions and can achieve performance gains if the Riverbed device can generate a valid signed checksum of the payload in the security context of the server. To accomplish it, the device sets itself up as a trusted server instance so that it can act as, and for a server that's in the scope of the network traffic that's being optimized.

The current deployment approach (September 2016) involves either enabling read-only domain controller (RODC) UserAccountControl settings on a regular computer account; or using a highly privileged service account that has Replicate Directory Changes All permissions. In some configurations, both types of accounts will be used. This approach has a number of security consequences, which may not be obvious at the time of configuration.

## Expectations

When a computer account is set up as domain controller, it receives certain flags and group memberships that allow it to perform security and Active Directory-specific procedures. These include the following ones:

- The account can impersonate any user in the Active Directory except those who are marked as "sensitive and not allowed for delegation." Because of Kerberos Protocol transition, the account can do this even without having the password for impersonation-allowed users.
- The "Replicate Directory Changes All" permission allows the device to access the password hashes of all users in the domain, including sensitive accounts like KrbTgt, Domain Controller accounts, and Trust relationships.
- The account is eligible for monitoring as a domain controller by monitoring solutions.
- Based on the existence of these flags, "callers" (including administration tools) expect a Windows-based server and try to access or interoperate with entities representing themselves as domain controllers. This includes services that are based on WMI, WinRM, LDAP, RPC, and Active Directory Web Services. Similarly, applications, member computers, and partner domain controllers expect entities that represent themselves as domain controllers to interact and respond in a consistent, well-defined manner.

## Security implications

As with any other computing device in a networking environment, Riverbed devices may come under attack by malware. Because of their ability to impersonate Active Directory users, Riverbed devices are attractive targets for such attacks.

Microsoft strongly recommends using the same level of physical and network protection and auditing as you use for your Read-Write Domain Controllers (RWDCs). Administration of these devices should follow current guidance regarding securing privileged access at [Securing privileged access](/security/compass/overview). If you currently use Riverbed devices in locations that aren't secure enough for RWDCs, we strongly recommend that you review the placement of these devices.

## Operational implications

Domain controllers have a special flag and additional objects associated with their accounts that provide unique role identification. These are as follows:

- UserAccountControl values on the domain controller's computer account
  - RWDC 0x82000 (Hex)
  - RODC 0x5011000 (Hex)
- NTDS Settings  object in the configuration container, within the domain controller's site

Tools, services, and applications may query these attributes to generate a list of domain controllers and then perform an operation, such as query, that assumes a normal DC response. Riverbed devices don't implement the full set of Windows domain controller services and do not respond to normal DC queries. Microsoft is aware of the following problems that are caused by this configuration:

- Migration of sysvol replication from File Replication Service (FRS) to Distributed File System Replication (DFSR)

    When a domain has transitioned to the Windows Server 2008 domain mode or later, Microsoft recommends that you migrate the sysvol replication engine from FRS to DFSR.

    The DFSR migration tool (dfsrMig.exe) builds an inventory of all domain controllers in the domain when the migration begins. This includes the DC-like accounts used by the Riverbed devices. Riverbed devices don't respond to the changes to Active Directory objects that are required for the migration to progress. So the DFSR migration tool fails to complete, and administrators must ignore errors to proceed to the next step in the sysvol migration. These false errors might overlap with actual errors from real Windows Server-based computers.

    Because sysvol migration cannot be completed when there's a Riverbed device in the domain, Microsoft recommends that you remove Riverbed devices during a migration.

- Monitoring tools

    Most server monitoring tools on the market support using Active Directory queries to populate an inventory of client and server systems. Tools that leverage the UserAccountControl or NTDS Setting object to find domain controllers may incorrectly identify the Riverbed accounts as domain controller accounts. As a result, Riverbed devices appear as manageable servers in this inventory list.

    Many solutions then allow the remote deployment of monitoring agents or let you query the device remotely for diagnostic information. However, Riverbed devices don't support these interfaces, and the monitoring tools report them as triggering failures.

    Contact Riverbed for information about how to successfully monitor Riverbed devices through the monitoring tool of your choice. If no monitoring tool is available, investigate the option of excluding the device from monitoring. Microsoft strongly recommends monitoring device health, given the sensitivity of the functions such devices perform.

- Group Policy Administration Tool (GPMC)

    In Windows Server 2012 and later versions, the GPMC can show the replication status of Group Policy settings in the domain or per policy. Riverbed devices are included in the list of eligible accounts for this status check.

    However, the information that's returned to GPMC by Riverbed is incomplete, because they have no NTDS Settings object in the Active Directory Configuration Partition. Because GPMC doesn't expect this, the GPMC console crashes.

    To prevent this failure, deploy the following update on your administration computers:

    [Group Policy Management Console crashes when you click the target domain](https://support.microsoft.com/help/2928427)

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
