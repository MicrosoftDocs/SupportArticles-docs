---
title: Cloud-init enabled deployment takes more than 120 seconds to start| Microsoft Docs
description: Troubleshoot Cloud-init enabled deployment takes more than 120 seconds to start
author: srijang
ms.service: virtual-machines
ms.topic: troubleshooting
ms.date: 02/01/2022
ms.author: srijangupta

---

# Cloud-init enabled deployment takes more than 120 seconds to start

## Symptoms

-	Rebooting VM takes over 120 Seconds to complete which is the cloud-init time wait setting for the ephemeral disk. This affects VM SKUs that do not provide, local, ephemeral disks:  (Ev4,Esv4-series ), ((Dv5,Dsv5-series ), ((Dasv5,Dadsv5-series ), ((DCasv5 and DCadsv5-series confidential )

Check /var/log/cloud-init.log/ /var/log/waagent.log/ (Init stage), you should see the following:

```
# grep "did not appear after 120 seconds"  *

cloud-init.log:2021-12-01 19:35:50,455 - DataSourceAzure.py[WARNING]: ephemeral device '/dev/disk/cloud/azure_resource' did not appear after 120 seconds.
cloud-init.log:2021-12-01 21:19:58,531 - DataSourceAzure.py[WARNING]: ephemeral device '/dev/disk/cloud/azure_resource' did not appear after 120 seconds.
cloud-init-output.log:2021-12-01 19:35:50,455 - DataSourceAzure.py[WARNING]: ephemeral device '/dev/disk/cloud/azure_resource' did not appear after 120 seconds.
cloud-init-output.log:2021-12-01 21:19:58,531 - DataSourceAzure.py[WARNING]: ephemeral device '/dev/disk/cloud/azure_resource' did not appear after 120 seconds.
messages:Dec  1 19:35:50 redhat84noephstor01 cloud-init[1065]: 2021-12-01 19:35:50,455 - DataSourceAzure.py[WARNING]: ephemeral device '/dev/disk/cloud/azure_resource' did not appear after 120 seconds.
messages:Dec  1 21:19:58 redhat84noephstor01 cloud-init[931]: 2021-12-01 21:19:58,531 - DataSourceAzure.py[WARNING]: ephemeral device '/dev/disk/cloud/azure_resource' did not appear after 120 seconds.
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

## Root Cause
- Cloud-init, on boot, executes DataSourceAzure.py which waits for the local ephemeral disks (/mnt/azure_resource) to become available. The time out for this wait is 120 seconds after which the boot process continues.


## Resolution
- The bug is resolved in cloud-init-21.2 or later.
- If cloud-init--21.2 or later is not available the time out can be reduced in DataSourceAzure.py: ` sudo sed -i 's/maxwait=120/maxwait=2/g' $(locate DataSourceAzure.py) `

