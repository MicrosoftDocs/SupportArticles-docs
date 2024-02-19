---
title: Switch options for Boot.ini files
description: Describes the switch options that you can use to modify Windows startup.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:no-boot-not-bugchecks, csstroubleshoot
---
# Available switch options for the Windows XP and the Windows Server 2003 Boot.ini files

This article describes the switch options that you can use to modify Windows startup.

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 833721

## Summary

You can add many different switches to the Boot.ini file that will modify the way that Microsoft Windows XP or Microsoft Windows Server 2003 start.

## More information

You can add the following switches to the Boot.ini file.

> [!NOTE]
> These switches apply to Microsoft Windows XP and to Microsoft Windows Server 2003, unless otherwise specified.

### /basevideo

The `/basevideo` switch forces the system into standard 640x480 16-color VGA mode by using a video driver that is compatible with any video adapter. This switch permits the system to load if you selected the wrong video resolution or refresh rate. Use this switch in conjunction with the `/sos` switch. If you install a new video driver, and it does not work correctly, you can use this parameter to start the operating system. You can then remove, update, or roll back the problem video driver.

### /baudrate=number  

This switch sets the baud rate of the debug port that is used for kernel debugging. For example, type `/baudrate=9600`. The default baud rate is 9600 kilobits per second (Kbps) if a modem is attached. The default baud rate is 115,200 Kbps for a null-modem cable. 9,600 is the normal rate for remote debugging over a modem. If this switch is in the Boot.ini file, the `/debug` switch is automatically enabled.

### /crashdebug

This switch loads the kernel debugger when you start the operating system. The switch remains inactive until a Stop message error occurs. `/crashdebug` is useful if you experience random kernel errors. With this switch, you can use the COM port for normal operations while Windows is running. If Windows crashes, the switch converts the port to a debug port. (This action turns on remote debugging.)

### /debug

This switch turns on the kernel debugger when you start Windows. The switch can be activated at any time by a host debugger that is connected to the computer, if you want to turn on live remote debugging of a Windows system through the COM ports. Unlike the `/crashdebug` switch, `/debug` uses the COM port whether you are debugging or not. Use this switch when you are debugging problems that are regularly reproducible.

### /debugport=comnumber

This switch specifies the communications port to use for the debug port, where **number** is the communications port, such as COM1, that you want to use. By default, `/debugport` uses COM2 if it exists. Otherwise, the switch uses COM1. If you include this switch in the Boot.ini file, the /debug switch becomes active.

### /maxmem=number  

This switch specifies the amount of RAM, in bytes, that Windows can use. For example, if you want Windows to use less than 64 MB of memory, use the `/maxmem=64` switch.

However, the `/maxmem` switch does not account for memory holes. Therefore, we recommend that you use the `/burnmemory` switch instead. The `/burnmemory` switch accounts for memory holes.

For example, if you use the `/Maxmem=64` switch, and the system requires 64 MB of memory to load, there may not actually be 64-MB available to the system because of a memory hole. In this scenario, Windows would not start.

### /noguiboot

This switch disables the bitmap that displays the progress bar for Windows startup. (The progress bar appears just before the logon prompt.)

### /nodebug

This switch turns off debugging. This scenario can cause a Stop error if a program has a debug hardcoded breakpoint in its software.

### /numproc=number  

This switch sets the number of processors that Windows will run at startup. With this switch, you can force a multiprocessor system to use only the quantity of processors (**number**) that you specify. This switch can help you troubleshoot performance problems and defective CPUs.

### /pcilock

For x86-based systems, this switch stops the operating system from dynamically assigning hardware input, hardware output, and interrupt request resources to Peripheral Connect Interface (PCI) devices. With this switch, the BIOS configures the devices.

### /fastdetect:comnumber

This switch turns off serial and bus mouse detection in the `Ntdetect.com` file for the specified port. Use this switch if you have a component other than a mouse that is attached to a serial port during the startup process. For example, type /fastdetect:com **number**, where **number** is the number of the serial port. Ports may be separated with commas to turn off more than one port. If you use `/fastdetect`, and you do not specify a communications port, serial mouse detection is turned off on all communications ports.

