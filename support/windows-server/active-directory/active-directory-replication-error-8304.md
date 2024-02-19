---
title: Active Directory replication error 8304
description: Provides a resolution for troubleshooting AD Replication error 8304, which is The maximum size on an object has been exceeded.
ms.date: 04/28/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, arrenc, johnbay, herbertm, joflore, v-lianna
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Active Directory replication error 8304: "The maximum size on an object has been exceeded"

_Original KB number:_ &nbsp; 4533837  
_Applies to:_ &nbsp; Supported versions of Windows Server

## Summary

This article discusses the causes and solutions for the Active Directory replication error 8304 (0x2070): "The maximum size on an object has been exceeded".

> [!NOTE]
> You can get the friendly text of the error code by running the `net helpmsg 8304` command.

## Symptoms

You may experience one of the following symptoms.

### Symptom 1

The `dcdiag` command reports that the Active Directory replication test failed and generated error 8304: "The maximum size of an object has been exceeded."

```output
Starting test: Replications  
    [Replications Check, <DESTINATION DC>] A recent replication attempt failed:  
        From <SOURCE DC>to <DESTINATION DC>  
        Naming Context: <directory partition DN path>  
        The replication generated an error (8304):  
        The maximum size of an object has been exceeded.  
        The failure occurred at <date><time>.  
        The last success occurred at <date><time>.  
    ......................... <DESTINATION DC> failed test Replications
```

### Symptom 2

When you right-click a connection object from a source domain controller (DC), and then you select **Replicate now**, the replication is unsuccessful and generates the following error message:

> Replicate Now
>
> The following error occurred during the attempt to synchronize naming context \<active directory partition name> from domain controller \<source DC> to domain controller \<destination DC>:
>
> The maximum size of an object has been exceeded
>
> The operation will not continue

### Symptom 3

Various repadmin.exe commands fail and generate error 8304. These commands include, but are not limited to, the following:

- `repadmin /add`
- `repadmin /replsum`
- `repadmin /showrepl`
- `repadmin /showrepl`
- `repadmin /syncall`

### Symptom 4

Event ID 1084 is logged in the Directory Service event log of DCs that are trying to replicate Active Directory objects inbound.

```output
Log Name:      Directory Service  
Source:        Microsoft-Windows-ActiveDirectory_DomainService  
Event ID:      1084  
Task Category: Replication  
Level:         Error  
User:          ANONYMOUS LOGON  
Computer:      <Destination DC>  
Description:  
Internal event: Active Directory Domain Services could not update the following object with changes received from the following source directory service. This is because an error occurred during the application of the changes to Active Directory Domain Services on the directory service.  

Object:  
CN=john\0ADEL:<GUID>,CN=Deleted Objects,<directory partition DN path>  
Object GUID:  
<GUID>  
Source directory service:  
<GUID>._msdcs.contoso.com  

Synchronization of the directory service with the source directory service is blocked until this update problem is corrected.  

This operation will be tried again at the next scheduled replication.

User Action  
Restart the local computer if this condition appears to be related to low system resources (for example, low physical or virtual memory).  

Additional Data  
Error value:  
8304 The maximum size of an object has been exceeded.
```

You may also see an event 1093:

```output
Log Name:      Directory Service  
Source:        Microsoft-Windows-ActiveDirectory_DomainService  
Event ID:      1093  
Task Category: Replication  
Level:         Warning  
Computer:      <Destination DC>  
Description:  
Active Directory Domain Services could not update the following object with attribute changes because the incoming change caused the object to exceed the maximum object record size. The incoming change to the following attribute will be reversed in an attempt to complete the update.  

Object:
CN=<MachineName>\0ADEL:<GUID>,CN=Deleted  
Objects,DC=xxxx,DC=domainname,DC=com  

Object GUID:  
<GUID>  

Attribute:  
9030d (lastKnownParent)
The current value (without changes) of the attribute on the local directory partition will replicate to all other directory services. This will counteract the change to the rest of the directory services. The reversal values may be recognized as follows:  

Version:  
2  

Time of change:  
<DateTime>

Update sequence number:  
65064475  
Note this event may not quote the attribute that has the most data or values. It quotes the update for the attribute that made the object size overflow.
```

## Cause

