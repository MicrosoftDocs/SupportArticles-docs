---
title: DCPROMO demotion fails
description: Solves an issue where the demotion of a Windows Server computer hosting the Active Directory Domain Services (AD DS) or domain controller server role fails.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Active Directory\DCPromo and the installation or removal of domain controllers, csstroubleshoot
---
# DCPROMO demotion fails if it's unable to contact the DNS infrastructure master

This article solves an issue where the demotion of a Windows Server computer that hosts the Active Directory Domain Services (AD DS) or domain controller server role fails.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2694933

## Symptoms

The graceful demotion of a Windows Server computer hosting the AD DS or domain controller server role fails. You see the following on-screen error:

> Title bar text: Active Directory Domain Services Installation Wizard  
> Message Text:  
> The operation failed because:  
> Active Directory Domain Services could not transfer the remaining data in directory partition  
> DC=DomainDNSZones,DC=\<DNS domjain name> to Active Directory Domain Controller  
> \\\\\<DNS name of helper DC used to service demotion>  
> "The directory service is missing mandatory configuration information, and is unable to determine the ownership of floating single-master operation roles."

The relevant part of the DCPROMO.LOG file contains the following text:

```output
<date> <time> [INFO] Transferring operations master roles owned by this Active Directory Domain Controller in directory partition  
DC=DomainDnsZones,DC=contoso,DC=com to Active Directory Domain Controller \\<DNS name of helper DC...  
<date> <time>  [INFO] EVENTLOG (Warning): NTDS Replication / Replication : 2091
```

A review of the infrastructure object and attributes for the DNS application partition referenced in the on-screen DCPROMO error and DCPROMO.LOG:

```output
Expanding base 'CN=Infrastructure,DC=DomainDnsZones,DC=contoso,DC=com'...  
Getting 1 entries:  
Dn: CN=Infrastructure,DC=DomainDnsZones,DC=contoso,DC=com  
cn: Infrastructure;  
distinguishedName: CN=Infrastructure,DC=DomainDnsZones,DC=contoso,DC=corp,DC=microsoft,DC=com;  
dSCorePropagationData: 0x0 = (  );  
fSMORoleOwner: CN=NTDS Settings\0ADEL:<NTDS Settings objet GUID>,CN=\<hostname of last DC to host the partition infrastructure role>,CN=Servers,CN=<active directory site name>,CN=Sites,CN=Configuration,DC=contoso,DC=com;  
instanceType: 0x4 = ( WRITE );  
isCriticalSystemObject: TRUE;  
name: Infrastructure;  
objectCategory: CN=Infrastructure-Update,CN=Schema,CN=Configuration,DC=contoso,DC=com;  
objectClass (2): top; infrastructureUpdate;  
objectGUID: <object guid>;  
showInAdvancedViewOnly: TRUE;  
systemFlags: 0x8C000000 = ( DISALLOW_DELETE | DOMAIN_DISALLOW_RENAME | DOMAIN_DISALLOW_MOVE );  
uSNChanged: <some USN #>;  
uSNCreated: <some USN #>;  
whenChanged: <date> <time>;  
whenCreated: <date> <time>;  
```

Where distinguishing elements in the LDAP output taken from the sample domain `CONTOSO.COM` include:

1. The `fSMORoleOwner` attribute contains the string 0ADEL indicating that the role owning DC's NTDS Settings object has been deleted.

2. The `fSMORoleOwner` attribute contains a 32-character alpha-numeric GUID of the owning DCs NTDS Settings object in the format of xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.

3. The name of the default DNS application partition for which the `fSMORoleOwner` attribute is assigned to a DC with a deleted NTDS Settings object. In this case, the error referenced the DomainDNSZones. This same error may also occur for the ForestDNSZones application partition.

## Cause

The error occurs when the domain controller that's being demoted can't outbound replicate changes to the DC that owns the infrastructure FSMO or operational role for the partition referenced in the DCPROMO [log] error.

Specifically, the demotion attempt is aborted to safeguard against data loss. In the case of DNS application partitions, the demotion is blocked to ensure that the following data is replicated:

- live and deleted DNS records
- ACLS of the DNS records
- metadata, such as registration and deletion dates

DN paths for partitions where the error in the [Symptoms](#symptoms) section may occur include:

- CN=Infrastructures,DC=DomainDNSZones....
- CN=Infrastructures,DC=ForestDNSZones....

## Resolution

> [!NOTE]
> When the infrastructure master is assigned to a deleted NTDSA on a DNS application partition, like DomainDNSZones, it may also be missing for ForestDNSZones partition or vice versa. We recommend that you verify that the for both the DomainDNSZones and ForestDNSZones partitions assigned to live Windows Server 2003 or later domain controllers hosting the DNS Server role and partition in question.

To resolve this issue, use one of the following methods:

1. Use `ADSIEDIT.MSC` to assign the DN path for the `fsMORoleOwner` attribute to a live DC that was a direct replication partner of the original FSMO role owner. Then wait for that change to inbound-replicate to the DC that's being demoted.

2. Run the script in the **Resolution** section of [KB949257](https://support.microsoft.com/help/949257) for the partition in question.

3. If the DC that's being demoted can't inbound-replicate changes for the directory partition in question, run the `DCPROMO /FORCEREMOVAL` command to forcefully demote the domain controller.

## More information

DCPromo attempts to outbound-replicate changes on every locally held NC so that unique changes aren't lost. If data is stored in DNS zones, DCPROMO attempts to outbound replicate the contents of DNS zones to the infrastructure master for the DNS partition in question.

Related problem:

[KB949257](https://support.microsoft.com/kb/949257) describes a problem where the `ADPREP /RODCPREP` command fails when infrastructure master for one or more DNS application partitions is assigned to a deleted NTDSA.
