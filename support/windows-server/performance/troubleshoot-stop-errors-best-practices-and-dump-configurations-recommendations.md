---
title: 'Troubleshoot stop errors: Best practices and dump configurations recommendations'
description: Introduces what happens during a stop error and best practices to prevent and troubleshoot stop error issues.
ms.date: 10/25/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom: sap:System Performance\System Reliability (crash, errors, bug check or Blue Screen, unexpected reboot), csstroubleshoot
---
# Troubleshoot stop errors: best practices and dump configurations recommendations

This article introduces what Windows does when a Blue Screen occurs. Additionally, the article provides some best practices on preventing and troubleshooting Blue Screen issues.

## What happens when a stop error happens

The Operating System (OS) is monitoring itself continuously to verify that it runs within the expected parameters. If this isn't the case, the OS calls the kernel function **KeBugCheckEx** to restart to recover from such an unhealthy scenario. For more information, see [KeBugCheckEx function (wdm.h)](/windows-hardware/drivers/ddi/wdm/nf-wdm-kebugcheckex). The **KeBugCheckEx** function then triggers the stop error (also known as Bug Check, Blue Screen of Death, Dump) and restart the computer.

The following sections use the issue described in [Bug Check 0x50: PAGE_FAULT_IN_NONPAGED_AREA](/windows-hardware/drivers/debugger/bug-check-0x50--page-fault-in-nonpaged-area) to explain what happens when a stop error occurs.

### Example for stop error 0x50

This stop error occurs in the following scenario:

The OS is trying to reference a part of memory that should be available in physical Random Access Memory (RAM). However, when OS accesses that memory, the memory couldn't be found and a page fault occurs.

This is violating the parameters for a healthy OS. Therefore, the OS calls KeBugCheckEx to shut down the OS in a controlled manner to prevent further damage to the OS.

Within this stop error process, there are three phases.

### Phase 1: Monitoring system (ongoing)

During this phase, the kernel continuously monitoring the system. In addition, during every startup, the session manager is reading the configuration from the registry key `HKLM\SYSTEM\CurrentControlSet\Control\CrashControl` for the dump configuration.

When the OS detects an unhealthy OS status, the KeBugCheckEx function is called.

### Phase 2: Stop error

During the stop error phase the OS, continue with the following steps in phase 2.

Display this blue status screen. (This is the reason why the stop error is called blue screen.)

:::image type="content" source="media/troubleshoot-stop-errors-best-practices-and-dump-configurations-recommendations/the-screenshot-of-the-blue-screen.png" alt-text="The screenshot of the blue screen.":::

In the screenshot, you can see the specific stop code at the black rectangle number 1. This stop code can help you to identify first steps by checking the [Bug Check Code Reference](/windows-hardware/drivers/debugger/bug-check-code-reference2). In Windows, there are over 300 different stop codes, and each is documented in detail in the article.

At the black rectangle number 2, you can see the progress of moving RAM to page file. This operation is based on configuration in CrashControl that was read during the boot of the system.

On large systems, this process can take some time. Let´s explain this by using a specific scenario.

Imaging that you have a system that has 1,024 GB of RAM. A typical Hard Disk Drive (HDD) has a disk I/O speed of up to 100 MB per second, while a Solid State Drive (SSD) can achieve speeds of up to 500 MB. When the OS generates a complete dump, check the following table for the time it takes based on disk configuration:

| Disk Type | Disk speed | Time to write a dump in seconds (minutes) |
| :-------- | :--------- | :---------------------------------------- |
| HDD       | 100 MB/sec | 10,485 sec (~175 min)                     |
| SSD       | 500 MB/sec | 2,097 sec (~35 min)                       |

> [!NOTE]
> In a physical system, the computer Basic Input-Output System (BIOS) might have the Automated system recovery (ASR) feature. This feature periodically check if Windows is running. When the check fails, the feature initiates a power reset to recover the system. This behavior interrupts the dump process because Windows and its services are no longer running during phase 2.

