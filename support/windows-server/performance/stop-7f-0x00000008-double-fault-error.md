---
title: Stop 7F, 0x00000008 (double-fault) error
description: Provides a solution to a STOP 0x0000007F, 0x00000008 error message on your computer because of a specific processor error.
ms.date: 10/15/2020
author: Deland-Han 
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Blue Screen/Bugcheck
ms.technology: Performance
---
# Stop 7F, 0x00000008 (double-fault) error occurs because of a single-bit error in the ESP register

This article provides a solution to a STOP 0x0000007F, 0x00000008 error message on your computer because of a specific processor error. This error message may be displayed when a single-bit error occurs in the  Electric Service Provider (ESP) register of a processor that is running on the computer.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 842465

## Symptoms

On a computer that is running one or more Intel Xeon processors, or that is running other processors, Windows may display a Stop error message that is similar to the following example:

> STOP 0x0000007F (0x00000008, 0x00000000, 0x00000000, 0x00000000) UNEXPECTED_KERNEL_MODE_TRAP

When this problem occurs, the following conditions are true:

- The first parameter of the Stop error is "0x0000008". (This error is a double-fault exception.)
- Because of a single-bit error in the upper half of the ESP register, the value in the ESP register is outside the stack range of the current thread.

## Cause

This problem occurs if one or more of the processors in the computer:

- Require a microcode update that isn't applied by the computer's basic input/output system (BIOS).

- Are damaged or defective.
- Are operating outside their specified ranges for temperature, power, or other conditions.

## Resolution

To resolve this problem, use one of the following troubleshooting methods.

## Method 1: Determine if the processor is running the production revision of the microcode update

A microcode update corrects errata, or bugs, in a processor's internally implemented logic. Microcode updates can't be permanently stored in the processor itself and must be loaded into the processor every time that the computer starts. Microcode updates can be applied by the computer's BIOS or by the Update.sys driver.

To identify the revision of the microcode update that is currently applied to an Intel processor that is installed on your computer, follow these steps:

