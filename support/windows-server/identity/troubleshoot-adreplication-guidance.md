---
title: Guidance for troubleshooting Active Directory replication
description: Introduces general guidance for troubleshooting scenarios related to Active Directory replication.
ms.date: 03/16/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-certificate-services, csstroubleshoot
ms.technology: windows-server-active-directory
---
# Active Directory replication troubleshooting guidance

<p class="alert is-flex is-primary"><span class="has-padding-left-medium has-padding-top-extra-small"><a class="button is-primary" href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806222" target='_blank'><b>Try our Virtual Agent</b></a></span><span class="has-padding-small"> - It can help you quickly identify and fix common Active Directory replication issues</span>

This article is designed to help get you started troubleshooting Active Directory replication issues.

## Troubleshooting checklist

Use the following checklist to troubleshoot these replication issues:

- The error and warning events in the Directory Service event log indicate the specific constraint that's causing replication failure on the source or destination domain controller. If the event message suggests steps for a solution, try the steps that are described in the event.
- Diagnostic tools such as `Repadmin` also provide information that can help you resolve replication failures. To help monitor replication and diagnose errors, use either of the following methods:
  - Download and run the [Microsoft Support and Recovery Assistant tool](https://outlookdiagnostics.azureedge.net/sarasetup/SetupProd_ADReplication.exe).
  - Use the [Active Directory Replication Status Tool](https://www.microsoft.com/download/details.aspx?id=30005) if you want only to analyze the replication status.
- Rule out intentional disruptions or hardware failures.
- In a scenario: A domain controller is built in a staging site. The domain controller is currently offline, and is waiting for its deployment in the final production site, a remote site such as a branch office.

  When another domain controller is trying to replica with the domain controller, it reports replication errors. You can account for such replication errors.
- Replication problems might be caused by hardware failure.
- Active Directory replication remote procedure calls (RPCs) occur dynamically over an available port through the RPC Endpoint Mapper (RPCSS) on port 135. Make sure that Windows Defender Firewall with Advanced Security and other firewalls are configured correctly to enable replication.

After you rule out intentional disconnections and hardware failures, the replication issues might have one of the following causes:

- Network connectivity: The network connection might be unavailable, or network settings might not configured correctly.
- Name resolution: DNS misconfigurations are a common cause of replication failures.
- Replication engine: If intersite replication schedules are too short, replication queues might be too large to process in the time that is required by the outbound replication schedule. In this case, replication of some changes might be stalled indefinitely, or long enough to exceed the tombstone lifetime.
- Replication topology: Domain controllers must have intersite links in Active Directory Domain Services (AD DS) that map to real wide area network (WAN) or virtual private network (VPN) connections. If you create objects in AD DS for the replication topology that aren't supported by the actual site topology of your network, replication that requires the misconfigured topology fails.
- Authentication and authorization: Authentication and authorization problems cause "access denied" errors when a domain controller tries to connect to its replication partner.
- Directory database store: The directory database might not be able to process transactions fast enough to keep up with replication time-outs.

## Common solutions for Active Directory replication issues

- Monitor replication health daily, or use `Repadmin` to retrieve replication status daily.
- Try to resolve any reported failure in a timely manner by using the methods that are described in the event messages and this guide. If software is causing the problem, uninstall the software before you continue to try other solutions.
- If the problem that is causing replication to fail can’t be resolved by any known methods, remove AD DS from the server, and then reinstall it. For more information about reinstalling AD DS, see [Decommissioning a Domain Controller](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc816644%28v=ws.10%29).
- If AD DS can't be removed in a typical manner while the server is connected to the network, use one of the following methods to resolve the problem:
  - Force AD DS removal in Directory Services Restore Mode (DSRM), clean up server metadata, and then reinstall AD DS.
  - Reinstall the operating system, and rebuild the domain controller.

## Common issues and solutions

Most replication problems are identified in the event messages that are logged in the Directory Service event log. Replication problems might also be identified in the form of error messages in the output of the `repadmin /showrepl` command.

### Event ID 2042

Repadmin message:  
> The time since last replication with this server has exceeded the tombstone lifetime.

A domain controller has failed inbound replication with the named source domain controller long enough for a deletion to have been tombstoned, replicated, and garbage-collected from AD DS. See [Active Directory replication Event ID 2042](/troubleshoot/windows-server/identity/active-directory-replication-event-id-2042).

### Event ID 1925

Repadmin message:  
> No inbound neighbors

If no items appear in the "Inbound Neighbors" section of the output that is generated by `repadmin /showrepl`, the domain controller wasn't able to establish replication links with another domain controller. See [Active Directory replication Event ID 1925](/troubleshoot/windows-server/identity/active-directory-replication-event-id-1925-dns-lookup).

### Error code 5

Repadmin message:  
> Access is denied.

A replication link exists between two domain controllers, but replication can’t be done correctly because of an authentication failure. See [Active Directory replication fails with error 5: Access is denied](/troubleshoot/windows-server/identity/replications-fail-with-error-5).

### Error code 49

Repadmin message:  
> LDAP Error 49.

The domain controller computer account might not be synchronized with the Key Distribution Center (KDC). Fix replication security issues.

### Event ID 1925 and event ID 2087

Repadmin message:  
> Cannot open LDAP connection to local host.

The administration tool couldn't contact AD DS. See the following articles:

- [Active Directory replication Event ID 1925](/troubleshoot/windows-server/identity/active-directory-replication-event-id-1925-dns-lookup)
- [Active Directory replication Event ID 2087](/troubleshoot/windows-server/identity/active-directory-replication-event-id-2087)

### Event ID 1925, event ID 2087 and event ID 2088

Repadmin message:  
> Last attempt at \<date - time\> failed with the "Target account name is incorrect."

This problem can be related to connectivity, DNS, or authentication issues. If this error is a DNS error, the local domain controller couldn't resolve the globally unique identifier (GUID)-based DNS name of its replication partner. See the following articles:

- [Active Directory replication Event ID 1925](/troubleshoot/windows-server/identity/active-directory-replication-event-id-1925-dns-lookup)
- [Active Directory replication Event ID 2087](/troubleshoot/windows-server/identity/active-directory-replication-event-id-2087)

## Data collection

Before contacting Microsoft support, you can gather information about your issue.

### Prerequisites

1. TSSv2 must be run by accounts with administrator privileges on the local system, and EULA must be accepted (once EULA is accepted, TSSv2 won't prompt again).
2. We recommend the local machine `RemoteSigned` PowerShell execution policy.

> [!NOTE]
> If the current PowerShell execution policy doesn't allow running TSSv2, take the following actions:
>
> - Set the `RemoteSigned` execution policy for the process level by running the cmdlet `PS C:\> Set-ExecutionPolicy -scope Process -ExecutionPolicy RemoteSigned`.
> - To verify if the change takes effect, run the cmdlet `PS C:\> Get-ExecutionPolicy -List`.
> - Because the process level permissions only apply to the current PowerShell session, once the given PowerShell window in which TSSv2 runs is closed, the assigned permission for the process level will also go back to the previously configured state.

### Gather key information before contacting Microsoft support

1. Download [TSSv2](https://aka.ms/getTSSv2) on all nodes and unzip it in the *C:\\tss_tool* folder.
2. Open the *C:\\tss_tool* folder from an elevated PowerShell command prompt.
3. Run the SDP tool to collect the logs from the source and destination nodes.
4. Unzip the file and run the following cmdlet on both nodes:

    ```PowerShell
    TSSv2.ps1 -SDP HyperV -SkipSDPList skipBPA,skipTS
    ```

Collect all logs. Zip and upload the collection on the workspace.

## Reference

- [Troubleshoot common Active Directory replication errors](/troubleshoot/windows-server/identity/common-active-directory-replication-errors)
- [Monitoring and Troubleshooting Active Directory Replication Using Repadmin](/previous-versions/windows/it-pro/windows-server-2003/cc811551%28v=ws.10%29)
