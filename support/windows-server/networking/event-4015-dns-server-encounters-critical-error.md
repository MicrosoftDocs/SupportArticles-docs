---
title: Event ID 4015 - The DNS server encountered a critical error
description: Describes how to interpret DNS Server Event ID 4015, identify the cause of the critical error, and then fix it.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna, herbertm, v-appelgatet
ms.custom:
- sap:network connectivity and file sharing\dns
- pcy:WinComm Networking
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Event ID 4015: The DNS server encountered a critical error

_Original KB number:_ &nbsp; 969488, 2733147

## Summary

Domain Name Service (DNS) server Event ID 4015 indicates that a domain controller (DC) that runs the DNS Server role experienced a critical error. The event description includes an error code that identifies the type of issue that occurred.  

This article describes three common scenarios that trigger Event ID 4015:

- Error code 00002095: A Read-Only Domain Controller (RODC) running DNS can't connect to a writable domain controller
- Error code 0000051B: The DNS server can't access an Active Directory object due to permission issues
- ADMIN_LIMIT_EXCEEDED: A DNS-related Active Directory object contains too many orphaned entries from demoted domain controllers

Review the error code in the Event ID 4015 description. Then, follow the troubleshooting steps for your specific scenario.

## Symptoms

A DNS server can generate Event ID 4015 in several different scenarios. Use the error code in the event description to distinguish which scenario you're experiencing, and then select the closest scenario from the following list:

