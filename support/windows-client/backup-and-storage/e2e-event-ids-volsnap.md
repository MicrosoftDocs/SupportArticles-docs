---
title: e2e Event IDs for Volsnap 
description: Lists the event IDs for Volsnap 
ms.date: 09/21/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Volume Shadow Copy Service (VSS)
ms.technology: windows-client-backup-and-storage
---
# e2e: Event IDs for Volsnap

This article provides some information about Event IDs for Volsnap.

_Original product version:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3081408

## Summary

In Windows 10, Volsnap has Event Tracing for Windows (ETW) tracing and flexible event logging. These features may be useful in the following scenarios:

- Recording statistics about mounting. For example, when you encounter an issue in which bringing a volume online takes a long time, Volsnap frequently is implicated in the delay. Decent diagnostic information will be helpful in troubleshooting.

- Debugging or diagnosis of snapshot failures, especially in scenarios in which it is difficult to use the debugger.

The features also play into a larger effort to provide diagnosability in the storage stack for complex operations such as cluster online/offline and for end-to-end diagnostics of storage stack failures.

The new diagnostics consist of a set of new ETW events that are logged to the Operational channel. The operational channel receives low-volume events that describe important events during infrequent large operations, such as volume online, volume offline, and so on.

In Windows 10, Volsnap also changes the way it logs to the System log. The legacy `IoWriteErrorLogEntry` API is no longer used. Instead, Volsnap imports the System log as an ETW channel and redefines its current complement of System events to provide richer information, as required.

Finally, Volsnap supports the acquisition and transfer of activity IDs.

## Possible events for Volsnap

For the Operational channel, the following are all the possible events.

- 500 Completing a failed upper-level read request

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-500.png" alt-text="Event 500.":::

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-id-500.png" alt-text="Event ID 500.":::

- 501 Completing a failed upper-level write request

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-501.png" alt-text="Event 501.":::

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-id-501.png" alt-text="Event ID 501.":::

- 503 Completing a failed upper-level paging write request

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-503.png" alt-text="Event 503.":::

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-id-503.png" alt-text="Event ID 503.":::

- 504 Completing a failed IOCTL request

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-504.png" alt-text="Event 504.":::

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-id-504.png" alt-text="Event ID 504.":::

- 505 Completing a failed Read SCSI SRB request

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-505.png" alt-text="Event 505.":::

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-id-505.png" alt-text="Event ID 505.":::

- 506 Completing a failed Write SCSI SRB request

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-506.png" alt-text="Event 506.":::

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-id-506.png" alt-text="Event ID 506.":::

- 507 Completing a failed non-ReadWrite SCSI SRB request

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-507.png" alt-text="Event 507.":::

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-id-507.png" alt-text="Event ID 507.":::

- 508 Completing a failed non-SCSI SRB request

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-508.png" alt-text="Event 508.":::

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-id-508.png" alt-text="Event ID 508.":::
- 509 Completing a failed PNP request

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-509.png" alt-text="Event 509.":::

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-id-509.png" alt-text="Event ID 509.":::

- 510 Completing a failed Power request

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-510.png" alt-text="Event 510].":::

    :::image type="content" source="./media/e2e-event-ids-volsnap/event-id-510.png" alt-text="Event ID 510.":::

- 511 Completing a failed WMI request  

## In earlier versions of Windows

In earlier versions of Windows, Volsnap had limited diagnostic features. Although it can log 42 different event messages, the routines that produce them are limited to providing up to two strings that represent volume names. The messages were logged by using the older API `IoWriteErrorLogEntry`. There was also a custom logging facility that was shared between Volsnap and various other components of VSS. In this custom logging, diagnostic data was written to the registry under `HKEY_LOCAL_MACHINE\SYSTEM\CCS\Services\vss\Diag`.

![Registry key image](./media/e2e-event-ids-volsnap/registry-key.png)

This mechanism was specific to the Volume Shadow Copy Service (VSS). Therefore, it required custom tools, such as VSS Reports, to extract the information. Also, it retained only the most recent instance of any given diagnostic message.

> [!NOTE]
> The legacy method of VSS logging is still used in Windows 10 because the ETW addition does not provide a complete replacement.
