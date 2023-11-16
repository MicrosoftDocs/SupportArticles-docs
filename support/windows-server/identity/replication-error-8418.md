---
title: Troubleshooting replication error 8418
description: Helps troubleshoot Active Directory replication error 8418.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
ms.technology: windows-server-active-directory
---
# Troubleshooting AD Replication error 8418: The replication operation failed because of a schema mismatch between the servers involved

This article describes the symptoms, cause, and resolution for resolving Active Directory replication failing with Win32 error 8418.

> [!NOTE]
> **Home users:** This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com/en-us).

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2734946

## Symptoms

This article describes the symptoms, cause, and resolution for resolving Active Directory replication failing with Win32 error 8418: The replication operation failed because of a schema mismatch between the servers involved.

This article is part of a series on troubleshooting AD replication errors and events documented on Technet. To find this and related articles, use your favorite Internet search engine to query on:
Troubleshooting AD replication error \<error number>: \<error string> site:support.microsoft.com

For example:
Troubleshooting AD replication error 5: Access is denied site:support.microsoft.com  

Replication of any Active Directory data between domain controllers in a forest relies on all DC's having a consistent view of the definitions of objects and attributes. These definitions are stored in the Schema partition of the Active Directory database. The directory replication engine prioritizes replication of data this in this partition above all others - when any change to a schema definition is detected between partners it must be replicated before data in other partitions can be synchronized.

1. One or more on-screen errors, logged events or diagnostic output identifies the existence of a schema mismatch.

    Possible formats for that error include:  

    |Decimal|Hex|Symbolic|Error String|
    |---|---|---|---|
    |8418|0x20e2|ERROR_DS_DRA_SCHEMA_MISMATCH|The replication operation failed because of a schema mismatch between the servers involved.|

2. DCPromo Promotion

    On-Screen error  

    > \---------------------------  
    > Active Directory Domain Services Installation Wizard  
    > \---------------------------  
    > The operation failed because: Active Directory Domain Services could not replicate the directory partition \<DN path of partition> from the remote
    > Active Directory Domain Controller \<helper DC FQDN>.  
    "The replication operation failed because of a schema mismatch between the servers involved."  
    > \---------------------------  
    > OK  
    > \---------------------------

    DCPROMO.LOG where error is encountered prior to non-critical replication phase:  

    >MM/DD/YYYY HH:MM:SS [INFO] NtdsInstall for <hostname.dns domain name.\<top level domain> returned 8418  
    MM/DD/YYYY HH:MM:SS [INFO] DsRolepInstallDs returned 8418  
    MM/DD/YYYY HH:MM:SS [ERROR] Failed to install to Directory Service (8418)  
    MM/DD/YYYY HH:MM:SS [INFO] Starting service NETLOGON  

    If the error is encountered during the non-critical replication phase of DCPROMO, the replica DC reboots and logs the following in the DCPROMO.LOG file.

    > MM/DD HH:MM:SS [WARNING] Non critical replication returned 8418 MM/DD HH:MM:SS [INFO] Cleaning up old Netlogon information MM/DD HH:MM:SS [INFO] Stopped the DS MM/DD HH:MM:SS [INFO] The attempted domain controller operation has completed

3. The following events may be logged in the Directory Service Event Log

    |Event Source|Event ID|Event String|
    |---|---|---|
    |Microsoft-Windows-ActiveDirectory_DomainService|1203|The directory service could not replicate the following object from the source directory service at the following network address because of an Active Directory Domain Services schema mismatch.|
    |Microsoft-Windows-ActiveDirectory_DomainService|1309 with error status 8418|The Knowledge Consistency Checker (KCC) has detected that successive attempts to replicate with the following directory service has consistently failed.|
    |Microsoft-Windows-ActiveDirectory_DomainService|1791 with error status 8418|Replication of application directory partition \<DN path> from source \<NTDS Settings object GUID> from source DC (\<source DC FQDN>) has been aborted. Replication requires consistent schema but last attempt to synchronize the schema had failed. It is crucial that schema replication functions properly. See previous errors for more diagnostics. If this issue persists, contact Microsoft Product Support Services for assistance. Error 8418: The replication operation failed because of a schema mismatch between the servers involved.|
    |NTDS KCC|1925 with error status 8418|The attempt to establish a replication link for the following writable directory partition failed.|
    |NTDS Replication|1203|The local domain controller could not replicate the following object from the source domain controller at the following network address because of an Active Directory schema mismatch|
    |NTDS Replication|1791 with error status 8418|Replication of Naming Context \<DN path> from source \<NTDS Settings object guid> has been aborted. Replication requires consistent schema but last attempt to sync the schema had failed. It is crucial that schema replication functions properly. See previous errors for more diagnostics. If this issue persists, contact Microsoft Product Support Services for assistance. Error 8418: The replication operation failed because of a schema mismatch between the servers involved.|

