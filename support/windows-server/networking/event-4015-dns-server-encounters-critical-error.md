---
title: Event ID 4015 is logged and the DNS server encounters a critical error
description: Helps to resolve the issue in which Event ID 4015 is logged and the Domain Name Service (DNS) server encounters a critical error.
ms.date: 45286
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-lianna
ms.custom: sap:dns, csstroubleshoot
---
# Event ID 4015 is logged and the DNS server encounters a critical error

This article helps to resolve the issue in which Event ID 4015 is logged and the Domain Name Service (DNS) server encounters a critical error.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 969488, 2733147

You receive Event ID 4015 in one of the following scenarios:

- If you're running the DNS role on a Read-Only Domain Controller (RODC) and a writable Domain Controller (hosting DNS) isn't accessible, the following event is logged on the RODC.

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

- The DNS server can't access the Active Directory object, and the following event is logged frequently in the DNS server's event log.

    ```output
    Type: Error
    Source: DNS
    Category: None
    Event ID: 4015
    Description:
    The DNS server has encountered a critical error from the Active Directory. Check that the Active Directory is functioning properly. The extended error debug information (which may be empty) is "0000051B: AttrErr: DSID-xxxx, #1: 0:0000051B: DSID-xxxx, problem 1005 (CONSTRAINT_ATT_TYPE), data 0, Att 20119(nTSecurityDescriptor)". The eventdata contains the error."
    ```

- In a forest or domain located in Active Directory integrated Domain Name System (DNS) zones, some domain controllers that have the DNS Server role installed have been promoted and demoted. Some promoted domain controllers can't register the SRV, Host A, Pointer (PTR), or Name Server (NS) in the Active Directory integrated DNS zones, and the following event is logged:

    ```ouput
    The DNS server has encountered a critical error from the Active Directory. Check that the Active Directory is functioning properly. The extended error debug information (which may be empty) is "00002024: SvcErr: DSID-02050BBD, problem 5008 (ADMIN_LIMIT_EXCEEDED), data -1026". The event data contains the error.
    ```

## RODC logs DNS Event ID 4015 every three minutes with error code 00002095

When an RODC locates a writeable DNS server to perform ReplicateSingleObject (RSO), it performs a DSGETDC function with the following flags set:

- `DS_AVOID_SELF`
- `DS_TRY_NEXTCLOSEST_SITE`
- `DS_DIRECTORY_SERVICE_6_REQUIRED`
- `DS_WRITEABLE_REQUIRED`

Once a DC is returned from the DSGETDC call, it uses the result to search for the NS record in DNS. If the DSGETDC call fails or it fails to find the NS record of the DC returned from DSGETDC, Event ID 4015 will be logged.

Possible causes of Event ID 4015:

- No writeable DC is accessible, or none returned from the DSGETDC call.
- The DSGETDC call was successful, but the DC returned doesn't have the DNS Server Role installed or doesn't register an NS record in DNS.

The following command can be run from the RODC to check which DC is returned from the DSGETDC call:

```console
nltest /dsgetdc: DOMAIN.COM /WRITABLE /AVOIDSELF /TRY_NEXT_CLOSEST_SITE /DS_6
```

Where `DOMAIN.COM` is your domain name.

For more information about the DSGETDC function, see [DsGetDcNameA function](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamea).

To resolve either of the causes above, ensure that a writable DC is accessible from the RODC, that the DNS Server Role is installed on that DC, and that the NS record is registered in DNS for the writable DC.

## Event ID 4015 is logged with error code 0000051B

This issue occurs because of permissions issues. SYSTEM isn't the owner of the DNS zone. You can [enable the Field Engineering diagnostic logging](../identity/configure-ad-and-lds-event-logging.md#enable-field-engineering-diagnostic-event-logging) to identify the DNS zone and change the owner.

### Set DNS zone owner to SYSTEM

To resolve this issue, follow these steps:

1. When you see the DNS error in the DNS server event logs again after the logging is enabled, stop the AD diagnostic field engineering logging by setting the following registry value to *0*:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics\15 Field Engineering`
2. Correlate the exact time of Event ID 4015 to the Directory Service Event ID 1644, and identify the DNS application directory partition.
3. Open the ADSI Edit (*Adsiedit.msc*) tool, and go to the LDAP location of the object identified in Event ID 1644, which correlates to Event ID 4015.
4. Right-click the zone, go to **Properties** > **Security** > **Advanced**, and make sure the **Owner** is set to **SYSTEM**.

## Event ID 4015 is logged with an extended error code (ADMIN_LIMIT_EXCEEDED)

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
Remove-DnsServerResourceRecord -zonename trustanchors -RRType Ns -Name “@” -RecordData DC.contoso.com
```

If you need to delete multiple resource records (RRs) for a single host, run the following cmdlets:

```powershell
$AllNsRecords = Get-DnsServerResourceRecord -ZoneName “trustanchors” -RRType Ns
Foreach($Record in $AllNsRecords){
If($Record.recorddata.nameserver -like "*dc2*"){
$Record | Remove-DnsServerResourceRecord -ZoneName trustanchors
}
}
$AllSrvRecords = Get-DnsServerResourceRecord -ZoneName “_msdcs.contoso.com” -RRType Srv
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
