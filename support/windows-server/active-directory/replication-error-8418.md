---
title: Troubleshooting replication error 8418
description: Helps troubleshoot Active Directory replication error 8418.
ms.date: 04/07/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:active directory\active directory replication and topology
- pcy:WinComm Directory Services
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Troubleshooting AD Replication error 8418: The replication operation failed because of a schema mismatch between the servers involved

> [!NOTE]
> **Home users:** This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com/en-us).

_Original KB number:_ &nbsp; 2734946

This article describes the symptoms, cause, and resolution for resolving Active Directory replication failing with Win32 error 8418: The replication operation failed because of a schema mismatch between the servers involved.


## Symptoms

- During a regular replication cycle, one or more on-screen errors, logged events, or diagnostics indicates that a schema mismatch occurred. The error text might include any or all of the following information:

  |Decimal|Hex|Symbolic|Error String|
  |---|---|---|---|
  |8418|`0x20e2`|`ERROR_DS_DRA_SCHEMA_MISMATCH`|The replication operation failed because of a schema mismatch between the servers involved.|

- When you try to promote a member server to a domain controller (DC), you receive the following message:

  ```output
  ---------------------------  
  Active Directory Domain Services Installation Wizard  
  ---------------------------  
  The operation failed because: Active Directory Domain Services could not replicate the directory partition <DN path of partition> from the remote
  Active Directory Domain Controller <helper DC FQDN>.  
  "The replication operation failed because of a schema mismatch between the servers involved."  
  ---------------------------  
  OK  
  ---------------------------
  ```

  If the error occurred before the DC promotion process reached the noncritical replication phase, the DCPromo.log file records entries that resemble the following example:

  ```output
  MM/DD/YYYY HH:MM:SS [INFO] NtdsInstall for <hostname.dns domain name.<top level domain> returned 8418  
  MM/DD/YYYY HH:MM:SS [INFO] DsRolepInstallDs returned 8418  
  MM/DD/YYYY HH:MM:SS [ERROR] Failed to install to Directory Service (8418)  
  MM/DD/YYYY HH:MM:SS [INFO] Starting service NETLOGON  
  ```

  If the error occurred during the noncritical replication phase, the new DC restarts. After the restart, DCPromo.log records entries that resemble the following examples:

  ```output
  MM/DD HH:MM:SS [WARNING] Non critical replication returned 8418
  MM/DD HH:MM:SS [INFO] Cleaning up old Netlogon information
  MM/DD HH:MM:SS [INFO] Stopped the DS
  MM/DD HH:MM:SS [INFO] The attempted domain controller operation has completed
  ```

- The directory service event log records one or more events that resemble the following examples:

  |Event source|Event ID or <br/>Event ID/Error status|Event string|
  |---|---|---|
  |Microsoft-Windows-ActiveDirectory_DomainService|1203|`The directory service could not replicate the following object from the source directory service at the following network address because of an Active Directory Domain Services schema mismatch.`|
  |Microsoft-Windows-ActiveDirectory_DomainService|1309/8418|`The Knowledge Consistency Checker (KCC) has detected that successive attempts to replicate with the following directory service has consistently failed.`|
  |Microsoft-Windows-ActiveDirectory_DomainService|1791/8418|`Replication of application directory partition <DN path> from source <NTDS Settings object GUID> from source DC (<source DC FQDN>) has been aborted. Replication requires consistent schema but last attempt to synchronize the schema had failed. It is crucial that schema replication functions properly. See previous errors for more diagnostics. If this issue persists, contact Microsoft Product Support Services for assistance. Error 8418: The replication operation failed because of a schema mismatch between the servers involved.`|
  |NTDS KCC (Knowledge Consistency Checker)|1925/8418|`The attempt to establish a replication link for the following writable directory partition failed.`|
  |NTDS Replication|1203|`The local domain controller could not replicate the following object from the source domain controller at the following network address because of an Active Directory schema mismatch`|
  |NTDS Replication|1791/8418|`Replication of Naming Context <DN path> from source <NTDS Settings object guid> has been aborted. Replication requires consistent schema but last attempt to sync the schema had failed. It is crucial that schema replication functions properly. See previous errors for more diagnostics. If this issue persists, contact Microsoft Product Support Services for assistance. Error 8418: The replication operation failed because of a schema mismatch between the servers involved.`|

