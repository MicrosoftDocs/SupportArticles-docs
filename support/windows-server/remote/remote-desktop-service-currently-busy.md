---
title: User receives Remote Desktop Service is currently busy message on connecting
description: Troubleshoot the Remote Desktop Service is currently busy error when users start a remote desktop connection.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, rklemen, v-lianna
ms.custom: sap:Remote Desktop Services and Terminal Services\Session connectivity, csstroubleshoot
---
# User receives "Remote Desktop Service is currently busy" message on connecting

This article provides guidance on troubleshooting the "Remote Desktop Service is currently busy" message encountered during Remote Desktop Protocol (RDP) connections.

## Initial triage troubleshooting

To begin troubleshooting, an important test is to access the affected computer by using the console (Either through a physical console locally, or, in the case of a virtual machine, through the Hypervisor's VM console.)

It is not expected to receive the "RDS Service is currently busy" error message during the test because we are not using RDP. The test help us find whether we have other types of issue during the logon. For example, a different error message, a slow logon or any other type of abnormal behavior.

If any other issue is found, the "Remote Desktop Service is currently busy" error message might be caused by issue. We strongly suggest addressing the issue before troubleshooting RDP.

> [!NOTE]
> In case we are using Hyper-V console to access the computer, make sure to use **Basic session** to do the test. This is because **Enhanced session** relies on RDP and we might receive the same "Remote Desktop Service is currently busy" message.
>
> If we find the issue occurs when using console, and confirmed that the issue is not RDP related, some of the troubleshooting steps in this article such as RDP server memory issue might still be help to troubleshoot the overall system performance issues.

## RDP server memory issue

To troubleshoot this issue further, first try to restart the target computer.

If restarting the computer temporarily solves the issue, but the issue reoccurs later, this might indicate a memory leak or other types of leaks, such as session leak, token leak and so on.

A potential workaround without restarting the whole system is to restart the Remote Desktop service. If it solves the issue, it might indicate an issue with the service. You need to verify whether the service is indeed consuming an unusual or abnormal amount of memory.

> [!NOTE]
> Restarting RDS service will disconnect all current users that are connected via RDP. The sessions will be maintained though, and users may reconnect to their sessions.

### Memory leaks

Monitor if there's another service or process with unusual memory consumption. If so, restarting the service or killing the process is also a good troubleshooting step and possible workaround.

> [!NOTE]
> Leaks are often caused by third-party software. Without proper data capture and a support case opened with Microsoft, it is difficult to pinpoint the cause.
>
> Testing by gradually uninstalling different software and monitoring if the issue stops can be a good approach. Also, ensure all third-party software is updated.
>
> If we confirm the issue does occur only via RDP, it is advisable to uninstall any third-party software that interacts with the RDP stack.

### Session leaks

Another common reason for this type of memory growing issue after system restart is session leaks, which is one of those situations where by looking at resource consumption (such as looking for high memory or CPU consumption in Task Manager) will not show anything obvious as the issue is occurring “under the hood” on the system.

There may be several different reasons for session leak, but it is very common that the leak is caused by 3rd party software. Particularly, it is very commonly caused by security software (such as antivirus or endpoint protection software) or other types of software that may interact with RDP user sessions.

> [!NOTE]
> Stopping the software does not have the same effect as totally uninstalling it from the system, because there may still be modules loaded, hooks to the system’s components, and so on.

If the issue is temporarily solved with a system restart, monitor if a certain process is consuming an unusual amount of memory and if the memory consumption is growing over time.

## GPO troubleshooting

Hardening on the system, configured via GPO, might also be a possible reason.

To troubleshoot the issue, identify and remove related GPOs to test and monitor if the issue reoccurs. For example, RDS related GPOs or hardening GPOs such as changes made to "User Rights Assignment" Security policies.

If possible, try to remove all GPOs from the system without that causing technical or security implications. This solution is a good test to narrow down if it is a GPO causing the RDP issue.

We can also check the "GroupPolicy" event logs to understand if there may be any GPO failing to be processed, or if there’s a global issue with GPService. Both of them can be the cause of the RDP issue.

## Data collection

Even if we identify a certain process or service that consumes too much memory, we will unlikely know what the root cause is. For unresolved issues, data collection is critical for complex analysis. Here are steps for preparing data before contacting Microsoft support.

### Traces capture using TSS tool

1. Download the latest version of the TSS tool from [https://aka.ms/GeTSS](https://aka.ms/GeTSS)
2. Extract it to the RDP client computer (source) and the RDP server (target).

   > [!NOTE]
   > In scenarios of a full RDS deployment, although the system displaying the "RDS service is currently busy" message is the most important for data capture, we should collect data from all systems involved in the connection flow, including the RD Connection Broker and RD Gateway.

3. Launch a PowerShell prompt on both systems and run the following commands, respectively:

   On RDP client:

   ```console
   .\TSS.ps1 -Scenario UEX_RDSCli
   ```

   On RDP Server(s):

   ```console
   *.\TSS.ps1 -Scenario UEX_RDSSrv*
   ```

4. Wait for the message that states to **Reproduce the issue now**.
5. Reproduce the connection until we get the "Remote Desktop Service is currently busy" error.
6. Stop the traces at this stage, by pressing the requested key.
7. Collect the data from the location where the tool prompts.
8. Gather the data from the location specified by the tool. (usually C:\MS_DATA).

### Full memory dump

We should take a full memory dump when the system is in the affected state and while reproducing an RDP connection that generates the "Remote Desktop Service is currently busy" error message.

> [!NOTE]
> Keep the connection with the error “RDS is currently busy” open while taking the dump, i.e., don’t close this connection and take the dump while the error is still being displayed on the affected connection.

Note down what was the user account used to reproduce this connection.

#### Capture dump on a hypervisor or virtual machine scenario

- Take a snapshot to the virtual machine with "full memory" option selected, if the hypervisor provides this option. At the time the dump is be taken (as described above).
- Convert the snapshot to a full memory dump.

> [!NOTE]
> Each Hypervisor manufacturer uses different tools / methods to convert the snapshot to full dump. Please check on the support documentation of that Hypervisor vendor how to perform this conversion.

#### Capture dump on physical system

Follow the steps described on the following article:

[Generate a kernel or complete crash dump](https://learn.microsoft.com/en-us/troubleshoot/windows-client/performance/generate-a-kernel-or-complete-crash-dump)

### Possible additional data

There are different types of data that can be captured depending on the situations discussed in this article. For example, if a specific process or service shows growing memory consumption, a specific Windows Performance Recorder (WPR) capture should be performed to capture the heap memory consumption of that process. However, Microsoft support will inform you of any additional data that may need to be captured after the initial analysis, based on the situation we are facing.
