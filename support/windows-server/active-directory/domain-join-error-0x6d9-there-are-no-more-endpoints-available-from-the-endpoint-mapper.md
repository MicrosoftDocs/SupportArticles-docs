---
title: Error 0x6D9 There Are No More Endpoints Available from the Endpoint Mapper
description: Addresses the error There are no more endpoints available from the endpoint mapper encountered during domain join operations.
ms.date: 03/28/2025
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

## Symptoms

When you try to join a computer to a domain, you receive the following error message:

> There are no more endpoints available from the endpoint mapper.

When you review the **netsetup.log** file, you find error messages that resemble the following entries:

```output
NetpGetDnsHostName: Read NV Hostname: <hostname>
NetpGetDnsHostName: PrimaryDnsSuffix defaulted to DNS domain name: <DNS domain>.<TLD>
NetpLsaOpenSecret: status: 0xc0000034
NetpGetLsaPrimaryDomain: status: 0x0
NetpLsaOpenSecret: status: 0xc0000034
NetpManageMachineAccountWithSid: NetUserAdd on \\<hostname>.<domain> for <computername>$ failed: 0x8b0
NetpManageMachineAccountWithSid: status of attempting to set password on \\<DC_name>.<domain>.<tld> for <hostname>$: 0x0
NetpJoinDomain: status of creating account: 0x0
NetpGetComputerObjectDn: Unable to bind to DS on \\<DC_name>.<domain>.<tld>: 0x6d9
NetpSetDnsHostNameAndSpn: NetpGetComputerObjectDn failed: 0x6d9
ldap_unbind status: 0x0
NetpJoinDomain: status of setting DnsHostName and SPN: 0x6d9
NetpJoinDomain: initiaing a rollback due to earlier errors
NetpGetLsaPrimaryDomain: status: 0x0
NetpManageMachineAccountWithSid: status of disabling account <hostname>$ on \\<DC_name>.<domain>.<tld>: 0x0
NetpJoinDomain: rollback: status of deleting computer account: 0x0
NetpLsaOpenSecret: status: 0x0
NetpJoinDomain: rollback: status of deleting secret: 0x0
NetpJoinDomain: status of disconnecting from \\<DC_name>.<domain>.<tld>: 0x0
NetpDoDomainJoin: status: 0x6d9
```

### Error detail

| Hexadecimal error | Decimal error | Symbolic error string | Friendly error                                                  |
| --------- | ------------- | --------------------- | --------------------------------------------------------------- |
| 0x6d9     | 1753          | EPT_S_NOT_REGISTERED  | There are no more endpoints available from the endpoint mapper. |

## Cause
  
Error 0x6D9 is logged when network connectivity is blocked between the joining client and the Domain Controller (DC). The network connectivity services the domain join operation initially over Transmission Control Protocol (TCP) port 135, and then an ephemeral port which is by default between 49152 to 65535. For more information, see [Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md).  

The network connectivity issue can be caused by several factors, including advanced security solutions with host firewalls installed on the DC, port exhaustion, and other potential issues.

## Resolution

1. On the joining client, open the **%systemroot%\\debug\\NETSETUP.LOG** file and determine the name of the DC selected by the joining client to perform the join operation. For example, the following **NETSETUP.LOG** sample shows that the joining client "APP_SRV" is using the DC "DC1.CONTOSO.COM":

   ```output
   NetpManageMachineAccountWithSid: NetUserAdd on '\\DC1.CONTOSO.COM' for 'APP_SRV$' failed: 0x8b0
   NetpManageMachineAccountWithSid: status of attempting to set password on '\\DC1.CONTOSO.COM' for '<APP_SRV>$': 0x0
   NetpJoinDomain: status of creating account: 0x0
   NetpGetComputerObjectDn: Unable to bind to DS on '\\DC1.CONTOSO.COM': 0x6d9
   ```

2. Verify that the joining client has network connectivity to the DC over the required ports and protocols used by the applicable operating system (OS) versions. Domain join clients initially connect to a DC over TCP port 135, and then a dynamically assigned port in the range between 49152 and 65535.
3. Ensure that the OS, software and hardware routers, firewalls, and switches allow connectivity over the required ports and protocols.
4. Ensure that there are enough ports available for the operation. You can use tools like netstat to check for port availability and usage.
5. If advanced security solutions with host firewalls are installed on the DC, review their settings to ensure they aren't blocking the required ports.
6. Consider other potential causes and troubleshoot accordingly. For example, check firewall rules, ensure proper Domain Name System (DNS) resolution, and verify the health of the DC.