- You manually trigger replication by using the **Replicate now** command in the Active Directory Sites and Services console. The operation fails, and generates an error message that resembles the following example:

  ```output
   --------------------------- Replicate Now ---------------------------
  The following error occurred during the attempt to synchronize naming context <Naming context> from Domain Controller <source DC> to Domain Controller <destination DC>: The replication operation failed because of a schema mismatch between the servers involved. This operation will not continue.
  --------------------------- OK ---------------------------
  ```

- When you use the RepAdmin tool (`repadmin.exe`), you see messages that resemble the following examples:

  | Command | Message |
  | - | - |
  | `Repadmin /ShowReps` | `Last attempt @ YYYY-MM-DD HH:MM:SS failed, result 8418 (0x20e2):`<br/>`The replication operation failed because of a schema mismatch between the servers involved.` |
  | `Repadmin /SyncAll` | `repadmin /syncall /AePdq Syncing all NC's held on <DC Name>.`<br/>`Syncing partition: DC=contoso,DC=com SyncAll reported the following errors:`<br/>`Error issuing replication: 8418 (0x20e2):`<br/>`The replication operation failed because of a schema mismatch between the servers involved.` |
  | `Repadmin /ReplSum` | `repadmin /replsummary Replication Summary Start Time: YYYY-MM-DD HH:MM:SS`<br/>`Beginning data collection for replication summary, this may take a while:`<br/>`.....`<br/>`Source DSA largest delta fails/total %% error <Source DC> xxh:yym:zzs 4 / 5 80 (8418)`<br/>`The replication operation failed because of a schema mismatch between the servers involved.`<br/>`Destination DSA largest delta fails/total %% error <dest DC> 04h:02m:16s 4 / 5 80 (8418)`<br/>`The replication operation failed because of a schema mismatch between the servers involved.` |

## Cause

Replication of any Active Directory data between DCs in a forest depends on all DC's having a consistent view of the definitions of objects and attributes. These definitions are stored in the Schema partition of the Active Directory database. The directory replication engine prioritizes the Schema partition so that any change to a schema definition replicates before any data that uses the schema definition can replicate.

**

Attempts to replicate AD when schema information is not consistent between the DC partners involved causes a "Schema Mismatch" error. This symptom manifests in a number of different ways. However, the underlying cause of the error varies.

There are also scenarios in which this error occurs, but there is not a mismatch in the schema information in the strictest sense. In these cases, Active Directory might not conform to the current schema definition for the relevant object or attribute whose value is being synchronized and applied at the destination DC.

> [!IMPORTANT]  
> Lab testing of schema modification is critical prior to implementing any proposed action plan into your production schema.

**



The duration of schema mismatch errors typically falls into one of two categories: Transient or persistent.

If the reports of schema mismatch errors match the following criteria, you can classify them as *transient* schema mismatch errors.

- The reports appear on different DCs throughout the forest, in a pattern that matches the AD replication topology and schedule. This kind of pattern typically occurs when you install an update to the schema.
- On any particular DC, the issue disappears after one replication cycle per replication partner. Allow twice the amount of time needed for an object update to replicate from one DC to all other DCs in the forest. The more replication partners a DC has, the longer this process takes.

Schema mismatch errors that don't meet these criteria and don't resolve themselves are *persistent* schema mismatch errors. Such errors indicate that there's an underlying issue that's interfering with normal replication. In some cases, you can identify and resolve the underlying issues. In other cases, you might need assistance from Microsoft Support.

**
For issues where schema replication fails due to improper attribute schema definitions, please engage Microsoft Customer Service and Support to work through the issue.  

## Resolution