At the black rectangle number 3, you can see a potential hint on what was involved in the crash. If the message is about a driver or software, checking for an update is a valid option.

Once the process of moving RAM to the page file has been completed, the page file is marked as a dump. In the final step, the system then is restarted (based on the configuration) to complete phase 2 and go to phase 3.

### Phase 3: Dump creation

During boot of the OS, the session manager process (SMSS.exe) loads the page file. Because the page file was marked as a dump, the SMSS.exe then extract the dump from the page file. The boot process might take longer than expected because the page file can be large. The last step of phase 3 is to log an event, with event ID 1001, Level: Error, and Source: BugCheck in the System event log:

:::image type="content" source="media/troubleshoot-stop-errors-best-practices-and-dump-configurations-recommendations/screenshot-of-the-event-id-1001.png" alt-text="Screenshot of the event ID 1001.":::

> [!IMPORTANT]
> This event also contains the specific stop code including the parameters (see black rectangle 1 in the picture). You can use this information in our public documentation to learn more about the bug check and its meaning in at [Bug Check Code Reference](/windows-hardware/drivers/debugger/bug-check-code-reference2).
>
> In addition, you can also see the dump location (see black rectangle 2 in the picture).

## Best practices for troubleshooting and preventing stop errors

In most scenarios, you can use the following steps to resolve a stop error.

### Ensure you're running on the latest patch for the OS

Microsoft is releasing patches to any supported OS monthly on every second Tuesday (Patch cycle). Those patches contain improvements for security and reliability. We recommended you install them soon after release.

### Ensure your software and drivers are up to date

Microsoft is working closely with our partners to ensure that their products are also working within the parameter of a healthy OS. When a stop error is reported to Microsoft and our support has identified this to be related to a specific driver or software, Microsoft notifies them. This normally results in an update of their software. Therefore, we recommend you keep software updated.

### Consider updating to the latest version of the OS

Sometimes improvements of Windows can't be shipped as part of an update and is only shipped as part of a new release of the OS. If you have updated the OS, software and the drivers, an upgrade of the OS might be a valid approach.

### Self-help via stop code reference

Within the [Bug Check Code Reference](/windows-hardware/drivers/debugger/bug-check-code-reference2), Microsoft provide guidance and recommendations based on the specific stop code. The article is a great place for information and a strong recommendation to check your specific bug check code against the reference. Microsoft is ware that this might be a complex solution and if you do need more help, open a support case with Microsoft. Ensure that you have a memory dump available to speed up the resolution.

### No dump is generated

To ensure the OS can capture a dump, please follow this recommendation.

## Recommended Dump configuration

This recommendation depends on the size of the system as the RAM and the hard disk space have a direct impact on our recommendation.

### Systems memory up to 32 GB

1. Ensure that page file is set to RAM + 300 MB.
2. Ensure that the system is set to a [complete dump](memory-dump-file-options.md#complete-memory-dump):
   Navigate to `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\CrashControl`, and set **CrashDumpEnabled** to **0x1**.

Ensure that you have enough disk space for the Pagefile + memory.dmp

### Systems memory over 32 GB

1. Ensure that page file is set to **System Managed**.
2. Ensure that the system is set to an [automatic memory dump](/windows-hardware/drivers/debugger/automatic-memory-dump):
   Navigate to `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\CrashControl` registry key, and set **CrashDumpEnabled** to **0x7**.

Normally, a kernel memory dump is smaller than 40 GB in most of the cases. The automatic dump in combination of a system managed page file is trying to ensure that the hard disk requirements are kept at a minimum. You still need to ensure that you have enough disk space for the Pagefile and the memory.dmp file.

If necessary, you can configure OS to save the dump file *%SystemRoot%\Memory.dmp* to a different location. For example, you can save the file to drive D, which is a second hard disk with enough disk space. To do so, follow these steps:

1. Navigate to `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\CrashControl` registry key
2. Set **DumpFile** to **d:\Memory.dmp**.

In addition, on large systems, ensure that ASR is disabled in the BIOS.
