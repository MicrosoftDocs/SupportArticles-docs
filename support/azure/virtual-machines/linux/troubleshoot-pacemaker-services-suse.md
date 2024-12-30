---
title: Troubleshoot startup issues in a SUSE Pacemaker cluster
description: Provides troubleshooting guidance for Pacemaker services that don't start
ms.reviewer: rnirek,rmuneer
ms.topic: troubleshooting
ms.date: 07/24/2024
ms.service: azure-virtual-machines
ms.collection: linux
ms.custom: sap:Issue with Pacemaker clustering, and fencing
ms.author: rnirek
author: rnirek
---

# Troubleshoot startup issues in a SUSE Pacemaker cluster

**Applies to:** :heavy_check_mark: Linux VMs

This article lists the common causes of Pacemaker service startup issues and provides resolutions to fix them.

## Scenario 1: Pacemaker startup failure because of SysRq-triggered reboot

The Pacemaker service doesn't start if the last startup was triggered by a SysRq action. The Pacemaker service can start successfully after a normal restart. This issue is caused by a conflict between the STONITH Block Device (SBD) `msgwait` time and the fast restart time of these Azure virtual machines (VMs), as specified in the `/etc/sysconfig/sbd` file:

```output
## Type: yesno / integer
## Default: no
#
# Whether to delay after starting sbd on boot for "msgwait" seconds.
# This may be necessary if your cluster nodes reboot so fast that the # other nodes are still waiting in the fence acknowledgement phase.
# This is an occasional issue with virtual machines.
#
# This can also be enabled by being set to a specific delay value, in # seconds. Sometimes a longer delay than the default, "msgwait", is # needed, for example in the cases where it's considered to be safer to 
# wait longer than:
# corosync token timeout + consensus timeout + pcmk_delay_max + msgwait # # Be aware that the special value "1" means "yes" rather than "1s".
#
# Consider that you might have to adapt the startup-timeout accordingly # if the default isn't sufficient. (TimeoutStartSec for systemd) # # This option may be ignored at a later point, once Pacemaker handles 
# this case better.
SBD_DELAY_START=no
```
### Resolution

1. Put the cluster into maintenance-mode:

   ```bash
   sudo crm configure property maintenance-mode=true
   ```
2. Edit the `/etc/sysconfig/sbd` file to change the `SBD_DELAY_START` parameter to `yes`.

3. Remove the cluster from maintenance mode:

   ```bash
   sudo crm configure property maintenance-mode=false
   ```
4. Restart the Pacemaker and SDB services, or restart both nodes:

   ```bash
   sudo systemctl restart sbd
   sudo systemctl restart Pacemaker
   ```

## Scenario 2:  Pacemaker doesn't start and returns code 100 after node fencing

After the cluster node is fenced, the Pacemaker service exits without starting and returns an exit status code of **100**.

   ```bash
   systemctl status Pacemaker.service
   
   ● Pacemaker.service - Pacemaker High Availability Cluster Manager
      Loaded: loaded (/usr/lib/systemd/system/Pacemaker.service; enabled; vendor preset: disabled)
      Active: inactive (dead) since Wed 2020-05-13 23:38:21 UTC; 25s ago
        Docs: man:Pacemakerd
              https://clusterlabs.org/Pacemaker/doc/en-US/Pacemaker/1.1/html-single/Pacemaker_Explained/index.html
    Main PID: 1570 (code=exited, status=100)
   ```

### Cause

If a node tries to rejoin the cluster after it's fenced but before the `msgwait` time-out finishes, the Pacemaker service doesn't start. Instead, the service returns an exit status code of **100**. To resolve the issue, enable the `SBD_DELAY_START` setting, and specify an `msgwait` delay for the startup of sbd.service. This allows more time for the node to rejoin the cluster, and it makes sure that the node can rejoin without experiencing the `msgwait` conflict. 

Notice that if the `SBD_DELAY_START` setting is used, and the SBD `msgwait` value is very high, other potential issues might occur. For more information, see [Settings for long timeout in SBD_DELAY_START](https://www.suse.com/support/kb/doc/?id=000019356).

### Resolution 1:

1. Put the cluster into maintenance-mode:

   ```bash
   sudo crm configure property maintenance-mode=true
   ```

2. Edit the `/etc/sysconfig/sbd` file to change the `SBD_DELAY_START` parameter to `yes`.

3. Make a copy of `sbd.service`:

   ```bash
   cp /usr/lib/systemd/system/sbd.service /etc/systemd/system/sbd.service
   ```

4. Edit `/etc/systemd/system/sbd.service` to add the following lines in the `[Unit]` and `[Service]` section:

   ```bash
   [Unit]
   Before=corosync.service
   [Service]
   TimeoutSec=144
   ```

5. Remove the cluster from maintenance-mode:

   ```bash
   sudo crm configure property maintenance-mode=false
   ```

6. Restart the Pacemaker and SDB services, or restart both nodes:

   ```bash
   sudo systemctl restart sbd
   sudo systemctl restart Pacemaker
   ```

### Resolution 2:
Tweak the SDB device `msgwait` time-out setting to be shorter than the time that's required for the SBD fencing action to finish and the `sbd.service` to be restored after a restart. Edit the `watchdog` parameter to be 50 percent of new `msgwait` time-out value. This is a process of optimization that must be tuned on a system-by-system basis.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
