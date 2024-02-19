---
title: Enable or disable DNS updates
description: Describes how to disable and enable dynamic registration with DNS servers in Windows.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, herbertm
ms.custom: sap:dns, csstroubleshoot
---
# How to enable or disable DNS updates in Windows

The article discusses how to disable DNS updates in Windows. By default, client computers have DNS updates enabled.

_Applies to:_ &nbsp; Windows 10, Windows Server 2012 R2, Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 246804

## Summary

Windows supports Domain Name System (DNS) updates per RFC 2136. By default, this behavior is enabled for Windows DNS clients.

Depending on the configuration and services that are running on a particular computer, different components perform DNS updates. There's no centralized way, such as a tool or registry keys, to manage the DNS update behavior of all components. This article describes each component and how to modify that particular component's behavior.

The article also discusses how to disable DNS updates in Windows. By default, computers that are running Windows Server have DNS updates enabled.

## Introduction

The following components perform DNS updates:

- Dynamic Host Configuration Protocol (DHCP) Client service  
    These updates apply to all Windows-based computers.
- DNS Server service  
    These updates apply to Windows-based DNS servers.
- Net Logon service  
    These updates apply to Windows-based domain controllers.
- Remote access client  
    These updates apply to Windows-based remote access clients.
- DNS clients  
    These updates apply to Windows-based DNS clients.

> [!NOTE]
> After you change one of these components by modifying the registry keys that are listed in this article, you must stop and restart the affected services. Sometimes, you must restart the computer. These instances are noted.

### DHCP Client service

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692).  

The DHCP Client service performs DNS updates for network adapters regardless of whether the adapter is configured by using DHCP or by using manual or static methods. This section describes how to enable and disable the following lookup registrations:

- Forward and reverse for all adapters
- Reverse for all adapters
- Advanced TCP/IP properties controls per adapter
- Forward and reverse per adapter
- Reverse per adapter
- Other settings

### Forward and reverse for all adapters

To disable both forward (A resource record) and reverse (PTR resource record) registrations that are performed for all adapters by the DHCP Client service, use the following registry subkey:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\DisableDynamicUpdate`  

Range: 0 - 1  
Default value: 0

> [!NOTE]
> When this registry value is set to **1**, the **Register this connection's addresses in DNS** check box that is located on the **DNS** tab of each network interface's **TCP/IP advanced properties**, will not be affected. If the check box was checked before the policy was enabled, it will still be checked after the policy is enabled. The registry setting made by the policy is a global setting that affects all interfaces, not an adapter-specific setting. This global setting is not revealed in the Data type REG_DWORD.

This key disables DNS update registration for all adapters on this computer. With DNS update, DNS client computers automatically register and update their resource records whenever address changes occur.

|Value  |Meaning  |
|---------|---------|
|0     |Enables DNS update registration         |
|1     |Disables DNS update registration         |

> [!NOTE]
> For DNS updates to operate on any adapter, DNS update must be enabled at the system level and at the adapter level. To disable DNS update for a particular adapter, add the DisableDynamicUpdate value to an interface name registry subkey and set its value to 1 . To disable DNS updates on all adapters in a computer, add the DisableDynamicUpdate value to the following subkey, and then set its value to 1:
>
> `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`
>
> When this registry value is set to 1, the **Register this connection's addresses in DNS** check box will not reflect the changes made to this registry key. (This check box is located on the **DNS** tab of each network interface's **TCP/IP advanced properties**.) If the check box was selected before the registry change, it will stay selected after this registry change. This registry setting is not an adapter-specific setting, but a global setting that affects all interfaces. This global setting is not revealed in the user interface.

Windows doesn't add this entry to the registry. You can add it by editing the registry or by using a program that edits the registry.

To make the changes to this value effective, you must restart Windows.

### Reverse for all adapters

When you want forward lookup (A resource record) registrations but not reverse lookups (PTR resource record) registrations, use the following registry subkey to disable registrations of PTR resource records:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\DisableReverseAddressRegistrations`  

Data type: REG_DWORD  
Range: 0 - 1  
Default value: 0  

This key disables DNS update registration of PTR resource records by this DNS client. PTR resource records associate an IP address with a computer name. This entry is designed for enterprises where the primary DNS server that is authoritative for the reverse lookup zone can't, or is configured not to, perform DNS updates. It reduces unnecessary network traffic and prevents event log errors that record unsuccessful tries to register PTR resource records.

