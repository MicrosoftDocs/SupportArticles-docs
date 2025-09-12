---
title: The Disable Port Monitoring task doesn't work
description: Fixes a problem that prevents port monitoring for a network port device from being disabled as expected when you run the Disable Port Monitoring task.
ms.date: 04/15/2024
ms.reviewer: robertri, lloydg
---
# Port monitoring isn't disabled when you run the Disable Port Monitoring task

This article provides a workaround for an issue that port monitoring for a network port device isn't disabled when you run the **Disable Port Monitoring** task.

_Original product version:_ &nbsp; Microsoft System Center 2012 Operations Manager, System Center 2012 R2 Operations Manager  
_Original KB number:_ &nbsp; 2960230

## Symptoms

When you run the **Disable Port Monitoring** task to disable monitoring of a network port device, port monitoring for that device isn't disabled as expected.

## Cause

This problem occurs if the port is a member of the Managed Computer Network Adapters group.

For example, this problem occurs under the following circumstances:

- The tasks for enabling and disabling port monitoring adds the port to the Critical Network Adapters group.
- Earlier, the port was added to the Managed Computer Network Adapters group because the computer that's attached to the port is being monitored (a process that's known as port stitching).
- The logic to determine whether a port is monitored checks whether the port is in any of the groups under **Group** of all network interfaces being actively monitored. These include the following groups:
  - Advanced Network Adapters group
  - Critical Network Adapters group (to which the enable/disable task adds the port)
  - Managed Computer Network Adapters group (to which the port is added through port stitching)
  - Relay Network Adapters group

Therefore, the port is still being actively monitored because it's a member of the Managed Computer Network Adapters group.

## Workaround

To disable monitoring on a particular port, regardless of the group membership of that port, follow these steps:

1. Select the port to disable, and then open Health Explorer.
2. In Health Explorer, select the top-level item that's named **Entity Health - *port_name* (Object)**.
3. In the Health Explorer window's toolbar, select **Disable this Monitor** on the **Overrides** menu, and then select **For the object: *port_name***.
4. In the **Override Properties** dialog box, make sure that the **Enabled** property override is set to **False**. Select a management pack to save this override (or create a new one), and then click **OK**.

To automatically disable monitoring by using PowerShell, run the following script in the System Center Operations Manager snap-in:

```powershell
$port = Get-SCOMMonitoringObject -DisplayName "SOME_DEVICE"
$monitorsToOverride = Get-SCOMMonitor -Recurse -Instance $port
$mp = Get-SCOMManagementPack -DisplayName "PORT_OVERRIDES_MP"
$monitorsToOverride | ForEach-Object {Disable-SCOMMonitor -Monitor $_ -Instance $port -ManagementPack $mp}
```

> [!NOTE]
> The `Get-SCOMMonitoringObject` command may return many objects, depending on the display name that's provided. Therefore, make sure that `$port` contains only one object. Then, customize the `Get-SCOMManagementPack` call to retrieve the management pack overrides. We recommend that you use a new management pack because the management pack can easily be deleted if something unexpected occurs.

## More information

Learn about the **What Gets Monitored** section in [What Gets Monitored with System Center Operations Manager 2012 Network Monitoring](https://techcommunity.microsoft.com/t5/system-center-blog/what-gets-monitored-with-system-center-operations-manager-2012/ba-p/343930).
