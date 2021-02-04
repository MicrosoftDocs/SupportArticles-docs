---
title: Configure cluster networks for CSV redirected access
description: Describes how to configure cluster networks for CSV redirected access for Data Protection Manager Hyper-V protection.
ms.date: 07/27/2020
ms.prod-support-area-path:
ms.reviewer: mjacquet
---
# Configure cluster networks for CSV redirected access in DPM 2010

This article describes how to configure cluster networks for Cluster Shared Volume (CSV) redirected access in Data Protection Manager (DPM) Hyper-V protection.

_Original product version:_ &nbsp; System Center Data Protection Manager 2010  
_Original KB number:_ &nbsp; 2473194

## Summary

When System Center Data Protection Manager 2010 protects Hyper-V guests using the Microsoft Software Shadow Copy provider (the VSS provider), DPM uses software snapshots when backing up guests located on Cluster Shared Volume (CSV) disks. While the backup is in progress, the CSV will remain in redirected access mode for the duration of the guest backup. This means all disk I/O for guests located on that CSV will be in redirected mode and be going over the network instead of direct access to the CSV and performance may be affected.

The obvious workaround for this issue is to contact your hardware manufacturer to get a hardware provider and we have a list of the ones in [Tested hardware VSS provider table](https://techcommunity.microsoft.com/t5/system-center-blog/tested-hardware-vss-provider-table/ba-p/341939).

To mitigate this potential performance hit, it's recommended that you have a dedicated network for redirected mode and preferably a separate one for live migration.

## Configure cluster networks

The following content describes how to properly configure the cluster networks so redirected I/O goes through a dedicated network for CSV traffic and not over a normal client access or the cluster heartbeat network.

For an example, if your cluster has the following three networks:

- **iSCSI Storage Network**
- **Heartbeat Cluster**
- **Host Access Cluster**

The **iSCSI Storage Network** is going out to the ISCSI SAN and are disabled for cluster use. This means that we have only two networks available for cluster. For a non-Hyper-V cluster, this would be fine, however when you start clustering virtual machines, you will need at least one additional network. The reason for this is that when the CSV drives go into Redirected Mode, all disk I/O is sent over the network designated for CSV to the one node identified as the coordinator. With DPM doing the backups, the coordinator node would be the one that's hosting the VM during the backup. You also have a network that's designated as the **Live Migration Network** when doing a live migration from one node to another. These networks will get flooded with I/O so you want to keep them from the primary heartbeat network or the network that clients access the VMs on.

For more information, see [Network requirements for using Cluster Shared Volumes](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff182358(v=ws.10)?redirectedfrom=MSDN#network-requirements-for-using-cluster-shared-volumes)

So now that we know we have two network cards to use, we can take a look at the metrics to see which is the CSV network and which is the **Live Migration Network**. You can check the metrics with PowerShell to get the output.  

```powershell
Import-Module failoverclusters
Get-ClusterNetwork | FT Name, Metric, Role
```

> |Name|Metric|Role|
> |---|---|---|
> |iSCSI Storage Network|10100|0|
> |Heartbeat Cluster|1000|1|
> |Host Access Cluster|10000|3|

So here we verify the **iSCSI Storage Network** is disabled for Cluster (Role=0), the **Heartbeat Cluster** is set for Cluster Communications Only (Role=1), and the **Host Access Cluster** is allowing Client Access (Role=3). Any network that has a default gateway defined is considered a public network and has a value of 10,000 or more. Any network without a default gateway is considered a private interconnect and given a value between 1,000 and 10,000. The lower the number, representing a cost, the more likely it will be used for private cluster communications including redirected I/O of Cluster Shared Volumes.

The order of networks for this setting is initially configured based on the **Cluster Network Metric** property. To avoid both CSV and Live Migration from using the same network, the network with the lowest Metric (highest priority) will be automatically placed at the bottom of the list and the network with then next lowest Metric will be placed at the top of the list. So in looking at what the output was above, the CSV traffic would be going over the **Heartbeat Cluster** network and the **Live Migration Network** would be the **Host Access Cluster** network. This is non-optimal and may affect client access to the running guests.

What you would need to do is add at least one additional network that can be used for the CSV redirected mode. Once you add the additional network, you should change the metrics so that you can configure which is used for CSV traffic.

For example, say you added a new network with no default gateway and called it **CSV-LM Cluster**.  Cluster will automatically assign it a metric. This looks like below.

```powershell
Get-ClusterNetwork | FT Name, Metric, Role
```

|Name|Metric|Role|
|---|---|---|
|iSCSI Storage Network|10100|0|
|Heartbeat Cluster|1000|1|
|Host Access Cluster|10000|3|
|CSV-LM Cluster|1100|1|

For information on how to change the metric on the **CSV-LM** Cluster network, see [Designating a Preferred Network for Cluster Shared Volumes Communication](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff182335(v=ws.10)?redirectedfrom=MSDN).

## Examples

To change the metric on the **CSV-LM Cluster** network, run this PowerShell command:

```powershell
Get-ClusterNetwork "CSV-LM Cluster" | %{$_.Metric=800}
```

If you added two networks (one for CSV and one for Live Migration), run these two commands:

```powershell
Get-ClusterNetwork "CSV Cluster" | %{$_.Metric=800}
Get-ClusterNetwork "LM Cluster" | %{$_.Metric=900}  
```

You should manually set it to lower than 1000 so that it doesn't have a chance to conflict with anything else new that might come in later. Now when you run the command to see what it configured, you see this result:

```powershell
Get-ClusterNetwork | FT Name, Metric, Role
```

|Name|Metric|Role|
|---|---|---|
|iSCSI Storage Network|10100|0|
|Heartbeat Cluster|1000|1|
|Host Access Cluster|10000|3|
|CSV Cluster|800|1|
|LM Cluster|900|1|

So based on the metric, the CSV Traffic will now be set for the **CSV Cluster** network because it's the lowest metric.

The other change you would want to do is change the network that's set for the **Live Migration network**. To do this, go to **Failover Management**, highlight any guest, then under the **Summary** section, right-click the guest and select **Properties** of that VM. It doesn't matter which guest as this is a single global setting. Once you get into the **Properties**, go to the **Live Migration Network** tab. In here, uncheck the **Host Access Cluster** network and select the **CSV-LM Cluster** (if this was only network added) or the **LM Cluster** (if you added two networks for this). This can all be done on the fly and is an immediate change. There would be no reboots or restarts necessary.

Once this is all done, you would then test by placing all CSV disks into redirected mode to see how the network handles the redirected I/O traffic. You do this in Windows 2008 R2 failover manager. Under the **Cluster Shared Volumes** node on the **Summary** page, right-click each cluster disk, select **More actions**, then select **Turn on redirected access for this cluster shared volume**. You can monitor I/O using task manager, performance, networking tab.

Keep in mind that when the drives are in redirected mode, the clients may get a little sluggish on the VMs but it should not be to the extent that a node is removed from the cluster due to loss of network connectivity, or clients cannot connect to the running guests in redirected mode. Once you confirm redirected mode works, turn off redirected mode for all CSV disks and start taking DPM backups and see if you run into any issues.

Before backups can be taken using the VSS provider, you must also enable serialization. See [Considerations for Backing Up Virtual Machines on CSV with the System VSS Provider](/previous-versions/system-center/data-protection-manager-2010/ff634192(v=technet.10)?redirectedfrom=MSDN) for more information.

## More information

You can also configure DPM 2010 to use a dedicated backup network to isolate backup data from going over the client access network. For more information, see [Using Backup Network Address](/previous-versions/system-center/data-protection-manager-2007/cc964298(v=technet.10)?redirectedfrom=MSDN).

The following links contain useful information about DPM 2010 protection of Hyper-V guests.

- [Managing Hyper-V Computers](/previous-versions/system-center/data-protection-manager-2010/ff399446(v=technet.10)?redirectedfrom=MSDN)
- [Understanding Protection for CSV](/previous-versions/system-center/data-protection-manager-2010/ff634189(v=technet.10)?redirectedfrom=MSDN)

The following links contain useful information on Cluster Shared Volumes and network considerations.

- [Requirements for Using Cluster Shared Volumes in a Failover Cluster in Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff182358(v=ws.10)?redirectedfrom=MSDN)
- [Hyper-V: Using Live Migration with Cluster Shared Volumes in Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd446679(v=ws.10)?redirectedfrom=MSDN)
