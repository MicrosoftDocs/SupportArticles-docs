---
title: Event ID 41 The system has rebooted without cleanly shutting down first
description: Describes the circumstances that cause a computer to generate Event ID 41, and provides guidance for troubleshooting the issue.
ms.date: 12/26/2023
ms.topic: troubleshooting
author: Teresa-Motiv
ms.author: dougeby
manager: dcscontentpm
ms.custom: sap:System Performance\System Reliability (crash, errors, bug check or Blue Screen, unexpected reboot), errors, bug check or Blue Screen, unexpected reboot), csstroubleshooting, CI 111437
ms.reviewer: kaushika
audience: itpro
localization_priority: medium
ms.collection: highpri
---
# Advanced troubleshooting for Event ID 41: "The system has rebooted without cleanly shutting down first"

> [!NOTE]
> Home users: This article is intended for use by support agents and IT professionals. If you're looking for more information about blue screen error messages, please visit [Troubleshoot blue screen errors](https://support.microsoft.com/help/14238/windows-10-troubleshoot-blue-screen-errors).

The preferred way to shut down Windows is to select **Start**, and then select an option to turn off or shut down the computer. When you use this standard method, the operating system closes all files and notifies the running services and applications so that they can write any unsaved data to disk and flush any active caches.

If your computer shuts down unexpectedly, Windows logs Event ID 41 the next time that the computer starts. The event text resembles the following information:

```output
Event ID: 41  
Description: The system has rebooted without cleanly shutting down first.
```