> [!NOTE]
> In earlier versions of Windows, including Windows NT 4.0, this switch was named `/noserialmice`.

### /sos

The `/sos` switch displays the device driver names while they are being loaded. By default, the Windows Loader screen only echoes progress dots. Use this switch with the `/basevideo` switch to determine the driver that is triggering a failure.

### /PAE

Use the `/PAE` switch with the corresponding entry in Boot.ini to permit a computer that supports physical address extension (PAE) mode to start normally. In Safe Mode, the computer starts by using normal kernels, even if the /PAE switch is specified.

### /HAL=filename

With this switch, you can define the actual hardware abstraction layer (HAL) that is loaded at startup. For example, type `/HAL=halmps.dll` to load the Halmps.dll in the System32 folder. This switch is useful to try out a different HAL before you rename the file to Hal.dll. This switch is also useful when you want to try to switch between starting in multiprocessor mode and starting in single processor mode. To do this, use this switch with the `/kernel` switch.

### /kernel=filename

With this switch, you can define the actual kernel that is loaded at startup. For example, type `/kernel=ntkrnlmp.exe` to load the Ntkrnlmp.exe file in the System32 folder. With this switch, you can switch between a debug-enabled kernel that is full of debugging code and a regular kernel.

### /bootlog

This switch turns on boot logging to a file that is named systemroot\Ntbtlog.txt. For more information about boot logging, see Windows Help.

### /burnmemory=number  

This switch specifies the amount of memory, in megabytes, that Windows cannot use. Use this parameter to confirm a performance problem or other problems that are related to RAM depletion. For example, type `/burnmemory=128` to reduce the physical memory that is available to Windows by 128 MB.

### /3GB

This switch forces x86-based systems to allocate 3 GB of virtual address space to programs and 1 GB to the kernel and to executive components. A program must be designed to take advantage of the additional memory address space. With this switch, user mode programs can access 3 GB of memory instead of the usual 2 GB that Windows allocates to user mode programs. The switch moves the starting point of kernel memory to 3 GB. Some configurations of Microsoft Exchange Server 2003 and Microsoft Windows Server 2003 may require this switch.

### /safeboot: parameter

This switch causes Windows to start in Safe Mode. This switch uses the following parameters:

- minimal
- network
- safeboot: minimal(alternateshell)
- DS Restore Mode (for Windows Server 2003 Domain Controllers only)

You can combine other Boot.ini parameters with `/safeboot: parameter`. The following examples illustrate the parameters that are in effect when you select a Safe Mode option from the startup recovery menu.

- Safe Mode with Networking  
`/safeboot: minimal /sos /bootlog /noguiboot`
- Safe Mode with Networking  
`/safeboot: network /sos /bootlog /noguiboot`
- Safe Mode with Command Prompt  
`/safeboot: minimal(alternateshell) /sos /bootlog /noguiboot`
- Windows in Directory Services Restore Mode  
(This switch starts only on domain controllers.)  
`/safeboot: disrepair /sos`

> [!NOTE]
> The `/sos`, `/bootlog`, and `/noguiboot` switches are not required with any one of these settings, but the switches can help with troubleshooting. These switches are included if you press F8 and then select one of the modes.

### /userva

Use this switch to customize the amount of memory that is allocated to processes when you use the /3GB switch. This switch permits more page table entry (PTE) kernel memory but still maintains almost 3 GB of process memory space.

> [!NOTE]
> Microsoft Product Support Services strongly recommends using a range of memory for the `/USERVA` switch that lies within the range of 2900-3030. This range is wide enough to provide a large enough pool of system page table entries for all currently observed issues. Usually a setting of `/userva=2900` will provide close to the maximum available number of system page table entries possible.

For more information, click the following article numbers to view the articles in the Microsoft Knowledge Base:

- [323427](https://support.microsoft.com/help/323427) How to manually edit the Boot.ini file in a Windows Server 2003 environment  

- [289022](https://support.microsoft.com/help/289022) HOW TO: Edit the Boot.ini file in Windows XP

### /usepmtimer

The `/usepmtimer` switch specifies that the Windows XP operating system or the Windows Server 2003 operating system use the PM-TIMER timer settings instead of the Time Stamp Counter (TSC) timer settings if the processor supports the PM_TIMER settings.

For more information about how to use the `/usepmtimer` switch, click the following article number to view the article in the Microsoft Knowledge Base:

[895980](https://support.microsoft.com/help/895980) Programs that use the QueryPerformanceCounter function may perform poorly in Windows Server 2003 and in Windows XP  

### /redirect

Use this switch to turn on Emergency Management Services (EMS) on a Windows Server 2003, Enterprise Edition-based computer. For additional information about EMS, search on "Emergency Management Services" in Windows Help and Support.

To turn on EMS by editing the Boot.ini on an x86-based computer, edit both the **[boot loader]** section and the **[operating systems]** section of the Boot.ini file. To do this, configure the following entries:

- Under **[boot loader]**, add one of the following required statements:

    ```ini
    redirect=COM x
    ```

    In this statement, replace **x** with one of the following COM port numbers:

  - 1
  - 2
  - 3
  - 4

    ```ini
    redirect=USEBIOSSETTINGS
    ```

    This statement permits the computer BIOS to determine the COM port to use for EMS.

- Under **[boot loader]**, add the following option statement:

    ```ini
    redirectbaudrate= baudrate
    ```

    Replace **baudrate** with one of the following values:

  - 9600
  - 19200
  - 57600
  - 115200

    By default, EMS uses the 9600 Kbps baud rate setting.

- Under **[operating systems]**, add the `/redirect` option to the operating system entry that you want to configure to use EMS. The following example illustrates the use of these switches:

    ```ini
    [boot loader]
    timeout=30
    default=multi(0)disk(0)rdisk(0)partition(1)\WINDOWS
    redirect=COM1
    redirectbaudrate=19200
    [operating systems]
    multi(0)disk(0)rdisk(0)partition(1)\WINDOWS="Windows Server 2003, Enterprise" /fastdetect
    multi(0)disk(0)rdisk(0)partition(1)\WINDOWS="Windows Server 2003, EMS" /fastdetect /redirect
    ```

### /channel

Use this switch together with the `/debug` switch and the `/debugport` switch to configure Windows to send debug information over an Institute of Electrical and Electronics Engineers, Inc. (IEEE) 1394 port. To support debugging over a 1394 port, both computers must be running Microsoft Windows XP or later. The 1394 port has a maximum number of 63 independent communications channels that are numbered 0 through 62. Different hardware implementations support a different number of channels across one bus. Windows XP has a limit of four destination computers. However, this limitation is removed in Windows Server 2003. To perform debugging, select a common channel number to use on both the computer that the debugger runs on, which is also known as the host computer, and the computer that you want to debug, which is also known as the destination computer. You can use any number from 1 to 62.

#### Configure the destination computer

1. Edit the Boot.ini file to add the `/CHANNEL= x` option to the operating system entry that you have configured for debugging. Replace **x** with the channel number that you want to use. For example, configure the **[operating systems]** area of the Boot.ini file to look similar to the following:

    ```ini
    [boot loader]
    timeout=30
    default=multi(0)disk(0)rdisk(0)partition(1)\WINDOWS
    [operating systems]
    multi(0)disk(0)rdisk(0)partition(1)\WINDOWS="Windows Server 2003, Enterprise" /fastdetect /debug /debugport=1394 /CHANNEL=3
    ```

2. Plug the 1394 cable in one of the 1394 ports.
3. Disable the 1394 host controller on the destination computer. To do this, start Device Manager, right-click the device, and then click **Disable**.
4. Restart the computer.

#### Configure the host computer

1. Plug the 1394 cable in one of the 1394 ports.
2. Install the kernel debugger binary files.
3. Start a command prompt. Press enter after you type each of the following commands:

    ```console
    set_NT_DEBUG_BUS=1394
    set_NT_DEBUG_1394_CHANNEL= x
    kd -k
    ```

4. Move to the folder where you installed the kernel debugger, and then type the command: kd.exe.

When you first start the debugger, a 1394 virtual driver is installed. This driver permits the debugger to communicate with the destination computer. You must be logged on with administrator rights for this driver installation to complete successfully.
