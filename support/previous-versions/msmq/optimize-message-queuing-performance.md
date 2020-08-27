---
title: Optimize Message Queuing performance
description: This article describes how to optimize Message Queuing (MSMQ) performance through the operating system.
ms.date: 07/23/2020
ms.prod-support-area-path: 
---
# Optimize Message Queuing (MSMQ) performance

This article describes how to optimize Microsoft Message Queuing (MSMQ) performance through the operating system.

_Original product version:_ &nbsp; Microsoft Message Queuing  
_Original KB number:_ &nbsp; 199428

## Summary

The speed with which your MSMQ Enterprise operates is largely dependent upon physical factors such as hardware, bandwidth, and so forth. It is also largely dependent on how your MSMQ applications are written. However, you can also optimize MSMQ performance through the operating system.

## More information

On a Windows NT computer, right-click on **My Computer**, click **Properties**, click the **Performance** tab, and make sure the **Application Performance Boost** is set to **None**. On the **Performance** tab, you can also increase the size of the paging file. Refer to the Windows NT Performance Monitor Help to determine if your computer is experiencing excessive paging.

If your computer has multiple drives, use the **Message Queue** applet in the Control Panel to select locations for the **Message Files** folder and **Message Logger** folder. For optimal performance, specify separate drives for the **Message Files** folder and **Message Logger** folder. If your computer uses disk striping with parity (RAID 5), specify that your **Message Files** folder and **Message Logger** folder are on the striped drive.

Put the Message Queue Information Service (MQIS) database files on different hard drives (that is, not on the drives used for messages files) also improves performance because disk activity for MQIS queries and messaging can be done in parallel. For large MQIS database (that is, much larger than the default 80/20), separating the drives used for the database data file and log file might also improve performance.

Be aware that auditing MSMQ operations and users from MSMQ Explorer will have a significant negative impact on MSMQ performance. The negative performance impact of using auditing largely depends on your specific security requirements. However, you can enable and disable auditing at run time using MSMQ Explorer and you can fine-tune it to your specific needs. You should do performance benchmarks in a lab environment on all proposed configurations prior to deployment.

You should perform performance benchmarks prior to using MSMQ and again when both MSMQ and your application are running. An optimally designed MSMQ application requires only a few percent more average CPU processor utilization than without the MSMQ application running.

You can use Performance Monitor to monitor MSMQ Queue, MSMQ Service, and MSMQ IS objects and their counters.
