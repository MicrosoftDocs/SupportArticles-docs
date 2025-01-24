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

This article introduces how to troubleshoot the "Remote Desktop Service is currently busy" message.

## Initial triage troubleshooting

An important first test to perform is to access the affected target system via console (either physical console / locally, or, in case of a Virtual Machine, through the Hypervisor’s VM console.

It is not expected on this test that we will also get the error message “RDS Service is currently busy” since we are not accessing via RDP, but we can this way understand if we have other types of issue when performing the logon – such as a different error message, a slow logon or any other type of abnormal behavior.
If so, this will strongly suggest we are facing another type of issue with the system, that is not RDP related, being RDP the victim of that unhealthy system state and retrieving the ” Remote Desktop Service is currently busy” upon connection.
In this situation, we should address this issue as a non-RDP issue during a first troubleshooting approach.

> [!NOTE]
> In case we are using Hyper-V console to access the system, make sure to use “Basic session”, since “Enhanced session” will rely on RDP protocol and we may receive the same “RDS is currently busy” message, as it will not be a “pure console” (no RDP involved) connection.
>
> If we do understand the issue is non-RDP related – if it occurs as well via console – the situation shouldn’t be approached as an RDP issue. Still, some of the troubleshooting steps mentioned below, related to RDP related troubleshooting (e.g., RDP server memory issue) may still be valid to troubleshoot overall system performance issues.

## RDP server memory issue

If restarting the system temporarily solves the issue until it returns, this may indicate a memory leak or other types of leaks (session leak, token leak, etc.).

Restart the “Remote Desktop Services” service. If it solves the issue, it may suggest it’s an issue related to this service, and we should also try to understand if the service is indeed consuming an unusual / abnormal amount of memory.
 This is also a potential workaround without having to restart the whole system.

> [!NOTE]
> Restarting RDS service will disconnect all current users that are connected via RDP. The sessions will be maintained though, and users may reconnect to their sessions.
>
> If we do understand the issue is non-RDP related – if it occurs as well via console – the situation shouldn’t be approached as an RDP issue. Still, some of the troubleshooting steps mentioned below, related to RDP related troubleshooting (e.g., RDP server memory issue) may still be valid to troubleshoot overall system performance issues.

Monitor if there’s another service or process with an usual memory consumption. If so, restarting the service or killing the process is also a good troubleshooting step and possible workaround.

Leaks are often caused by third-party software. Without proper data capture and a support case opened with Microsoft, it is difficult to pinpoint the cause.

Testing by gradually uninstalling different software and monitoring if the issue stops can be a good approach. Ensure all third-party software is updated.

If we confirm the issue does occur only via RDP, it is advisable to uninstall any third-party software that interacts with the RDP stack.

Another common reason for this type of “growing” issue after system restart is session leaks, which is one of those situations where by looking at resource consumption (such as looking for high memory or CPU consumption in Task Manager) will not show anything obvious as the issue is occurring “under the hood” on the system.
There may be several different reasons for session leak but, again, it is very common it is caused by 3rd party software.
In the particular case of session leak, is also very common that this is caused by security software (Anti-virus, EndPoint protection software, etc.) or other types of software that may interact with RDP user’s sessions.

> [!NOTE]
> Stopping the software does not have the same effect as totally uninstalling it from the system, as there may still be modules loaded, hooks to the system’s components, etc.

If the issue is temporarily solved with a system restart, monitor if a certain process is consuming an unusual amount of memory and if its memory consumption is growing over time.

## GPO troubleshooting

Hardening on the system, configured via GPO, may also be a possible reason. Identifying and removing related GPOs (e.g., RDS related GPOs or hardening GPOs such as changes made to "User Rights Assignment" Security policies) is a good test while monitoring if the issue returns.
If possible, try to remove all GPOs from the system without that causing technical or security implications, that would be a good test as well, to narrow down if it is a GPO causing it.

We can also check the “GroupPolicy” event logs to try to understand if there may be any GPO failing to be processed or if there’s a global issue with GPService, which can also be reasons to trigger this behavior.

## Data collection

Although we’ve discussed many possible reasons related to what may cause this type of issue, for this kind of situation it’s usually not possible to know what is causing the issue without proper data capture and complex analysis - even if we identify a certain process or service that consumes too much memory, we will unlikely know what the root cause is for that high memory consumption.

We will now discuss data that can be captured in advance before opening a support case with Microsoft’s support.

### Traces capture using TSS tool

Download the latest version of the TSS tool from [https://aka.ms/GeTSS](https://aka.ms/GeTSS)

Extract it to the RDP client system (source) and RDP server (target)

> [!NOTE]
> For scenarios of a full RDS deployment, although the system where the “RDS service is currently busy” is showing, is the most important system to capture the data in, we should capture the data in all systems of the deployment involved in the connection flow (which includes RD Connection Broker and RD Gateway).

Launch a PowerShell prompt on both systems and run the following commands, respectively:

RDP Client:

```console
.\TSS.ps1 -Scenario UEX_RDSCli
```

RDP Server(s):

```console
*.\TSS.ps1 -Scenario UEX_RDSSrv*
```

Wait for the message that states to “Reproduce the issue now”

Reproduce the connection until we get the “RDS is currently busy” error

Stop the traces at this stage, by pressing the requested key to do so

Gather the data from where the tool informs it was saved (usually “C:\MS_DATA”)

### Full memory dump

We should take the full memory dump at the time the system is in the affect state and while reproducing a RDP connection that will generate the “RDS is currently busy” error message.

> [!NOTE]
> Keep the connection with the error “RDS is currently busy” open while taking the dump, i.e., don’t close this connection and take the dump while the error is still being displayed on the affected connection.
Please note down what was the user account used to reproduce this connection.

### Capture dump on a Hypervisor / Virtual Machine scenario

- Take a snapshot to the Virtual Machine – with “full memory” option selected, if the Hypervisor provides this option - at the time the dump should be taken (as described above).
- Convert the snapshot to a full memory dump.

> [!NOTE]
> Each Hypervisor manufacturer uses different tools / methods to convert the snapshot to full dump. Please check on the support documentation of that Hypervisor vendor how to perform this conversion.

### Capture dump on physical system

Please follow the steps described on the following article:
[Generate a kernel or complete crash dump](https://learn.microsoft.com/en-us/troubleshoot/windows-client/performance/generate-a-kernel-or-complete-crash-dump)

### Possible additional data

There are different types of data that can be captured according to the different situations we’ve discussed within this article (for example, when a specific process / service that has growing memory consumption, a specific WPR capture should be performed to capture heap memory consumption of that process), but Microsoft’s support will inform accordingly what additional data may need to be captured after the first analysis is done and according to the situation we are facing.
