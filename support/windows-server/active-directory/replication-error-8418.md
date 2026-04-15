---
title: Troubleshooting replication error 8418--Schema mismatch
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
# Troubleshooting AD Replication error 8418: The replication operation failed because of a schema mismatch

> [!NOTE]
> **Home users:** This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com/en-us).

_Original KB number:_ &nbsp; 2734946

This article describes the symptoms, cause, and resolution for resolving Active Directory replication failing with Win32 error 8418: The replication operation failed because of a schema mismatch between the servers involved.


## Symptoms

You observe one or more of the following symptoms:

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

- You use one of the following RepAdmin commands (`repadmin.exe`), and you see messages that resemble the following examples:

  | Command | Message |
  | - | - |
  | `Repadmin /ShowReps` | `Last attempt @ YYYY-MM-DD HH:MM:SS failed, result 8418 (0x20e2):`<br/>`The replication operation failed because of a schema mismatch between the servers involved.` |
  | `Repadmin /SyncAll` | `repadmin /syncall /AePdq Syncing all NC's held on <DC Name>.`<br/>`Syncing partition: DC=contoso,DC=com SyncAll reported the following errors:`<br/>`Error issuing replication: 8418 (0x20e2):`<br/>`The replication operation failed because of a schema mismatch between the servers involved.` |
  | `Repadmin /ReplSum` | `repadmin /replsummary Replication Summary Start Time: YYYY-MM-DD HH:MM:SS`<br/>`Beginning data collection for replication summary, this may take a while:`<br/>`.....`<br/>`Source DSA largest delta fails/total %% error <Source DC> xxh:yym:zzs 4 / 5 80 (8418)`<br/>`The replication operation failed because of a schema mismatch between the servers involved.`<br/>`Destination DSA largest delta fails/total %% error <dest DC> 04h:02m:16s 4 / 5 80 (8418)`<br/>`The replication operation failed because of a schema mismatch between the servers involved.` |

## Cause

Replication of any Active Directory data between DCs in a forest depends on all DC's having a consistent view of the definitions of objects and attributes. These definitions are stored in the Schema partition of the Active Directory database. The directory replication engine prioritizes the Schema partition so that any change to a schema definition replicates before any data that uses the schema definition can replicate.

Schema mismatches can occur under the following circumstances:

- DCs replicate the schema partition, and the source DC has different schema information than the destination DC.
- DCs replicate a non-schema partition, and the data on the source DC uses a different schema than the data on the destination DC.

 In order to resolve a schema mismatch issue, you have to understand the scenario in which the issue occurred. Such scenarios include:

- The issue occurred after the Active Directory schema was updated. In many cases, this issue is transient and resolves itself.

  > [!IMPORTANT]  
  > Lab testing of schema modification is critical prior to implementing any proposed action plan into your production schema.

- The issue occurred when you tried to promote a member server to a domain controller (DC). The promotion operation failed.
- The issue occurred during normal replication. Typically, this means that an underlying issue is preventing Active Directory from resolving issues that would normally be transient. This scenario has multiple possible causes, including (but not limited to) the following issues:
  - A DC is quarantined, or might have lingering objects
  - Communication has stopped because of a DNS or RPC issue
  - A DC has stopped replicating for other reasons
  - Objects can't replicate because their `nTSecurityDescriptor` attributes are too large

A less common scenario is one in which the schema partition on one or more DCs has improper attribute definitions. Possible schema definition issues that can trigger mismatch include:  

- OID Clash
- Invalid OM Syntax values
- Invalid MayContain values
- Objects with attributes that contain data but the schema definition for the attribute type(s) has been marked as defunct

For issues where schema replication fails due to improper attribute schema definitions, please engage Microsoft Customer Service and Support to work through the issue.  

### Transient issues versus persistent issues

Schema mismatch issues typically fall into one of two categories: *Transient* or *persistent*.

Transient schema mismatch issues meet the following criteria:

- The error messages appear on different DCs throughout the forest, in a pattern that matches the Active Directory replication topology and schedule. This kind of pattern typically occurs when you install an update to the schema.
- On any particular DC, the issue disappears after one replication cycle per replication partner. Allow twice the amount of time needed for an object update to replicate from one DC to all other DCs in the forest. The more replication partners a DC has, the longer this process takes.

Persistent schema mismatch issues don't meet these criteria, and don't resolve themselves. Such issues indicate one or more of the following issues:

