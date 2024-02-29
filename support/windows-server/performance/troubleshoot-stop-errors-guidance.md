---
title: Guidance for troubleshooting stop errors and unexpected restart.
description: Introduces general guidance for troubleshooting scenarios related to stop errors and unexpected restart.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
---
# Stop errors and unexpected restart troubleshooting guidance

<p class="alert is-flex is-primary"><span class="has-padding-left-medium has-padding-top-extra-small"><a class="button is-primary" href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806236" target='_blank'><b>Try our Virtual Agent</b></a></span><span class="has-padding-small"> - It can help you quickly identify and fix common Windows boot issues</span>

This solution is designed to help you troubleshoot Stop error scenarios.

There's no simple explanation for the cause of Stop errors (also known as blue screen errors or bug check errors). Many factors might be involved, and the cause is not always obvious. For example, you might be using new hardware or third-party software that isn't compatible with your Windows device.

## Troubleshooting checklist

1. Review the Stop error codes that you find in the event log. Search online for the specific Stop error codes to see whether there are any known issues, resolutions, or workarounds for the issue.
2. Make sure that the hard disk has sufficient free space. Although the space requirement can vary, we recommend that the disk have 10 to 15 percent free space.
3. Contact the respective hardware or software vendor to update the drivers and applications in the following scenarios:

   - The error message indicates that a specific driver is causing the problem.
   - You are seeing an indication of a service that is starting or stopping before the failure occurred. In this situation, determine whether the service behavior is consistent across all instances of the failure.
   - You have made any software or hardware changes.

4. Make sure that you install the latest Windows updates, cumulative updates, and rollup updates.
5. Make sure that the BIOS and firmware are up-to-date.
6. Run any relevant hardware and memory tests.
7. Run [Microsoft Safety Scanner](https://www.microsoft.com/security/scanner/en-us/default.aspx) or any other virus detection program that includes checks of the Master Boot Record for infections.

## Common issues and solutions

### Bug check code: KMODE_EXCEPTION_NOT_HANDLED

Stop error code:  
> 0x0000001E

If a driver is identified in the Stop error message, disable or remove that driver. Disable or remove any drivers or services that were recently added. If the error occurs during the startup sequence, and the system partition is formatted by using the NTFS file system, you might be able to use Safe mode to disable the driver in Device Manager. To do this, follow these steps:

1. Go to **Settings** > **Update & security** > **Recovery**. Under **Advanced startup**, select **Restart now**.
2. After your PC restarts to the **Choose an option** screen, select **Troubleshoot** > **Advanced options** > **Startup Settings** > **Restart**.
3. After the computer restarts, you'll see a list of options. Press 4 or F4 to start the computer in Safe mode. Or, if you intend to use the internet while in Safe mode, press 5 or F5 for the **Safe Mode with Networking** option.

### Bug check code: MEMORY_MANAGEMENT

Stop error code:  
> 0x0000001A

When you troubleshoot this issue, running the Windows Memory Diagnostic tool could be useful to exclude any kind of problem that affects the physical memory modules. See [Bug Check 0x1A: MEMORY_MANAGEMENT](/windows-hardware/drivers/debugger/bug-check-0x1a--memory-management).

### Bug check code: SYSTEM_SERVICE_EXCEPTION

Stop error code:  
> 0x0000003B

This error code indicates that the executing code had an exception, and the thread that was below it is a system thread. Follow these steps:

1. If new device drivers or system services have been added recently, try removing or updating them. 
2. Look in Device Manager to see whether any devices are marked with an exclamation point (!) to indicate a problem. Review the events log that's displayed in the properties for any faulting device driver. Try to update the related driver.
3. Check the System Log in Event Viewer for additional error messages that might help pinpoint the device or driver that's causing the error. Look for critical errors in the system log that occurred around the same time as the Stop error.
4. If you recently added hardware to the system, try removing or replacing it. Or check with the manufacturer to see whether any updates are available.

### Bug check code: DRIVER_IRQL_NOT_LESS_OR_EQUAL

Stop error code:  
> 0x000000D1

This error code indicates that a driver has tried to access an address that's pageable (or that's completely invalid) while the interrupt request level (IRQL) was too high. This can be caused by the following actions:

- Dereferencing a bad pointer (such as a NULL or freed pointer) while executing at or above DISPATCH_LEVEL.
- Accessing pageable data at or above DISPATCH_LEVEL.
- Executing pageable code at or above DISPATCH_LEVEL.

> [!NOTE]
> If a driver that's responsible for the error can be identified, its name is displayed on screen.

To troubleshoot this issue, check the System log in Event Viewer for additional error messages that might help identify the device or driver that's causing this Stop error. If a driver is identified in the error message, disable the driver or check with the manufacturer for driver updates. Verify that any new hardware that's installed is compatible with the installed version of Windows.

