---
title: Error 0x5 Access Denied When You Rename a Computer That Is a Member of a Domain
description: Helps resolve error 0x5 Access Denied when you rename a computer that is a member of a domain.
ms.date: 03/26/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, raviks, herbertm, dennhu, eriw, v-lianna
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
---
# Error 0x5 Access Denied when you rename a computer that is member of a domain

This article helps resolve error 0x5 **Access Denied** when you rename a computer that is a member of a domain.

When you check the **NetSetup.log** file, you see the following entries:

```output
NetpChangeMachineName: from 'TESTNAME97' to 'TESTNAME98' using 'ADATUM.COM\test_adm_user' [0x2]
NetpDsGetDcName: trying to find DC in domain 'ADATUM', flags: 0x1010
NetpDsGetDcName: found DC '\\ADATUMDC01' in the specified domain
NetpChangeMachineName: status of connecting to  dc '\\ADATUMDC01': 0x0
NetpGetLsaPrimaryDomain: status: 0x0
NetpManageMachineAccountWithSid: status of NetUserSetInfo on '\\ADATUMDC01' for 'TESTNAME97$': 0x5 Access Denied
```

`NetUserSetInfo` targets the domain controller (DC) Security Accounts Manager Server (SAM) server component, which uses the SAM Remote Procedure Call (RPC) function on Server Message Block (SMB) Named Pipes. Here's the complete TCP connection network traffic during the NetSetup failure event, which indicates the failure at a SAM connection:

```output
ADATUMDC01   10.101.56.150 TCP TCP: [Bad CheckSum]Flags=...A..S., SrcPort=Microsoft-DS(445), DstPort=59729, PayloadLen=0, Seq=347025249, Ack=2963325843, Win=8192 (Negotiated scale factor 0x8) = 8192
10.101.56.150 ADATUMDC01   TCP TCP:Flags=...A...., SrcPort=59729, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=2963325843, Ack=347025250, Win=256
...
ADATUMDC01   10.101.56.150 MSRPC MSRPC:c/o Fault:  Call=0x2  Context=0x0  Status=0x5  Cancels=0x0  0x5 Access Denied
...
```

## Security policy prevent malicious SAM enumeration

Remote SAM access control was introduced in Windows Server 2016 and Windows 10, version 1607 and later versions as a new security policy to prevent malicious SAM enumeration. Here's the information of the policy:

|Security policy path  |Local Security Policy > Security Settings > Local Policies > Security Options  |
|---------|---------|
|**Policy**     |**Network access: Restrict clients allowed to make remote calls to SAM**         |
|**Registry value**     |`HKLM\SYSTEM\CurrentControlSet\Control\Lsa\RestrictRemoteSam`         |

Only security groups allowed to read the Remote SAM Remote Procedure Call (RPC) access defined in the policy setting can set up a SAM connection with the target machine.

This policy setting isn't useful on DCs because Active Directory objects have their own access control settings, which aren't available for domain members or stand-alone machines with the SAM database.

DCs might have the setting as it stays configured when you promote a member server with this setting to be a DC.

To resolve this issue, you can use one of the following methods:

## Method 1: Define a policy setting for DCs that allows the calls

Set the **Network access: Restrict clients allowed to make remote calls to SAM** policy to allow **Everyone** or **Authenticated Users** and apply it to all DCs.

This resolves the problem for all DCs, and ensures they all use the same setting.

## Method 2: Delete the registry value RestrictRemoteSam

> [!NOTE]
>
> - Only consider this approach if for some reason you can't follow method 1. With this method, you might encounter the problem again if a DC happens to have `RestrictRemoteSam` set to a restrictive Access Control List.
> - The default Security Descriptor Definition Language (SDDL) could be overwritten by the setting defined in other level Group Policy Objects (GPOs).

Delete the registry value to apply the default SDDL. The default value for DCs means that everyone has read permissions to preserve compatibility. To delete the registry value, run the following command:

```console
reg delete "HKLM\system\currentControlSet\control\lsa" /v restrictRemoteSam /f
```

> [!NOTE]
> This change doesn't require a restart.

A customized SDDL for the policy might result in unexpected failures. Here're some scenarios to be aware of:

- Admin tools, scripts, and software that previously enumerated users, groups, and group memberships might fail.
- Remote Desktop Protocol (RDP) connections to Remote Desktop Services (RDS) Servers fail when the RDS tries to retrieve user details using remote SAM RPC calls.
- Applications that use Authorization (AuthZ) against accounts that are disabled can run into Access Denied errors. For example, Microsoft Exchange Server might encounter this issue during Offline Address Book (OAB) generation checks.
  
  For more information, see [AuthZ fails with an Access Denied error when an application does access checks in Windows Server](../group-policy/authz-fails-access-denied-error-application-access-check.md).
