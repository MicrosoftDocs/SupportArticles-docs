---
title: Troubleshooting AD Replication error 8477
description: Describes an issue where AD operations fail with error 8477 (The replication request has been posted; waiting for reply).
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Troubleshooting AD Replication error 8477: The replication request has been posted; waiting for reply

This article describes an issue where Active Directory Replications fail with error 8477: "The replication request has been posted; waiting for reply".

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2758780

> [!NOTE]
> **Home users:** This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com).

## Symptoms

This article describes the symptoms, cause, and resolution steps involved in troubleshooting Active Directory Replication error 8477: "The replication request has been posted; waiting for reply".

The symptoms discussed in this article are commonly related to the occurrence of event 8477, however may also be observed with other events related to slow or delayed replication. When troubleshooting such issues, consideration should be given to all factors that may cause replication delays and be remediated accordingly.

### Output from repadmin.exe /showreps /verbose may report the replication attempt has failed with error 8477 - "The replication request has been posted; waiting for reply"  

> DC=Contoso,DC=com  
    Default-First-Site-Name\DomainController via RPC  
        DSA object GUID: \<source DCs ntds settings object object guid>  
        Address: \<source DCs ntds settings object object guid>._msdcs.Contoso.Com  
        DSA invocationID: \<source DCs NTDS DB invocation id>  
        DO_SCHEDULED_SYNCS WRITEABLE COMPRESS_CHANGES NO_CHANGE_NOTIFICATIONS PREEMPTED  
        USNs: 1158544/OU, 111052/PU  
        Last attempt @ \<Date Time> was delayed for a normal reason, result 8477 (0x211d):  
    The replication request has been posted; waiting for reply.  
        Last success @ \<Date Time>  

### Output from repadmin.exe /queue may report a large number of queued inbound replication requests and an unprecedentedly long execution time  

> Repadmin /queue  
repadmin running command /queue against server localhost  
>
> Queue contains 26 items.  
Current task began executing at \<Date Time>.  
Task has been executing for 86 minutes, 12 seconds.  
>
> [6485] Enqueued \<Date Time> at priority 590  
    SYNC FROM SOURCE  
    NC DC=Contoso,DC=com  
    DC Default-First-Site-Name\DomainController  
    DC object GUID \<source DCs ntds settings object object guid>  
    DC transport addr \<source DCs ntds settings object object guid>._msdcs.Contoso.com  
  ASYNCHRONOUS_OPERATION WRITEABLE PERIODIC NEVER_NOTIFY PREEMPTED  

> [!Note]
> The occurrence of event 8477 when inbound replication requests are queuing is generally observed following a preempted replication task. This event is indicated by event 8461 - The replication operation was preempted.

### When using dcdiag.exe, initialization of a recently promoted Domain Controller may be delayed, awaiting the completion of an initial synchronization  

> Directory Server Diagnosis  
>
> Performing initial setup:  
   Trying to find home server...  
   Home Server = DomainController  
The directory service on DomainController has not finished initializing.  
In order for the directory service to consider itself synchronized, it must  
attempt an initial synchronization with at least one replica of this  
server's writeable domain. It must also obtain Rid information from the Rid  
FSMO holder.  
The directory service has not signalled the event which lets other services  
know that it is ready to accept requests. Services such as the Key  
Distribution Center, Intersite Messaging Service, and NetLogon will not  
consider this system as an eligible domain controller.  
   \* Identified AD Forest.  
   Done gathering initial info.  
The directory service on BOULDERDC01 has not finished initializing.  
In order for the directory service to consider itself synchronized, it must  
attempt an initial synchronization with at least one replica of this  
server's writeable domain. It must also obtain Rid information from the Rid  
FSMO holder.  
The directory service has not signalled the event which lets other services  
know that it is ready to accept requests. Services such as the Key  
Distribution Center, Intersite Messaging Service, and NetLogon will not  
consider this system as an eligible domain controller.  
Done gathering initial info.  

> [!Note]
> The output from dcdiag.exe described above is normal behavior during the promotion of a new, replica domain controller into an environment. The occurrence of 8477 in this case should be given time to clear through normal replication cycles before remedial activities being considered or conducted.  

