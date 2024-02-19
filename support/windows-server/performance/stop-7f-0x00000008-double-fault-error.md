---
title: Stop 7F, 0x00000008 (double-fault) error
description: Provides a solution to a STOP 0x0000007F, 0x00000008 error message on your computer because of a specific processor error.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
---
# Stop 7F, 0x00000008 (double-fault) error occurs because of a single-bit error in the ESP register

This article provides a solution to a STOP 0x0000007F, 0x00000008 error message on your computer because of a specific processor error. This error message may be displayed when a single-bit error occurs in the ESP register of a processor that is running on the computer.

_Applies to:_ &nbsp; Windows Server 2012 R2  
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

1. Download the [Intel Processor Identification Utility](https://www.intel.com/content/www/us/en/download/12136/intel-processor-identification-utility-windows-version.html?wapkw=Frequency%20ID%20Utility).

2. Install and run the Intel Processor Identification Utility on the computer that is experiencing symptoms.

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

3. Run the `!analyze -v` command to obtain an automated analysis of the dump file.

4. Examine the output of the `!analyze -v` command to see if the output shows a double-fault condition. If a double-fault condition exists, run the `.tss 28` command to display the system state at the time of the double-fault. Generally, this value is relatively close to the value of the EBP register.

5. Run the `!thread` command to view the current thread's stack range. A double-fault exception typically occurs when the value of the ESP register is outside the range of addresses that are reserved for the stack for the current thread.

    When this particular thread is running, the ESP register value must always be between the Stack Base value (f5d2a000) and the Limit value (f5d27000). Generally, the value of the ESP register is relatively close to the Current value (f5d29c9c). (The Current value is also between the Stack Base value and the Limit value.)

    You may also be able to check the stack range values by running the `!pcr` command.

    The `NtTib.StackLimit` value represents the lower limit of the stack range. The `NtTib.StackBase` value represents a recent value of ESP. The `NtTib.StackBase` value may be compared against the current value of the ESP register to help identify whether there's a single-bit error in the current ESP register value.

6. Run the `.formats esp ^ ebp` command to display the differences in values between the ESP and EBP registers. The stack pointer value in the EBP register will be close to the stack pointer value in the ESP register, except for the single-bit error. This command frequently reveals the single high-order bit that contains the error, especially when the error is displayed in binary format.

    If you ignore the lower, least significant digits, the single-bit difference between the ESP and EBP registers is 00000000 00001000 00000000 00000000 in binary format. The difference is 00080000 in hexadecimal format.

    This single-bit error causes the ESP register to contain an incorrect value. The incorrect value causes a double-fault exception, a bug check, and a system crash.

To obtain more information about your specific hardware, follow these steps:

1. Use the `!cpuinfo` command to obtain CPU version information.

    Although the **Update Signature** value may not always be accurately reported when you analyze a crash dump file, the **Update Signature** field generally indicates the microcode update revision that is applied to the CPU.

2. Use the `!pcitree` command to find the vendor and device identifiers (VenDev IDs) for existing Peripheral Connect Interface (PCI) devices.

    For each PCI device that is listed, the first 8-digit hexadecimal value (DWORD) on each line is the VenDev ID. The Vendor ID is actually the second 4 digits of this value. For example, the first device that is listed has a VenDev ID of 0x00141166. The Device ID is 0x0014, and the Vendor ID is 0x1166. The Vendor ID for ServerWorks is 0x1166. So this output is from a processor that is installed on a motherboard that uses ServerWorks chipsets.

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