Self
  
  Symptoms: 
    Event ID 1309, error 8418 (Microsoft-Windows-ActiveDirectory_DomainService)
    Event ID 1791, error 8418 (Microsoft-Windows-ActiveDirectory_DomainService or NTDS Replication)
    Event ID 1925, error 8418 (NTDS KCC)


In order to resolve an issue where schema mismatch is cited, it is critical to understand the scenario in which the is error is being raised as it may influence the data collected. The common scenarios are:  

- Recent schema update
- DC promotion
- Normal replication
- nTSecurityDescriptor size

### Schema update - Transient issues

Schema Update - after an administrative schema update is likely that a schema mismatch will occur on various DC's throughout the forest. This will typically happen in a pattern that matches the AD replication topology and schedule. This behavior is normal so long as the error state is transient*. This class of failure is most likely to be reported by monitoring software and requires no administrative intervention.


### DCPromo fails (Persistent issue)

["Schema mismatch" error message occurs when you try to run the Active Directory Installation Wizard (Dcpromo.exe)](schema-mismatch-error-ad-installation-wizard-dcpromo.md)
  Context: DCPromo fails
  Symptoms: event ID 1203 (Microsoft-Windows-ActiveDirectory_DomainService or NTDS Replication)



### Replication blocked by underlying issues

In some scenarios the schema mismatch error will persist indefinitely and intervention is required to investigate, identify the underlying trigger and resolve. 

Some scenarios present as known issues while in others the Schema Mismatch is purely a side effect of other blocking issues that prevent it from self-resolving through normal replication. The following error codes indicate issues that might prevent Active Directory from resolving a schema mismatch:

| Error code | Event ID and source, if appropriate |
| - | - |
| 1340 | 1450 NTDS SDProp |
| 1722 | |
| 1753 | |
| 8614 | 1925 NTDS KCC<br/>2042 NDTS Replication |
| 8606 | 1988 NTDS Replication |
| 8456 or 8457 | 1308 NTDS KCC<br/>1393 NTDS General<br/>1586 NTDS Replication<br/>1925 NTDS KCC<br/>1926 NTDS KCC<br/>2023 NTDS Replication<br/>2095 Microsoft-Windows-ActiveDirectory_DomainService<br>2103 Microsoft-Windows-ActiveDirectory_DomainService or NTDS General |
| 8524 | 1308 NTDS KCC<br/>1655 NTDS General<br/>1865 NTDS KCC<br/>1925 NTDS KCC<br/>1926 NTDS KCC<br/>2023 Microsoft-Windows-ActiveDirectory_DomainService<br/>2087 NTDS Replication<br/>2088 NTDS Replication |

> [!NOTE]  
>
> In addition to appearing in logged events, these error codes can occur when you use command-line tools such as `repadmin`, `dcdiag`, or `dcpromo`.
> Some events are associated with more than one error code. When you review your event log for these events, make sure you check the error code that's listed in the event so you can interpret the event correctly.


#### 1340

    NTDS SDPROP Event ID 1450, error 1340 The inherited access control list (ACL) or access control entry (ACE) could not be built.
    The security descriptor propagation task could not calculate a new security descriptor for the following object
    This problem occurs because the Security Descriptor on the problem object has exceeded the maximum size of 65,535 bytes. This is an operating system limitation.
  (related: [Active Directory replication error 8304: "The maximum size on an object has been exceeded"](active-directory-replication-error-8304.md))

#### 8614

[Troubleshoot Active Directory replication error 8614](replication-error-8614.md)
  Context: Replication quarantine (It has been too long since this machine replicated)
  Symptoms: DCDiag/ Repadmin: error 8614. NTDS KCC, NTDS General, or Microsoft-Windows-ActiveDirectory_DomainService events, including:
    NTDS KCC Event ID 1925
    NTDS Replication Event ID 2042 (also [Active Directory replication Event ID 2042: It has been too long since this machine replicated](active-directory-replication-event-id-2042.md))
    Active Directory Sites and Services