### When using dcdiag.exe, the 'Replications' test case may issue a 'REPLICATION LATENCY WARNING'  

> Starting test: Replications  
   REPLICATION LATENCY WARNING  
   DomainController: A long-running replication operation is in progress  
      The job has been executing for 84 minutes and 22 seconds.  
      Replication of new changes along this path will be delayed.  
      This is normal for a new connection, or for a system
      that has been down a long time.  
      Enqueued \<Date Time> at priority 90  
      Op:             SYNC FROM SOURCE  
      NC DC=Contoso,DC=com  
      DSADN \<source DCs ntds settings object object guid>  
>
>DSA transport addr \<source DCs ntds settings object object guid>._msdcs.Contoso.com  
   ......................... DomainController passed test Replications  

### 'NTDS Replication' event 1580 may be logged in the directory service event log

| **Event Source**| **Event ID**| **Event String** |
|---|---|---|
| NTDS Replication| 1580| A long-running Active Directory Domain Services inbound replication task has finished with the following parameters. </br>Elapsed time (minutes): </br>84 </br> Operation:</br> Synchronize Replica </br>Options:</br> 0x21000051 </br>Parameter 1:</br> DC=Contoso,DC=com </br>Parameter 2: </br>\<source DCs ntds settings object object guid></br> Parameter 3: </br></br>Parameter 4:</br></br> A long-running replication task may also occur when a system has been unavailable or a directory partition has been unavailable for an extended period of time. A long running replication task may indicate a large number of updates, or a number of complex updates occurring at the source directory service. Doing these updates during non-critical times may prevent replication delays.</br></br> A long running replication task is normal in the case of adding a new directory partition to Active Directory Domain Services. This can occur because of a new installation, global catalog promotion, or a connection generated by the Knowledge Consistency Checker (KCC). </br></br>Additional Data</br> Error value:</br> The operation completed successfully. |
  
## Cause

The 8477 (The replication request has been posted; waiting for reply) status is informational and represents normal Active Directory replication operation, indicating that replication is currently in progress from the source and hasn't yet been applied to the destination Domain Controllers database replica.

The presence of this event for an extended period may, however, may be indicative of issues with Active Directory Replication on the Destination Domain Controller. Possible causes may include:  

1. Low Available Physical Memory, High Latency or Low-Bandwidth Network Links, Excessive CPU Utilization or Disk I/O for the amount of data that the domain controller is replicating
2. High rate of change for objects in Active Directory Domain Services (AD DS)
3. Third-Party utilities that may hamper or delay normal replication function
4. Large Groups (Greater than 5000 Members) where Linked-value Replication isn't enabled
5. A recent modification to the Active Directory Schema where a sizeable number of schema attributes have been modified or indexed

## Resolution

Investigation of replication error 8477 should be conducted, at least initially, on the Destination Domain Controller within the replication partnership. The resolution section of this article will discuss techniques an Active Directory Administrator should use to resolve the possible causes for error 8477 as per the "Cause" section.

### Low Available Physical Memory, High Latency or Low-Bandwidth Network Links, Excessive CPU Utilization or Disk I/O for the amount of data that the domain controller is replicating  

Active Directory Domain Controllers should be configured with as few additional roles and applications as possible, ideally a Domain Controller should be a single purpose server used only to service queries and authentication requests. When troubleshooting Active Directory performance issues, it's often best to first analyze the system for any additional applications, services, or tasks that are unnecessary or redundant.

As an initial step, an IT Professional should check Task Manager (and Resource Monitor where appropriate) for overall CPU and Memory usage to determine if it's uncharacteristically high or deviates from a predefined baseline. If no baseline exists, Microsoft Best Practice suggests that sustained and repeated CPU usage greater than 80% would be considered high and should be investigated further.

