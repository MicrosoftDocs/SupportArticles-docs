---
title: Status Code 0x216d and Your Computer Can't Be Joined to the Domain
description: Helps resolve an issue in which you can't join a domain with status code 0x216d.
ms.date: 04/23/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, raviks, herbertm, dennhu, eriw, v-lianna
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
---
# Status code 0x216d: Your computer could not be joined to the domain

This article helps resolve an issue in which you can't join a workgroup computer to a domain with status code 0x216d.

When you join a workgroup computer to a domain, you receive the following error message:

> The following error occurred when attempting to join the domain "\<DomainName\>":
>
> Your computer could not be joined to the domain. You have exceeded the maximum number of computer accounts you are allowed to create in this domain. Contact your system administrator to have this limit reset or increased.

When you check the **NetSetup.log** file, you see the following entries:

```output
NetpMapGetLdapExtendedError: Parsed [0x216d] from server extended error string: 0000216D: SvcErr: DSID-031A124C, problem 5003 (WILL_NOT_PERFORM), data 0
NetpModifyComputerObjectInDs: ldap_add_s failed: 0x35 0x216d
NetpCreateComputerObjectInDs: NetpModifyComputerObjectInDs failed: 0x216d
NetpProvisionComputerAccount: LDAP creation failed: 0x216d
NetpProvisionComputerAccount: Retrying downlevel per options
NetpManageMachineAccountWithSid: NetUserAdd on '<dc_fqdn>' for 'CLIENT1$' failed: 0x216d
NetpProvisionComputerAccount: retry status of creating account: 0x216d
ldap_unbind status: 0x0
NetpJoinCreatePackagePart: status:0x216d.
NetpJoinDomainOnDs: Function exits with status of: 0x216d
NetpJoinDomainOnDs: status of disconnecting from '\\<dc_fqdn>': 0x0
NetpResetIDNEncoding: DnsDisableIdnEncoding(RESETALL) on '<domain_name>' returned 0x0
NetpJoinDomainOnDs: NetpResetIDNEncoding on '<domain_name>': 0x0
NetpDoDomainJoin: status: 0x216d
```

Status code 0x216d is logged in one of the following conditions:

- The user account trying to join the computer to the domain has exceeded the limit of 10 computers that can be joined to the domain.
- There's a Group Policy Object (GPO) restriction to block authenticated users from joining a computer to the domain.

To resolve the issue, verify the following items:

- The [default limit on the number of workstations a user can join to the domain](default-workstation-numbers-join-domain.md).
- The user account is a member of the group mentioned in the **Add workstations to domain** policy of the **Default Domain Controllers Policy** GPO or the **Winning GPO**.

    The GPO setting is located at **Computer Configuration** > **Windows Settings** > **Security Settings** > **Local Policies** > **User Rights Assignment** > **Add workstations to domain**.
