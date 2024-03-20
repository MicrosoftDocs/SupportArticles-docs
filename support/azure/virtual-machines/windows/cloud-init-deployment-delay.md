---
title: Cloud-init-enabled VM takes a long time to start up
description: Troubleshoot a cloud-init-enabled Azure Virtual Machine deployment that takes more than 120 seconds to start up.
editor: v-jsitser
ms.service: virtual-machines
ms.subservice: vm-deploy
ms.date: 02/03/2022
ms.reviewer: srijangupta, v-leedennis
---
# Cloud–init-enabled VM takes a long time to start up

This article describes how to troubleshoot an unexpected startup delay on an [Azure Virtual Machine (VM) that uses the cloud-init feature](/azure/virtual-machines/linux/using-cloud-init). This delay can cause a cloud-init-enabled Azure VM deployment to require more than two minutes (120 seconds) to start up.

## Symptoms

Starting an Azure VM takes more than two minutes to finish on VM products that don't provide local ephemeral disks, such as the following products:

- [Ev4 and Esv4-series](/azure/virtual-machines/ev4-esv4-series)
- [Dv5 and Dsv5-series](/azure/virtual-machines/dv5-dsv5-series)
- [Dasv5 and Dadsv5-series](/azure/virtual-machines/dasv5-dadsv5-series)
- [DCasv5 and DCadsv5-series confidential](/azure/virtual-machines/dcasv5-dcadsv5-series)

If you check log files such as */var/log/cloud-init.log* and */var/log/waagent.log* (init stage), you'll see output that resembles the following example:

```output
# grep "did not appear after 120 seconds"  *

cloud-init.log:2021-12-01 19:35:50,455 - DataSourceAzure.py[WARNING]: ephemeral device '/dev/disk/cloud/azure_resource' did not appear after 120 seconds.
cloud-init.log:2021-12-01 21:19:58,531 - DataSourceAzure.py[WARNING]: ephemeral device '/dev/disk/cloud/azure_resource' did not appear after 120 seconds.
cloud-init-output.log:2021-12-01 19:35:50,455 - DataSourceAzure.py[WARNING]: ephemeral device '/dev/disk/cloud/azure_resource' did not appear after 120 seconds.
cloud-init-output.log:2021-12-01 21:19:58,531 - DataSourceAzure.py[WARNING]: ephemeral device '/dev/disk/cloud/azure_resource' did not appear after 120 seconds.
messages:Dec  1 19:35:50 redhat84noephstor01 cloud-init[1065]: 2021-12-01 19:35:50,455 - DataSourceAzure.py[WARNING]: ephemeral device '/dev/disk/cloud/azure_resource' did not appear after 120 seconds.
messages:Dec  1 21:19:58 redhat84noephstor01 cloud-init[931]: 2021-12-01 21:19:58,531 - DataSourceAzure.py[WARNING]: ephemeral device '/dev/disk/cloud/azure_resource' did not appear after 120 seconds.
```

```output
# /var/log/cloud-init.log

2021-12-01 19:35:50,481 - util.py[WARNING]: Failed partitioning operation
Device /dev/disk/cloud/azure_resource did not exist and was not created with a udevadm settle.
2021-12-01 19:35:50,481 - util.py[DEBUG]: Failed partitioning operation
Device /dev/disk/cloud/azure_resource did not exist and was not created with a udevadm settle.
Traceback (most recent call last):
  File "/usr/lib/python3.6/site-packages/cloudinit/config/cc_disk_setup.py", line 141, in handle
    func=mkpart, args=(disk, definition))
  File "/usr/lib/python3.6/site-packages/cloudinit/util.py", line 2292, in log_time
    ret = func(*args, **kwargs)
  File "/usr/lib/python3.6/site-packages/cloudinit/config/cc_disk_setup.py", line 780, in mkpart
    assert_and_settle_device(device)
  File "/usr/lib/python3.6/site-packages/cloudinit/config/cc_disk_setup.py", line 
```

## Cause

During VM startup, [cloud-init](https://cloudinit.readthedocs.io) runs the *DataSourceAzure.py* file in Python, and then waits for the local ephemeral disks (*/mnt/azure_resource*) to become available. Because you're using an Azure VM that doesn't have local ephemeral disks, cloud-init must wait until the process times out. The timeout interval for ephemeral disks is 120 seconds before the startup process continues.

## Solution

Upgrade your copy of cloud-init to version 21.2 or a later version.

## Workaround

If you can't upgrade cloud-init to version 21.2 or a later version, you can edit the *DataSourceAzure.py* file to shorten the timeout value. The following example modifies the timeout value from 120 seconds to two seconds:

  ```bash
  sudo sed -i 's/maxwait=120/maxwait=2/g' $(locate DataSourceAzure.py)
  ```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
