---
title: Domain join error 0x6D9 "There are no more endpoints available from the endpoint mapper"
description: Addresses the error "There are no more endpoints available from the endpoint mapper" encountered during domain join operations.
ms.date: 03/26/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: raviks, eriw, dennhu
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
---
# Domain join error 0x6D9 "There are no more endpoints available from the endpoint mapper"

This article addresses the error code 0x6D9 encountered during domain join operations.

## Symptom

When you try to join a computer to a domain, you receive the following error message:

> There are no more endpoints available from the endpoint mapper.

You review the *netsetup.log* log and found error messages that resemble the following:

```output
mm/dd/yyyy hh:mm:ss:ms NetpGetDnsHostName: Read NV Hostname: <hostname>
mm/dd/yyyy hh:mm:ss:ms NetpGetDnsHostName: PrimaryDnsSuffix defaulted to DNS domain name: <DNS domain>.<TLD>
mm/dd/yyyy hh:mm:ss:ms NetpLsaOpenSecret: status: 0xc0000034
mm/dd/yyyy hh:mm:ss:ms NetpGetLsaPrimaryDomain: status: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpLsaOpenSecret: status: 0xc0000034
mm/dd/yyyy hh:mm:ss:ms NetpManageMachineAccountWithSid: NetUserAdd on \\<hostname>.<domain> for <computername>$ failed: 0x8b0
mm/dd/yyyy hh:mm:ss:ms NetpManageMachineAccountWithSid: status of attempting to set password on \\<DC name>.<domain>.<tld> for <hostname>$: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomain: status of creating account: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpGetComputerObjectDn: Unable to bind to DS on \\<DC name>.<domain>.<tld>: 0x6d9
mm/dd/yyyy hh:mm:ss:ms NetpSetDnsHostNameAndSpn: NetpGetComputerObjectDn failed: 0x6d9
mm/dd/yyyy hh:mm:ss:ms ldap_unbind status: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomain: status of setting DnsHostName and SPN: 0x6d9
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomain: initiaing a rollback due to earlier errors
mm/dd/yyyy hh:mm:ss:ms NetpGetLsaPrimaryDomain: status: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpManageMachineAccountWithSid: status of disabling account <hostname>$ on \\<DC name>.<domain>.<tld>: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomain: rollback: status of deleting computer account: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpLsaOpenSecret: status: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomain: rollback: status of deleting secret: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomain: status of disconnecting from \\<DC name>.<domain>.<tld>: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpDoDomainJoin: status: 0x6d9
```

### Error detail

| HEX error | Decimal error | Symbolic Error String | Friendly Error                                                  |
| --------- | ------------- | --------------------- | --------------------------------------------------------------- |
| 0x6d9     | 1753          | EPT_S_NOT_REGISTERED  | There are no more endpoints available from the endpoint mapper. |

## Cause
  
Error 0x6D9 is logged when network connectivity is blocked between the joining client and the helper DC. The network connectivity services the domain join operation over port 135 or a port in the ephemeral range between 1025 to 5000 or 49152 to 65535. For more information, see [Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md).  

The network connectivity issue can be caused by several factors, including Symantec Endpoint Protection (if it is installed on the helper DC), port exhaustion, and other potential issues.

## Resolution

1. On the joining client, open the *%systemroot%\\debug\\NETSETUP.LOG* file and determine the name of the helper DC selected by the joining client to perform the join operation. For example: the following NETSETUP.LOG sample shows that the joining client "APP_SRV" is using helper DC "DC1.CONTOSO.COM ":

   ```output
   mm/dd hh:mm:ss NetpManageMachineAccountWithSid: NetUserAdd on '\\DC1.CONTOSO.COM' for 'APP_SRV$' failed: 0x8b0
   mm/dd hh:mm:ss NetpManageMachineAccountWithSid: status of attempting to set password on '\\DC1.CONTOSO.COM' for '<APP_SRV>$': 0x0
   mm/dd hh:mm:ss NetpJoinDomain: status of creating account: 0x0
   mm/dd hh:mm:ss NetpGetComputerObjectDn: Unable to bind to DS on '\\DC1.CONTOSO.COM': 0x6d9
   ```

2. Verify that the joining client has network connectivity to the DC over the required ports and protocols used by the applicable operating system (OS) versions. Domain join clients connect a helper DC over TCP port 135 by the dynamically assigned port in the range between 49152 and 65535.
3. Ensure that the OS, software and hardware routers, firewalls, and switches allow connectivity over the required ports and protocols.
4. Ensure that there are enough available ports for the operation. You can use tools like netstat to check for port availability and usage.
5. If Symantec Endpoint Protection is installed on the helper DC, review its settings to ensure it is not blocking the required ports.
6. Consider other potential causes and troubleshoot accordingly, such as checking for firewall rules, ensuring proper DNS resolution, and verifying the health of the DC.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