- [RODC DNS server logs DNS Event ID 4015 (error code 00002095) every three minutes](#rodc-dns-server-logs-dns-event-id-4015-error-code-00002095-every-three-minutes). This scenario might have the following conditions:

  - A Read-Only Domain Controller (RODC) run the DNS role.
  - The RODC can't connect to a writable domain controller (DC) that runs the DNS role.
  
  In this scenario, the RODC logs events that resemble the following example:

    ```output
    Log Name: DNS Server
    Source: Microsoft-Windows-DNS-Server-Service
    Date: date time
    Event ID: 4015
    Task Category: None
    Level: Error
    Keywords: Classic
    User: N/A
    Computer: <ComputerName>
    Description:
    The DNS server has encountered a critical error from the Active Directory. Check that the Active Directory is functioning properly. The extended error debug information (which may be empty) is "00002095: SvcErr: DSID-03210A6A, problem 5012 (DIR_ERROR), data 16". The event data contains the error.
    ```

- [DNS server logs Event ID 4015 (error code 0000051B)](#dns-server-logs-event-id-4015-error-code-0000051b). This scenario might occur if the DNS server can't access an Active Directory object. In this scenario, the DNS server repeatedly logs events that resemble the following example:

    ```output
    Type: Error
    Source: DNS
    Category: None
    Event ID: 4015
    Description:
    The DNS server has encountered a critical error from the Active Directory. Check that the Active Directory is functioning properly. The extended error debug information (which may be empty) is "0000051B: AttrErr: DSID-xxxx, #1: 0:0000051B: DSID-xxxx, problem 1005 (CONSTRAINT_ATT_TYPE), data 0, Att 20119(nTSecurityDescriptor)". The eventdata contains the error."
    ```

- [DNS server logs Event ID 4015 (extended error code (ADMIN_LIMIT_EXCEEDED))](#dns-server-logs-event-id-4015-extended-error-code-admin_limit_exceeded). This issue might occur in the following scenario:

  - The forest or domain uses Active Directory-integrated DNS zones.
  - Some DCs that act as DNS servers have been promoted and demoted.
  Some of the promoted DCs can't register DNS records in the DNS zones. This issue includes server (SRV) records, Host (A) records, pointer (PTR) records, or name server (NS) records. The affected DCs log Event ID 4015, and the description of the event resembles the following example:

  ```ouput
  The DNS server has encountered a critical error from the Active Directory. Check that the Active Directory is functioning properly. The extended error debug information (which may be empty) is "00002024: SvcErr: DSID-02050BBD, problem 5008 (ADMIN_LIMIT_EXCEEDED), data -1026". The event data contains the error.
  ```

## RODC DNS server logs DNS Event ID 4015 (error code 00002095) every three minutes

### Cause

An RODC keeps itself up to date by replicating changes from one or more writable DCs. An RODC that's functioning as a DNS server uses the [replicateSingleObject](/openspecs/windows_protocols/ms-adts/d3d19d15-8427-4d4d-8256-d5fb11333292) operation to make sure that it has the latest DNS information. In this scenario, the RODC tries to update a name server (NS) record.

To support this functionality, the RODC DNS server must be able to locate a writeable DC DNS server, as needed. To locate the server, the RODC uses one of the `DsGetDC` functions (such as [DsGetDCNameA](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamea) or [DsGetDCNameW](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamew)) together with the following flags:

- `DS_AVOID_SELF`
- `DS_TRY_NEXTCLOSEST_SITE`
- `DS_DIRECTORY_SERVICE_6_REQUIRED`
- `DS_WRITEABLE_REQUIRED`

The `DsGetDC` function returns a DC. The RODC searches this DC for the appropriate NS record. In either of the following cases, the RODC logs Event ID 4015:

- The identified DC isn't a DNS server, or doesn't list an appropriate NS record.
- The function didn't identify a writeable DC.

### Resolution

1. To check the results of the `DsGetDC` function, open a Windows Command Prompt window on the RODC, and then run the following command:

   ```console
   nltest /dsgetdc: <DomainFQDN> /WRITABLE /AVOIDSELF /TRY_NEXT_CLOSEST_SITE /DS_6
   ```

   > [!NOTE]  
   > In this command, \<DomainFQDN> represents the fully qualified domain name (FQDN) of the domain.

1. If the command output lists a DC, check that DC's configuration. If the command didn't locate a DC, update your DNS topology to make sure that the RODC can connect to an appropriate DC. In both cases, make sure that the DC meets the following criteria:

   - The DC is writeable.
   - The DC has the DNS Server role installed.
   - The DNS records on the DC are configured correctly.

## DNS server logs Event ID 4015 (error code 0000051B)

The access issue is caused by one of the following conditions:

- The SYSTEM account isn't the owner of the DNS zone.
- The Users group for the domain doesn't have the correct members, including the Authenticated Users group. In this case, the issue might not appear until the DNS servers have been running for at least 10 hours, and it occurs sporadically on multiple DCs.

### The SYSTEM account isn't the owner of the DNS zone - Resolution

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

To resolve this issue, follow these steps:

1. To enable Field Engineering diagnostic logging on a DC that's generating Event ID 4015, follow the instructions in [Enable Field Engineering diagnostic event logging](../identity/configure-ad-and-lds-event-logging.md#enable-field-engineering-diagnostic-event-logging).

1. Reproduce the issue.

1. To stop Field Engineering diagnostic logging, set the `15 Field Engineering` registry entry to *0*. This entry is under the following subkey:

   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics\`

1. Note the time at which Event ID 4015 occurred, and look for an instance of Directory Service Event ID 1644 that occurred at the same time. In that instance of Event ID 1644, note the FQDN of the object that the event identifies. The object should represent a DNS zone.
1. Open the ADSI Edit (*Adsiedit.msc*) tool, and go to the LDAP location of the DNS zone object.
1. Right-click the zone object, and then select **Properties** > **Security** > **Advanced**.
1. Make sure that **Owner** is set to **SYSTEM**.

### The Users group for the domain doesn't have the correct members - Resolution

To resolve this issue, follow these steps:

1. Use an Admin group member account to sign in to the DC. You can also run this procedure on an admin computer by adding the `/domain` parameter.

1. To list the current members of the Users group, open a Windows Command Prompt window, and then run the following command:

   ```console
   net localgroup users /domain
   ```

1. The group should have the following members:

   - Domain Users
   - NT AUTHORITY\Authenticated Users
   - NT AUTHORITY\INTERACTIVE

1. If one or more of the listed groups is missing, add them as group members. For example, to add NT AUTHORITY\Authenticated Users, run the following command at the command prompt:

   ```console
   net localgroup users "NT AUTHORITY\Authenticated Users" /add /domain
   ```

1. Wait for the change to replicate among the DCs.

1. On all the DCs in the domain, restart the DNS Server service.

## DNS server logs Event ID 4015 (extended error code (ADMIN_LIMIT_EXCEEDED))

### Cause

The DNS Server service generates this error code if a multi-valued `dnsRecord` attribute of a `dnsNode` object in Active Directory contains too many values.

Active Directory represents DNS names as `dnsNode`-class objects. It records DNS records as values in the `dnsRecord` attributes of those objects. When you promote a DC into a forest as a DNS server, Active Directory automatically adds the appropriate DNS records to new and existing `dnsNode` objects. However, when you demote a DC that acts as a DNS server, Active Directory doesn't automatically clean up the related DNS objects and attributes. Those objects and attributes are left as "orphans." After multiple demote and promote operations in a single forest, orphaned values can accumulate to the point that `dnsRecord` attributes reach their maximum capacity.

To check the current number of records for the objects in each DNS-related partition, run the following `repadmin` commands:

```console
repadmin /showattr . "CN=MicrosoftDNS,CN=System,DC=contoso,DC=com" /subtree /filter:"(objectclass=dnsnode)" /atts:"dnsRecord" /allvalues >c:\temp\dns_Domain.txt
repadmin /showattr . "CN=MicrosoftDNS,DC=DomainDnsZones,DC=contoso,DC=com" /subtree /filter:"(objectclass=dnsnode)" /atts:"dnsRecord" /allvalues>c:\temp\dns_DomainDnsZones.txt
repadmin /showattr . "CN=MicrosoftDNS,DC=ForestDnsZones,DC=contoso,DC=com" /subtree /filter:"(objectclass=dnsnode)" /atts:"dnsRecord" /allvalues >c:\temp\dns_ForestDnsZones.txt
```

The output displays the current number of entries that are contained in `dnsRecord` attributes of the corresponding Active Directory `dnsNode` objects. For example, the following excerpt shows command output that refers to a single `dnsNode` object. The `dnsRecord` attribute for this object has 1,280 values:

```output
DN: DC=@,DC=..TrustAnchors,CN=MicrosoftDNS,DC=ForestDnsZones,DC=contoso,DC=com
1280> dnsRecord: <48 byte blob>;
```

> [!NOTE]  
> The `repadmin` output doesn't show the actual values. It represents each value as a "blob." This excerpt shows a single value.

### Resolution

To resolve this issue, you have to remove all the orphaned entries of the demoted domain controllers. To check each zone and selectively delete the appropriate records, open an administrative Windows PowerShell window, and run the following cmdlets for each zone:

```powershell
Get-DnsServerResourceRecord -ZoneName "<ZoneName>" -RRType "<ResourceRecordType>"
Remove-DnsServerResourceRecord -zonename "<ZoneName>" -RRType "<ResourceRecordType>" -Name "<ResourceRecordName>" -RecordData "<DC_FQDN>"
```

In the following example, the first command retrieves all the name server record values for the trustanchors zone. The second command selects any of those records that have the name "@" and that relate to the DC that has the name "DC-10.contoso.com." Then, it deletes those records.

```powershell
Get-DnsServerResourceRecord -ZoneName "trustanchors" -RRType "NS"
Remove-DnsServerResourceRecord -zonename "trustanchors" -RRType "NS" -Name "@" -RecordData "dc2.contoso.com"
```

The following example shows a script that uses these commands to delete multiple resource record values for a single host:

```powershell
$AllNsRecords = Get-DnsServerResourceRecord -ZoneName "trustanchors" -RRType "NS"
Foreach($Record in $AllNsRecords){
If($Record.recorddata.nameserver -like "*dc2*"){
$Record | Remove-DnsServerResourceRecord -ZoneName "trustanchors"
}
}
$AllSrvRecords = Get-DnsServerResourceRecord -ZoneName "_msdcs.contoso.com" -RRType "Srv"
Foreach($Record in $AllSrvRecords){
If($Record.recorddata.domainname -like "*dc2*"){
$Record | Remove-DnsServerResourceRecord -ZoneName "_msdcs.contoso.com"
}
}
```

## Data collection

If you have to contact Microsoft Support, you can use [scripts from the TroubleShootingScript toolset (TSS)](https://aka.ms/getTSS) to gather information about DNS issues and provide background. For more information about how to use TSS when you troubleshoot DNS issues, see [Data collection](troubleshoot-dns-guidance.md#data-collection) in "DNS troubleshooting guidance."

In particular, use the following command to gather trace data about Event ID 4015:

```powershell
.\TSS.ps1 -Scenario NET_DNSsrv -Mode Verbose -WaitEvent Evt:4015:'DNS Server'
```

> [!NOTE]
> The trace logging automatically stops after Event ID 4015 is logged.
