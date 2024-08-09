---
title: Unable to start Pacemaker services in SUSE
description: Provides troubleshooting guidance for Pacemaker Services fail to start
ms.reviewer: rnirek,rmuneer
ms.topic: troubleshooting
ms.date: 07/24/2024
ms.service: virtual-machines
ms.collection: linux
ms.custom: sap:Issue with Pacemaker clustering, and fencing
ms.author: rnirek
author: rnirek
---

# Troubleshoot Pacemaker Service startup issues in SUSE Pacemaker cluster

**Applies to:** :heavy_check_mark: Linux VMs

This article lists the common causes of pacemaker services failed to start and provides resolutions for the issues.

## Create a Pacemaker cluster

To create a basic Pacemaker cluster in  SUSE Linux Enterprise Server (SLES) in Azure, follow the steps as documented [Set up Pacemaker on SUSE Linux Enterprise Server in Azure](/azure/sap/workloads/high-availability-guide-suse-pacemaker).

## Cause 1:
The pacemaker fails to start if a sysrq trigger action caused the last reboot. Manual graceful reboot works fine.

### Symptom:
A conflict between sbd msgwait time and the fast reboot time of these Azure VMs. Documented further in `/etc/sysconfig/sbd`:

```bash
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

1. Put the cluster under maintenance-mode:
```bash
sudo crm configure property maintenance-mode=true
```
2. Edit the `/etc/sysconfig/sbd` file and change `SBD_DELAY_START` parameter to `yes`.

3. Remove the cluster out of maintenance-mode.
```bash
sudo crm configure property maintenance-mode=false
```
4.Restart the pacemaker and sbd  service or reboot both nodes
```bash
sudo systemctl restart sbd
sudo systemctl restart pacemaker
```

## Cause 2:
After cluster node was fenced, pacemaker service is unable to start and exit with code 100.
```bash
systemctl status pacemaker.service

● pacemaker.service - Pacemaker High Availability Cluster Manager
   Loaded: loaded (/usr/lib/systemd/system/pacemaker.service; enabled; vendor preset: disabled)
   Active: inactive (dead) since Wed 2020-05-13 23:38:21 UTC; 25s ago
     Docs: man:pacemakerd
           https://clusterlabs.org/pacemaker/doc/en-US/Pacemaker/1.1/html-single/Pacemaker_Explained/index.html
 Main PID: 1570 (code=exited, status=100)
```

### Symptom:
If a node attempts to rejoin the cluster after it's fenced and before the msgwait timeout completes, `pacemaker.service` fails to start with an exit status of 100. Enabling the SBD_DELAY_START setting puts a "msgwait" delay on the startup of sbd.service. This increases for the node to rejoin, and ensures the node can rejoin without experiencing the msgwait conflict. 

Per SBD man page:

*-4 N Set msgwait timeout to N seconds. This should be twice the watchdog timeout. This is the time after which a message written to the node's slot will be considered delivered. (Or long enough for the node to detect that it needed to self-fence)*

If the SBD_DELAY_START setting is used, and SBD msgwait value is high there's a potential of two other issues:

1. The SBD service will timeout during start, as the SBD_DELAY_START might take longer than the default for system services in systemd.

2. The returning node starts corosync and results in  blocking the cluster services. The symptom looks like everything from a cluster perspective worked, for example fencing. But then "the surviving node waited until the fenced node returned."

The logs show entries similar to

```bash
 Dec 03 15:29:25 [3533] animal    pengine:   notice: LogActions: Start   fs_mysap   (animal - blocked)
```

You can check SBD msgwait time with the command:

```bash
sbd -d /dev/sdc dump
```

> [!NOTE]
> Here the sbd device is /dev/sdc. Add your appropriate SBD device that has been configured for STONITH purposes.

### Resolution 1:

1. Put the cluster under maintenance-mode:
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

5. Remove the cluster out of maintenance-mode.

```bash
sudo crm configure property maintenance-mode=false
```

6.Restart the pacemaker and sbd  service or reboot both nodes

```bash
sudo systemctl restart sbd
sudo systemctl restart pacemaker
```

### Resolution 2:
Tweak sbd device msgwait timeout shorter than the time it takes for SBD fencing action to complete and `sbd.service` to start up again after reboot. Modify `watchdog` parameter to 50% of new `msgwait` timeout. This is a process of optimization and must be tuned on a system-by-system basis.

## Next Steps

If you need more help, open a support request by using the following instructions:

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
