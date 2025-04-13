---
title: Secure Time Seeding Recommendation for Windows Server
description: Describes workarounds for an issue in which the computer clock resets to a past date and time.
ms.date: 
manager: 
audience: itpro
ms.topic: troubleshooting
ms.reviewer: 
ms.custom:
- sap:active directory\windows time service configuration,accuracy,and synchronization
- pcy:WinComm Directory Services
keywords: Windows Time service, w32time, clock skew, NTP, STS, Secure Time Seeding
---

# Secure Time Seeding Recommendation for Windows Server

This article provides recommendations for Secure Time Seeding feature on Windows Server along with general good time synchronization practices.

_Applies to:_ &nbsp;All editions of Windows Server 2025, Windows Server 2022, Windows Server 2019, Windows Server 2016 and intermediate releases therein.


**Brief Summary**

Customers have reported timekeeping issues on Windows Server 2016 and newer Windows Server OS deployments linked to the [Secure Time Seeding (STS)](https://learn.microsoft.com/en-us/archive/blogs/w32time/secure-time-seeding-improving-time-keeping-in-windows) feature, due to its incompatibility with the affected deployments.

Based on customer reports and the associated feedback, we recommend the Secure Time Seeding (STS) feature to be disabled on your Windows Server 2016 and newer Windows Server machines hosting time-sensitive workloads. This includes any ADDS Domain Controllers, VM Hosts, Servers that use time for critical functionality or providing connectivity or as part of data processing in your deployments.

We recommend you consider disabling the STS feature on all your Windows Server 2016 and newer Windows Server machines hosting generic/non-time-sensitive workloads to avoid unforeseen timekeeping-related incompatibility issues arising from STS.

We recommend you review the timekeeping requirements for your Windows Server 2016 and newer Windows Server OS deployment(s) and ensure suitable time dissemination/synchronization and time monitoring are in place for Windows machines hosting time-sensitive workloads in your deployments, including any ADDS Domain Controllers and other potentially critical machines in your deployments.


## Document Overview

The primary audience of this document are administrators managing Windows Server 2016, Windows Server 2019, Windows Server 2022, Windows Server 2025 machines in their deployment. This document highlights potential issues with Secure Time Seeding (STS) feature on Windows Server OS and provides guidance and considerations relevant to disabling this feature in Windows Server OS deployments.

We recommend you read through this document for informational purposes even if you have already disabled STS in your deployments.

This article gives high-level overview of:
- The Secure Time Seeding (STS) feature in Windows OS
- STS-related timekeeping issues in some Windows Server OS SKUs reported to us
- Disabling STS Feature on Windows Server OS
- Critical aspects of timekeeping, time synchronization and dissemination
- A sample set of suggested actions for you to assess your time synchronization needs and to disable the STS feature on your Windows Server OS deployments.

## Overview of Secure Time Seeding (STS)

Secure Time Seeding (STS) is a heuristic based timekeeping mechanism on Windows OS that determines the approximate current time using time metadata from outbound SSL/TLS connections on a machine and uses that time information to detect and correct any large errors in the system clock on that machine.

The approximate time determined by STS depends on the time metadata available to the feature. This time metadata originates from the SSL/TLS servers that a machine connects to. Please refer to this article (originally published in 2016) for more details on the STS feature: [Secure Time Seeding – improving time keeping in Windows \ Microsoft Learn](https://learn.microsoft.com/en-us/archive/blogs/w32time/secure-time-seeding-improving-time-keeping-in-windows)

The primary goal of the STS feature is to correct system time when environmental factors such as hardware malfunctions or other sources introduce time errors large enough to prevent SSL/TLS from functioning as expected. The rate of incidence of such environment-induced time errors depends on the specific deployment environment.

STS produced reliable results in our observations, often better than long-term reliability of timekeeping on the computer hardware, for instance.

STS feature is enabled by default in all editions of Windows Server 2016, Windows Server 2019, Windows Server 2022, all editions of Windows Client OS starting with Windows 10 Release 1511 and all subsequent Windows Client OS releases, Windows IoT releases, and SKUs of all other Windows OS released with/after Windows Client release 1511.

STS feature is disabled by default on Windows Server 2025, based on customer feedback covered in the next section.

The subsequent section discusses the registry and Group Policy settings that could be used by an administrator to control the enablement of this feature in Windows OS.

## Timekeeping Issues Related to Secure Time Seeding (STS)

We received several customer incident reports of large and erroneous transient time jumps in Windows Server OS deployments that may have been caused by the Secure Time Seeding (STS) feature. These issues have the following common characteristics:
- These have been reported to occur in certain customer deployments on machines running various releases/versions of **Windows Server OS**.
- A low rate of incidence, when compared to overall deployment duration of STS feature.
- STS feature is enabled on the affected machines.
- W32time service sets the system time to a random incorrect value, with a time error varying from days, weeks to years.
- This is followed in a very high likelihood of W32time service automatically correcting the previously introduced error in system time after a noticeable but brief period, which varies from deployment to deployment.
- STS issues are not repeatable on demand in most cases.

Since these incidents occurred only when the STS feature was enabled, they may have been caused due to matching anomalous time metadata presented to STS feature from outbound SSL/TLS connections to different services on each of the affected machines. Such incidents indicate a potential incompatibility between STS feature and the applications/services deployed on the specific machines and/or in specific deployment environments.

We also received reports of customer incidents that involved large persistent time errors occurring on Windows Server OS machines with the STS feature enabled. In those timekeeping incidents, the time errors did not self-correct within a reasonable time, and were resolved after disabling the STS feature on the affected machines. This led to those customers discovering the incompatibility between the STS feature on the affected machines with applications running on the machine or with the specific deployment environment, and aided their decision to disable STS feature in the affected deployments.

STS was designed to function with the SSL/TLS metadata available in generic Windows OS deployments. All the customer reports about STS indicate to us that certain customer deployments of Windows Server OS may be incompatible with STS design heuristics, and the feature may not perform as expected in such scenarios.

We do not have information about specific applications or services or deployments that are incompatible with the STS feature. In case someone experiences time issues on a machine where STS is enabled, we recommend disabling STS to prevent it from potentially changing the system time to an incorrect value.

We received customer feedback that the STS feature should be disabled by default on the Windows Server OS, which we incorporated into the recently released Windows Server 2025 OS.

Some customers noticed the incorrect time issues (induced by STS or otherwise) on affected machines while investigating secondary effects of the incorrect time, since they do not monitor the time on such machines. We have also taken this experience into account in the guidance being provided later in this document.

## Disabling STS Feature on Windows Server OS

We are advising all enterprise customers who have deployed Windows Server OS (Releases Server 2016, Server 2019, Server 2022 and all intermediate releases therein) either as standalone machines or as part of ADDS to evaluate disabling the STS feature on those machines. This recommendation to disable STS applies even if you have never faced any prior issues with the STS feature. STS is disabled by default on Windows Server 2025, but please verify the STS settings even on this OS meet the requirements of your deployment.
- We recommend disabling the STS feature on Windows Server machines running any time-sensitive workloads, including these machines in your deployments:
  - ADDS Domain Controllers
  - Servers that use time for critical functionality
  - Servers that use time for providing connectivity
  - Servers that use time as part of data processing
  - VM Hosts
- We recommend you consider disabling the STS feature by default on Windows Server OS machines in your deployment, even if these machines do not host time-sensitive workloads and even if you never experienced STS related time issues on these machines.
- If you have never experienced STS issues on Windows Server OS machines in your environment and/or choose to continue using STS on those machines, please be advised of the issues in timekeeping potentially caused by this feature. We recommend that you take note of the STS issues on Windows Server OS and the guidance discussed in this document and plan for eventually disabling the STS feature on those machines in your deployment.

Settings to disable Secure Time Seeding:

Disabling (or enabling) STS requires administrators to modify settings either in the registry setting or in the group policy on the target machines and reboot those machines.

| Group Policy Setting | Local Setting |
|----------------------|---------------|
| Path: Computer Configuration\Administrative Templates\System\Windows Time Service<br><br>Group Policy: Global Configuration Settings<br>Setting: UtilizeSslTimeData<br>Value:<br>0 = STS disabled<br>1 = STS enabled<br>(Reboot required)<br>[https://learn.microsoft.com/en-us/windows-server/networking/windows-time-service/windows-time-service-tools-and-settings?tabs=config#using-local-group-policy-editor](https://learn.microsoft.com/en-us/windows-server/networking/windows-time-service/windows-time-service-tools-and-settings?tabs=config#using-local-group-policy-editor) | Please back up existing settings before making any registry changes.<br><br>Registry Key: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config<br>Value Name: UtilizeSslTimeData<br>Value Type: REG_DWORD<br>Value:<br>0 = STS disabled<br>1 = STS enabled<br>(Reboot required)<br>[https://learn.microsoft.com/en-us/windows-server/networking/windows-time-service/windows-time-service-tools-and-settings?tabs=config#windows-time-registry-reference](https://learn.microsoft.com/en-us/windows-server/networking/windows-time-service/windows-time-service-tools-and-settings?tabs=config#windows-time-registry-reference)<br><br>Command to disable STS Local setting in registry:<br>reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config" /v "UtilizeSslTimeData" /t REG_DWORD /d 0 /f |

Determine STS setting used by W32time service:
- Using Services Events (_not available on all editions and releases_):
  - (Optional) Start W32time Service: _net start w32time_
  - Locate Time-Service operational event log (Log name: Microsoft-Windows-Time-Service/Operational, File path: %SystemRoot%\System32\Winevt\Logs\Microsoft-Windows-Time-Service%4Operational.evtx)
  - Locate the latest event among the events 257, 260 and 263 and look for _UtilizeSslTimeData_ text in the event message.
    - “_UtilizeSslTimeData: 0_” indicates STS feature is disabled
    - “_UtilizeSslTimeData: X_” (X is a non-zero number) indicates STS feature is enabled
- Through W32time debug log (_available on all editions and releases_):
  - (optional) Archive any existing W32time debug log to avoid confusion.
    - Stop W32time service: _net stop w32time_
    - Archive existing W32time debug log: _move c:\w32time.log c:\w32time_archive.log_
  - Enable W32time service logging: _w32tm.exe /debug /enable /file:c:\w32time.log /size:100000000 /entries:0-300_
  - Restart W32time service
    - Stop W32time service: _net stop w32time_
    - Start W32time service: _net start w32time_
  - Look for the text indicating STS status in W32time.log:
    - “_ReadConfig: 'UtilizeSslTimeData'=0x00000000_” indicates STS is disabled
    - “_ReadConfig: 'UtilizeSslTimeData'=0xYYYYYYYY_”, where _YYYYYYYY_ is any non-zero hexadecimal number indicates STS is enabled.

Additionally, we recommend that you ensure appropriate time dissemination/ synchronization and time monitoring are in place to meet timekeeping requirements in your deployment (see below discussion regarding various timekeeping approaches). We believe this is essential for machines running time-sensitive workloads. It is also important for other deployments as well, given the unforeseen dependencies those deployments have on system time.

## Scope for the general recommendations in this document:

Recommendations on disabling Secure Time Seeding (STS) feature in this document are applicable to deployments running Windows Server OS SKUs (Windows Server 2016 and newer releases) only, based on the customer feedback we received. We have not received similar feedback on STS feature on non-Windows Server OS SKUs and hence, we do not extend the recommendations to non- Windows Server OS SKUs (various non-Server editions and releases of Windows OS 1511 or newer –e.g.: various editions and releases of Windows 10 Client SKUs, Windows 10 IoT,Windows 11 Client SKUs and Windows 11 IoT etc.).

Different Windows OS SKUs host different components and workloads, and are deployed in a variety of environments, all of which impact the available SSL/TLS time metadata and heuristic outcome of STS, as well as any downstream effects of STS issues. These factors, along with customer feedback we received mainly towards STS feature in Windows Server OS SKUs leads us to believe that such issues are not impacting all Windows OS SKUs uniformly.

Administrators can apply the general guidance in the following sections to review their own time dissemination and monitoring solutions for all Windows OS SKUs in their deployment for better timekeeping and insight into their deployment.

Handling issues on Windows SKUs outside the scope of the current for general recommendations:

This part of the note is included for completeness only. There are no current trends of this scenario occurring on non-Windows Server OS SKUs and there is no current general guidance to disabling STS in non- Windows Server OS SKUs.

There is a small but distinct possibility that machine(s) in a deployment running non-Windows Server OS SKUs (various non-Server editions and releases of Windows OS 1511 or newer – e.g.: Windows 10 Client SKUs, Windows 10 IoT, Windows11 Client SKUs and Windows 11 IoT etc.) may also experience STS-related time issues based on unique circumstances in that deployment and incidence of such issues can be mitigated only by disabling the STS feature on the affected machine(s).

Certain machines (e.g.: portable devices relying solely on aged rechargeable batteries as a power source and experience complete power drain before the next battery recharge) running Windows OS may be relying on STS to automatically correct gross time errors. These machines may require alternate intervention to correct the time if STS feature is disabled.

Administrators should take their deployment requirements and operational data into consideration, along with the general guidance provided in this document when deciding on disabling STS on non-Windows Server OS SKUs in their deployment. Thorough testing of any changes to Windows settings or any newly deployed solution is also recommended as part of this process.

## Time Synchronization, Time Monitoring and Disabling STS

Timekeeping and time synchronization are complex topics that are subjects of several papers and books. We have attempted to summarize some relevant aspects of this here to help our customers review their own time distribution mechanisms and gain operational insight into their deployment.
- Timekeeping on a machine can be influenced by software such as the OS itself, inbox services like W32time service, admin tools, 3rd party applications with sufficient privileges or by the underlying timekeeping firmware/hardware, backup CMOS clock/battery, runtime conditions on the CPU/Memory or even environmental conditions. Various timekeeping and time synchronization features in Windows aim to bring order to this seemingly chaotic process of timekeeping and attempt to keep a machine’s time within acceptable limits for a given use case.
- Commodity computing equipment typically needs time corrections, and this applies to devices running various Windows OS SKUs also. In-market Windows OS SKUs (Server 2016, Server 2019, Server 2022, Server 2025, Windows 10, Windows 11, Windows 10 IoT, Windows 11 IoT, inclusive of multiple intermediate releases and various other Windows OS SKUs) each have a default W32Time Service configuration to maintain and synchronize time on a generic device.
  - As part of this, STS is enabled by default on Windows Server 2016, Windows Server 2019, Windows Server 2022 and intermediate releases and is disabled by default on various editions of Windows Server 2025, based on customer feedback.
- Familiarize yourself with the W32time service registry settings documented here: [Windows Time service tools and settings \ Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/networking/windows-time-service/windows-time-service-tools-and-settings?tabs=config).
- Many customers modify the default W32Time settings to better suit their deployment and timekeeping requirements. Modifying the STS setting should be considered in a similar vein.
- Capturing the System Event Logs (among other event logs) on Windows systems in a deployment can be helpful in triaging various issues in the deployment.
  - Setting the system time in Windows OS results in Kernel-General Event #1 being logged in the System Event Log. The message text in this event has been bolstered over OS releases and all versions should log / identify the PID of the process setting the time and a way to compute the time change.
  - All events in the System Event Log include current Local System Time in the metadata.
  - Some Windows OS SKUs by default write the System event logs into this file: _%SystemRoot%\System32\Winevt\Logs\System.evtx_, and these logs can be typically viewed in the EventViewer application.
  - Several aspects of event logging are configurable by the Administrator.
  - Windows OS SKUs without the default event logging component can capture this event log using event listeners.
  - This article and linked video explain various aspects of Windows Event logging: [https://techcommunity.microsoft.com/t5/itops-talk-blog/understanding-the-windows-event-log-and-event-log-policies/ba-p/4065107](https://techcommunity.microsoft.com/t5/itops-talk-blog/understanding-the-windows-event-log-and-event-log-policies/ba-p/4065107). Further details are available in this Windows training module: [https://learn.microsoft.com/en-us/training/modules/manage-monitor-event-logs/](https://learn.microsoft.com/en-us/training/modules/manage-monitor-event-logs/).
  - Several monitoring solutions available in the market (created by 3rd parties, as well as Microsoft) capture event logs as part of their functionality. This document does not recommend any specific solution.
- Time-sensitive workloads are applications and services that require a machine’s time to be accurate within a certain margin of error. Hosting time-sensitive workloads in a deployment is an important factor in deciding on further customization of time synchronization and distribution topology described below.
- Managing timekeeping on any deployment makes it necessary to monitor the time on each device in that deployment and have an action plan when the monitoring indicates errors.
  - Sophistication of monitoring is dependent on specific time accuracy requirements (which ranges from high accuracy (<1ms) to approximate timekeeping (~months/years)).
  - Monitoring is essential in any deployment hosting time-sensitive workloads and is potentially important in other scenarios also.
  - Monitoring can help identify faulty hardware or poor timekeeping in advance and prevent downstream effects from such situations.
  - Monitoring can be indirect by using event logs or other observable system metrics or direct using NTP pings against a reference time source.
- Many deployments use external time servers, but certain deployments use dedicated time servers that they control and manage. Such dedicated time servers need to be monitored for any issues arising from failures in the underlying hardware of those devices. External time servers/time sources may allow only limited monitoring.
- There is a large variety of customer networks and deployments, ranging from public internet access points, home networks to advanced private networks. We can generalize these into two broad categories - private/intra networks and public/inter networks – and examine possible time synchronization solutions for each category. This is a high-level abstract view of these deployments and readers are encouraged to treat the details presented here as such.
  - Private networks often deploy local NTP time servers and distribute the time within the network.  
  - Public networks commonly use publicly accessible NTP servers to synchronize time (e.g.: time.windows.com).  
  - An NTP server on your private network may be more accommodating to your needs than a public NTP server, but the latter may be readily accessible. 
  - NTP protocol used in most of these scenarios is NTP (Plaintext) defined in RFC 1305 and its advanced variations. This protocol is widely used across various OS platforms and across the internet for time synchronization. W32time service requires an admin to specify an NTP server name or IP address in the settings for it to be used as a time source. The common (Plaintext) NTP source used in W32time settings is “time.windows.com”.
- Active Directory Domain Services (ADDS) uses NTP augmented with ADDS security extensions within the AD Domain/Forest and it is typically bridged outside the AD Forest though standard plaintext NTP. Time distribution within ADDS uses available Domain Controllers as primary or intermediate time servers. Most ADDS machines dynamically discover their time server, except the DCs marked “Good Time Server” (Forest Root Primary Domain Controller defaults to this role) that are either accurate sources of time or are explicitly configured to synchronize from an external time source.
- Customers must first determine whether their Windows OS Server machine is deployed in a private network or a public network and then make choices about the specific Windows timekeeping settings they are going to use in that deployment. 
- Some deployments may need redundancy of time servers to avoid any loss of availability. Relying on an odd number of comparable time servers (>1) can help meet this goal. 
- Customers hosting time sensitive workloads should ensure their time distribution and monitoring in those environments meet their needs.  
- Once you have sufficient information about machines that host time sensitive workloads, time distribution topology and monitoring (including time monitoring) in your deployment, we suggest you gradually roll out disabling STS on Windows Server OS SKUs (various versions/editions), starting with the least significant machine to the most significant machine.

With this background on timekeeping and time synchronization, below is a set of suggested actions to review your deployment and change it, including disabling STS as previously recommended. This sample list must be tailored to suit your specific deployments. 
- Review the time distribution/synchronization mechanism(s) you are using for timekeeping on your Windows Server OS machines. 
- Determine if your deployment has time-sensitive workloads and determine the margin of acceptable time error. In general, larger time errors are easier to detect than smaller time errors.  
- Determine if you have a time monitoring mechanism in place on these machines to meet your timekeeping requirements – this could be an exclusive time monitoring system or a general monitoring solution that is deployed on each machine in this deployment. 
- We suggest deploying time monitoring mechanism(s) if are running time-sensitive workloads. Monitoring the System event log on a target machine for Kernel-General Event #1 is one possible way to sudden/large time changes (>1 second) or corrections. There are other ways of monitoring time, all of which are beyond the scope of this document. The higher the time accuracy your deployment needs, the more acute the need to deploy a monitoring solution.  
- Familiarize yourself with the STS feature and the recommendations in this document to disable STS. 
- If you have a test environment available, test your new settings with STS disabled in that environment to ensure they work as intended. We also recommend you test your time monitoring solution in this test environment as well. 
- Gradually disable STS feature on Windows Server OS machines either via a registry setting change or via the Group Policy setting on ADDS-joined machines and schedule a restart to fully apply the change. 
- Validate that W32time service is now running with STS disabled. 

 