[Troubleshooting High CPU Usage on a Domain Controller](https://technet.microsoft.com/library/bb727054.aspx) - Troubleshooting High CPU Usage on a Domain Controller

Regarding disk usage, on Active Directory Domain Controllers the Ntds.dit and edb.log files should be the most active files on the system. To determine whether this is the case, performance logging and analysis (as per the below) should be conducted.

Low Bandwidth, High Latency, or Busy Network Connectivity may also cause error 8477 to occur on Active Directory Domain Controllers. Network Performance data metrics should be collected from a Domain Controller utilizing Performance Monitor, Network Monitor, or other such tools. Guidance around monitoring and measuring replication traffic is detailed in [Active Directory Replication Traffic](https://technet.microsoft.com/library/bb742457.aspx).

**For Windows Server 2003 based Domain Controllers:**  
An IT Professional may choose to use Performance Monitor with Processor, Physical Disk, Network Interface, and Directory Services counters added to determine and investigate performance issues on the system. Instead, Server Performance Advisor may reduce the complexity in analyzing performance metrics obtained from Performance Monitor. The tool is a free download and will look at CPU, Network, Memory, and Disk I/O giving detail around overall utilization and a determination as to whether the performance data is seen as idle, normal, or potentially problematic.

**For Windows Server 2008 and above based Domain Controllers:**  
Performance Monitor in Windows Server 2008 and later includes the key functionality of Server Performance Advisor straight out of the box. Within the System Data Collector Sets, the Active Directory Diagnostics set will, similarly to Server Performance Advisor, produce a report with key metrics for Active Directory Performance investigation and provide warnings for uncharacteristic behavior on Active Directory Domain Controllers. Any warnings are included at the top of the report an example of which is below:  

|WARNING|</br>|
|---|---|
| **Symptom:**| The system is experiencing excessive paging |
| **Cause:**| Available memory on the system is low. |
| **Details:**| The total physical memory on the system is not capable of handling the load. |
| **Resolution:**| Upgrade the physical memory or reduce system load |
| **Related:**| Memory Diagnosis |
| **Symptom:**| On directory servers, Ntds.dit and Edb.log should be the most active files. In this case, C:\Windows\NTDS\ntds.dit has the highest I/O rate (84.622 operations/sec). |

### High rate of change for objects in Active Directory Domain Services (AD DS)  

In a busy Active Directory Environment, a large number of changes may occur to objects between each scheduled replication. If this is expected within the environment, all aspects of the organizations infrastructure should be sized appropriately to ease effective replication.

In the event that an IT Administrator isn't aware or not expecting a large number of changes and is receiving error 8477, investigation should be conducted to determine what changes are occurring in the environment and whether these are expected or the result of an issue with an application or service. An effective means for performing this task is to determine what objects are changing through the use of the uSNChanged attribute, the highest uSNChanged value on a specific Domain Controller represents the High-Watermark USN.

Running repadmin /showreps /verbose against a domain controller with event 8477 being displayed will show the current High-Watermark and is followed by /OU:

> DC=Contoso,DC=com  
    Default-First-Site-Name\DomainController via RPC  
        DSA object GUID: \<source DCs ntds settings object object guid>  
        Address: \<source DCs ntds settings object object guid>._msdcs.Contoso.Com  
        DSA invocationID: \<source DCs NTDS DB invocation id>  
        DO_SCHEDULED_SYNCS WRITEABLE COMPRESS_CHANGES NO_CHANGE_NOTIFICATIONS PREEMPTED  
        USNs: 1158544/OU, 111052/PU  
        Last attempt @ \<Date Time> was delayed for a normal reason, result 8477 (0x211d):  
    The replication request has been posted; waiting for reply.  
        Last success @ \<Date Time>  

Depending on the number of changes occurring, the highest USN present on a Domain Controller may increment quickly, to determine the objects that are being updated, it's suggested that on the Source Replication Partner, the below command is run for the relevant Naming Context:

`Repadmin /showattrDomainControllerNameDC=Contoso,DC=com /subtree /filter:"(uSNChanged>=highestcommitedusn)" /atts:objectclass`

Specific Applications or Services, such as the Exchange Recipient Update Service may make regular changes to Active Directory Attributes and may need to be tuned if resulting replication traffic is unmanageable.  

### Third-Party utilities that may hamper or delay normal replication function  

Third-Party applications should be configured and tuned around performance and supportability best practices. Certain applications, if not configured around best practices for Active Directory Performance, may cause impact to normal Active Directory Domain Controller function.

Applications of note include (but aren't limited to):

a. Virus Scanning Software  
b. Monitoring Agents  
c. Identity Synchronization and Management Applications  
d. Backup Software and Agents  
[Virus scanning recommendations for Enterprise computers that are running currently supported versions of Windows](https://support.microsoft.com/help/822158/virus-scanning-recommendations-for-enterprise-computers)

### Large Groups (Greater than 5000 Members) where Linked-value Replication isn't enabled  

Linked-value replication isn't available in Windows 2000 Server forests. Because an originating update must be written in a single database transaction, and because the practical limit for a single transaction is 5,000 values, membership of more than 5,000 values isn't supported in Windows 2000 Server Active Directory. A group of this size represents a limitation both for the database write operation that is required to record a change to an attribute of that size and the transfer of that much data over the network. This is different in forests at Windows 2003 or higher functional level where linked-valued replication (LVR) for group memberships is enabled.

When a Domain is upgraded from a 2000 functional level, the memberships of any groups carried are considered legacy and can still cause replication issues:

1. Forests before the 2003 functional level should divide the groups into smaller groups that don't exceed 5,000 members. Group nesting can also be used, providing the applications and services using the groups can support it.

2. Forests at the 2003 functional level can remove and reinstate group members to make them LVR-enabled. Over time, as security principals are added and removed from groups, the members are slowly enabled for LVR
Note: Events 1479 and 1519 are also commonly logged in the Directory Service Event Log when large groups are causing replication issues and delays.

Using repadmin /showobjmeta legacy members in a group can be determined and converted to LVR enabled members if necessary to resolve the issue, these users are denoted with 'Type' of value LEGACY:  

> repadmin /showobjmeta DomainControllerName "CN=Administrators,CN=Builtin,DC=Contoso,DC=Com"
>
> 3 entries.  
 **Type    Attribute     Last Mod Time                            Originating DSA  Loc.USN Org.USN Ver**  
======= ============  =============                           ================= ======= ======= ===  
 **Distinguished Name**  
        =============================  
PRESENT       member \<Date Time>                    Default-First-Site-Name\DomainController    8203    8203   1  
        CN=Administrator,CN=Users,DC=Contoso,DC=Com  
PRESENT       member \<Date Time>                    Default-First-Site-Name\DomainController   12398   12398   1  
        CN=Enterprise Admins,CN=Users,DC=Contoso,DC=Com  
PRESENT       member \<Date Time>                    Default-First-Site-Name\DomainController   12378   12378   1  
        CN=Domain Admins,CN=Users,DC=Contoso,DC=Com  
 **LEGACY**       member \<Date Time>                    Default-First-Site-Name\DomainController   198458   198458   1
        CN=mjordan,CN=Users,DC=Contoso,DC=Com

### A recent modification to the Active Directory Schema where a sizeable number of schema attributes have been modified or indexed  

Attribute definitions are stored in attributeSchema objects in the schema directory partition. Changes to attributeSchema objects block other replication until the schema changes are done. During replication of any directory partition other than the schema directory partition, the replication system first checks to see whether the schema versions of the source and the destination domain controllers are in agreement. If the versions aren't the same, the replication of the other directory partition is rescheduled until the schema directory partition is synchronized.

Modification of the schema through the use of LDIFDE or customized binaries included with applications (that is, Microsoft Exchange, Operations Manager, and so on) may add indexed attributes to the schema directory partition. Depending on the size of the update, replication delays can be caused in large databases.

In cases such as these, the 8477 state may appear as a transient issue and should be expected to self-resolve once the higher priority schema updates are successfully replicated and all other replication catches up on backlogged changes within the directory.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

## More information

[How the Active Directory Replication Model Works](https://technet.microsoft.com/library/cc772726%28v=WS.10%29.aspx)
