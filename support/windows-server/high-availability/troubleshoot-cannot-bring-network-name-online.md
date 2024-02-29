---
title: Can't bring a network name online in a cluster
description: Provides guidance for when a network name fails to come online in a Windows-based failover cluster
ms.date: 12/26/2023
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:cannot-bring-a-resource-online, csstroubleshoot
---
# Can't bring a network name online in a failover cluster

## Troubleshooting checklist

1. Review the system and the cluster log to find the exact errors or warnings that prevent the network name from coming online. Usually, in addition to Event ID 1069, Event ID 1207 is also logged:

   - Event ID 1069

     > Error 1069 Microsoft-Windows-FailoverClustering Cluster resource '\<Name of the Resource>' of type '\<Resource Type>' in clustered role '\<Available Storage>' failed.

   - Event ID 1207

     > Cluster network name resource 'Cluster Name' cannot be brought online. The computer object associated with the resource could not be updated in domain 'domainname.com' for the following reason.

2. Ensure that the Virtual Computer Object (VCO) or Cluster Name Object (CNO) has appropriate permissions in Active Directory. For more information, see [Prestage Cluster Computer Objects in Active Directory Domain Services](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn466519%28v=ws.11%29).

3. If CNO is affected, after adjusting the permissions, you can run the **Repair** option to sync the AD password for the CNO again. For more information, see [Understanding the Repair Active Directory Object Recovery Action](https://techcommunity.microsoft.com/t5/failover-clustering/understanding-the-repair-active-directory-object-recovery-action/ba-p/371891).

4. You can run a cluster validation (without the storage section) to check the supportability of the cluster and see if there are any misconfigurations.

5. The CNO or VCO might not be able to come online because of DNS issues. The permissions for the CNO or VCO records need to be checked as well. Network traces will show the cause of the issue.

## Common issues and solutions

For the following Event IDs, [review the logs to find more information about the issue](#review-the-logs-to-find-more-information-about-the-issue).

### Event ID 1050

> Cluster network name resource '%1' cannot be brought online because name '%2' matches this cluster node name.  Ensure that network names are unique.

### Event ID 1051

> Cluster network name resource '%1' cannot be brought online.
>
> In a cluster, a Network Name resource can be important because other resources depend on it. A Network Name resource can come online only if it is configured correctly, and is supported correctly by available networks and network configurations.

### Event ID 1052

> Cluster Network Name resource '%1' cannot be brought online because the name could not be added to the system.
>
> In a cluster, a Network Name resource can be important because other resources depend on it. A Network Name resource can come online only if it is configured correctly, and is supported correctly by available networks and network configurations.

### Event ID: 1211

> Cluster network name resource '%1' cannot be brought online.
>
> In a cluster, a Network Name resource can be important because other resources depend on it. A Network Name resource can come online only if it is configured correctly, and is supported correctly by available networks and network configurations.

This event indicates that the cluster couldn't locate a writeable domain controller.

### Event ID 1212

> Cluster network name resource '%1' cannot be brought online.
>
> In a cluster, a Network Name resource can be important because other resources depend on it. A Network Name resource can come online only if it is configured correctly, and is supported correctly by available networks and network configurations.

This event indicates that the cluster couldn't locate a writeable domain controller.

### Event ID 1218

> Cluster network name resource '%1' failed to perform a name change operation (attempting to change original name '%3' to name '%4')
>
> In a cluster, a Network Name resource can be important because other resources depend on it. A Network Name resource can come online only if it is configured correctly, and is supported correctly by available networks and network configurations.

This event indicates that the cluster couldn't find the CNO in Active Directory. The next time you try to bring the cluster online, it will try to recreate the CNO.

### Event ID 1219

> Cluster network name resource '%1' failed to perform a name change operation
>
> In a cluster, a Network Name resource can be important because other resources depend on it. A Network Name resource can come online only if it is configured correctly, and is supported correctly by available networks and network configurations.

This event indicates that the cluster couldn't contact a domain controller.

### Review the logs to find more information about the issue

For Event ID 1050, 1051, 1052, 1211, 1212, 1218, and 1219, follow these steps:

1. Use Event Viewer to review the application and system logs.

   > [!NOTE]
   > In particular, search for any events related to domain controller functionality.

2. To search for information about an error code, use one of the following methods:

   - See [system error codes](/windows/win32/debug/system-error-codes).

   - At a command prompt, run the following command:

     ```console
     NET HELPMSG <Code>
     ```

     > [!NOTE]
     > The placeholder \<Code> represents the error code.

3. Generate a fresh cluster log and review it. To generate a fresh cluster log, reproduce the issue and open an elevated PowerShell prompt. At the elevated PowerShell prompt, run the following cmdlet:

   `Get-ClusterLog -Destination C:\temp\ -TimeSpan 5 -UseLocalTime`

If you identify an issue that you can fix, fix it and try to start the affected clustered resource again.
