---
title: Active Directory domain join troubleshooting guidance
description: Provides guidance to troubleshoot domain join issues.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
---
# Active Directory domain join troubleshooting guidance

This guide provides the fundamental concepts used when troubleshooting Active Directory domain join issues.

## Troubleshooting checklist

- Domain Name System (DNS): Anytime you have an issue joining a domain, one of the first things to check is DNS. DNS is the heart of Active Directory and makes things work correctly, including domain join. Make sure of the following items:

  - DNS server addresses are correct.
  - DNS suffix search order is correct if multiple DNS domains are in play.
  - There are no stale or duplicate DNS records referencing the same computer account.
  - Reverse DNS doesn't point to a different name as the A record.
  - The domain name, domain controllers (DCs), and DNS servers can be pinged.
  - Check for DNS record conflicts for the specific server.

- *Netsetup.log*: The *Netsetup.log* file is a valuable resource when you troubleshoot a domain join issue. The *netsetup.log* file is located at *C:\\Windows\\Debug\\netsetup.log*.
- Network trace: During an AD domain join, multiple types of traffic occur between the client and some DNS servers and then between the client and some DCs. If you see an error in any of the above traffic, follow the corresponding troubleshooting steps of that protocol or component to narrow it down. For more information, see [Using Netsh to Manage Traces](/windows/win32/ndf/using-netsh-to-manage-traces).
- Domain join hardening changes: Windows updates released on and after October 11, 2022, contain additional protections introduced by [CVE-2022-38042](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2022-38042). These protections intentionally prevent domain join operations from reusing an existing computer account in the target domain unless one of the following conditions exist:

  - The user attempting the operation is the creator of the existing account.
  - The computer was created by a member of domain administrators.

   For more information, see [KB5020276—Netjoin: Domain join hardening changes](https://support.microsoft.com/topic/kb5020276-netjoin-domain-join-hardening-changes-2b65a0f3-1f4c-42ef-ac0f-1caaf421baf8).

### Port Requirements

The following table lists the ports required to be open between the client computer and the DC.

|Port|Protocol|Application protocol|System service name|
|---|---|---|---|
|53|TCP|DNS|DNS Server|
|53|UDP|DNS|DNS Server|
|389|UDP|DC Locator|LSASS|
|389|TCP|LDAP Server|LSASS|
|88|TCP|Kerberos|Kerberos Key Distribution Server|
|135|TCP|RPC|RPC Endpoint Mapper|
|445|TCP|SMB|LanmanServer|
|1024-65535|TCP|RPC|RPC Endpoint Mapper for DSCrackNames, SAMR and Netlogon calls between Client and Domain Controller|

## Common issues and solutions

### Error code 0x569

For more information, see [Error code 0x569: The user has not been granted the requested logon type at this computer](error-0x569-not-granted-logon-type.md).

### Error code 0x534

> No mapping between account names and security IDs was done.

Here's an example from the *netsetup.log* file:

```output
mm/dd/yyyy hh:mm:ss:ms NetpCreateComputerObjectInDs: NetpGetComputerObjectDn failed: 0x534
mm/dd/yyyy hh:mm:ss:ms NetpProvisionComputerAccount: LDAP creation failed: 0x534
mm/dd/yyyy hh:mm:ss:ms ldap_unbind status: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: Function exits with status of: 0x534
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: status of disconnecting from '\\<DC name>': 0x0
mm/dd/yyyy hh:mm:ss:ms NetpDoDomainJoin: status: 0x534
```
  
The domain join graphical user interface (GUI) can call the `NetJoinDomain` API twice to join a computer to a domain. The first call is made without the "create" flag being specified to locate a pre-created computer account in the target domain. If no account is found, a second `NetJoinDomain` API call may be made with the "create" flag specified.
  
In another scenario, the 0x534 error code is logged when you attempt to change the password for a machine account. However, the account can't be found on the targeted DC, likely because the account was not created or due to replication latency or a replication failure.

The 0x534 error code is commonly logged as a transient error when domain join searches the target domain. The search determines whether a matching computer account was pre-created or the join operation needs to dynamically create a computer account on the target domain. Check the bit flags in the join options to see if the type of join being performed is relying on a pre-created or newly created computer account.

### Error code 0x6BF or 0xC002001C

> The remote procedure call failed and did not execute.

Here's an example from the *netsetup.log* file:

```output
mm/dd/yyyy hh:mm:ss:ms NetpGetLsaHandle: LsaOpenPolicy on \\<DC name>.<domain>.<tld> failed: 0xc002001c
mm/dd/yyyy hh:mm:ss:ms NetpGetLsaPrimaryDomain: status: 0xc002001c
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomain: initiaing a rollback due to earlier errors
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomain: status of disconnecting from '\\<DC name>.<domain>.<tld>': 0x0
mm/dd/yyyy hh:mm:ss:ms NetpDoDomainJoin: status: 0x6bf
```

This error occurs when a network device (router, firewall, or VPN device) rejects network packets between the client being joined and the DC.

Make sure of the following items:

- Verify the connectivity between the client being joined and the target DC over the required ports and protocols.
- Disable bind time feature negotiation.
- Disable TCP Chimney Offload and IP offload.

### Error code 0x6D9

> There are no more endpoints available from the endpoint mapper.

Here's an example from the *netsetup.log* file:

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
  
Error 0x6D9 is logged when network connectivity is blocked between the joining client and the helper DC. The network connectivity services the domain join operation over port 135 or a port in the ephemeral range between 1025 to 5000 or 49152 to 65535. For more information, see [Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md).  

To resolve this error, follow these steps:

1. On the joining client, open the *%systemroot%\\debug\\NETSETUP.LOG* file and determine the name of the helper DC selected by the joining client to perform the join operation.
2. Verify that the joining client has network connectivity to the DC over the required ports and protocols used by the applicable operating system (OS) versions. Domain join clients connect a helper DC over TCP port 135 by the dynamically assigned port in the range between 49152 and 65535.
3. Ensure that the OS, software and hardware routers, firewalls, and switches allow connectivity over the required ports and protocols.

### Error code 0xa8b

For more information, see [Error code 0xa8b: An attempt to resolve the DNS name of a DC in the domain being joined has failed](error-0xa8b-resolve-dns-fail.md).

### Error code 0x40

The following error messages occur when you try to join the computer to the domain:

> The specified network name is no longer available

:::image type="content" source="media/active-directory-domain-join-troubleshooting-guidance/domain-join-error-message.png" alt-text="Screenshot of the dialog box showing the error message for error code 0x40.":::

Here's an example from the *netsetup.log* file:

```output
mm/dd/yyyy hh:mm:ss:ms NetpValidateName: checking to see if '<domain_name>' is valid as type 3 name
mm/dd/yyyy hh:mm:ss:ms NetpCheckDomainNameIsValid [ Exists ] for '<domain_name>' returned 0x0
mm/dd/yyyy hh:mm:ss:ms NetpValidateName: name '<domain_name>' is valid for type 3
mm/dd/yyyy hh:mm:ss:ms NetpDsGetDcName: trying to find DC in domain '<domain_name>', flags: 0x40001010
mm/dd/yyyy hh:mm:ss:ms NetpDsGetDcName: failed to find a DC having account 'CLIENT1$': 0x525, last error is 0x0
mm/dd/yyyy hh:mm:ss:ms NetpDsGetDcName: status of verifying DNS A record name resolution for 'DCA.<domain_name>': 0x0
mm/dd/yyyy hh:mm:ss:ms NetpDsGetDcName: found DC '\\<dc_fqdn>' in the specified domain
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: NetpDsGetDcName returned: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpDisableIDNEncoding: using FQDN <domain_name> from dcinfo
mm/dd/yyyy hh:mm:ss:ms NetpDisableIDNEncoding: DnsDisableIdnEncoding(UNTILREBOOT) on '<domain_name>' succeeded
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: NetpDisableIDNEncoding returned: 0x0
mm/dd/yyyy hh:mm:ss:ms NetUseAdd to \\<dc_fqdn>\IPC$ returned 64
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: status of connecting to dc '\\<dc_fqdn>': 0x40
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: Function exits with status of: 0x40
mm/dd/yyyy hh:mm:ss:ms NetpResetIDNEncoding: DnsDisableIdnEncoding(RESETALL) on '<domain_name>' returned 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: NetpResetIDNEncoding on '<domain_name>': 0x0
mm/dd/yyyy hh:mm:ss:ms NetpDoDomainJoin: status: 0x40
```

This error is logged when the client computer lacks network connectivity on TCP port 88 between the client machine and the DC. To troubleshoot this issue, you can run the following command to test the connection:

```PowerShell
Test-NetConnection <IP_address_of_the_DC> -Port 88
```

Expected Output:

:::image type="content" source="media/active-directory-domain-join-troubleshooting-guidance/test-netconnection-output-88.png" alt-text="Screenshot that shows the Test-NetConnection command for TCP port 88 output.":::

The output indicates that the Kerberos Port TCP 88 is open between the client and the DC.

### Error code 0x54b

:::image type="content" source="media/active-directory-domain-join-troubleshooting-guidance/error-0x54b-message.png" alt-text="Screenshot of the dialog box showing the error message for error code 0x54b.":::

Here's an example of the error message:

> Note: This information is intended for a network administrator.  If you are not your network's administrator, notify the administrator that you received this information, which has been recorded in the file C:\WINDOWS\debug\dcdiag.txt.
>
> The following error occurred when DNS was queried for the service location (SRV) resource record used to locate an Active Directory Domain Controller (AD DC) for domain "<domain_name>":
>
> The error was: "This operation returned because the timeout period expired."
> (error code 0x000005B4 ERROR_TIMEOUT)
>
> The query was for the SRV record for <srv_record>
>
> The DNS servers used by this computer for name resolution are not responding. This computer is configured to use DNS servers with the following IP addresses:
>
> <ip_address>
>
> Verify that this computer is connected to the network, that these are the correct DNS server IP addresses, and that at least one of the DNS servers is running.

Here's an example from the *netsetup.log* file:

```output
mm/dd/yyyy hh:mm:ss:ms NetpValidateName: checking to see if '<domain_name>' is valid as type 3 name
mm/dd/yyyy hh:mm:ss:ms NetpCheckDomainNameIsValid for <domain_name> returned 0x54b, last error is 0x0
mm/dd/yyyy hh:mm:ss:ms NetpCheckDomainNameIsValid [ Exists ] for '<domain_name>' returned 0x54b
```

To resolve the 0x54b error, follow these steps:

- Check the network connectivity between the client and the Domain controller.
- Verify if the Preferred DNS Server is the correct DNS Server.
- Run `nltest /dsgetdc` (DC Discovery) to verify if you can discover a DC.
  
  For example:

  ```console
  nltest /dsgetdc:<domain_name> /force
  ```

  Expected Output:

  :::image type="content" source="media/active-directory-domain-join-troubleshooting-guidance/nltest-output.png" alt-text="Screenshot that shows the nltest command output.":::

- Run `DCDiag /v` on the closest domain controller and verify if SRV records are registered. For example: `_ldap._tcp.dc._msdcs.<domain_name>.com`.

### Error code 0x0000232A

Error 0x0000232A is logged when the client computer lacks NetBIOS name resolution to the domain.

:::image type="content" source="media/active-directory-domain-join-troubleshooting-guidance/error-0x0000232a-message.png" alt-text="Screenshot of the dialog box showing the error message for error code 0x0000232A.":::

Here's an example of the error message:

> Note: This information is intended for a network administrator.  If you are not your network's administrator, notify the administrator that you received this information, which has been recorded in the file C:\WINDOWS\debug\dcdiag.txt.
>
> The domain name "\<NetBIOS_name\>" might be a NetBIOS domain name.  If this is the case, verify that the domain name is properly registered with WINS.
>
> If you are certain that the name is not a NetBIOS domain name, then the following information can help you troubleshoot your DNS configuration.
>
> The following error occurred when DNS was queried for the service location (SRV) resource record used to locate an Active Directory Domain Controller (AD DC) for domain "\<NetBIOS_name\>":
>
> The error was: "DNS server failure."
> (error code 0x0000232A RCODE_SERVER_FAILURE)
>
> The query was for the SRV record for _ldap._tcp.dc._msdcs.\<NetBIOS_name\>
>
> Common causes of this error include the following:
>
> - The DNS servers used by this computer contain incorrect root hints. This computer is configured to use DNS servers with the following IP addresses:
>
> \<ip_address\>
>
> - One or more of the following zones contains incorrect delegation:
>
> \<NetBIOS_name\>
> . (the root zone)

Here's an example from the *netsetup.log* file:

```output
mm/dd/yyyy hh:mm:ss:ms NetpValidateName: checking to see if '<NetBIOS_name>' is valid as type 3 name
mm/dd/yyyy hh:mm:ss:ms NetpCheckDomainNameIsValid for <NetBIOS_name> returned 0x54b, last error is 0x0
mm/dd/yyyy hh:mm:ss:ms NetpCheckDomainNameIsValid [ Exists ] for '<NetBIOS_name>' returned 0x54b
```

When you enter the domain name, make sure you enter the DNS Domain Name rather than the NetBIOS name. For example, if the DNS name of the domain is contoso.com, make sure you enter that name instead of just contoso.

### Error code 0x3a

The following error occurred when attempting to join the domain:

> The specified server cannot perform the requested operation.

:::image type="content" source="media/active-directory-domain-join-troubleshooting-guidance/error-0x3a-message.png" alt-text="Screenshot of the dialog box showing the error message for error code 0x3a.":::

Here's an example from the *netsetup.log* file:

```output
mm/dd/yyyy hh:mm:ss:ms NetpLdapBind: ldap_bind failed on <dc_fqdn>: 81: Server Down
mm/dd/yyyy hh:mm:ss:ms NetpJoinCreatePackagePart: status:0x3a.
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: Function exits with status of: 0x3a
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: status of disconnecting from '\\<dc_fqdn>': 0x0
mm/dd/yyyy hh:mm:ss:ms NetpResetIDNEncoding: DnsDisableIdnEncoding(RESETALL) on '<domain_name>' returned 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: NetpResetIDNEncoding on '<domain_name>': 0x0
mm/dd/yyyy hh:mm:ss:ms NetpDoDomainJoin: status: 0x3a
```

Error 0x3a is logged when the client computer lacks network connectivity on TCP port 389 between the client computer and the DC. To troubleshoot this issue, use the following command to test the connection:

```PowerShell
Test-NetConnection <IP_address_of_the_DC> -Port 389
```

Expected Output:

:::image type="content" source="media/active-directory-domain-join-troubleshooting-guidance/test-netconnection-output-389.png" alt-text="Screenshot that shows the Test-NetConnection command for TCP port 389 output.":::

It indicates that the LDAP Port TCP 389 is open between the client and the DC.

### Error code 0x216d

The following error occurred when attempting to join the domain:

> Your computer could not be joined to the domain. You have exceeded the maximum number of computer accounts you are allowed to create in this domain. Contact your system administrator to have this limit reset or increased.

:::image type="content" source="media/active-directory-domain-join-troubleshooting-guidance/error-0x216d-message.png" alt-text="Screenshot of the dialog box showing the error message for error code 0x216d.":::

```output
mm/dd/yyyy hh:mm:ss:ms NetpMapGetLdapExtendedError: Parsed [0x216d] from server extended error string: 0000216D: SvcErr: DSID-031A124C, problem 5003 (WILL_NOT_PERFORM), data 0
mm/dd/yyyy hh:mm:ss:ms NetpModifyComputerObjectInDs: ldap_add_s failed: 0x35 0x216d
mm/dd/yyyy hh:mm:ss:ms NetpCreateComputerObjectInDs: NetpModifyComputerObjectInDs failed: 0x216d
mm/dd/yyyy hh:mm:ss:ms NetpProvisionComputerAccount: LDAP creation failed: 0x216d
mm/dd/yyyy hh:mm:ss:ms NetpProvisionComputerAccount: Retrying downlevel per options
mm/dd/yyyy hh:mm:ss:ms NetpManageMachineAccountWithSid: NetUserAdd on '<dc_fqdn>' for 'CLIENT1$' failed: 0x216d
mm/dd/yyyy hh:mm:ss:ms NetpProvisionComputerAccount: retry status of creating account: 0x216d
mm/dd/yyyy hh:mm:ss:ms ldap_unbind status: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinCreatePackagePart: status:0x216d.
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: Function exits with status of: 0x216d
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: status of disconnecting from '\\<dc_fqdn>': 0x0
mm/dd/yyyy hh:mm:ss:ms NetpResetIDNEncoding: DnsDisableIdnEncoding(RESETALL) on '<domain_name>' returned 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: NetpResetIDNEncoding on '<domain_name>': 0x0
mm/dd/yyyy hh:mm:ss:ms NetpDoDomainJoin: status: 0x216d
```

Error 0x216d is logged in one of these conditions:

- The user account trying to join the machine to the domain has exceeded the limit of 10 machines joined to the domain.
- There is a GPO restriction to block authenticated users from joining a machine to the domain.

Verify that the user account is a member of the group mentioned in the **Add Workstations to domain** policy of the **Default Domain Controller Policy** GPO or the **Winning** GPO.

The GPO setting is located at **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Local Policies User Rights Assignment** > **Add workstations to domain**.

To verify the default limit to the number of workstations a user can join to the domain, see [Default limit to number of workstations a user can join to the domain](default-workstation-numbers-join-domain.md).

### Other errors that occur when you join Windows-based computers to a domain

For more information, see:

- Troubleshoot [Networking error messages and resolutions](troubleshoot-errors-join-computer-to-domain.md#networking-error-messages-and-resolutions)
- Troubleshoot [Authentication error messages and resolutions](troubleshoot-errors-join-computer-to-domain.md#authentication-error-messages-and-resolutions)