Error 8304 is logged when the domain controller tries to replicate an object that exceeds the maximum size.

The most common cause is having a non-linked attribute with a big number of values. Because of the internal structure of the Active Directory database together with the Active Directory database record size of 8 KB, this limit of the values is about 1200-1300 values, depending on the population of other non-linked attributes.

On the source server, when you use a tool like LDP or run the `repadmin /showattr /allvalues /extended` command on the object, the output resembles the following:

```output
1> distinguishedName:<GUID=<GUID>>;CN=Allowedclients\0ADEL:<GUID>,CN=Deleted Objects,CN=Configuration,DC=contoso,DC=com

1> instanceType: 0x4 = ( WRITE )

1> whenCreated: 25.4.2018. 13:48:07Central European Daylight Time

…

1> msDS-LastKnownRDN: Allowed clients

1>msExchSmtpReceiveMaxRecipientsPerMessage: 200

1243> msExchSmtpReceiveRemoteIPRanges:10.142.241.142;…
```

The following are the attributes that you may encounter issue:

- proxyAddresses
- servicePrincipalName
- userCertificate
- msExchSmtpReceiveRemoteIPRanges
- dnsRecord
- msiFileList
- msTSProperty01, msTSProperty02, …
- registeredAddress

> [!NOTE]
> This issue may happen for any multi-valued non-linked attribute. Attribute with syntax linked or linked with data are not affected by this problem.

Depending on the available resources and actual local database page population, the limit may be hit at different number of values. This is why a certain change can be taken by some Domain Controller or LDS instances, but not on others.

This problem might also occur when a single attribute value exceeds approximately 5 MB. The AD database transaction must hold both the previous and the new value when the attribute value is updated.

## Resolution

This limit is independent of the Microsoft LDAP Server OS version. There is no workaround for this limitation. You need to potentially revise your application and how it uses this attribute.

The 1084 event will list the object that has exceeded the maximum size. If the object is an alive object, identify the attribute that has too many values and remove some of the values on the source domain controller.

If the object is a deleted object, and the Active Directory recycle bin is enabled, the best method to correct the issue is to force the object to become a recycled object. When the object is recycled, Active Directory removes most attributes. This typically reduces the size of the object enough so that it can be replicated successfully. This process will truly delete the object and make it unrecoverable from the recycle bin. If the object is a security principal such as a user account, we recommend that you do not undelete the object. If a sufficiently large object is undeleted, it may prevent some attributes from being correctly set. This can cause the object to be damaged and may prevent the object from being used or even deleted.

The following PowerShell command can be used to force the object into the recycled state.

> [!NOTE]
> The following command must be run on the DC listed in the 1084 event as the source domain controller. The event will also list the object distinguished name.

```powershell
Get-ADObject <dn of object> -IncludeDeletedObjects | Remove-ADObject
```

For example:

```powershell
Get-ADObject "CN=john\0ADEL:<GUID>,CN=Deleted Objects,dc=contoso,dc=com" | Remove-ADObject
```

After the object is recycled, use Active Directory Sites and Services to try to force replication.

## More information

Here are some suggestions to avoid the limit from past Microsoft issues.

### Use of dnsRecord attribute by Microsoft DNS Server

Each IP address or SRV name target is an additional value of the dnsRecord attribute. By default, each domain controller in Active Directory registers a series of names with DNS, some are based on the sites the domain controller covers, some are site-less. The limit is usually reached for site-less names.

When you approach a lot of domain controllers in a domain, like 1200 domain controllers, there may be issues updating the DNS objects for the names with the additional values. In such a domain, it is also often not desired to have this many entries for site-less names. To avoid this limit, you can create a registry value "DnsAvoidRegisterRecords" on the domain controllers that should not be present in site-less names.

### DFS Volume management in version 1 namespaces attribute PKT

DFS version 1 namespaces use a single AD object per namespace, and all the DFS link information is kept in a single attribute "PKT". There are problems with managing the namespace when this blob exceeds 5 MB (roughly 5000 links).

For more information, see [How DFS Works](/previous-versions/windows/it-pro/windows-server-2003/cc782417(v=ws.10)).

In Windows Server 2008, DFS introduces version 2 namespaces where each DFS link is a separate AD object.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