#### 8606

[Active Directory Replication Error 8606: Insufficient attributes were given to create an object](replication-error-8606.md)
  Context: DCDiag, Repadmin ADS&S 
  Symptoms: error message, event
    NTDS Replication Event ID 1988 (abandoned/lingering object): [Active Directory replication Event ID 1388 or 1988: A lingering object is detected](active-directory-replication-event-id-1388-1988.md)

#### 8456 or 8457

|[Active Directory replication error 8456 or 8457: The source / destination server is currently rejecting replication requests](replication-error-8456-8457.md)

  Events with this status code:
    NTDS KCC   1308
    NTDS General 1393 The hard disk is full
    NTDS KCC   1925
    NTDS KCC   1926
    NTDS Replication   1586
    NTDS Replication   2023
    Microsoft-Windows-ActiveDirectory_DomainService   2095
    Microsoft-Windows-ActiveDirectory_DomainService/NTDS General   2103 A USN rollback occurred

  Context: DCPromo, DCDiag, RepAdmin
  Symptoms error messages, events (multiple possible causes)
    Incoming or outgoing replication was automatically disabled by the operating system because of multiple root causes.

#### 8524

[Active Directory Replication Error 8524: The DSA operation is unable to proceed because of a DNS lookup failure](replication-error-8524.md)
  Context: DCDiag, RepAdmin, 
  Symptoms: Error messages, events

 

#### RPC:
  Context: RepAdmin, DCPromo, DCDiag tools
  [Active Directory replication error 1722: The RPC server is unavailable](replication-error-1722-rpc-server-unavailable.md)
  [Active Directory Replication Error 1753: There are no more endpoints available from the endpoint mapper](replication-error-1753.md)

Other codes: [Troubleshoot common Active Directory replication errors](common-active-directory-replication-errors.md)



### Initial Data Collection  

The aim of the initial data collection is to try to capture information sufficient to identify if a known issue is being experienced or if other issues are contributing to the failure.

Collecting replication data for all DC's in the forest is advised particularly in the case where a schema mismatch has been noted after a recent Schema Update or during normal replication monitoring. Collecting this data helps identify any pockets of replication failure on which to focus.

`Repadmin showrepl * /csv > allrepl.csv`

Once all the DCs experiencing replication failures, of ANY form, have been identified from the `repadmin /showrepl` data focus can move to specific DCs.

### Data: Recent schema update

As stated previously, in the case of a recent schema update it is common for some DCs to report the schema mismatch as a normal part of processing the update. This state should only be investigated if it persists for an extended period. 

### Data: Promoting a DC

Schema Mismatch during promotion of a DC is almost always a persistent issue that cannot be overcome without investigation and remedial steps being taken.

In the case where DCpromo fails with a schema mismatch the following data should be collected:

- DCpromo and DCpromoUI logs
- NTDS Diagnostic Event Logging on both the source and destination DC as described below in "Data Collection Phase 2"
- Ldifde Export of the Schema partition as described below in the "Schema Review"

### Verify the Schema Versions  

The current schema version can be read from two places on any given DC - the registry and in the Active Directory itself. In normal operation the two values should be in sync and should correctly reflect the Schema Version of the forest as defined by the schema FSMO.

Note: Only Microsoft provided updates of the Active Directory Schema will update the SchemaVersion number.

Reference Schema Version Values

|Operating System|Schema Version|
|---|---|
|Windows 2000|13|
|Windows Server 2003|30|
|Windows Server 2003 R2|31|
|Windows Server 2008|43|
|Windows Server 2008R2|47|
|Windows Server 2012|56|
|Windows Server 2012R2|69|
|Windows Server 2016|87|
|Windows Server 2019|88|
|Windows Server 2022|88|

In the Registry:

`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters\SystemSchemaVersion`

In Active Directory:

> Object: Cn=Schema,cn=configuration,dc=contoso,dc=com  
Attribute: ObjectVersion

You can use either of the following commands to export the schema version from Active Directory.