4. Active Directory Sites and Services fail with the following error:

    > \--------------------------- Replicate Now --------------------------- The following error occurred during the attempt to synchronize naming context \<Naming context> from Domain Controller \<source DC> to Domain Controller \<destination DC>: The replication operation failed because of a schema mismatch between the servers involved. This operation will not continue. --------------------------- OK ---------------------------

5. `REPADMIN.EXE` shows the following errors:

    `REPADMIN /SHOWREPS`

    > Last attempt @ YYYY-MM-DD HH:MM:SS failed, result 8418 (0x20e2): The replication operation failed because of a schema mismatch between the servers involved.

    `REPADMIN /SYNCALL`

    > repadmin /syncall /AePdq Syncing all NC's held on \<DC Name>. Syncing partition: DC=contoso,DC=com SyncAll reported the following errors: Error issuing replication: 8418 (0x20e2): The replication operation failed because of a schema mismatch between the servers involved.

    `REPADMIN /REPLSUM`

    > repadmin /replsummary Replication Summary Start Time: YYYY-MM-DD HH:MM:SS Beginning data collection for replication summary, this may take a while: ..... Source DSA largest delta fails/total %% error \<Source DC> xxh:yym:zzs 4 / 5 80 (8418) The replication operation failed because of a schema mismatch between the servers involved. Destination DSA largest delta fails/total %% error \<dest DC> 04h:02m:16s 4 / 5 80 (8418) The replication operation failed because of a schema mismatch between the servers involved.

## Cause

Attempts to replicate AD when schema information is not consistent between the DC partners involved will result in a "Schema Mismatch" error status. This symptom can be manifested in a number of different ways as outlined above. However the underlying cause of the error being raised can vary.

There are also scenarios where this error will be raised but there is not a mismatch in the schema information in the strictest sense. In these cases, it may be that the Active Directory data being replicated does not conform to the current schema definition for the relevant object or attribute whose value is being synchronized and applied at the destination DC.

The duration of schema mismatch errors typically fall into one of two categories, transient or persistent. Within the persistent category, there are some failures that can be investigated AND resolved safely.

For issues where schema replication fails due to improper attribute schema definitions please engage Microsoft Customer Service and Support to work through the issue.  

Note: Lab testing of schema modification is critical prior to implementing any proposed action plan into your production schema.

Schema Update - after an administrative schema update is likely that a schema mismatch will occur on various DC's throughout the forest. This will typically happen in a pattern that matches the AD replication topology and schedule. This behavior is normal so long as the error state is transient*. This class of failure is most likely to be

reported by monitoring software and requires no administrative intervention.

The duration for which schema mismatch may be logged by a given destination DC should last no more than one replication cycle for any given partner. DC's with only one partner should only see the error once while bridge head dc's may see the error multiple times, once for each partner.

A reasonable estimate of the acceptable time limit transient failure is forest convergence period* x 1.5.

*The largest amount of time taken for an object update to replicate from one DC to all other DCs in the forest.

Transient Symptom Triggers  

Schema Update - after an administrative schema update is likely that a schema mismatch will occur on various DC's throughout the forest. This will typically happen in a pattern that matches the AD replication topology and schedule. This behavior is normal so long as the error state is transient*. This class of failure is most likely to be reported by monitoring software and requires no administrative intervention.

The duration for which schema mismatch may be logged by a given destination DC should last no more than one replication cycle for any given partner. DC's with only one partner should only see the error once while bridge head dc's may see the error multiple times, once for each partner.

*A reasonable estimate of the acceptable time limit transient failure is twice the amount of time taken for an object update to replicate from one DC to all other DCs in the forest.

Persistent Symptom Triggers  

In some scenarios the schema mismatch error will persist indefinitely and intervention is required to investigate, identify the underlying trigger and resolve. Some scenarios present as known issues while in other the Schema Mismatch is purely a side effect of other blocking issues that prevent it from self-resolving through normal replication.

Known Issues  

|KB Article No.|Title|Key Data|
|---|---|---|
|982438|You cannot install AD DS in Windows Server 2008 in a Windows Server 2003-based domain if another computer that is in the same domain has MSCS installed|Event ID 1791|
|947020|Event IDs 1481, 1173, and 1203 are logged in the Directory Services log on a Windows Server 2003-based domain controller|Event ID 1481 Error 2083; DSID 31510B7<br/><br/>Event ID 1173 Param 2083 DSID 31010B7<br/><br/>Event ID 1203 "Schema Mismatch"|
|824873|Event 1791 is logged when information is replicated from Windows 2000 to Windows Server 2003|Event ID 1791 Error 8418<br/><br/>Event ID 1481 DSID 3151030|
|2001769|Error While Propagating Permissions: "Unable to save permission ...|Event ID 1450 DSID 3150dbe|
  