### Bug check code: DRIVER_POWER_STATE_FAILURE

Stop error code:  
> 0x0000009F

This error code indicates that the driver is in an inconsistent or invalid power state. Follow these steps:

1. If new device drivers or system services have been added recently, try removing or updating them. Try to determine what changed in the system that caused the new error code to appear.
2. Look in Device Manager to see if any devices are marked with the exclamation point (!). Review the event log that's displayed in the driver properties window for any faulting driver. Try updating the related driver.
3. Check the system log in Event Viewer for additional error messages that might help pinpoint the device or driver that is causing the error. For more information, see Open Event Viewer. Look for critical errors in the system log that occurred in the same time window as the blue screen.
4. To isolate the cause, temporally disable power saving by using the Power Options item in Control Panel. Some driver issues are related to the various states of system hibernation and the suspending and resumption of power.
5. If you recently added hardware to the system, try removing or replacing it. Or check with the manufacturer to see if any patches are available.
6. You can try running the hardware diagnostics supplied by the system manufacturer.
7. Check with the manufacturer to see whether an updated system ACPI/BIOS or other firmware is available.

For advanced debugging, see [Bug Check 0x9F](/windows-hardware/drivers/debugger/bug-check-0x9f--driver-power-state-failure#resolution).

### Bug check code: SYSTEM_THREAD_EXCEPTION_NOT_HANDLED

Stop error code:  
> 0x0000007E

This error code indicates that a system thread generated an exception that the error handler didn't catch. To interpret it, you must identify which exception was generated. Follow these steps:

1. Check the system log in Event Viewer for additional error messages that might help identify the device or driver that's causing Stop error 0x7E.
2. If a driver is identified in the error message, disable the driver or check with the manufacturer for driver updates.
3. Check with your hardware vendor for any ACPI or other firmware updates. Hardware issues, such as system incompatibilities, memory conflicts, and IRQ conflicts can also generate this error.
4. You can also disable memory caching (shadowing) of the BIOS to try to resolve the error. Also run hardware diagnostics that the system manufacturer supplies.
5. Verify that any added hardware is compatible with the installed version of Windows.

### Bug check code: Inaccessible_Boot_Device

Stop error code:  
> 0x0000007B

To troubleshoot this issue, see [Advanced troubleshooting for Stop error 7B or Inaccessible_Boot_Device](/windows/client-management/troubleshoot-inaccessible-boot-device).

## Data collection

Before contacting Microsoft support, you can gather information about your issue.

### Prerequisites

1. TSS must be run by accounts with administrator privileges on the local system, and EULA must be accepted (once EULA is accepted, TSS won't prompt again).
2. We recommend the local machine `RemoteSigned` PowerShell execution policy.

> [!NOTE]
> If the current PowerShell execution policy doesn't allow running TSS, take the following actions:
>
> - Set the `RemoteSigned` execution policy for the process level by running the cmdlet `PS C:\> Set-ExecutionPolicy -scope Process -ExecutionPolicy RemoteSigned`.
> - To verify if the change takes effect, run the cmdlet `PS C:\> Get-ExecutionPolicy -List`.
> - Because the process level permissions only apply to the current PowerShell session, once the given PowerShell window in which TSS runs is closed, the assigned permission for the process level will also go back to the previously configured state.

### Gather key information before contacting Microsoft support

1. Download [TSS](https://aka.ms/getTSS) on all nodes and unzip it in the *C:\\tss* folder.
2. Open the *C:\\tss* folder from an elevated PowerShell command prompt.
3. Start the following traces on the problem computer by using the following cmdlet:

    ```PowerShell
    TSS.ps1 -SDP PERF,SETUP
    ```

4. Respond to the EULA prompt.
5. Wait until the automated scripts finish collecting the required data.

The traces will be stored in a zip file in the *C:\\MS_DATA\\SDP_PERFSETUP\\* folder, which can be uploaded to the Microsoft workspace for analysis.

## Reference

- [Advanced troubleshooting for Stop error or blue screen error issue](/windows/client-management/troubleshoot-stop-errors)

  - [Advanced troubleshooting steps](/windows/client-management/troubleshoot-stop-errors#advanced-troubleshooting-steps)
  - [Advanced troubleshooting using Driver Verifier](/windows/client-management/troubleshoot-stop-errors#advanced-troubleshooting-using-driver-verifier)

- Page file settings

  - [Introduction to page files](/windows/client-management/introduction-page-file)
  - [Determine the appropriate page file size](/windows/client-management/determine-appropriate-page-file-size)

- [Generate a kernel or complete crash dump](/windows/client-management/generate-kernel-or-complete-crash-dump)
- [Configure system failure and recovery options in Windows](/windows/client-management/system-failure-recovery-options)
- [Windows clients performance troubleshooting documentation](../../windows-client/performance/performance-overview.md)