```console
Ldifde -f schemaver.ldf -d Cn=Schema,cn=configuration,dc=contoso,dc=com -l ObjectVersion
```

```console
dsquery * cn=schema,cn=configuration,dc=contoso,dc=com -scope base -attr objectVersion
```

### Possible Resolution 1 - recent update

In the scenario where the following conditions apply:

- The AD schema has been recently updated
- One or more partners of a DC is reporting a schema mismatch for an extended period
- The registry and AD schema versions on the source DC are in sync and match the expected forest-wide version

It's possible that a reboot of the source DC will resolve the replication failures. *The underlying cause is thought to be failure to correctly reload the in-memory version of schema after the schema update has been received.*

Data Collection Phase 2  

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

In the event that the previous resolution is not applicable or is unsuccessful, increase "NTDS Diagnostic" Event Logging on both Source AND Destination DCs under the following registry subkey

`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Diagnostics`

|Name|Type|Value|
|---|---|---|
|5 Replication|DWORD|5|
|9 Internal Processing|DWORD|5|
|24 Schema|DWORD|5|
|7 Internal Configuration|DWORD|5|
  
This will log additional information to the Directory Services event log that will assist in diagnosing the issue

Trigger the scenario that raises the Schema Mismatch err and review the event log data collected to try to identify:

- The object on which replication is failing either by its Distinguished Name or ObjectGUID

- The attribute being applied either by its ldapdisplayname or its internal ID
- Any internal or extended error data.

Event ID's of interest from the Directory Service Event log include:

- Replication Event 1173

- Replication Event 1791

- Replication Event 1203

The following example events show both an internal ID and extended error data

```output
Log Name: Directory Service  
Source: Microsoft-Windows-ActiveDirectory_DomainService  
Date: <DateTime>  
Event ID: 1173  
Task Category: Internal Processing  
Level: Warning  
Keywords: Classic  
User: ANONYMOUS LOGON  
Computer: `Dc12.Contoso.com`  
Description:  
Internal event: Active Directory Domain Services has encountered the following exception and associated parameters.  
Exception:  
e0010004  
Parameter: 0  
Additional Data  
Error value:  
8364  
Internal ID:  
2050078
```

The following example event identifies a specific object on which replication blocked.

```output
Log Name: Directory Service  
Source: Microsoft-Windows-ActiveDirectory_DomainService  
Date: <DateTime>  
Event ID: 1203  
Task Category: Replication  
Level: Warning  
Keywords: Classic  
User: ANONYMOUS LOGON  
Computer: `GB-JDT-DMV-N55.contoso.com`  
Description:  
The directory service could not replicate the following object from the source directory service at the following network address because of an Active Directory Domain Services schema mismatch.  
Object: CN=Machine,CN={54EFB8A2-33F1-4E04-B4AD-229ABA513555},CN=Policies,CN=System,DC=contoso,DC=com  
Network address: *\<GUID>*._msdcs.contoso.com  
Active Directory Domain Services will attempt to synchronize the schema before attempting to synchronize the following directory partition. Directory partition:  
DC=contoso,DC=comiption:  
The directory service could not replicate the following object from the source directory service at the following network address because of an Active Directory Domain Services schema mismatch. Object:  
CN=Machine,CN={54EFB8A2-33F1-4E04-B4AD-229ABA513555},CN=Policies,CN=System,DC=contoso,DC=com Network address:  
<GUID>._msdcs.contoso.com  
Active Directory Domain Services will attempt to synchronize the schema before attempting to synchronize the following directory partition. Directory partition: DC=contoso,DC=com
```

Review the data collected  

Look for correlating events including the ones noted above which point to known trigger scenarios.

Look for events that might indicate other underlying issues on the source or destination that might be blocking replication and so causing what might be a transient mismatch failure to persist.  

### nTSecurityDescriptor size

If the Size of the nTSecurityDescriptor is greater than 64KB, it can also generate this error.  You must manually check from the object reported in Event ID 1450 to see where ACEs have been applied from.  Below is sample code that you can use as en example of what you can write specifically for your organization.



