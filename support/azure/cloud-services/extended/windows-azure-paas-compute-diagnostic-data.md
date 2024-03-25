---
title: Windows Azure platform as a service compute diagnostic data
description: Learn what data is available in Azure platform as a service (PaaS) compute environments. Discover how to gather this data from a PaaS Windows virtual machine.
ms.date: 09/26/2022
editor: v-jsitser
ms.reviewer: v-maallu, v-leedennis
ms.service: cloud-services
ms.subservice: troubleshoot-extended-support
#Customer intent: As an Azure virtual machine user, I want to know what kinds of compute diagnostic data can be extracted from a platform as a service (PaaS) Windows virtual machine (VM) so that I can use this data to help troubleshoot various problems.
---

# Windows Azure platform as a service (PaaS) compute diagnostic data

When you have to troubleshoot a problem, one of the most important things to understand is what diagnostic data is available. If you don't know where to look for logs or other diagnostic information, you might have to resort to the trial-and-error or shotgun approach to troubleshooting. If you have access to logs, you have a better chance of diagnosing any problem, even if it isn't within your area of expertise.

This article discusses the data that's available in Azure platform as a service (PaaS) compute environments. It describes how you can easily gather this data from a Windows PaaS virtual machine (VM).

The following sections include the most commonly used data sources when you troubleshoot problems in a Windows PaaS VM. The sections are ordered roughly by importance (the frequency of using the log to diagnose problems).

## Windows Azure event logs

Windows Azure event logs contain key diagnostic output from the Azure runtime. The logs record information about such events as the following:

- Role starts and stops
- Startup tasks
- `OnStart` start and stop
- `OnRun` start
- Crashes
- Recycles

To view the Windows Azure event logs:

1. On the **Start** menu, search for *Event Viewer*, and then select that app.

1. In the navigation pane, expand **Applications and Services Logs**, and then select **Windows Azure**.

This diagnostic source helps you identify the cause of several of the most common problems that prevent Azure roles from starting correctly. These include startup task failures and crashing in `OnStart` or `OnRun`. Event Viewer captures crashes in the Azure runtime host processes that run your role entry point code (such as *WebRole.cs* or *WorkerRole.cs*), and provides call stacks.

## Application event logs

You can use application event logs for standard troubleshooting on both Azure and on-premises servers. You might often find *w3wp.exe*-related errors in these logs.

To view the application event logs:

1. On the **Start** menu, search for *Event Viewer*, and then select that app.

1. In the navigation pane, expand **Windows Logs**, and then select **Application**.

## App agent runtime logs

The app agent runtime log is located at *C:\\Logs\\AppAgentRuntime.log* and is written by the *WindowsAzureGuestAgent.exe* executable. The log contains information about events that occur within the guest agent and the VM. This event information includes, but isn't limited to, the following categories:

- Firewall configuration
- Role state changes
- Recycles
- Reboots
- Health status changes
- Role stops and starts
- Certificate configuration

This log is useful to get a quick overview of the events that occur over time to a role. This is because it records major changes to the role without logging heartbeats. If the guest agent can't start the role correctly (for example, if a locked file prevents directory cleanup), you'll see the event recorded in this log.

## App agent heartbeat logs

The app agent heartbeat log is located at *C:\\Logs\\WaAppAgent.log* and is written by the *WindowsAzureGuestAgent.exe* executable. It contains status information about the health probes to the host bootstrapper.

The guest agent process is responsible for reporting health status (for example, `Ready` or `Busy`) to the fabric. Therefore, the health status that this log reports is the same as the status that you'll see in the management portal. The log is useful to determine the current state of the role within the VM, or to determine what the state was at some previous time. You can provide problem descriptions such as "My website was down from 10:00 AM to 11:30 AM yesterday" to use the heartbeat log to help you determine the health status of the role during that time.

## Host bootstrapper logs

The host bootstrapper log is located at *C:\\Resources\\WaHostBootstrapper.log*. It contains entries for startup tasks, including plug-ins such as Caching or Remote Desktop Protocol (RDP). The log also contains health probes for the host process that runs your role entry point code (the *WebRole.cs* code that runs in *WaIISHost.exe*).

A log file is generated every time that the host bootstrapper is restarted. (In other words, it restarts whenever your role is recycled because of an event such as a crash, recycle, VM restart, or upgrade.) This practice makes the log easy to use to determine how often or when your role was recycled.

## Internet Information Services logs

The Internet Information Services (IIS) logs are located at *C:\\Resources\\Directory\\\<DeploymentID>.\<RoleName>.DiagnosticStore\\LogFiles\\Web*. These logs are used for standard troubleshooting on both Azure and on-premises servers.

IIS logs are often overlooked in scenarios such as "My website was down from 10:00 AM to 11:30 AM yesterday." It's natural to blame Azure for the outage. ("My site was working fine for two weeks, so the problem must be Azure!") However, the IIS logs often indicate otherwise. You might find that increased response times occurred immediately before the outage. Or, you might find that non-success status codes were returned by IIS. These codes would indicate a problem that occurred within the website itself (that is, in the ASP.NET code that runs in *w3wp.exe*) and not in Azure.

## Performance counters

To view performance counters, select the **Start** menu, search on *perfmon*, and then select **Performance Monitor**. This app is a snap-in to the Microsoft Management Console (MMC). Alternatively, [install and configure Windows Azure diagnostics extension (WAD)](/azure/azure-monitor/agents/diagnostics-extension-windows-install).

Performance counters are used for standard troubleshooting on both Azure and on-premises servers. If you set up WAD ahead of time, you'll often have valuable performance counters to troubleshoot problems that occurred in the past (for example, "My website was down from 10:00 AM to 11:30 AM yesterday.").

