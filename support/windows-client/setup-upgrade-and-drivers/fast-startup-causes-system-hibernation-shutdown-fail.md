---
title: Fast startup causes hibernation or shutdown to fail in Windows 10 or Windows 8.1
description: Provides help to solve an issue where the process fails when you try to shut down or hibernate the system on a computer.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:power-management, csstroubleshoot
---
# Fast startup causes hibernation or shutdown to fail in Windows 10 or Windows 8.1

This article provides help to solve an issue where the process fails when you try to shut down or hibernate the system on a computer.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3211190

## Symptoms

When you try to shut down or hibernate the system on a computer that's running Windows 10 or Windows 8.1, the process fails and reverts to the Windows Lock screen.

Additionally, when you go to the **Details** tab in this event and then select friendly view, you may notice the following:

> Binary data:
>
> In Words
>
> 0000: 00000000 00000001 00000000 C004002D  
 0010: 00002005 C0000034 00000000 00000000  
 0020: 00000000 00000000
>
> C0000034 - means STATUS_OBJECT_NAME_NOT_FOUND
>
> C004002D - means IO_DUMP_DRIVER_LOAD_FAILURE

## Cause

This issue may occur if Fast Startup is enabled under **Control Panel\\All Control Panel Items\\Power Options\\System Settings**. When Fast Startup is enabled and a user shuts down the computer, all sessions are logged off, and the computer enters hibernation. As part of the hibernation process, Windows initializes the system's memory dump configuration. If the driver is not loaded, it fails to hibernate, and the event that's mentioned in the [Symptoms](#symptoms) section is logged. This brings you back to the Windows Lock screen.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see
[How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To resolve this issue, check whether event ID 45 is logged in the System log. If you see this event, verify the contents under the DumpFilters registry value:

1. Open the **Run** box. To do this, press the Windows logo key‌ + R.
2. Type *regedit*, and then press Enter.
3. Locate and click the following registry entry:  
    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\CrashControl\`

4. From the pane on the right, verify the contents under the DumpFilters registry value.
5. Remove everything and make sure that dumpfve.sys is the only value listed.
6. Exit Registry editor.
7. Restart the computer to enable Fast Startup.

## Workaround

If you want to shut down the computer without using the Hybrid Shutdown behavior, you can use Shutdown.exe instead. Full shutdown is the default when you use Shutdown.exe, as follows:

```console
Shutdown /s /t 0  
```

The Shutdown.exe command also includes an optional `/hybrid`  parameter that can be used if you want to use the new method:

```console
Shutdown /s /hybrid /t 0 
```

> [!NOTE]
>
> - The Fast Startup setting doesn't apply to Restart.
> - Fast Startup is enabled by default in Windows.
> - Disabling Fast Startup is not recommended.

## More information

During Fast Startup, the kernel session is not closed, but it is hibernated. Fast Startup is a setting that helps the computer start faster after shutdown. Windows does this by saving the kernel session and device drivers (system information) to the hibernate (hiberfil.sys) file on disk instead of closing it when you shut down the computer.

When you restart the computer, this typically means that you want a completely new Windows state, either because you have installed a driver or replaced Windows elements that cannot be replaced without a full restart.

Therefore, the restart process in Windows continues to perform a full boot cycle, without the hibernation performance improvement that's described in this article.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