Examples of other causes include but are not limited to:

- Database corruption
- Memory constraints
- Replication quarantine
- Strict replication consistency
- Disabled replication
- DNS (Domain Name Resolution) issues
- RPC communication issues
- Local or network firewalls

See [Causes](#cause) for details of events and related status codes for some of these issues.

### Supplementary Actions  

If the object triggering failure can be identified, then first use `repadmin /showobjmeta` to dump the object replication metadata and on both source and destination DC. This method can be used to identify "candidate" attributes that could be the cause of failure.

```console
Repadmin /showobjmeta Target_DC "<DN_of_Trigger_Object>"
```

If only the GUID of the object is known use the syntax:

`Repadmin /showobjmeta Target_DC "<GUID=ObjectGuid_of_Trigger_Object>"`

Review the replication metadata for correctness by ensuring that all the replicated attributes display a correctly formed attribute name

Example  

The two entries for replication metadata for a problem object as displayed by `Repadmin.exe` shows no `ldapdisplayname`:

```output
USN DSA Org USN Org. Time/Date Version Attribute  
24260 f4617e99-9688-42a6-8562-43fdd2d5cda4 18085395 <DateTime> 2  
24260 f4617e99-9688-42a6-8562-43fdd2d5cda4 18086114 <DateTime> 3
```

If any of the metadata fields has no associated name, try using ldp.exe  to expose the internal `attributeid`.

The metadata for the same object above as displayed in LDP.exe shows the `AttributeID` associated with the data

```output
AttID Ver Loc.USN Originating DSA Org.USN Org.Time/Date  
250000 2 24260  f4617e99-9688-42a6-8562-43fdd2d5cda4 18085395 <DateTime>  
250004 3 24260  f4617e99-9688-42a6-8562-43fdd2d5cda4 18086114 <DateTime>  
```

The attribute ID can be used to help identify the problem attribute, but requires the engagement of Microsoft Support.

Version comparison - attributes to be replicated will have higher version numbers on the source.

> [!NOTE]
> In the DCpromo scenario, the destination object will most likely not yet exist.

If ONLY the object can be identified from the event data, dump the attribute values of the trigger object.

```console
Ldifde -f results.txt> -d "DN_of Trigger_Object" -s Target_DC Ldifde -f \<results.txt> -d "<GUID=ObjectGuid_of Trigger_Object>" -s Target_DC Repadmin /showattr Target_DC "DN_of Trigger_Object" Repadmin /showattr Target_DC "DN_of Trigger_Object"
```

If the replication events citing 8418 yielded any Extended or Internal errors use those values to try to match against known issues.

If the attribute triggering failure cannot be identified by the event log data or replication metadata, then it will be necessary to engage Microsoft Product Support to assist with the investigation.

Schema Review  

Once a potential trigger attribute has been identified and other known causes eliminated then the next action is to review the schema definition for the attribute. This analysis is best performed with the assistance Microsoft Product Support.

Export of entire schema partition from both source and destination domain controllers:

```console
Ldifde -f schema _TargetDC.ldf -d cn=schema,cn=configuration,dc=contoso,dc=com -s Target_DC
```

## Data to provide to Microsoft Support  

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

Be prepared to provide the following information to Microsoft Support staff to assist in diagnosing the causes of the schema mismatch  

- Export of schema partition from the source domain controller
- DCpromo logs from destination DC (if appropriate for the scenario)
- `Repadmin /showrepl` output from the source and destination domain controller
- Directory Services Event logs with extended logging from the source and destination domain controller
- Replication metadata of any problem object identified from the event logs
- LDIFDE Export of any problem object identified from the event logs

## More information

Possible schema definition issues that can trigger mismatch include:  

- OID Clash
- Invalid OM Syntax values
- Invalid MayContain values
- Objects with attributes that contain data but the schema definition for the attribute type(s) has been marked as defunct
