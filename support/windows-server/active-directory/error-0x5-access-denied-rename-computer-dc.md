---
title: Error 0x5 Access Denied When You Rename a Computer in a DC
description: Helps resolve error 0x5 Access Denied when you rename a computer in a domain controller (DC).
ms.date: 03/21/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, raviks, v-lianna
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
---
# Error 0x5 Access Denied when you rename a computer in a DC

This article helps resolve error 0x5 **Access Denied** when you rename a computer in a domain controller (DC).

When you rename a computer in a Windows Server 2016 DC, you might encounter an **Access Denied** error.

When you check the **NetSetup.log** file, you see the following entries:

```output
mm/dd/yyyy hh:mm:ss:ms NetpChangeMachineName: from 'TESTNAME97' to 'TESTNAME98' using 'ADATUM.COM\test_adm_user' [0x2]
mm/dd/yyyy hh:mm:ss:ms NetpDsGetDcName: trying to find DC in domain 'ADATUM', flags: 0x1010
mm/dd/yyyy hh:mm:ss:ms NetpDsGetDcName: found DC '\\ADATUMDC01' in the specified domain
mm/dd/yyyy hh:mm:ss:ms NetpChangeMachineName: status of connecting to  dc '\\ADATUMDC01': 0x0
mm/dd/yyyy hh:mm:ss:ms NetpGetLsaPrimaryDomain: status: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpManageMachineAccountWithSid: status of NetUserSetInfo on '\\ADATUMDC01' for 'TESTNAME97$': 0x5 Access Denied
```

`NetUserSetInfo` targets the DC's Security Accounts Manager Server (SAM) server component, which uses the SAM Remote Procedure Call (RPC) function interface based on TCP port 445. Here is the complete TCP connection network traffic during the NetSetup failure event, which indicates the failure at a SAM connection:

```output
14930 hh:mm:ss hh:mm:ss yyyy/mm/dd 71.2725304  (0) ADATUMDC01   10.101.56.150 TCP TCP: [Bad CheckSum]Flags=...A..S., SrcPort=Microsoft-DS(445), DstPort=59729, PayloadLen=0, Seq=347025249, Ack=2963325843, Win=8192 (Negotiated scale factor 0x8) = 8192
14931 hh:mm:ss hh:mm:ss yyyy/mm/dd 71.2731444  (0) 10.101.56.150 ADATUMDC01   TCP TCP:Flags=...A...., SrcPort=59729, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=2963325843, Ack=347025250, Win=256
...
15188 hh:mm:ss hh:mm:ss yyyy/mm/dd 71.6538995  (4) ADATUMDC01   10.101.56.150 MSRPC MSRPC:c/o Fault:  Call=0x2  Context=0x0  Status=0x5  Cancels=0x0  0x5 Access Denied
...
```

In addition, you see the following event in the DC SAM server Event Trace Log (ETL):

```output
[0] 0268.12C0:: yyyy/mm/dd- hh:mm:ss [SAMSRV] security_c3857 SampCheckRpcRemoteCallerAccess() - Remote SAM Access is denied in case1 for the client SID:<SID> from network address: <IP Address>
```

## Security policy prevent malicious SAM enumeration

Remote SAM access control was introduced in Windows Server 2016 and Windows 10, version 1607 and later versions as a new security policy to prevent malicious SAM enumeration. Here's the information of the policy:

|Security policy path  |Local Security Policy > Security Settings > Local Policies > Security Options  |
|---------|---------|
|**Policy**     |**Network access: Restrict clients allowed to make remote calls to SAM**         |
|**Registry value**     |`HKLM\SYSTEM\CurrentControlSet\Control\Lsa\RestrictRemoteSam`         |

Only security groups allowed to read for the Remote SAM Remote Procedure Call (RPC) access defined in the policy setting, can set up a SAM  connection with the DC.

## Delete the registry value RestrictRemoteSam

In Windows Server 2016 DCs, delete the registry value to apply the default Security Descriptor Definition Language (SDDL). The default value for DCs means that everyone has read permissions to preserve compatibility. To delete the registry value, run the following command:

```console
reg delete "HKLM\system\currentControlSet\control\lsa" /v restrictRemoteSam /f
```

> [!NOTE]
> This change doesn't require a restart.

A customized SDDL for the policy might result in unexpected failures. Here are some scenarios to be aware of:

- Admin tools, scripts, and software that previously enumerated users, groups, and group memberships might fail.
- Remote Desktop Protocol (RDP) connections to Remote Desktop Services (RDS) Servers fail when the RDS tries to retrieve user details using remote SAM RPC calls.
- Applications that use Authorization (AuthZ) against accounts that are disabled can run into Access Denied errors. For example, Microsoft Exchange Server might encounter this issue during Offline Address Book (OAB) generation checks.
  
  For more information, see [AuthZ fails with an Access Denied error when an application does access checks in Windows Server](../group-policy/authz-fails-access-denied-error-application-access-check.md).
