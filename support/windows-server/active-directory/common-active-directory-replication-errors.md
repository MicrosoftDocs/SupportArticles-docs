---
title: Troubleshoot common AD replication errors
description: Contains troubleshooting information to help you fix Active Directory replication errors.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, arrenc, justintu
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Troubleshoot common Active Directory replication errors

This article contains information and links to help you troubleshoot Active Directory Replication errors. It is intended to provide Active Directory administrators with a method to diagnose replication failures and to determine where those failures are occurring.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3108513

> [!NOTE]
> **Home users**: This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com).

## Error codes

To troubleshoot specific errors, refer to the following table.

|Replication error code|Cause|Related Knowledge Base article|
|---|---|---|
|8464|This issue occurs because partial attribute set (PAS) synchronization is triggered when an attribute is added to the PAS.| [Active Directory replication error 8464: Synchronization attempt failed](replication-error-8464.md) |
|8477|This code is informational and represents a regular Active Directory replication operation. It indicates that replication is currently in progress from the source and has not yet been applied to the destination domain controller's database replica.| [Troubleshooting AD Replication error 8477: The replication request has been posted; waiting for reply](replication-error-8477.md) |
|8418|Attempts to replicate Active Directory when schema information is not consistent between the domain controller partners that are involved result in a **Schema Mismatch** error status. This symptom manifests itself in several ways. The underlying cause of the error may vary.| [Troubleshooting AD Replication error 8418: The replication operation failed because of a schema mismatch between the servers involved](replication-error-8418.md) |
|1908|This error has two primary causes:<ul><li>The destination domain controller can't contact a key distribution center (KDC).</li><li>The computer is experiencing Kerberos-related errors.</li></ul>| [Troubleshooting AD Replication error 1908: Could not find the domain controller for this domain](https://support.microsoft.com/help/2712026) |
|8333|This error has multiple causes. They include the following:<ul><li> Database corruption, with additional associated errors that are logged in the event log of the source domain controller</li><li> Lingering objects that have associated errors logged</li><li> Conflict objects</li><li> A third-party process</li></ul>| [Troubleshooting AD Replication error 8333: Directory Object Not Found](replication-error-8333.md) |
|8589|This error most commonly occurs on a domain controller after a replication partner has Active Directory forcibly removed and then is re-promoted before end-to-end replication can complete. This error can also occur when you rename a domain controller and the serverReference attribute is not updated.| [Troubleshooting AD Replication error 8589: The DS cannot derive a service principal name (SPN)](replication-error-8589.md) |
|1818|The issue occurs when the destination domain controller that is performing incoming replication does not receive replication changes within the number of seconds that is specified in the RPC Replication Timeout registry key.| [Troubleshooting AD Replication error 1818: The remote procedure call was cancelled](replication-error-1818.md) |
|8446|This error can occur when the Active Directory replication engine cannot allocate memory to run Active Directory replication.| [Troubleshooting AD Replication error 8446: The replication operation failed to allocate memory](replication-error-8446.md) |
|8240|This error indicates that the specific object could not be found in the directory. This error may be encountered in the following situations:<ul><li> During AD replication</li><li> Reported 8240 in 1126 Event (NTDS)</li></ul>| [Troubleshooting AD Replication error 8240: There is no such object on the server](active-directory-replication-error-8240.md) |
|8451|Status 8451: **The replication operation encountered a database** error has multiple causes. Refer to the related Knowledge Base article in the third column.| [Active Directory Replication Error 8451: The replication operation encountered a database error](https://support.microsoft.com/help/2645996) |
|1256|This error is logged because of a connectivity failure.| [Active Directory Replication Error 1256: The remote system is not available.](https://support.microsoft.com/help/2200187) |
|1396|Known causes of this error include the following:<ul><li> The service principal name (SPN) does not exist on the global catalog that is searched by the Kerberos Key Distribution Center (KDC) on behalf of the client that is trying to authenticate by using the Kerberos protocol.</li><li> The user or service account that should contain the SPN that is being looked up does not exist on the global catalog that is searched by the KDC on behalf of the destination domain controller that is trying to replicate.</li><li> The destination domain controller lacks a Local Security Authority (LSA) secret for the source domain controller's domain.</li><li> The SPN that is being looked up exists on the account of a different computer than the source domain controller.</li></ul>| [Active Directory Replication Error 1396: Logon Failure: The target account name is incorrect.](https://support.microsoft.com/help/2183411) |
|1722|Remote Procedure Call (RPC) is an intermediate layer between the network transport and the application protocol. RPC itself has no special insight into failures. However, it tries to map lower-layer protocol failures into an error at the RPC layer.| [Active Directory replication error 1722: The RPC server is unavailable](replication-error-1722-rpc-server-unavailable.md) |
|-2146893022|This error code is not returned by Active Directory. However, it may be returned by lower-layer components. These include RPC, the Kerberos protocol, Secure Sockets Layer (SSL), LSA, and NT LAN Manager (NTLM). The code is returned for various reasons.| [Active Directory replication error -2146893022: The target principal name is incorrect](replication-error-2146893022.md) |
|1753|Specific causes of this error include the following:<ul><li> The server app never started.</li><li> The server app started. However, there was a failure during initialization that prevented the server app from registering with the RPC Endpoint Mapper.</li><li> The server app started but later died. </li><li> The server app manually unregistered its endpoints. (This resembled the previous cause, but its occurrence was intentional. You are unlikely to receive this error for this reason. However, we include it for completeness.)</li><li> The RPC client (that is, the destination domain controller) contacted a different RPC server than the intended one because of a name-to-IP mapping error in DNS, WINS, or the host / lmhosts file.</li></ul>| [Active Directory Replication Error 1753: There are no more endpoints available from the endpoint mapper](replication-error-1753.md) |
|8606|Error 8606 is logged when the following conditions are true:<ul><li> A source domain controller sends an update to an object (instead of sending an originating object create request) that was already created, deleted, and then reclaimed by garbage collection from a destination domain controller's copy of Active Directory.</li><li> The destination domain controller was configured to run in strict replication consistency.</li></ul>| [Active Directory Replication Error 8606: Insufficient attributes were given to create an object](replication-error-8606.md) |
|1127|Error 8606 is logged when the following conditions are true:<ul><li> A source domain controller sends an update to an object (instead of sending an originating object create request) that was already created, deleted, and then reclaimed by garbage collection from a destination domain controller's copy of Active Directory.</li><li> The destination domain controller was configured to run in strict replication consistency. duplication of above?</li> </ul>| [Active Directory Replication Error 1127: While accessing the hard disk, a disk operation failed even after retries](replication-error-1127.md) |
|8452|This error most frequently occurs when the replication topology in a domain controller that is starting replication differs from the replication topology that is defined in the destination domain controller's copy of Active Directory.| [The naming context is in the process of being removed or is not replicated from the specified server](replication-error-8452.md) |
|8456 or 8457|Incoming or outgoing replication was automatically disabled by the operating system because of multiple root causes.| [2023007](https://support.microsoft.com/help/2023007) |
|8453|This **Replication Access was denied** error has multiple causes.| [Active Directory replication error 8453: Replication access was denied](replication-error-8453.md) |
|8524|This is a catch-all error for all possible DNS failures that affect Active Directory on post-Windows Server 2003 SP1-based domain controllers.| [Active Directory Replication Error 8524: The DSA operation is unable to proceed because of a DNS lookup failure](replication-error-8524.md) |
|8614|Causes of this error (and for NTDS Replication Event 2042) include the following:<ul><li> The destination domain controller that is logging the 8614 error did not inbound-replicate a directory partition from one or more source domain controllers for Tombstone lifetime number of days.</li><li>System time on the destination domain controller moved, or jumped, Tombstone lifetime one or more days into the future after the last successful replication.</li></ul>| [Troubleshoot Active Directory replication error 8614](replication-error-8614.md) |
|8545|This Active Directory replication error is logged when the source domain controller tries to send changes for a recently migrated object when the destination domain controller has the object present in a different partition.| [Active Directory replication error 8545: Replication update could not be applied](active-directory-replication-error-8545.md) |
|5|This Active Directory replication error has multiple causes.| [Active Directory replication error 5 - Access is denied](replication-error-5.md) |
  
## Event IDs

To troubleshoot specific event IDs, refer to the following table:

| Event ID| Cause| Related article |
|---|---|---|
|Event ID 1311|Fixing Replication Topology Problems| [How to troubleshoot Event ID 1311 messages on a Windows domain](troubleshoot-event-id-1311-messages.md) |
|Event ID 1388 or 1988|A lingering object is detected| [4469619](https://support.microsoft.com/help/4469619) |
|Event ID 2042|It has been too long since this machine replicated| [4469622](https://support.microsoft.com/help/4469622) |
|Event ID 1925|Attempt to establish a replication link failed due to DNS lookup problem| [4469659](https://support.microsoft.com/help/4469659) |
|Event ID 2087|DNS lookup failure caused replication to fail| [4469661](https://support.microsoft.com/help/4469661) |
|Event ID 2088|DNS lookup failure occurred with replication success| [Event ID 2088: DNS lookup failure occurred with replication success](/windows-server/identity/ad-ds/manage/component-updates/event-id-2088--dns-lookup-failure-occurred-with-replication-success) |
  
## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

## References

- [Troubleshooting Active Directory Replication Problems](/previous-versions/windows/it-pro/windows-2000-server/bb727057(v=technet.10))

- [Troubleshooting Active Directory Replication Problems](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc949120(v=ws.10))

- [Diagnose Active Directory replication failures](diagnose-replication-failures.md)