- There's an underlying issue that's interfering with normal replication. The replication service can't resolve the schema mismatch until the underlying issue is corrected. In some cases, you can identify and resolve the underlying issues. In other cases, you might need assistance from Microsoft Support. For example, any of the following issues can block replication.
  - Database corruption
  - Memory constraints
  - Replication quarantine
  - Strict replication consistency enforced
  - Disabled replication
  - DNS (Domain Name Resolution) issues
  - RPC communication issues
  - Local or network firewalls

## Collect diagnostic data to help isolate possible causes

### Level 1: Review the overall replication status

We recommend that you start your investigation by collecting replication data for all the DCs in the forest. Collecting this data helps identify any pockets of replication failure. To collect data and export it to a .csv file for analysis, run a command that resembles the following example at the command prompt:

```console
Repadmin showrepl * /csv > allrepl.csv
```

Review this data, identifying all the DCs that experience *any* replication issues.

If you recently applied a schema update to the forest, see [Resolution 1: Following a schema update, issues persist](#resolution-1-following-a-schema-update-issues-persist).

If you haven't recently updated the schema, continue on to collect diagnostic event logs.

### Level 2: Collect and review diagnostic logs

#### Increase the diagnostic logging level

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

Increase level of event logging on both source and destination DCs. To change the logging level, follow these steps:

1. in Registry Editor, go to the following subkey:

   `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Diagnostics`

1. Update the values of the registry entries as described in the following table:  

   |Name|Type|Value|
   |---|---|---|
   |`5 Replication`|DWORD|`5`|
   |`9 Internal Processing`|DWORD|`5`|
   |`24 Schema`|DWORD|`5`|
   |`7 Internal Configuration`|DWORD|`5`|

#### Review the errors and event logs for any replication issues

Wait for the issue to occur, or repeat the action that triggers the issue (for example, promote a member server to a domain controller). After the schema mismatch occurs, review the event logs on the affected DCs and their replication partners. Look for any information in the errors or events that identifies the source of the issue or what resource the issue affects.

- Look for the Event ID (if applicable) and the error code.
- Does the error or event refer to one or more computers? Replication errors typically list a source DC and a destination DC. For events, the destination DC typically logs the event. Look for the DN, NetBIOS name, or the directory service agent GUID (DSA GUID) for each DC.
- Does the error or event identify a particular object or attribute that triggers the issue? Look for the object DN or GUID, or the attribute display name or GUID.
- Look for any internal or extended error data.

The following table lists examples of error codes that indicate issues that prevent Active Directory from resolving a schema mismatch:

> [!NOTE]  
>
> - In addition to appearing in logged events, these error codes can occur when you use command-line tools such as `repadmin`, `dcdiag`, or `dcpromo`.
> - If you receive the schema mismatch error when you try to promote a member server to a DC, collect the DCpromo and DCpromoUI log files. This kind of issue is almost always persistent, and doesn't resolve itself.
> - Some events are associated with more than one error code. When you review your event log for these events, make sure you check the error code that's listed in the event so you can interpret the event correctly.

| Error code | Event ID and source, if appropriate | More information |
| - | - |
| | 1203 Microsoft-Windows-ActiveDirectory_DomainService or NTDS Replication | |
| 1340 | 1450 NTDS SDProp | [Inherited access ACL or ACE couldn't be built](#the-inherited-access-control-list-acl-or-access-control-entry-ace-could-not-be-built-event-1450-error-code-1340) |
| 1722 | | [Active Directory replication error 1722](replication-error-1722-rpc-server-unavailable.md) |
| 1753 | | [Active Directory Replication Error 1753](replication-error-1753.md) |
| 8614 | 1925 NTDS KCC<br/>2042 NDTS Replication | [Troubleshoot Active Directory replication error 8614](replication-error-8614.md)<br/>[Active Directory replication Event ID 2042](active-directory-replication-event-id-2042.md) |
| 8606 | 1988 NTDS Replication | [Active Directory Replication Error 8606](replication-error-8606.md) |
| 8456 or 8457 | 1308 NTDS KCC<br/>1393 NTDS General<br/>1586 NTDS Replication<br/>1925 NTDS KCC<br/>1926 NTDS KCC<br/>2023 NTDS Replication<br/>2095 Microsoft-Windows-ActiveDirectory_DomainService<br>2103 Microsoft-Windows-ActiveDirectory_DomainService or NTDS General | [Active Directory replication error 8456 or 8457](replication-error-8456-8457.md) |
| 8524 | 1308 NTDS KCC<br/>1655 NTDS General<br/>1865 NTDS KCC<br/>1925 NTDS KCC<br/>1926 NTDS KCC<br/>2023 Microsoft-Windows-ActiveDirectory_DomainService<br/>2087 NTDS Replication<br/>2088 NTDS Replication | [Active Directory Replication Error 8524](replication-error-8524.md) |

For additional common error codes, see [Troubleshoot common Active Directory replication errors](common-active-directory-replication-errors.md).

If you can isolate object or attribute identifiers from the error or event information, continue to the next section to collect object and attribute metadata.

If the replication events citing 8418 yielded any Extended or Internal errors use those values to try to match against known issues.

### Level 3: Export object metadata

If you can identify an object or attribute as the cause of the replication issue, dump the object's replication metadata. To retrieve this data, run `repadmin /showobjmeta` on both the source dC and the destination DC, as shown in the following examples:

If you have the DN of the object that caused the issue, open an administrative Command Prompt window, and then run the following command:

```console
Repadmin /showobjmeta <Target_DC> "<DN_of_Trigger_Object>"
```

If you have the GUID of the object or attribute that caused the issue, run the following command:

```console
`Repadmin /showobjmeta <Target_DC> "GUID=<ObjectGuid_of_Trigger_Object>"`
```

> [!NOTE]  
>
> - In these commands, \<Target_DC> represents the DC whose data you're retrieving (the source DC or the destination DC).
> - You can use <ObjectGuid_of_Trigger_Object> to represent the GUID of an object or of one of the object's attributes.
> - If the issue occurred when you promoted a member computer to a DC, the destination DC is the computer that you tried to promote. It might not yet have the object.

You can use this method to identify "candidate" attributes that might be causing the issue.

If you only have an identifier for an object, dump all the attribute values of the object by running a set of commands that resembles the following example:

```console
Ldifde -f results.txt -d "<DN_of Trigger_Object>" -s <Target_DC> 
Ldifde -f results.txt -d "GUID=<ObjectGuid_of Trigger_Object>" -s <Target_DC>
Repadmin /showattr <Target_DC> "<DN_of Trigger_Object>"
Repadmin /showattr <Target_DC> "GUID=<ObjectGuid_of Trigger_Object>"
```

## Resolution 1: Following a schema update, issues persist

After the Active Directory schema updates, schema mismatch issues typically appear and disappear on various DCs throughout the forest. This behavior typically occurs in a pattern that matches the replication topology and schedule. These transient schema mismatches are the expected behavior. Monitoring software typically reports the issues, but they don't require administrative intervention.

If schema mismatch issues persist for an extended period, such as more than twice the time needed for an update to replicate through the entire topology, then you should investigate the issue. A single DC might need to restart, the update might not have applied correctly, or an underlying issue might be blocking replication.

### Step 1: Verify that the schema version values in Active Directory and the registry match

Each DC stores the version of the schema that it uses in two locations; The registry, and in its local Active Directory replica. During normal operation, the two values should be in sync and should correctly reflect the schema version of the forest as defined by the DC that owns the schema Flexible Single Master Operation (FSMO) role. If the values don't match for a particular DC, that DC might not have received the schema update yet. Check the status values on DCs that report persistent schema mismatches, and on their replication partners.

> [!NOTE]  
> To make sure that `SchemaVersion` updates correctly, install only the updates of the Active Directory Schema that Microsoft provides.

To review the version number in the registry, in Registry Editor, go to the following subkey: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters\SystemSchemaVersion`

To view the version number in Active Directory, use one of the following methods:

- In ADSIEdit, connect to the Schema naming context for the affected forest, right-click the schema object (for example, `cn=Schema,cn=configuration,dc=contoso,dc=com`), and then select **Properties**. Look for the value of the `ObjectVersion` attribute.

- In a Command Prompt window on a DC, run a command that resembles the following example:

  ```console
  Ldifde -f schemaver.ldf -d Cn=Schema,cn=configuration,dc=contoso,dc=com -l ObjectVersion
  ```

- At the DC command prompt, run a command that resembles the following example:

  ```console
  dsquery * cn=schema,cn=configuration,dc=contoso,dc=com -scope base -attr objectVersion
  ```

For reference, the following table lists the schema versions for different versions of Windows Server.

|Operating system|Schema version|
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

### Step 2: Restart the source DC that's not replicating the update

You can use this step when the following conditions apply:

- The Active Directory schema was recently updated.
- You identify one or more DCs that report a persistent schema mismatch issue.
- These DCs use the same source DC for inbound replication.
- The source DC has the expected schema version information in the registry and in its Active Directory replica. This information matches the updated forest version (the source dC has the correct update installed).

Restart the source DC.

In some cases, a DC might not correctly reload the in-memory schema version after it receives the schema update. If this is the case, restarting the DC should resolve the issue.

If the issue persists, see [Data to provide to Microsoft Support](#data-to-provide-to-microsoft-support), and then contact Microsoft Support for assistance.

## Resolution 2: One or more objects or attributes trigger a persistent issue

Objects and attributes can trigger replication issues in several ways, and the causes for such issues might not appear to relate directly to the schema. One such potential issue is the size of an object's security descriptor (the `nTSecurityDescriptor` attribute). If the attribute gets too large, it can block replication. Fortunately, [error code 1340](#the-inherited-access-control-list-acl-or-access-control-entry-ace-could-not-be-built-event-1450-error-code-1340) specifically indicates that this issue has occurred.

Other object and attribute issues are more complex, and you might need to contact Microsoft Support for assistance. For guidance in troubleshooting these issues, see [Troubleshooting other object or attribute issues](#troubleshooting-other-object-or-attribute-issues).

### The inherited access control list (ACL) or access control entry (ACE) could not be built (Event 1450, error code 1340)

This error indicates that the identified object's security descriptor (the `nTSecurityDescriptor` attribute) is too large.

The security descriptor contains the object's ACL information, which includes ACEs that are set directly on the object and ACEs that are inherited from the parent object. Windows limits the attribute to 65,535 bytes.

To resolve this issue, you have to reduce the size of the object's security descriptor by reducing the number of ACEs. This process involves manually checking the security descriptor to identify the directly-applied ACEs and the inherited ACEs, and the sources of the inherited ACEs. If multiple objects trigger error code 1340, it's efficient to use a script to collect this information. For an example of such a script, see [Scripts to calculate the sizes of object security descriptors](../support-tools/scripts-calculate-size-object-security-descriptors.md).

### Troubleshooting other object or attribute issues

Review the replication metadata for correctness by ensuring that all the replicated attributes display a correctly formed attribute name

Example  

The two entries for replication metadata for a problem object as displayed by `Repadmin.exe` shows no `ldapdisplayname`:

```output
USN   DSA Org                              USN Org. Time/Date  Version Attribute  
24260 f4617e99-9688-42a6-8562-43fdd2d5cda4 18085395 <DateTime> 2  
24260 f4617e99-9688-42a6-8562-43fdd2d5cda4 18086114 <DateTime> 3
```

If any of the metadata fields has no associated name, try using `ldp.exe` to expose the internal `attributeid`.

The metadata for the same object above as displayed in LDP.exe shows the `AttributeID` associated with the data

```output
AttID  Ver Loc.USN Originating DSA                      Org.USN  Org.Time/Date  
250000 2   24260   f4617e99-9688-42a6-8562-43fdd2d5cda4 18085395 <DateTime>  
250004 3   24260   f4617e99-9688-42a6-8562-43fdd2d5cda4 18086114 <DateTime>  
```

The attribute ID can be used to help identify the problem attribute, but requires the engagement of Microsoft Support.

Version comparison - attributes to be replicated will have higher version numbers on the source.



If the attribute triggering failure cannot be identified by the event log data or replication metadata, then it will be necessary to engage Microsoft Product Support to assist with the investigation.

Schema Review  

Once a potential trigger attribute has been identified and other known causes eliminated then the next action is to review the schema definition for the attribute. This analysis is best performed with the assistance Microsoft Product Support.







["Schema mismatch" error message occurs when you try to run the Active Directory Installation Wizard (Dcpromo.exe)](schema-mismatch-error-ad-installation-wizard-dcpromo.md)
  Context: DCPromo fails
  Symptoms: event ID 1203 (Microsoft-Windows-ActiveDirectory_DomainService or NTDS Replication)





## Data to provide to Microsoft Support  

If you need assistance from Microsoft support, we recommend you collect information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

Additionally, gather the following information to help Microsoft Support staff to assist in diagnosing the causes of the schema mismatch (much of this information was gathered in earlier sections of this article).

- DCpromo logs from destination DC (if appropriate for the scenario)
- `Repadmin /showrepl` output from the source DC and the destination DC
- Directory Services event logs from the source and destination domain controller
- Replication metadata of any problem object that the errors or events identified
- Exported LDIFDE data of any problem object that the errors or events identified
- Exported schema partition LDIFDE data from both the source DC and the destination DC. To export this information to a file, run the following command at a command prompt:

  ```console
  Ldifde -f schema <Target_DC>.ldf -d cn=schema,cn=configuration,dc=<Domain>,dc=com -s <Target_DC>
  ```

  > [!NOTE]  
  > In this command, \<Target_DC> represents the name of the DC that holds the replica that you want to export, and \<Domain> is the name of the root domain to which the schema belongs.
