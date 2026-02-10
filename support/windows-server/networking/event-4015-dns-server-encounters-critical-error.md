---
title: Event ID 4015 - The DNS server encountered a critical error
description: Describes how to fix the issue in which Event ID 4015 is logged and the Domain Name Service (DNS) server encounters a critical error.
ms.date: 02/10/2026
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

This article helps to resolve the issue in which Event ID 4015 is logged and the Domain Name Service (DNS) server encounters a critical error.

## Symptoms

A DNS server can generate Event ID 4015 in several different scenarios. Use the error code in the event description to distinguish which scenario you have, and select the closest scenario from the following list:

- [RODC DNS server logs DNS Event ID 4015 (error code 00002095) every three minutes](#rodc-dns-server-logs-dns-event-id-4015-error-code-00002095-every-three-minutes). This issue might occur in the following scenario:

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

- [DNS server logs Event ID 4015 (error code 0000051B)](#dns-server-logs-event-id-4015-error-code-0000051b). This issue might occur if the DNS server can't access an Active Directory object. In this scenario, the DNS server repeatedly logs events that resemble the following example:

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

An RODC keeps itself up-to-date by replicating changes from one or more writable DCs. An RODC that's functioning as a DNS server uses [replicateSingleObject](/openspecs/windows_protocols/ms-adts/d3d19d15-8427-4d4d-8256-d5fb11333292) to make sure that it has the latest DNS information. In this scenario, the RODC tries to update a name server (NS) record.

To support this functionality, the RODC DNS server must be able to locate a writeable DC DNS server as needed. To do this, the RODC uses one of the `DsGetDC` functions (such as [DsGetDCNameA](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamea) or [DsGetDCNameW](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamew)) together with with the following flags:

- `DS_AVOID_SELF`
- `DS_TRY_NEXTCLOSEST_SITE`
- `DS_DIRECTORY_SERVICE_6_REQUIRED`
- `DS_WRITEABLE_REQUIRED`

The `DsGetDC` function returns a DC, which the RODC searches for the appropriate NS record. In either of the following cases, the RODC logs Event ID 4015.

- The identified DC isn't a DNS server, or doesn't list an appropriate NS record.
- The function didn't identify a writeable DC.

### Resolution

1. To check the results of the `DsGetDC` function, open a Windows Command Prompt window on the RODC. Run the following command:

   ```console
   nltest /dsgetdc: <DomainFQDN> /WRITABLE /AVOIDSELF /TRY_NEXT_CLOSEST_SITE /DS_6
   ```

   > [!NOTE]  
   > In this command, \<DomainFQDN> represents the fully qualified domain name (FQDN) for the domain.

1. If the command output lists a DC, check that DC's configuration. If the command didn't locate a DC, update your DNS topology to make sure that the RODC can connect to an appropriate DC. In both cases, make sure that the DC meets the following criteria:

   - The DC is writeable
   - The DC has the DNS Server role installed
   - The DNS records on the DC are correctly configured.

## DNS server logs Event ID 4015 (error code 0000051B)

One of the following conditions causes the access issue:

- The SYSTEM account isn't the owner of the DNS zone.
- The Users group for the domain doesn't have the correct members, including the Authenticated Users group. In this case, the issue might not appear until the DNS servers have been running for at least 10 hours, and it occurs sporadically on multiple DCs.

### The SYSTEM account isn't the owner of the DNS zone

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

### The Users group for the domain doesn't have the correct members

To resolve this issue, follow these steps:

1. Use an Admin group member account to sign in to the DC. You can also run this procedure on an admin computer when you add the `/domain` parameter.

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

1. On all of the DCs in the domain, restart the DNS Server service.

## DNS server logs Event ID 4015 (extended error code (ADMIN_LIMIT_EXCEEDED))

This issue occurs when the DNS Server service reaches the `dnsRecord` multi-valued attribute limit for the `dnsNode` object in Active Directory. In Active Directory integrated DNS zones, DNS names are represented by `dnsNode` objects, and DNS records are stored as values in `dnsRecord` attributes of `dnsNode` objects. DNS resource records (RRs) of demoted domain controllers won't be deleted automatically from `dnsRecord` attributes of `dnsNode` objects in the corresponding zone of the related Active Directory partition. For example:

```output
DC=..TrustAnchors,CN=MicrosoftDNS,DC=ForestDnsZones,DC=xxx,DC=xxx
```

When additional records are added to `dnsRecord` attributes of `dnsNode` objects, the orphaned entries of demoted domain controllers result in the ADMIN_LIMIT_EXCEEDED error.

To check the current number of records in each partition, run the following `repadmin` commands:

```console
repadmin /showattr . "CN=MicrosoftDNS,CN=System,DC=contoso,DC=com" /subtree /filter:"(objectclass=dnsnode)" /atts:"dnsRecord" /allvalues >c:\temp\dns_Domain.txt
repadmin /showattr . "CN=MicrosoftDNS,DC=DomainDnsZones,DC=contoso,DC=com" /subtree /filter:"(objectclass=dnsnode)" /atts:"dnsRecord" /allvalues>c:\temp\dns_DomainDnsZones.txt
repadmin /showattr . "CN=MicrosoftDNS,DC=ForestDnsZones,DC=contoso,DC=com" /subtree /filter:"(objectclass=dnsnode)" /atts:"dnsRecord" /allvalues >c:\temp\dns_ForestDnsZones.txt
```

The output displays the current number of entries in `dnsRecord` attributes of the corresponding Active Directory integrated zone. For example:

```output
DN: DC=@,DC=..TrustAnchors,CN=MicrosoftDNS,DC=ForestDnsZones,DC=contoso,DC=com
1280> dnsRecord: <48 byte blob>;
```

### Delete orphaned entries of denoted domain controllers

To resolve this issue, remove all orphaned entries of the denoted domain controllers from the zones. To check and selectively delete the entries, run the following Windows PowerShell cmdlets:

```powershell
Get-DnsServerResourceRecord -ZoneName trustanchors -RRType Ns
Remove-DnsServerResourceRecord -zonename trustanchors -RRType Ns -Name "@" -RecordData DC.contoso.com
```

If you need to delete multiple resource records (RRs) for a single host, run the following cmdlets:

```powershell
$AllNsRecords = Get-DnsServerResourceRecord -ZoneName "trustanchors" -RRType Ns
Foreach($Record in $AllNsRecords){
If($Record.recorddata.nameserver -like "*dc2*"){
$Record | Remove-DnsServerResourceRecord -ZoneName trustanchors
}
}
$AllSrvRecords = Get-DnsServerResourceRecord -ZoneName "_msdcs.contoso.com" -RRType Srv
Foreach($Record in $AllSrvRecords){
If($Record.recorddata.domainname -like "*dc2*"){
$Record | Remove-DnsServerResourceRecord -ZoneName _msdcs.contoso.com
}
}
```

### Enable debug logging with TroubleShootingScript (TSS)

To start traces on the DNS Server by using [TSS](https://aka.ms/getTSS), run the following cmdlet:

```powershell
.\TSS.ps1 -Scenario NET_DNSsrv -Mode Verbose -WaitEvent Evt:4015:'DNS Server'
```

> [!NOTE]
> The trace logging will stop automatically after Event ID 4015 is logged.

For more information, see [Gather key information before contacting Microsoft support](troubleshoot-dns-guidance.md#gather-key-information-before-contacting-microsoft-support).