|Value  |Meaning  |
|---------|---------|
|0     |Register PTR resource records         |
|1     |Do not register PTR resource records         |

> [!NOTE]
> Windows does not add this entry to the registry. You can add it by editing the registry or by using a program that edits the registry.

To make the changes to this value effective, you must restart Windows.

### Advanced TCP/IP properties controls per adapter

DNS registrations that are performed by each adapter can be changed by using the following adapter-specific advanced TCP/IP settings on the
 **DNS** tab:

- **DNS suffix for this connection**  
- **Register this connection's addresses in DNS**  
- **Use this connection's DNS suffix in DNS registration**

The **Register this connection's addresses in DNS** default setting registers A and PTR resource records for the first IP address that is configured on this adapter. Clear this check box to keep the DHCP Client service from registering both A and PTR resource records for this adapter.

By default, the **Use this connection's DNS suffix in DNS registration** setting is cleared. Each computer has a primary DNS suffix. Use the ipconfig /all command to view this suffix.

Additionally, each adapter can also have a separate DNS suffix that is configured for itself. An adapter-specific DNS suffix can be configured manually or by using DHCP option 15 as part of the DHCP lease process.

Select this check box to enable the DHCP Client service to register A and PTR resource records for the **PrimaryDnsSuffix** host name and for the following fully qualified domain name (FQDN): hostname. **dns_suffix_for_this_adapter**  

### Forward and reverse per adapter

To disable A and PTR resource record registrations that are performed for a specific adapter by the DHCP Client service, use the following registry subkey:

 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\<Interface name>\DisableDynamicUpdate`

Data type: REG_DWORD  
Range: 0 - 1  
Default value: 0  

This disables DNS update registration on this adapter. With DNS update, DNS client computers automatically register and update their resource records whenever address changes occur.

|Value  |Meaning  |
|---------|---------|
|0     |Enables DNS update registration         |
|1     |Disables DNS update registration         |

> [!NOTE]
> For DNS updates to operate on any adapter, it must be enabled at the system level and at the adapter level. To disable DNS updates for a particular adapter, add the DisableDynamicUpdate value to an interface name registry subkey, and then set its value to 1. To disable DNS updates on all adapters in a computer, add the DisableDynamicUpdate value to the following registry subkey, and then set its value to 1:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`

Windows doesn't add this entry to the registry. You can add it by editing the registry or by using a program that edits the registry.

To make the changes to this value effective, you must restart Windows.

### Reverse per adapter

There's no mechanism to disable PTR resource record registrations on a per-adapter basis.

### Other settings

This section lists other parameters that are used by the DHCP Client service as they relate to DNS updates.

By default, DNS records are re-registered dynamically and periodically every 24 hours. You can use the following registry subkey to modify the update interval:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\DefaultRegistrationRefreshInterval`
  
Data type: REG_DWORD  
Range: 0x0 - 0xFFFFFFFF seconds  
Default value: 0x15180 (86,400 seconds = 24 hours)

This specifies the time interval between DNS update registration updates. To make the changes to this value effective, you must restart Windows.

The default Time To Live (TTL) value used for dynamic registrations is 20 minutes. You can use the following registry subkey to modify the TTL value:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\DefaultRegistrationTTL`  

Data type: REG_DWORD  
Range: 0x0 - 0xFFFFFFFF seconds  
Default value: 0x4B0 (1,200 seconds = 20 minutes)  
Scope: Affects all adapters  

This specifies the TTL of the DNS registration.

Windows doesn't add this entry to the registry. You can add it by editing the registry or by using a program that edits the registry.

To make the changes to this value effective, you must restart Windows.

By default, only the first IP address is dynamically registered. You can use the following registry key to modify the number of IP addresses that are dynamically registered for an adapter that is configured with more than one IP address, or is logically multihomed:

 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\<Interface name>\MaxNumberOfAddressesToRegister`

Data type: REG_DWORD  
Range: 0x0 - 0xFFFFFFFF  
Default value: 0x1  
Scope: Affects this adapter only  

This setting determines the maximum number of IP addresses that can be registered in DNS for this adapter.

If the value of this entry is 0, IP addresses can't be registered for this adapter.

To make the changes to this value effective, you must restart Windows.

By default, non-secure DNS registrations are tried. You can use the following registry subkey to modify this behavior:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\UpdateSecurityLevel`  

