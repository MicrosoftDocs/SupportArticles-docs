---
title: Domain join error 0x534 "No mapping between account names and security IDs was done"
description: Addresses the error "No mapping between account names and security IDs was done" encountered during domain join operations.
ms.date: 03/26/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: raviks, eriw, dennhu
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
---
# Domain join error 0x534 "No mapping between account names and security IDs was done"

This article addresses the error code 0x534 encountered during domain join operations.

## Symptom

When you try to join a computer to a domain, you receive the following error message:

> No mapping between account names and security IDs was done.

You review the *netsetup.log* log and found error messages that resemble the following:

```output
NetpCreateComputerObjectInDs: NetpGetComputerObjectDn failed: 0x534
NetpProvisionComputerAccount: LDAP creation failed: 0x534
ldap_unbind status: 0x0
NetpJoinDomainOnDs: Function exits with status of: 0x534
NetpJoinDomainOnDs: status of disconnecting from '\\<DC name>': 0x0
NetpDoDomainJoin: status: 0x534
```

### Error detail

|HEX error|Decimal error|Symbolic Error String|
|---|---|---|
|0x534|1332|ERROR_NONE_MAPPED|

## Cause

The domain-join graphical user interface (GUI) or user interface (UI) can call the NetJoinDomain API twice to join a computer to a domain. The first call is made without the "create" flag being specified to locate a pre-created computer account in the target domain. If no account is found, a second `NetJoinDomain` API call might be made with the "create" flag specified.

The 0x534 error code or status is commonly logged as a transient error when domain join searches the target domain or when the domain join UI is used and certain values are present in the options bit (values of 25, 27, 425, or 427 are common).

In another scenario, this error occurs when you try to change the password for a machine account. However, the account can't be found on the targeted Domain Controller (DC), likely because the account wasn't created or due to replication latency or a replication failure. Check the bit flags in the join options to see if the type of join being performed is relying on a pre-created or newly created computer account.

## Resolution

To fix the issue, focus on the bits in the options flag. Check whether the type of join being performed is relying on preexisting accounts or requires creating new ones.