Aside from problems for which you gather specific performance counters, the most common uses for performance counters that are gathered by WAD is to look for the following items, in the given order:

1. Regular performance counter entries

1. A period of no entries

1. One of the states in the following table.

   | State                           | Description                                                               |
   |---------------------------------|---------------------------------------------------------------------------|
   | The resuming of regular entries | A scenario in which the VM potentially had not been running               |
   | 100 percent CPU usage           | An infinite loop or some other logic problem in the website's code itself |

## HTTP.SYS logs

The HTTP.SYS logs are located at *D:\\Windows\\System32\\LogFiles\\HTTPERR*. These logs are used for standard troubleshooting on both Azure and on-premises servers.

As is true for [IIS logs](#internet-information-services-logs), the HTTP.SYS logs are often overlooked. However, they're important when you try to troubleshoot a problem in which a hosted service website isn't responding. Often, this problem is caused by IIS being unable to process the volume of requests that come in. The evidence for this cause usually appears in the HTTP.SYS logs.

## IIS failed request log files

"IIS failed request" log files are located at *C:\\Resources\\Directory\\\<DeploymentID>.\<RoleName>.DiagnosticStore\\FailedReqLogFiles*. These logs are used for standard troubleshooting on both Azure and on-premises servers.

By default, these log files aren't turned on in Windows Azure. They're rarely used. However, if you're troubleshooting problems that are specific to IIS or ASP.NET, you should consider turning on FREB (failed request event buffering) tracing. FREB tracing can provide more details about these problems.

## Windows Azure diagnostics tables and configuration

The tables and configuration for the Windows Azure diagnostics extension (WAD) are located at *C:\\Resources\\Directory\\\<DeploymentID>.\<RoleName>.DiagnosticStore\\Monitor*. These items represent the local on-VM cache of the WAD data.

WAD takes the following steps:

1. Captures the data as you've configured it.

1. Stores the data in custom .tsf files on the VM.

1. Transfers the data to storage based on the scheduled transfer period that you specified.

Unfortunately, because the data is in a custom .tsf format, the contents of the WAD data are of limited use. But they do contain the diagnostic configuration files that are useful to troubleshoot problems if WAD isn't working correctly. In the *Configuration* folder, look for a file that's named *config.xml*. This file includes the configuration data for WAD. If WAD isn't working correctly, check this file to make sure that it's reflecting the way that you expect WAD to be configured.

## Windows Azure caching log files

The Windows Azure caching log files are located at *C:\\Resources\\Directory\\\<DeploymentID>.\<RoleName>.DiagnosticStore\\AzureCaching*. These logs contain detailed information about Windows Azure role-based caching. The logs can help you troubleshoot problems in which caching isn't working as expected.

## WaIISHost logs

The WaIISHost log is located at *C:\\Resources\\Directory\\\<DeploymentID>.\<RoleName>.DiagnosticStore\\WaIISHost.log*. It contains information from the *WaIISHost.exe* process. This process is where your role entry point code (*WebRole.cs*) runs for WebRoles. Most of this information is also included in the other logs that are discussed in this article (such as the [Windows Azure event logs](#windows-azure-event-logs)). However, you might occasionally find more useful information here.

## IISConfigurator logs

The IISConfigurator log is located at *C:\\Resources\\Directory\\\<DeploymentID>.\<RoleName>.DiagnosticStore\\IISConfigurator.log*. It contains information about the IISConfigurator process. This process is used to do the actual IIS configuration of your website, based on the model that you defined in the service definition files. The process rarely fails or encounters errors. But if IIS or *w3wp.exe* doesn't seem to be set up correctly for your service, this log is the place to check.

## Role configuration files

The role configuration file is located at *C:\\Config\\\<DeploymentID>.\<RoleName>.\<Version>.xml*. It contains information about the configuration for your role, such as the following items:

- Settings that are defined in the *ServiceConfiguration.cscfg* file

- Local resource directories

- IP addresses and ports for dynamic IP (DIP) and virtual IP (VIP)

- Certificate thumbprints

- Load balancer probes

- Other instances

The role configuration file is similar to the [role model definition file](#role-model-definition-file) in that it doesn't contain runtime-generated information. However, it can be useful to make sure that your service is configured as expected.

## Role model definition file

The role model definition file is located at *E:\\RoleModel.xml* or *F:\\RoleModel.xml*. It contains information about how your service is defined according to the Azure runtime.

The file contains entries for each startup task and information about how the task is run, including the following characteristics:

- Background
- Environment variables
- Location

You can also see how your **\<sites>** element is defined for a web role.

The role model definition file doesn't contain runtime-generated information, but it can help you verify that Azure is running your service as you expect. This verification often helps when you have a particular version of a service definition on your development computer, but the build and package server is using another version of the service definition files.

## About ETL files

The *C:\\Logs* folder contains *RuntimeEvents_\<Iteration>.etl* and *WaAppAgent_\<Iteration>.etl* files. These event trace log (ETL) files are Event Tracing for Windows (ETW) traces that contain a compilation of the information that's found in the [Windows Azure event logs](#windows-azure-event-logs), [guest agent logs](#app-agent-runtime-logs), and other logs. The files are a convenient compilation of the most important log data in an Azure VM. Because the files are in ETL format, you have to take some extra steps to consume the information. If you have a favorite ETW viewing tool, you can ignore many of the mentioned log files. Instead, you can just look at the information in these two ETL files.

## Next steps

> [!div class="nextstepaction"]
> [Gather log files for offline analysis and preservation](gather-log-files-offline-analysis-preservation.md)

## More information

- [Azure role architecture](/archive/blogs/kwill/windows-azure-role-architecture)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