Data type: REG_DWORD  
Range: 0x0 | 0x10 | 0x100  
Default value: 0x0  
Scope: Affects all adapters  

This determines whether the DNS client uses secure dynamic update or standard dynamic update. Windows supports both dynamic updates and secure dynamic updates. With secure dynamic updates, the authoritative name server accepts updates only from authorized clients and servers.

|Value  |Meaning  |
|---------|---------|
|0 (0x0)     |Send secure dynamic updates only when non-secure dynamic updates are refused.         |
|16 (0x10)     |Send only non-secure dynamic updates.         |
|256 (0x100)     |Send only secure dynamic updates.         |

Windows doesn't add this entry to the registry. You can add it by editing the registry or by using a program that edits the registry.

To make the changes to this value effective, you must restart Windows.

By default, the DNS client tries to replace the original registration with a record that associates the DNS name to its own IP address. You can use the following registry subkey to modify this behavior:

 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\DisableReplaceAddressesInConflicts`  

Data type: REG_DWORD  
Range: 0 - 1  
Default value: 0  
Scope: Affects all adapters  

This prevents the DNS client from overwriting an existing resource record when it discovers an address conflict during dynamic update. An address conflict occurs when the DNS client discovers that an existing A resource record associates its DNS name with the IP address of a different computer.

By default, the DNS client tries to replace the original registration with a record that associates the DNS name to its own IP address. However, you can use this entry to direct DNS back out of the registration process. An error in Event Viewer isn't logged.

This entry is designed for zones that don't use secure dynamic update. It prevents unauthorized users from changing the IP address registration of a client computer.

|Value  |Meaning  |
|---------|---------|
|0     |The DNS client overwrites the existing A resource record with an A resource record for its own IP address.         |
|1     |The DNS client backs out of the registration process. No error is written to the Event Viewer log.         |

Windows doesn't add this entry to the registry. You can add it by editing the registry or by using a program that edits the registry.

To make the changes to this value effective, you must restart Windows.

### DNS Server service

The DNS Server service registers host name A resource records for all the adapters that the service is listening on if the service is authoritative (SOA) for a particular name.

When a server that is running the DNS Server service has multiple adapters, unwanted addresses can be automatically published. Common scenarios include disconnected or unused network adapters that publish AutoNet addresses and private or perimeter network (DMZ) interfaces that publish unreachable addresses.

If the Network Load Balancing service is installed on a DNS server, both the virtual network adapter address and the dedicated network adapter address will be registered by the DNS Server service. The adapters that the DNS server is listening on can be changed by using the DNS snap-in. In **Server properties**, click the **Adapters** tab.

If the list of IP addresses that the DNS server listens to and serves is different from the list of IP addresses that is published or that is registered by the DNS Server service, use the following registry subkey:

 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNS\Parameters\PublishAddresses`  

Data type: REG_SZ  
Range: \<IP address> [\<IP address>]  
Default value: blank  

This value specifies the IP addresses that you want to publish for the computer. The DNS server creates A resource records only for the addresses in this list. If this entry doesn't appear in the registry, or if its value is blank, the DNS server creates an A resource record for each of the computer's IP addresses.

This entry is designed for computers that have multiple IP addresses. With this entry, you can publish only a subset of the available addresses. Typically, this entry is used to prevent the DNS server from returning a private network address in response to a query when the computer has a corporate network address.

DNS reads its registry entries only when it starts. You can change entries while the DNS server is running by using the DNS console. If you change entries by editing the registry, the changes aren't effective until you restart the DNS server.

The DNS server doesn't add this entry to the registry. You can add it by editing the registry or by using a program that edits the registry.

### The Net Logon service

By default, the Net Logon service registers certain SRV, CNAME, and A resource records every hour, even if some or all these records are correctly registered in DNS. The list of records that the Net Logon service tries to register is stored in the *%systemroot%\\System32\\Config\\Netlogon.dns* file. This log file lists records that are required to be registered for this domain controller.

The Net Logon service does not provide a mechanism to control registrations that it performs on a per-adapter basis. This section describes how to enable and disable the following items:

- All registrations
- Net Logon service A registrations

#### All registrations