This event indicates that some unexpected activity prevented Windows from shutting down correctly. Such a shutdown might be caused by an interruption in the power supply or by a Stop error. If feasible, Windows records any error codes as it shuts down. During the [kernel phase](windows-boot-issues-troubleshooting.md#kernel-phase) of the next Windows startup, Windows checks for these codes and includes any existing codes in the event data of Event ID 41.

```output
EventData  
BugcheckCode 159  
BugcheckParameter1 0x3  
BugcheckParameter2 0xfffffa80029c5060  
BugcheckParameter3 0xfffff8000403d518  
BugcheckParameter4 0xfffffa800208c010  
SleepInProgress false  
PowerButtonTimestamp 0Converts to 0x9f (0x3, 0xfffffa80029c5060, 0xfffff8000403d518, 0xfffffa800208c010)  
```

## How to use Event ID 41 when you troubleshoot an unexpected shutdown or restart

By itself, Event ID 41 might not contain sufficient information to explicitly define what occurred. Typically, you've to also consider what was occurring at the time of the unexpected shutdown (for example, the power supply failed). Use the information in this article to identify a troubleshooting approach that is appropriate for your circumstances:

- [Scenario 1](#scenario-1-the-computer-restarts-because-of-a-stop-error-and-event-id-41-contains-a-stop-error-bug-check-code): The computer restarts because of a Stop error, and Event ID 41 contains a Stop error (bug check) code
- [Scenario 2](#scenario-2-the-computer-restarts-because-you-pressed-and-held-the-power-button): The computer restarts because you pressed and held the power button
- [Scenario 3](#scenario-3-the-computer-is-unresponsive-or-randomly-restarts-and-event-id-41-isnt-recorded-or-the-event-id-41-entry-or-lists-error-code-values-of-zero): The computer is unresponsive or randomly restarts, and Event ID 41 isn't logged or the Event ID 41 entry lists error code values of zero

## Scenario 1: The computer restarts because of a Stop error, and Event ID 41 contains a Stop error (bug check) code

When a computer shuts down or restarts because of a Stop error, Windows includes the Stop error data in Event ID 41 as part of more event data. This information includes the Stop error code (also called a bug check code), as shown in the following example:

```output
EventData  
BugcheckCode 159  
BugcheckParameter1 0x3  
BugcheckParameter2 0xfffffa80029c5060  
BugcheckParameter3 0xfffff8000403d518  
BugcheckParameter4 0xfffffa800208c010  
```

> [!NOTE]  
> Event ID 41 includes the bug check code in decimal format. Most documentation that describes bug check codes refers to the codes as hexadecimal values instead of decimal values. To convert decimal to hexadecimal, follow these steps:
>  
> 1. Select **Start**, type *calc* in the **Search** box, and then select **Calculator**.
> 2. In the **Calculator** window, select **View** > **Programmer**.
> 3. On the left side of calculator, verify that **Dec** is highlighted.
> 4. Use the keyboard to enter the decimal value of the bug check code.
> 5. On the left side of the calculator, select **Hex**.  
> The value that the calculator displays is now the hexadecimal code.
>  
> When you convert a bug check code to hexadecimal format, verify that the "0x" designation is followed by eight digits (that is, the part of the code after the "x" includes enough zeros to fill out eight digits). For example, 0x9F is typically documented as 0x0000009f, and 0xA is documented as 0x0000000A. In the case of the example event data in this article, "159" converts to 0x0000009f.  

After you identify the hexadecimal value, use the following references to continue troubleshooting:

- [Advanced troubleshooting for Stop error or blue screen error issue](stop-error-or-blue-screen-error-troubleshooting.md).
- [Bug Check Code Reference](/windows-hardware/drivers/debugger/bug-check-code-reference2). This page lists links to documentation for different bug check codes.
- [How to Debug Kernel Mode Blue Screen Crashes (for beginners)](/archive/blogs/askcore/how-to-debug-kernel-mode-blue-screen-crashes-for-beginners).

## Scenario 2: The computer restarts because you pressed and held the power button

Because this method of restarting the computer interferes with the Windows shutdown operation, we recommend that you use this method only if you've no alternative. For example, you might have to use this approach if your computer isn't responding. When you restart the computer by pressing and holding the power button, the computer logs an Event ID 41 that includes a non-zero value for the **PowerButtonTimestamp** entry.

```xml
<EventData>
<Data Name="BugcheckCode">0</Data>
<Data Name="BugcheckParameter1">0x0</Data>
<Data Name="BugcheckParameter2">0x0</Data>
<Data Name="BugcheckParameter3">0x0</Data>
<Data Name="BugcheckParameter4">0x0</Data>
<Data Name="SleepInProgress">0</Data>
<Data Name="PowerButtonTimestamp">131728546170882432</Data>
<Data Name="BootAppStatus">0</Data>
</EventData>
```

For help when troubleshooting an unresponsive computer, see [Windows Help](https://support.microsoft.com/hub/4338813/windows-help?os=windows-10). Consider searching for assistance by using keywords such as "hang," "responding," or "blank screen."

## Scenario 3: The computer is unresponsive or randomly restarts, and Event ID 41 isn't recorded or the Event ID 41 entry or lists error code values of zero

This scenario includes the following circumstances:

- You shut off power to an unresponsive computer, and then you restart the computer.  
   To verify that a computer is unresponsive, press the <kbd>Caps lock</kbd> key on the keyboard. If the <kbd>Caps lock</kbd> light on the keyboard doesn't change when you press the <kbd>Caps lock</kbd> key, the computer might be unresponsive (also known as a hard hang).  
- The computer restarts, but it doesn't generate Event ID 41.
- The computer restarts and generates Event ID 41, but the **BugcheckCode** and **PowerButtonTimestamp** values are zero.

In such cases, something prevents Windows from generating error codes or from writing error codes to disk. Something might block write access to the disk (as in the case of an unresponsive computer) or the computer might shut down too quickly to write the error codes or even detect an error.

The information in Event ID 41 provides some indication of where to start checking for problems:

- Event ID 41 isn't recorded or the bug check code is zero. This behavior might indicate a power supply problem. If the power to a computer is interrupted, the computer might shut down without generating a Stop error. If it does generate a Stop error, it might not finish writing the error codes to disk. The next time the computer starts, it might not log Event ID 41. Or, if it does, the bug check code is zero. The following conditions might be the cause:
  - In the case of a portable computer, the battery was removed or drained.
  - In the case of a desktop computer, the computer was unplugged or experienced a power outage.
  - The power supply is underpowered or faulty.

- The PowerButtonTimestamp value is zero. This behavior might occur if you disconnected the power to a computer that wasn't responding to input. The following conditions might be the cause:
  - A Windows process blocked write access to the disk, and you shut down the computer by pressing and holding the power button for at least four seconds.
  - You disconnected the power to an unresponsive computer.

- Failure to write dump file and all the values are Zero. For example:

  ```xml
  <EventData>
  <Data Name="BugcheckCode">0</Data>
  <Data Name="BugcheckParameter1">0x0</Data>
  <Data Name="BugcheckParameter2">0x0</Data>
  <Data Name="BugcheckParameter3">0x0</Data>
  <Data Name="BugcheckParameter4">0x0</Data>
  <Data Name="SleepInProgress">0</Data>
  <Data Name="PowerButtonTimestamp">0</Data>
  <Data Name="BootAppStatus">0</Data>
  </EventData>
  ```

  However, there is an event ID 46 logged by volmgr : **Crash dump initialization failed!**. This event may occur if the computer started without a configured dump file. The default dump file is the pagefile.
  
  :::image type="content" source="media/event-id-41-restart.md/event-id-screenshot.png" alt-text="Screenshot of the event log." border="true":::
  
  Therefore, when you have a case with an unexpected restart and event ID 41 has all value as **0**, check if you have an event ID 46 by volmgr. If so, check the pagefile configuration. Unexpected reboots could still happened due to a bugcheck, but the system can not write the bugcheck type in event ID 41 and could not also generate a memory dump. See [Event ID 46 when you start a computer](../../windows-server/performance/event-id-46-start-a-computer.md)

Typically, the symptoms described in this scenario indicate a hardware problem. To help isolate the problem, do the following steps:

- Disable overclocking. If the computer has overclocking enabled, disable it. Verify that the issue occurs when the system runs at the correct speed.
- Check the memory. Use a memory checker to determine the memory health and configuration. Verify that all memory chips run at the same speed and that every chip is configured correctly in the system.
- Check the power supply. Verify that the power supply has enough wattage to appropriately handle the installed devices. If you added memory, installed a newer processor, installed more drives, or added external devices, such devices can require more energy than the current power supply can provide consistently. If the computer logged event ID 41 because the power to the computer was interrupted, consider obtaining an uninterruptible power supply (UPS) such as a battery backup power supply.
- Check for overheating. Examine the internal temperature of the hardware and check for any overheating components.
- If the computer is a physical machine, it could have been restarted by an Automatic Server Recovery (ASR) software that detected the machine is not responsive.
- If system is running in a Hyper-V virtual machine (VM), and is not part of a clustered environment, the system could have been restarted by the Hyper-V heartbeat feature. If this feature is enabled and the host does not detect a heartbeat from the VM (maybe because it's not responsive), Hyper-V will restart the VM.
- If the issue occurs in a Hyper-V clustered environment, the issue could be related to the **Enable heartbeat monitoring for the virtual machine** option. See [Corrupted memory dump file when you try to obtain a full memory dump file from a virtual machine that is running in a cluster environment](../../windows-server/high-availability/corrupted-memory-dump-file.md).
- If the issue occurs with a VMWare VM, it could be related to the heartbeat feature in VMWare, or the VM is part of some third party cluster.
- Check for any suspicious event before the shutdown time (obtained from event ID 6008) in both Application and System log.

If you perform these checks and still can't isolate the problem, set the system to its default configuration and verify whether the issue still occurs.

> [!NOTE]  
> If you see a Stop error message that includes a bug check code, but event ID 41 doesn't include that code, change the restart behavior for the computer. To do this, follow these steps:
>  
> 1. Right-click **My Computer**, then select **Properties** > **Advanced system settings** > **Advanced**.
> 2. In the **Startup and Recovery** section, select **Settings**.
> 3. Clear the **Automatically restart** check box.

## More information

### Details about the event ID 41

The Kernel Power event ID 41 error occurs when the computer shuts down or restarts unexpectedly. When a Windows-based computer starts, a check is performed to determine whether the computer was shut down cleanly. If not, a Kernel Power event ID 41 message is generated.

An event ID 41 is used to report that something unexpected happened that prevented Windows from shutting down correctly. There may be insufficient information to explicitly define what happened. See [Kernel Power Event ID 41](https://social.technet.microsoft.com/wiki/contents/articles/14246.kernel-power-event-id-41.aspx) for more information.

- Log name: System
- Product: Windows Operating System
- ID: 41
- Source: Microsoft-Windows-Kernel-Power
- Level: Critical
- Version: 6.1
- Message: The system has rebooted without cleanly shutting down first. This error could be caused if the system stopped responding, crashed, or lost power unexpectedly.

> [!NOTE]
> The time shown in the .evtx file is adjusted to your system's time. Check the time zone of the server.

- Event ID 41: This event indicates that Windows restarted without a complete shutdown.
- Event ID 1074: This event is logged when an application is responsible for the system shutdown or restart. It also indicates when a user restarted or shut down the system by using the **Start** menu or by pressing Ctrl+Alt+Del.
- Event ID 6006: This event indicates that Windows was adequately turned off.
- Event ID 6008: This event indicates an improper or dirty shutdown. It is logged when the most recent shutdown was unexpected.

Just before the computer shuts down, `shutdown.exe` will record the shutdown event in the Windows System log with a Source=User32 and event ID 1074 along with any custom message & reason code.

The event log is the only way to tell that a reboot triggered from `shutdown.exe` is pending. The event also records the username, and the date and time when the `shutdown` command was issued.

When using `shutdown.exe` to restart a server, the shutdown process will normally allow 30 seconds to ensure each running service has time to stop. Services are shutdown in alphabetical order. Halting the services manually in a specific order with `NET STOP` or `SC` can be slightly faster.

### Boot Status File (from the windows internals 6th)

Windows uses a boot status file (*%SystemRoot%\Bootstat.dat*) to record the fact that it has progressed through various stages of the system life cycle, including startup and shutdown.

This allows the Boot Manager, Windows loader, and the Startup Repair tool to detect abnormal shutdown or a failure to shut down cleanly, in order to offer the user recovery and diagnostic boot options, such as Last Known Good and Safe Mode. This binary file contains information through which the system reports the success of the following phases of the system life cycle:

- Boot (the definition of a successful boot is the same as the one used for determining Last Known Good status, which was described earlier)
- Shutdown
- Resume from hibernate or suspend

The boot status file also indicates whether a problem was detected the last time the user tried to boot the operating system and the recovery options shown, indicating that the user has been made aware of the problem and taken action. Runtime Library APIs (Rtl) in ntdll.dll contain the private interfaces that Windows uses to read from and write to the file. Like the BCD, it cannot be edited by users.

### About shutdown

When a shutdown is initiated, Windows sends a WM_QUERYENDSESSION message to all running applications that have a user interface (UI) thread. This message asks the application to save any unsaved data and terminate gracefully. If the application does not respond to the message within a certain time limit, Windows sends a WM_ENDSESSION message to the application, which terminates the application immediately.

If all applications respond to the WM_QUERYENDSESSION message and terminate gracefully, Windows logs a clean shutdown event in the System event log. If any application does not respond to the message or terminates abnormally, Windows logs a dirty shutdown event in the System event log.

The unexpected shutdowns are mostly caused by components outside the operating system.

A dirty shutdown is when a computer system is shut down without going through the proper shutdown process. This can happen when the power is suddenly cut off or when the computer is forced to shut down by holding down the power button. A dirty shutdown can cause data loss or corruption and can also lead to boot-up problems.

The dirty shutdown count registry is a registry key in the Windows Registry that is used to track the number of times a computer system has been shut down without going through the proper shutdown process. This key can be useful when troubleshooting boot-up problems to identify whether the system was powered off incorrectly.

You can also clear all the values (like DirtyShutdown, LastAliveStamp, TimeStampInterval) in the following registry key: `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability`. This can help prevent the Shutdown Event Tracker from appearing after an unexpected shutdown.
