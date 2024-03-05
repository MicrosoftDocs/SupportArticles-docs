---
title: High CPU usage in LSAISO process
description: Fixes a problem in which the LSAISO process experiences high CPU usage on a computer that's running Windows.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:slow-performance, csstroubleshoot
---
# High CPU usage in the LSAISO process on Windows

This article provides resolutions of a problem in which the LSAISO process experiences high CPU usage on a computer that's running Windows.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 4032786

## Symptoms

The LSAISO (LSA Isolated) process experiences high CPU usage on a computer that's running Windows 10, Windows Server 2016, or later versions.

## Cause

In Windows, the LSAISO process runs as an Isolated User Mode (IUM) process in a new security environment that is known as Virtual Secure Mode (VSM).

Applications and drivers that try to load a DLL into an IUM process, inject a thread, or deliver a user-mode APC may destabilize the entire system. This destabilization can include the high LSAISO CPU scenario that is mentioned in the "Symptoms" section.

## Resolution 1: Use the process of elimination

It's common for some applications (such as antivirus programs) to inject DLLs or queue APCs to the LSAISO process. This causes the LSAISO process to experience high CPU usage.

For troubleshooting, it's not possible to attach tools to a IUM process. This prevents you from using the Windows Debugging Tools or WPA\XPERF to capture stack traces during the LSAISO CPU spiking. So the best troubleshooting method in this scenario is to use the "process of elimination" methodology. To do this, disable applications and drivers until the CPU spike is mitigated. After you determine which software is causing the problem, contact the vendor for a software update. You can reference the ISV recommendations that are listed in the following MSDN topic:

[Isolated User Mode (IUM) Processes](/windows/win32/procthread/isolated-user-mode--ium--processes)

> [!NOTE]
> This method may require a reboot after you disable the suspected software and drivers as you test for the CPU spike.

## Resolution 2: Check for queued APCs

Download the free Debugging Tools for Windows (WinDbg, KD, CDB, NTSD). These tools are included in both the Windows Driver Kit (WDK) and the Windows Driver Kit (WDK). Then, follow these steps to determine which driver is queuing an APC to LSAISO:

1. While you reproduce the CPU spike, generate a kernel memory dump by using a tool such as NotMyFault.exe from the following Sysinternals website:

    [Sysinternals Suite](/sysinternals/downloads/sysinternals-suite)
  
    > [!NOTE]
    > A complete memory dump isn't recommended because it would require decryption if VSM is enabled on the system. To enable the kernel dump, follow these steps:
  
    1. Open the **System** item in Control Panel, and then select **Advanced system settings**.
    2. On the **Advanced**  tab of the **System Properties**  dialog box, select **Settings** in the **Startup and Recovery** area.
    3. In the **Startup and Recovery** dialog box, select **Kernel memory dump** in the **Write debugging information** list.
    4. Note the **Dump File** location to use in step 5, and then select **OK**.
2. Open the WinDbg.exe tool from the Debugging Tools for Windows.
3. On the **File** menu, click **Symbol File Path**, add the following path for the Microsoft Symbol Server to the **Symbol path** box, and then select **OK**:  
   `https://msdl.microsoft.com/download/symbols`
4. On the **File** menu, click **Open Crash Dump**.
5. Browse to the location of the kernel dump file that you noted in step 1d, and then select **Open**. Check the date on the .dmp file to make sure that it was newly created during this troubleshooting session.
6. In the **Command** window, type **!apc**, and then press Enter.

    :::image type="content" source="media/lsaiso-process-high-cpu-usage/type-apc.png" alt-text="Screenshot of the command box of the kernel dump file which shows !apc.":::  

    The output should resemble the following screenshot.

    :::image type="content" source="media/lsaiso-process-high-cpu-usage/apc-output.png" alt-text="Screenshot of the output of the !apc command. In this example, a driver that is named ProblemDriver.sys is listed under LsaIso.exe.":::
7. Search the results for **LsaIso.exe**. If a driver that is named \<ProblemDriver>.sys is listed under **LsaIso.exe** (as shown in the example screenshot of output in step 6), contact the vendor, and then refer them to the recommended mitigation that is listed in the [Isolated User Mode (IUM) Processes](/windows/win32/procthread/isolated-user-mode--ium--processes) topic.

    > [!NOTE]
    > If no drivers are listed under **Lsaiso.exe**, this means that the LSAISO process has no queued APCs.

## More information

VSM uses isolation modes that are known as Virtual Trust Levels (VTL) to protect IUM processes (also known as trustlets). IUM processes such as LSAISO run in VTL1 while other processes run in VTL0. The memory pages of processes that run in VTL1 are protected from any malicious code that is running in VTL0.

Prior to Windows 10 and Windows Server 2016, the Local Security Authority Subsystem Service (LSASS) process was solely responsible for managing the local system policy, user authentication, and auditing while it also handled sensitive security data such as password hashes and Kerberos keys.

To use the security benefits of VSM, the LSAISO trustlet that runs in VTL1 communicates through an RPC channel with the LSAISO process that's running in VTL0. The LSAISO secrets are encrypted before they're sent to LSASS, and the pages of LSAISO are protected from any malicious code that's running in VTL0.