Other Blocking Issues  

|Topic|KB|Key Data|
|---|---|---|
|Replication Quarantine|[2020053](https://support.microsoft.com/help/2020053)|Event ID 2042<br/><br/>Error status 8614|
|Replication failure caused by Lingering objects when Strict Replication Consistency is enabled|[2028495](https://support.microsoft.com/help/2028495)|Event ID 1988 with status 8606|
|Replication Topology|||
|Disabled Replication<br/><br/>|[2028495](https://support.microsoft.com/help/2028495)<br/><br/>|Status 8457|
|DNS (Name Resolution)|[2021446](https://support.microsoft.com/help/2021446)|Event ID 2023 with Status code 8524|
|RPC|1722:<br/><br/> [2102154](https://support.microsoft.com/help/2102154) <br/><br/>1753:<br/><br/>[2089874](https://support.microsoft.com/help/2089874)|Status Code 1722<br/><br/>Status Code 1753|
  
## Resolution

In order to resolve an issue where schema mismatch is cited, it is critical to understand the scenario in which the is error is being raised as it may influence the data collected. The common scenarios are:  

- Recent Schema Update
- DC Promotion
- Normal Replication

As stated previously, in the case of a recent schema update it is common for some DC's to report the schema mismatch as a normal part of processing the update. This state should only be investigated if it persists for an extended period Schema Mismatch during promotion of a DC is almost always a persistent issue that cannot be overcome without investigation and remedial steps being taken.

Initial Data Collection  

The aim of the initial data collection is to try to capture information sufficient to identify if a known issue is being experienced or if other issues are contributing to the failure.

Collecting replication data for all DC's in the forest is advised particularly in the case where a schema mismatch has been noted after a recent Schema Update or during normal replication monitoring. Collecting this data helps identify any pockets of replication failure on which to focus.

`Repadmin showrepl * /csv > allrepl.csv`

Once all the DC's experiencing replication failures, of ANY form, have been identified from the `repadmin /showrepl` data focus cam move to specific DC's.

In the case where DCpromo fails with a schema mismatch the following data should be collected:

- DCpromo and DCpromoUI logs
- NTDS Diagnostic Event Logging on both the source and destination DC as described below in "Data Collection Phase 2"
- Ldifde Export of the Schema partition as described below in the "Schema Review"

Verify the Schema Versions  

The current schema version can be read from two places on any given DC - the registry and in the Active Directory itself. In normal operation the two values should be in sync and should correctly reflect the Schema Version of the forest as defined by the schema  FSMO.

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
  
In the Registry:

`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters\SystemSchemaVersion`

In Active Directory:

> Object: Cn=Schema,cn=configuration,dc=contoso,dc=com  
Attribute: ObjectVersion

The schema version in AD can be exported using one of the following commands

`Ldifde -f schemaver.ldf -d Cn=Schema,cn=configuration,dc=contoso,dc=com -l ObjectVersion  
dsquery * cn=schema,cn=configuration,dc=contoso,dc=com -scope base -attr objectVersion`

Possible Resolution 1  

In the scenario where the following conditions apply:

The AD schema has been recently updated

One or more partners of a DC is reporting a schema mismatch for an extended period

The registry and AD schema versions on the source DC are in sync and match the expected forest-wide version

It's possible that a reboot of the source DC will resolve the replication failures. The underlying cause is thought to be failure to correctly reload the in memory version of schema after the schema update has been received.

Data Collection Phase 2  

In the event that the resolution above is not applicable or is unsuccessful increase "NTDS Diagnostic" Event Logging on both Source AND Destination DCs under the following registry key

`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Diagnostics`

|Name|Type|Value|
|---|---|---|
|5 Replication|DWORD|5|
|9 Internal Processing|DWORD|5|
|24 Schema|DWORD|5|
|7 Internal Configuration|DWORD|5|
  
This will log additional information to the Directory Services event log that will assist in diagnosing the issue

Trigger the scenario that raises the Schema Mismatch err and review the event log data collected to try to identify:

- The object on which replication is failing either by its Distinguished Name  or ObjectGUID
- The attribute being applied either by its ldapdisplayname or its internal ID
- Any internal or extended error data.

Event ID's of interest from the Directory Service Event log include:

Replication event 1173

Replication  Event 1791

Replication  Event 1203

The following example events show both an internal ID and extended error data

> Log Name: Directory Service  
Source: Microsoft-Windows-ActiveDirectory_DomainService  
Date: *\<DateTime>*  
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

The following example event identifies a specific object on which replication blocked.

> Log Name: Directory Service  
Source: Microsoft-Windows-ActiveDirectory_DomainService  
Date: *\<DateTime>*  
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
*\<GUID>*._msdcs.contoso.com  
Active Directory Domain Services will attempt to synchronize the schema before attempting to synchronize the following directory partition. Directory partition: DC=contoso,DC=com

Review the data collected  

Look for correlating events  including the ones noted above which point to known trigger scenarios.

Look for events that might indicate other underlying issues on the source or destination that might be blocking replication and so causing what might be a transient mismatch failure to persist.  

Examples of other causes include but are not limited to:

Database CorruptionMemory Constraints
Replication Quarantine
Strict Replication Consistency
Disabled Replication
Objects with Security Descriptors in excess of 64 Kb
DNS (Name Resolution) etc.
RPC Communication Failures
Local firewalls

See Causes Section for details of events and related status codes for some of these issues.

Supplementary Actions  

If the object triggering failure can be identified, then first use `repadmin /showobjmeta` to dump the object replication metadata and on both source and destination DC. This method  can be used to identify "candidate" attributes that could be the cause of failure

`Repadmin /showobjmeta Target_DC "DN_of Trigger_Object"`

If only the GUID of the object is known use the syntax:

`Repadmin /showobjmeta Target_DC "\<GUID=ObjectGuid_of Trigger_Object>"`

Review the replication metadata for correctness by ensuring that all the replicated attributes display a correctly formed attribute  name

Example  

The two entries fro replication metadata for a problem object as displayed by `Repadmin.exe` shows no ldapdisplayname:

> USN DSA Org USN Org. Time/Date Version Attribute  
24260 f4617e99-9688-42a6-8562-43fdd2d5cda4 18085395 *\<DateTime>* 2  
24260 f4617e99-9688-42a6-8562-43fdd2d5cda4 18086114 *\<DateTime>* 3

If any of the metadata fields has no associated name try using ldp.exe  to expose the internal attributeid

The metadata for the same object above as displayed in LDP.exe shows the AttributeID associated with the data

> AttID Ver Loc.USN Originating DSA Org.USN Org.Time/Date  
250000 2 24260  f4617e99-9688-42a6-8562-43fdd2d5cda4 18085395 *\<DateTime>*  
250004 3 24260  f4617e99-9688-42a6-8562-43fdd2d5cda4 18086114 *\<DateTime>*  

The attribute ID can be used to help identify the problem attribute but requires the engagement of Microsoft Support.

Version comparison - attributes to be replicated will have higher version numbers on the source.

> [!NOTE]
> In the DCpromo scenario, the destination object will most likely not yet exist.

If ONLY the object can be identified from the event data, dump the attribute values of the trigger object.

```console
Ldifde -f results.txt> -d "DN_of Trigger_Object" -s Target_DC Ldifde -f  \<results.txt> -d "<GUID=ObjectGuid_of Trigger_Object>" -s Target_DC Repadmin /showattr Target_DC "DN_of Trigger_Object" Repadmin /showattr Target_DC "DN_of Trigger_Object"
```

If the replication events citing 8418 yielded any Extended or Internal errors use those values to try to match against known issues.

If the attribute triggering failure cannot be identified by the event log data or replication metadata, then it will be necessary to engage Microsoft Product Support to assist with the investigation.

Schema Review  

Once a potential trigger attribute has been identified and other known causes eliminated then the next action is to review the schema definition for the attribute. This analysis  is best performed with the assistance  Microsoft Product Support.

Export of entire schema partition from both source and destination domain controllers:

```console
Ldifde -f schema _TargetDC.ldf -d cn=schema,cn=configuration,dc=contoso,dc=com -s Target_DC
```

Data to provide to Microsoft Support  

Be prepared to provide the following information to Microsoft Support staff to assist in diagnosing the causes of the schema mismatch  

- Export of schema partition from the source domain controller
- DCpromo logs from destination DC (if appropriate for the scenario)
- `Repadmin /showrepl` output from the source and destination domain controller
- Directory Services Event logs with extended logging from the source and destination domain controller
- Replication metadata of any problem object identified from the event logs
- LDIFDE Export of any problem object identified from the event logs

## More information

Possible schema definition issues that can trigger mismatch include:  

OID Clash
Invalid OM Syntax values
Invalid MayContain values
Objects with attributes that contain data but the schema definition for the attribute type(s) has been marked as defunct

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
