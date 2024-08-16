---
title: Unable to start Pacemaker services in SUSE
description: Provides troubleshooting guidance for Pacemaker Services fail to start
ms.reviewer: rnirek,rmuneer
ms.topic: troubleshooting
ms.date: 07/24/2024
ms.service: azure-virtual-machines
ms.collection: linux
ms.custom: sap:Issue with Pacemaker clustering, and fencing
ms.author: rnirek
author: rnirek
---

# Troubleshoot Pacemaker Service startup issues in SUSE Pacemaker cluster

**Applies to:** :heavy_check_mark: Linux VMs

This article lists the common causes of pacemaker service startup issues and provides resolutions to fix them.

## Scenario 1: Pacemaker Service startup failure due to SysRq triggered reboot

The pacemaker service fails to start if the previous reboot was triggered by a SysRq action. The pacemaker service can start successfully after a normal reboot. This issue is caused by a conflict exists between the SBD (STONITH Block Device) `msgwait` time and the fast reboot time of these Azure VMs, as specified in `/etc/sysconfig/sbd`:

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
# Consider that you might have to adapt the startup-timeout accordingly # if the default isn't sufficient. (TimeoutStartSec for systemd) # # This option may be ignored at a later point, once pacemaker handles 
# this case better.
SBD_DELAY_START=no
```
### Resolution:

1. Put the cluster into maintenance-mode:

   ```bash
   sudo crm configure property maintenance-mode=true
   ```
2. Edit the `/etc/sysconfig/sbd` file and change `SBD_DELAY_START` parameter to `yes`.

3. Remove the cluster from maintenance mode:
   ```bash
   sudo crm configure property maintenance-mode=false
   ```
4.Restart the pacemaker and SDB services or reboot both nodes:
   ```bash
   sudo systemctl restart sbd
   sudo systemctl restart pacemaker
   ```

## Scenario 2:  Pacemaker Service fails to start with code 100 after node fencing

After cluster node was fenced, the pacemaker service is unable to start and exit with code 100.

   ```bash
   systemctl status pacemaker.service
   
   ● pacemaker.service - Pacemaker High Availability Cluster Manager
      Loaded: loaded (/usr/lib/systemd/system/pacemaker.service; enabled; vendor preset: disabled)
      Active: inactive (dead) since Wed 2020-05-13 23:38:21 UTC; 25s ago
        Docs: man:pacemakerd
              https://clusterlabs.org/pacemaker/doc/en-US/Pacemaker/1.1/html-single/Pacemaker_Explained/index.html
    Main PID: 1570 (code=exited, status=100)
   ```

### Cause

If a node attempts to rejoin the cluster after it's fenced and before the `msgwait` timeout completes, the pacemaker service fails to start with an exit status of 100. To resolve the issue, enabling the `SBD_DELAY_START` setting puts a "msgwait" delay on the startup of sbd.service. This increases for the node to rejoin, and ensures the node can rejoin without experiencing the `msgwait` conflict. 

Note that if the `SBD_DELAY_START` setting is used, and SBD `msgwait` value is very high, two other potential problems might occur. For more information, see [Settings for long timeout in SBD_DELAY_START](https://www.suse.com/support/kb/doc/?id=000019356).

### Resolution 1:

1. Put the cluster into maintenance-mode:
   ```bash
   sudo crm configure property maintenance-mode=true
   ```

2.Edit the `/etc/sysconfig/sbd` file and change `SBD_DELAY_START` parameter to `yes`.

3. Make a copy of `sbd.service`

   ```bash
   cp /usr/lib/systemd/system/sbd.service /etc/systemd/system/sbd.service
   ```
4. Edit `/etc/systemd/system/sbd.service` and add the following lines in `[Unit]` and `[Service]` section:

```bash
   [Unit]
   Before=corosync.service
   [Service]
   TimeoutSec=144
```

5. Remove the cluster from maintenance-mode.

   ```bash
   sudo crm configure property maintenance-mode=false
   ```

6.Restart the pacemaker and SDB service or reboot both nodes:

   ```bash
   sudo systemctl restart sbd
   sudo systemctl restart pacemaker
   ```

### Resolution 2:
Tweak SDB device `msgwait` timeout shorter than the time it takes for SBD fencing action to complete and `sbd.service` to start up again after reboot. Modify `watchdog` parameter to 50% of new `msgwait` timeout. This is a process of optimization and must be tuned on a system-by-system basis.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]