To disable all registrations that are performed by the Net Logon service, use the following registry subkey. (A restart of the Net Logon service is required, although a restart of the computer is preferred.)

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters\UseDynamicDns`  

Data type: REG_DWORD  
Range: 0 - 1  
Default value: 1  

This value determines whether the Net Logon service on this domain controller uses DNS updates. The Net Logon service can use DNS updates to register DNS names that identify the domain controller. Whenever an authorized zone server requests an update, DNS updates provide automatic updates of zone data, such as DNS names, on the zone's primary server. DNS supplements the static, manual method of adding and changing zone records. The dynamic update protocol is defined in RFC 2136.

|Value  |Meaning  |
|---------|---------|
|0     |The Net Logon service does not use DNS updates. Records specified in the Netlogon.dns file must be registered manually in DNS.         |
|1     |The Net Logon service uses DNS updates to register the names that identify this domain controller.         |

You might disable the Net Logon service's use of DNS updates if your DNS servers don't support DNS updates or to remove the network traffic that is associated with periodic registration of the Net Logon service's DNS records.

This entry is supported on domain controllers only. Windows doesn't add this entry to the registry. You can add it by editing the registry or by using a program that edits the registry.

To make the changes to this value effective, delete the *%systemroot%\\System32\\Config\\netlogon.dnb* file, and then restart the Net Logon service.

### Net Logon service A registrations

By default, the Net Logon service on a domain controller registers SRV, domain A, and global catalog A resource records every hour. SRV records are mapped to an FQDN, and A resource records are mapped to an IP address.

Registration of domain A resource records for all adapters by the Net Logon service and subsequent re-registration every hour, by default, can be problematic if clients resolve the domain name to an unreachable IP address.

The following registry subkey enables or disables the registration of A resource records by the Net Logon service for a domain controller. The domain A resource records aren't required by Windows, but they're registered for the benefit of Lightweight Directory Access Protocol (LDAP) implementations that don't support SRV records.

This RegisterDnsARecords registry value disables all A resource record registrations that are performed by the Net Logon service. These records include the gc._msdcs.DnsForestName records. Registration of gc._msdcs.DnsForestName records is required and must be performed manually if the RegisterDnsARecords registry value is set to disabled.

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters\RegisterDnsARecords`  

Data type: REG_DWORD  
Range: 0 - 1  
Default value: 1  

This value determines whether this domain controller registers DNS A (IP address) records for the domain. If this domain controller is a global catalog resource, this entry also determines whether the domain controller registers global catalog DNS A resource records.

|Value  |Meaning  |
|---------|---------|
|0     |Does not register DNS A resource records. LDAP implementations that do not support SRV records will not be able to locate the LDAP server on this domain controller.         |
|1     |Registers DNS A resource records.         |

> [!NOTE]
> This entry is used only when it appears in the registry of a domain controller. You might set this value to 0 if DNS does not complete its updates because it cannot update A resource records. DNS stops updating when an update try does not succeed.

Windows doesn't add this entry to the registry. You can add it by editing the registry or by using a program that edits the registry.

To make the changes to this value effective, you must restart the Net Logon service.

### Remote access client

To configure individual Remote Access Service connection settings, use Advanced TCP/IP properties, as in the "Per adapter - advanced TCP/IP properties controls" section.

### How to disable DNS updates in Windows

By default, client computers that are running Windows have DNS updates enabled. To disable domain name system (DNS) dynamic update protocol registration for all network interfaces, use one of the following methods:

#### Method 1

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. Locate and then click the following registry subkey:  
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`

3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
4. Type *DisableDynamicUpdate*, and then press ENTER two times.
5. In the **Edit DWORD Value** dialog box, type *1* in the **Value data** box, and then click **OK**.

    > [!NOTE]
    > By default, the DNS update is enabled (0).

6. Exit **Registry Editor**.

#### Method 2

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. Locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Dnscache\Parameters`

3. On the **Edit** menu, point to **New**, click **DWORD Value**, and then type *RegistrationEnabled*.
4. Right-click **RegistrationEnabled**, click **Modify**, type *0* in the **Value data** box, and then click **OK**.
5. Exit **Registry Editor**.

For more information about how to configure DNS dynamic updates and how to integrate DNS updates with DHCP, see [How to configure DNS dynamic update in Windows Server](configure-dns-dynamic-updates-windows-server-2003.md).