1. Download the Intel Processor Frequency ID Utility from the [Intel Web site](http://support.intel.com/support/processors/tools/frequencyid).

2. Install and run the Intel Processor Frequency ID Utility on the computer that is experiencing symptoms.

3. Write down the following CPU information for each processor:
   - CPU Family
   - CPU Model
   - CPU Stepping
   - CPU Revision

   The CPU Family, CPU Model, and CPU Stepping values identify the specific type of processor. The CPU Revision value identifies the revision of the microcode update that is applied.
4. Contact your computer manufacturer to determine whether the revision of the microcode update is the most current revision that is available for a particular processor. If the revision isn't the most current, ask your computer manufacturer for an updated BIOS that will apply the most current microcode update revision.

The symptoms that are described in this article have been observed most frequently on Intel Xeon processors that have the CPU Family, CPU Model, and CPU Stepping values of 15, 2, and 9 respectively and that are installed on motherboards that use ServerWorks chipsets. (The CPU Family, CPU Model, and CPU Stepping hexadecimal values are F, 2, and 9 respectively.) These processors require a revision value of 0x18 or later to function correctly. (0x18 is equivalent to a decimal value of 24.)

A revision value of 0 indicates that the computer BIOS doesn't have the correct microcode update for the processors that are installed in the computer. You must update the BIOS with a microcode update revision that supports the processors that you're using.

Intel recommends that you apply the latest microcode update revisions to help avoid known issues.

## Method 2: Determine if a processor is damaged or defective

If the processors that are installed in the affected computers have the production microcode update revision applied, and the symptoms that are described in this article don't occur on all computers of the same model that are running the same processors, the processors may be defective.

To determine if a processor is damaged or defective, move the processor to a computer that isn't experiencing any symptoms.

> [!WARNING]
> If you change processors, follow instructions that are provided by your computer manufacturer, or engage appropriately qualified hardware technicians to change the processors.

If the symptoms continue to occur on the original computer with the replacement processor, but not on the other computer with the original processor, the problem is probably not caused by a damaged or a defective processor.

If the symptoms don't continue to occur on the original computer with the replacement processor, but do occur on the other computer with the original processor, the problem is probably caused by a damaged or a defective processor. In this case, contact your computer manufacturer to replace the original processor.

If the computer that is experiencing the symptoms that are described in this article has more that one processor, move all processors to the other computer. If the results indicate that one or more of these processors may be defective, move processors one at a time to determine the processor or processors that may be defective.

## Method 3: Determine if a processor is operating outside a specified range of environmental conditions

Excessive room temperature, bad ventilation, or dust accumulation can cause electronic components, such as processors, to behave erratically. Malfunctioning fans or blocked air passages can cause ventilation problems. If the interior or the air passages of the computer are dusty, or if the computer exhibits symptoms when it's installed only in a particular location, system overheating may be a factor. Make sure that components are clean, that fans are functioning correctly, and that air passages aren't obstructed. Additionally, make sure that the room where the computer is located is adequately ventilated. The temperature of the room must be in the operating range that is specified by the computer manufacturer.

Voltage that is higher or lower than specified, or that fluctuates, may cause processors and other electronic components to behave erratically. Incorrect or inconsistent main power voltage, an overloaded or improperly functioning power supply in the computer, or improperly functioning motherboard circuitry may cause incorrect or inconsistent voltage to be supplied to the processor. Contact the appropriate technicians to verify whether any one of these issues may be the cause of symptoms.

## More information

For more information about STOP 0x0000007F errors, see [0x0000007F Stop error on a Windows-based computer](https://support.microsoft.com/help/137539).

The ESP register is also known as the stack pointer register. A stack is a data structure in memory that is used to store information about the current state of the execution of a thread. A thread's stack is used to keep track of function calls in progress, of parameters that are passed to those functions, and of variables that are used by those functions. The value in the ESP register is expected to point to the current top of the stack. If the value in ESP is incorrect, it may point to incorrect information or to an invalid address. If the value in ESP points to an invalid address, a double-fault exception may occur.

To determine if the Stop error is the result of a single-bit error in the ESP register, follow these steps:

1. Install the Microsoft Debugging Tools for Windows.

2. Run the WinDbg tool, select **File**, select **Open Crash Dump** to locate the memory dump file that contains the Stop error information, and then select **OK**.

    The initial bug check analysis typically appears similar to the following example:

    ```console
    *******************************************************************************
    *                                                                             *
    *                        Bugcheck Analysis                                    *
    *                                                                             *
    *******************************************************************************

    Use !analyze -v to get detailed debugging information.

    BugCheck 7F, {8, 0, 0, 0}

    Probably caused by : ntkrnlmp.exe ( nt!KiUnlockDispatcherDatabase+1c )

    Followup: MachineOwner
    ```

3. Run the `!analyze -v` command to obtain an automated analysis of the dump file. The following is an example of the output of the `!analyze -v` command:

    ```console
    0: kd> !analyze -v
    *******************************************************************************
    *                                                                             *
    *                        Bugcheck Analysis                                    *
    *                                                                             *
    *******************************************************************************

    UNEXPECTED_KERNEL_MODE_TRAP (7f)
    This means a trap occurred in kernel mode, and it is a trap of a kind
    that the kernel isn't permitted to have/catch (bound trap) or that
    is always instant death (double fault).  The first number in the
    bugcheck params is the number of the trap (8 = double fault, etc)
    Consult an Intel x86 family manual to learn more about what these
    traps are. Here is a *portion* of those codes:
    If kv shows a taskGate
            use .tss on the part before the colon, then kv.
    Else if kv shows a trapframe
            use .trap on that value
    Else
            .trap on the appropriate frame will show where the trap was taken
            (on x86, this will be the ebp that goes with the procedure KiTrap)
    Endif
    kb will then show the corrected stack.
    Arguments:
    Arg1: 00000008, EXCEPTION_DOUBLE_FAULT
    Arg2: 00000000
    Arg3: 00000000
    Arg4: 00000000

    Debugging Details:
    ------------------

    BUGCHECK_STR:  0x7f_8

    TSS:  00000028 -- (.tss 28)
    eax=ffdff4dc ebx=f5d299dc ecx=8046f1c0 edx=00000000 esi=853e7a60 edi=00000102
    eip=8046a86c esp=f5da9948 ebp=f5d2997c iopl=0         nv up ei pl zr na po nc
    cs=0008  ss=0010  ds=0023  es=0023  fs=0030  gs=0000             efl=00010246
    nt!KiUnlockDispatcherDatabase+0x1c:
    8046a86c 59               pop     ecx
    Resetting default scope

    DEFAULT_BUCKET_ID:  DRIVER_FAULT

    LAST_CONTROL_TRANSFER:  from 80450bb3 to 8046a86c

    STACK_TEXT:  
    f5d2997c 80450bb3 00000003 f5d299f8 00000001 nt!KiUnlockDispatcherDatabase+0x1c
    f5d29d48 80466389 00000003 0076fe84 00000001 nt!NtWaitForMultipleObjects+0x385
    f5d29d48 77f9323e 00000003 0076fe84 00000001 nt!KiSystemService+0xc9
    0076fe5c 77e7a059 00000003 0076fe84 00000001 ntdll!ZwWaitForMultipleObjects+0xb
    0076feac 77dee9fb 0076fe84 00000001 00000000 KERNEL32!WaitForMultipleObjectsEx+0xea
    0076ff08 77deea48 0076fed4 0076ff5c 00000000 USER32!MsgWaitForMultipleObjectsEx+0x153
    0076ff24 6d095a7c 00000002 0076ff5c 00000000 USER32!MsgWaitForMultipleObjects+0x1d
    0076ff7c 780085bc 00283a90 0062f5ac 0062ffdc IisRTL!SchedulerWorkerThread+0xa7
    0076ff90 8042fa31 85400680 0076ff88 ffffffff MSVCRT!_endthreadex+0xc1
    00283ab8 ffffffff 00000000 00000000 00000000 nt!KiDeliverApc+0x1a1
    00283ab8 ffffffff 00000000 00000000 00000000 0xffffffff
    0000096c 00000000 00000000 00000000 00000000 0xffffffff

    FOLLOWUP_IP:
    nt!KiUnlockDispatcherDatabase+1c
    8046a86c 59               pop     ecx

    SYMBOL_STACK_INDEX:  0

    FOLLOWUP_NAME:  MachineOwner

    SYMBOL_NAME:  nt!KiUnlockDispatcherDatabase+1c

    MODULE_NAME:  nt

    IMAGE_NAME:  ntkrnlmp.exe

    DEBUG_FLR_IMAGE_TIMESTAMP:  3ee650b3

    STACK_COMMAND:  .tss 28 ; kb

    BUCKET_ID:  0x7f_8_nt!KiUnlockDispatcherDatabase+1c

    Followup: MachineOwner
    ```

4. Examine the output of the `!analyze -v` command to see if the output shows a double-fault condition. If a double-fault condition exists, run the `.tss 28` command to display the system state at the time of the double-fault. For example, the following output shows the values in the processor's registers at the moment when a double-fault exception occurred:

    ```console
    0: kd> .tss 28
    eax=ffdff4dc ebx=f5d299dc ecx=8046f1c0 edx=00000000 esi=853e7a60 edi=00000102
    eip=8046a86c esp=f5da9948 ebp=f5d2997c iopl=0         nv up ei pl zr na po nc
    cs=0008  ss=0010  ds=0023  es=0023  fs=0030  gs=0000             efl=00010246
    nt!KiUnlockDispatcherDatabase+0x1c:
    8046a86c 59               pop     ecx
    ```

    In the previous example, the value of the ESP register is f5da9948. Generally, this value is relatively close to the value of the EBP register. In the previous example, the value of the EBP register is f5d2997c.

5. Run the `!thread` command to view the current thread's stack range. A double-fault exception typically occurs when the value of the ESP register is outside the range of addresses that are reserved for the stack for the current thread. The following is an example of the output of the `!thread` command:

    ```console
    0: kd> !thread
    THREAD 853e7a60  Cid 904.96c  Teb: 7ffdc000  Win32Thread: a21a5c48 RUNNING
    Not impersonating
    Owning Process 85400680
    Wait Start TickCount    578275        Elapsed Ticks: 0
    Context Switch Count    38423                   LargeStack
    UserTime                  0:00:02.0031
    KernelTime                0:00:06.0640
    Start Address KERNEL32!BaseThreadStartThunk (0x77e5b700)
    Win32 Start Address MSVCRT!_threadstartex (0x78008532)
    Stack Init f5d2a000 Current f5d29c9c Base f5d2a000 Limit f5d27000 Call 0
    Priority 8 BasePriority 8 PriorityDecrement 0 DecrementCount 0

    ChildEBP RetAddr  Args to Child
    00000000 8046a86c 00000000 00000000 00000000 nt!_KiTrap08+0x41
    f5d2997c 80450bb3 00000003 f5d299f8 00000001 nt!KiUnlockDispatcherDatabase+0x1c
    f5d29d48 80466389 00000003 0076fe84 00000001 nt!NtWaitForMultipleObjects+0x385
    f5d29d48 77f9323e 00000003 0076fe84 00000001 nt!_KiSystemService+0xc9
    0076fe5c 77e7a059 00000003 0076fe84 00000001 ntdll!ZwWaitForMultipleObjects+0xb
    0076feac 77dee9fb 0076fe84 00000001 00000000 KERNEL32!WaitForMultipleObjectsEx+0xea
    0076ff08 77deea48 0076fed4 0076ff5c 00000000 USER32!MsgWaitForMultipleObjectsEx+0x153
    0076ff24 6d095a7c 00000002 0076ff5c 00000000 USER32!MsgWaitForMultipleObjects+0x1d
    0076ff7c 780085bc 00283a90 0062f5ac 0062ffdc IisRTL!SchedulerWorkerThread+0xa7
    0076ffb4 77e5b382 00283ab8 0062f5ac 0062ffdc MSVCRT!_threadstartex+0x8f
    0076ffec 00000000 78008532 00283ab8 00000000 KERNEL32!BaseThreadStart+0x52
    ```

    In the previous output, the following information indicates the stack range values:

    > Stack Init f5d2a000 Current f5d29c9c Base f5d2a000 Limit f5d27000 Call 0

    When this particular thread is running, the ESP register value must always be between the Stack Base value (f5d2a000) and the Limit value (f5d27000). Generally, the value of the ESP register is relatively close to the Current value (f5d29c9c). (The Current value is also between the Stack Base value and the Limit value.) In the previous example, the value of the ESP register is f5da9948. This value is considerably outside the required range.

    You may also be able to check the stack range values by running the `!pcr` command. The following is an example of the output of the `!pcr` command:

    ```console
    0: kd> !pcr
    PCR Processor 0 @ffdff000
    NtTib.ExceptionList: f5d29d38
        NtTib.StackBase: f5d29df0
       NtTib.StackLimit: f5d27000
     NtTib.SubSystemTib: 00000000
          NtTib.Version: 00000000
      NtTib.UserPointer: 00000000
          NtTib.SelfTib: 7ffdc000

                SelfPcr: ffdff000
                   Prcb: ffdff120
                   Irql: 00000000
                    IRR: 00000000
                    IDR: ffffffff
          InterruptMode: 00000000
                    IDT: 80036400
                    GDT: 80036000
                    TSS: 80474850

          CurrentThread: 853e7a60
             NextThread: 00000000
             IdleThread: 80470600

              DpcQueue:
    ```

    The `NtTib.StackLimit` value represents the lower limit of the stack range. The `NtTib.StackBase` value represents a recent value of ESP. The `NtTib.StackBase` value may be compared against the current value of the ESP register to help identify whether there's a single-bit error in the current ESP register value.

6. Run the `.formats esp ^ ebp` command to display the differences in values between the ESP and EBP registers. The stack pointer value in the EBP register will be close to the stack pointer value in the ESP register, except for the single-bit error. This command frequently reveals the single high-order bit that contains the error, especially when the error is displayed in binary format, as it is in the following example:

    ```console
    0: kd> .formats esp ^ ebp
    Evaluate expression:
      Hex:     00080034
      Decimal: 524340
      Octal:   00002000064
      Binary:  00000000 00001000 00000000 00110100
      Chars:   ...4
      Time:    Tue Jan 06 17:39:00 1970
      Float:   low 7.34757e-040 high 0
      Double:  2.59058e-318
    ```

    If you ignore the lower, least significant digits, the single-bit difference between the ESP and EBP registers is 00000000 00001000 00000000 00000000 in binary format. The difference is 00080000 in hexadecimal format.

    This single-bit error causes the ESP register to contain an incorrect value. The incorrect value causes a double-fault exception, a bug check, and a system crash.

To obtain more information about your specific hardware, follow these steps:

1. Use the `!cpuinfo` command to obtain CPU version information. The following is an example of the output from the `!cpuinfo` command.

    ```console
    0: kd> !cpuinfo
    TargetInfo::ReadMsr is not available in the current debug session
    CP F/M/S Manufacturer  MHz Update Signature Features
     0 15,2,9 GenuineIntel 2790>0000000000000000<00002fff
     1 15,2,9 GenuineIntel 2790 0000000000000000 00002fff
    ```

    Although the **Update Signature** value may not always be accurately reported when you analyze a crash dump file, the **Update Signature** field generally indicates the microcode update revision that is applied to the CPU. In the previous example, this value is 0 (0000000000000000). The currently supported revision is 0x18 (0000001800000000), as shown in the following example output:

    ```console
    0: kd> !cpuinfo
    CP F/M/S Manufacturer MHz Update Signature Features
    TargetInfo::ReadMsr is not available in the current debug session
     0 15,2,9 GenuineIntel 2994>0000001800000000<00033fff
     1 15,2,9 GenuineIntel 2994 0000001800000000 00033fff
     2 15,2,9 GenuineIntel 2994 0000001800000000 00033fff
     3 15,2,9 GenuineIntel 2994 0000001800000000 00033fff
    ```

2. Use the `!pcitree` command to find the vendor and device identifiers (VenDev IDs) for existing Peripheral Connect Interface (PCI) devices. The following is an example of the output from the `!pcitree` command:

    ```console
    0: kd> !pcitree
    Bus 0x0 (FDO Ext 85dceed8)
      0600 00141166 (d=0,  f=0) devext 85dcf348 Bridge/HOST to PCI
      0600 00141166 (d=0,  f=1) devext 85e110e8 Bridge/HOST to PCI
      0600 00141166 (d=0,  f=2) devext 85e11ee8 Bridge/HOST to PCI
      0100 00c09005 (d=2,  f=0) devext 85e11ce8 Mass Storage Controller/SCSI
      0100 00c09005 (d=2,  f=1) devext 85e11ae8 Mass Storage Controller/SCSI
      0300 47521002 (d=3,  f=0) devext 85e11788 Display Controller/VGA
      0200 16a614e4 (d=4,  f=0) devext 85e11428 Network Controller/Ethernet
      0880 a0f00e11 (d=5,  f=0) devext 85dcdee8 Base System Device/'Other' base system device
      0601 02011166 (d=f, f=0) devext 85dcdb88 Bridge/PCI to ISA
      0101 02121166 (d=f, f=1) devext 85dcd988 Mass Storage Controller/IDE
      0c03 02201166 (d=f, f=2) devext 85dcd628 Serial Bus Controller/USB
      0600 02251166 (d=f, f=3) devext 85dcd2c8 Bridge/HOST to PCI
      0600 01011166 (d=11, f=0) devext 85e100e8 Bridge/HOST to PCI
      0600 01011166 (d=11, f=2) devext 85e10ee8 Bridge/HOST to PCI
    Bus 0x2 (FDO Ext 85dcecd8)
      0104 00460e11 (d=2,  f=0) devext 85e0f9a8 Mass Storage Controller/RAID
    Bus 0x5 (FDO Ext 85dce9d8)
    No devices have been enumerated on this bus.
    Total PCI Root busses processed = 3
    ```

    For each PCI device that is listed, the first 8-digit hexadecimal value (DWORD) on each line is the VenDev ID. The Vendor ID is actually the second 4 digits of this value. For example, the first device that is listed in the previous example has a VenDev ID of 0x00141166. The Device ID is 0x0014, and the Vendor ID is 0x1166. The Vendor ID for ServerWorks is 0x1166. So this output is from a processor that is installed on a motherboard that uses ServerWorks chipsets.

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
