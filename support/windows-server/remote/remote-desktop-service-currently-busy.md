---
title: Remote Desktop Service Is Currently Busy Message on Connecting
description: Troubleshoot the Remote Desktop Service is currently busy error when users start a remote desktop connection.
ms.date: 02/08/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, rklemen, v-lianna
ms.custom: sap:Remote Desktop Services and Terminal Services\Session connectivity, csstroubleshoot
---

# "Remote Desktop Service is currently busy" message during RDP connections

This article provides guidance on troubleshooting the "Remote Desktop Service is currently busy" message encountered during Remote Desktop Protocol (RDP) connections.

## Initial triage troubleshooting

To begin troubleshooting, an important test is to access the affected computer by using the console (either a local physical console or, when you're using a virtual machine (VM), the hypervisor's VM console).

You aren't expected to receive the "Remote Desktop Service is currently busy" error message during the test because you aren't using RDP. The test helps find out if there are other types of issues during the logon, such as a different error message, a slow logon, or any other type of abnormal behavior.

If you encounter any other issues while logging in via the console, such as different error messages or unexpected behaviors, it likely indicates that the "Remote Desktop Service is currently busy" error is caused by another underlying issue on the system. We strongly recommend addressing the underlying issue before troubleshooting RDP.

> [!NOTE]
> If you're using the Hyper-V console to access the computer, make sure to use the **Basic session** to do the test. This is because the **Enhanced session** relies on RDP and you might receive the same "Remote Desktop Service is currently busy" message.
>
> If you find the issue occurs when using console and confirm that the issue isn't RDP-related, some of the troubleshooting steps in this article, such as RDP server memory issues, might still be helpful to troubleshoot the overall system performance issues.

## RDP server memory issues

To troubleshoot this issue further, first try to restart the target computer.

If restarting the computer temporarily solves the issue, but the issue reoccurs later, its might indicate a memory leak or other types of leaks, such as session leaks or token leaks.

A potential workaround without restarting the whole system is to restart the Remote Desktop Services (RDS) service. If it solves the issue, it might indicate an issue with the service. You need to verify whether the service consumes an unusual or abnormal amount of memory.

> [!NOTE]
> Restarting the RDS service disconnects all current users that are connected via RDP. The sessions are maintained, though, and users might reconnect to their sessions.

### Memory leaks

Monitor if there's another service or process that consumes unusual memory. If so, restarting the service or killing the process is also a good troubleshooting step and possible workaround.

> [!NOTE]
> Leaks are often caused by non-Microsoft software. Without proper data capture and a support case opened with Microsoft, it's difficult to pinpoint the cause.
>
> A good approach to testing is gradually uninstalling different software and monitoring if the issue stops. Also, ensure all non-Microsoft software is updated.
>
> If you confirm the issue does occur only via RDP, it's advisable to uninstall any non-Microsoft software that interacts with the RDP stack.

### Session leaks

Another common reason for this type of memory-growing issue after a system restart is session leaks. In this situation, looking at resource consumption (such as looking for high memory or CPU consumption in Task Manager) doesn't show anything obvious because the issue is occurring "under the hood" on the system.

There might be several reasons for a session leak, but it's common that the leak is caused by non-Microsoft software. Particularly, it's very commonly caused by security software (such as antivirus or endpoint protection software) or other types of software that might interact with RDP user sessions.

> [!NOTE]
> Stopping the software doesn't have the same effect as totally uninstalling it from the system because there might still be modules loaded, hooks to the system's components, and so on.

If the issue is temporarily solved with a system restart, monitor if a certain process consumes an unusual amount of memory and if the memory consumption grows over time.

## GPO troubleshooting

Hardening on the system, configured via Group Policy Object (GPO), might also be a possible reason.

To troubleshoot the issue, identify and remove the related GPOs to test and monitor if the issue reoccurs. For example, RDS-related GPOs or hardening GPOs, such as changes made to "User Rights Assignment" security policies.

If possible, try to remove all GPOs from the system without causing technical or security implications. This solution is a good test to determine whether a GPO is causing the RDP issue.

You can also check the "GroupPolicy" event logs to see if any GPOs can't be processed or if there's a global issue with the Group Policy Client service (gpsvc). Both of them can be the cause of the RDP issue.

## Data collection

Even if you identify a certain process or service that consumes too much memory, you might not know the root cause. For unresolved issues, data collection is critical for complex analysis. Here are the steps for preparing data before contacting Microsoft support.

### Capture traces using the TSS tool

1. Download the latest version of the TroubleShootingScript (TSS) tool from [https://aka.ms/getTSS](https://aka.ms/getTSS)
2. Extract it to the RDP client computer (source) and the RDP server (target).

   > [!NOTE]
   > In scenarios of a full RDS deployment, although the system displaying the "Remote Desktop Service is currently busy" message is the most important for data capture, you should collect data from all systems involved in the connection flow, including the RD Connection Broker and RD Gateway.

3. Open a PowerShell prompt on both systems and run the following commands respectively:

   On the RDP client:

   ```console
   .\TSS.ps1 -Scenario UEX_RDSCli
   ```

   On the RDP server:

   ```console
   .\TSS.ps1 -Scenario UEX_RDSSrv
   ```

4. Wait for the "Reproduce the issue now" message to appear.
5. Reproduce the connection until you receive the "Remote Desktop Service is currently busy" error.
6. Stop the traces at this stage by pressing the requested key.
7. Gather the data from the location specified by the tool. (usually **C:\MS_DATA**).

### Complete memory dump

You should take a complete memory dump when the system is affected while reproducing an RDP connection that generates the "Remote Desktop Service is currently busy" error message.

> [!NOTE]
> Keep the connection with the "Remote Desktop Service is currently busy" error open while taking the dump.

Note down the user account used to reproduce this connection.

#### Capture dumps in a hypervisor or VM scenario

- Take a snapshot of the VM with the **Complete memory dump** option selected, if the hypervisor provides this option, when taking the dump (as described earlier).
- Convert the snapshot to a complete memory dump.

> [!NOTE]
> Each hypervisor manufacturer uses different tools and methods to convert the snapshot to a complete dump. For instructions on how to perform this conversion, check the support documentation of that hypervisor vendor.

#### Capture dumps on a physical system

Follow the steps described in [Generate a kernel or complete crash dump](../../windows-client/performance/generate-a-kernel-or-complete-crash-dump.md).

### Possible additional data

Different types of data can be captured depending on the situations discussed in this article. For example, if a specific process or service shows increasing memory consumption, a specific Windows Performance Recorder (WPR) capture should be performed to capture the heap memory consumption of that process. However, Microsoft support will inform you of any extra data that might need to be captured after the initial analysis based on your situation.
