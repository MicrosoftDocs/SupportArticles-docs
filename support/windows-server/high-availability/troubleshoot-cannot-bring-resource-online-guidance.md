---
title: Can't bring a clustered resource online troubleshooting guidance
description: Provides guidance for when a clustered resource fails to come online in a Windows-based failover cluster
ms.date: 04/18/2022
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:cannot-bring-a-resource-online, csstroubleshoot
ms.technology: windows-server-high-availability
---
# Can't bring a clustered resource online troubleshooting guidance

This guidance is designed to get you started on troubleshooting issues where clustered resources can't be brought online in a Windows-based cluster environment.

## Troubleshooting checklist

1. When a resource fails to come online, Event ID 1069 is logged on the server that's hosting the resource of concern:

   > Error 1069 Microsoft-Windows-FailoverClustering Cluster resource '\<Name of the Resource>' of type '\<Resource Type>' in clustered role '\<Available Storage>' failed.

2. Check the System event log for the Event ID, and then check if other errors or warnings are logged. For example:

   - If a physical disk resource can't come online, check for disk-related errors or warnings. For example, Event ID 129 (bus reset) or Event ID 153 (IO retried).

   - If a network name resource can't come online, check for DNS-related entries.

   - If an IP address resource can't come online, check for NIC-related events, errors, or warnings.

3. If nothing except Event ID 1069 is logged, review the cluster log for further troubleshooting. Open an elevated PowerShell prompt and run the following cmdlet:

   ```powershell
   Get-ClusterLog -Destination C:\temp
   ```

   > [!NOTE]
   > This cmdlet will generate the cluster logs on all cluster members and copy them to the *C:\temp* folder on the server where the cmdlet was executed.

4. Search for strings in the cluster log that might correlate with Event ID 1069:

   ```output
   [RCM] rcm::RcmResource::HandleFailure
   [RHS] Online for resource
   OnlineThread: Error <Code> bringing resource online.
   [RHS] RhsCall::DeadlockMonitor: Call ONLINERESOURCE
   ```

   > [!NOTE]
   > The placeholder \<Code> represents the error code and can differ depending on the issue.

## Common support scenarios

- [Can't bring a network name online](troubleshoot-cannot-bring-network-name-online.md)

- [Can't bring a physical disk online](troubleshoot-cannot-bring-physical-disk-online.md)

- [Can't bring an IP address online](troubleshoot-cannot-bring-ip-address-online.md)

## Data collection

Before contacting Microsoft Support, you can gather information about the issue.

### Prerequisites

1. [TSSv2](https://aka.ms/getTSSv2) must be executed in the context of an account with admin rights on the local system, and EULA must be accepted (once EULA is accepted, TSSv2 won't prompt it again).

2. We recommend that the local machine uses the **RemoteSigned** PowerShell execution policy.

> [!NOTE]
> In case the current PowerShell execution policy doesn't allow running TSSv2, the following actions could be taken:
>
> - Set **RemoteSigned** for the **Process** level and run the following cmdlet:
>
>   `PS C:\> Set-ExecutionPolicy -scope Process -ExecutionPolicy RemoteSigned`
>
> - Verify if the change has taken effect, run the following cmdlet:
>
>   `PS C:\> Get-ExecutionPolicy -List`
>
> Since the **Process** level permissions only apply to the current PowerShell session, once the given PowerShell window in which TSSv2 runs is closed, the assigned permission for the **Process** level will also go back to the previously configured state.

### Gather key information before you contact Microsoft Support

1. Download [TSSv2](https://aka.ms/getTSSv2) and unzip it to the *C:\tss_tool* folder.

2. Open an elevated PowerShell prompt and change the directory to the *C:\tss_tool* folder.

3. Start the trace by running the cmdlet on the source and destination nodes.

   ```powershell
   .\Get-psSDP.ps1
   ```
