---
title: Secure Time Seeding Recommendations for Windows Server
description: Recommendations for the Secure Time Seeding feature in Windows Server and general good time synchronization practices.
ms.date: 04/21/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, adpatang, v-lianna
ms.custom:
- sap:active directory\windows time service configuration,accuracy,and synchronization
- pcy:WinComm Directory Services
keywords: Windows Time service, w32time, clock skew, NTP, STS, Secure Time Seeding
---

# Secure Time Seeding recommendations for Windows Server

This article provides recommendations for the [Secure Time Seeding (STS)](/archive/blogs/w32time/secure-time-seeding-improving-time-keeping-in-windows) feature in Windows Server, along with general good time synchronization practices.

## Summary

Customers have reported timekeeping issues in Windows Server 2016 and later Windows Server operating system (OS) deployments linked to the STS feature, due to its incompatibility with the affected deployments.

Based on customer reports and the associated feedback, we recommend disabling the STS feature in Windows Server 2016 and later Windows Server machines hosting time-sensitive workloads. This includes any Active Directory Domain Services (ADDS) domain controllers, virtual machine (VM) hosts, and servers that use time for critical functionality, providing connectivity, or data processing in your deployments.

We recommend that you consider disabling the STS feature in all Windows Server 2016 and later Windows Server machines hosting generic/non-time-sensitive workloads to avoid unforeseen timekeeping-related incompatibility issues arising from STS.

We recommend that you review the timekeeping requirements for Windows Server 2016 and later Windows Server OS deployments and ensure suitable time dissemination/synchronization and time monitoring are in place for Windows machines hosting time-sensitive workloads in your deployments, including any ADDS domain controllers and other potentially critical machines.
## Article overview

The primary audience of this article is administrators managing Windows Server 2016, Windows Server 2019, Windows Server 2022, and Windows Server 2025 machines in their deployments. This article highlights potential issues with the STS feature in Windows Server OS. It provides guidance and considerations for disabling this feature in Windows Server OS deployments.

We recommend you read through this article for informational purposes even if you have already disabled STS in your deployments.

This article gives a high-level overview of:

- The STS feature in Windows OS.

- STS-related timekeeping issues in some Windows Server OS stock keeping units (SKUs) reported to Microsoft.

- Disabling the STS feature in Windows Server OS.

- Critical aspects of timekeeping, time synchronization, and dissemination.

- A sample set of suggested actions to assess your time synchronization needs and disable the STS feature in your Windows Server OS deployments.

## Overview of STS

STS is a heuristic-based timekeeping mechanism in Windows OS that determines the approximate current time using time metadata from outbound Secure Sockets Layer (SSL)/Transport Layer Security (TLS) connections on a machine and uses that time information to detect and correct any large errors in the system clock on that machine.

The approximate time determined by STS depends on the time metadata available to the feature. This time metadata originates from the SSL/TLS servers that a machine connects to. For more details on the STS feature, refer to [Secure Time Seeding—improving time keeping in Windows](/archive/blogs/w32time/secure-time-seeding-improving-time-keeping-in-windows) (originally published in 2016).

The primary goal of the STS feature is to correct system time when environmental factors such as hardware malfunctions or other sources introduce time errors large enough to prevent SSL/TLS from functioning as expected. The incidence rate of such environment-induced time errors depends on the specific deployment environment.

STS produced reliable results in our observations, often better than long-term reliability of timekeeping on the computer hardware, for instance.

The STS feature is enabled by default in all editions of Windows Server 2016, Windows Server 2019, and Windows Server 2022, all editions of Windows client OS starting with Windows 10, version 1511, and all subsequent Windows client OS releases, Windows IoT releases, and SKUs of all other Windows OS released with/after Windows 10, version 1511.

The STS feature is disabled by default in Windows Server 2025, based on customer feedback covered in the next section.

The subsequent section discusses the registry and Group Policy settings that can be used by an administrator to control the enablement of this feature in Windows OS.

## Timekeeping issues related to STS

Several customer incident reports have been received regarding large and erroneous transient time jumps in Windows Server OS deployments, which might have been caused by the STS feature. These issues have the following common characteristics:

- These issues have been reported to occur in certain customer deployments on machines running various releases/versions of Windows Server OS.

- A low incidence compared to the overall deployment duration of the STS feature.

- The STS feature is enabled on the affected machines.

- The W32time service sets the system time to a random incorrect value, with a time error varying from days and weeks to years.

- This is followed by a high likelihood of the W32time service automatically correcting the previously introduced error in system time after a noticeable but brief period, which varies from deployment to deployment.

- STS issues aren't repeatable on demand in most cases.

Since these incidents occurred only when the STS feature was enabled, they might have been caused by matching anomalous time metadata presented to the STS feature from outbound SSL/TLS connections to different services on each affected machine. Such incidents indicate a potential incompatibility between the STS feature and the applications/services deployed on the specific machines and/or in specific deployment environments.

Reports of customer incidents have been received, involving large persistent time errors occurring on Windows Server machines with the STS feature enabled. In those timekeeping incidents, the time errors weren't self-corrected within a reasonable time and were resolved after disabling the STS feature on the affected machines. This led to those customers discovering the incompatibility between the STS feature on the affected machines with applications running on the machine or with the specific deployment environment and aided their decision to disable the STS feature in the affected deployments.

STS was designed to function with the SSL/TLS metadata available in generic Windows OS deployments. However, all customer reports about STS indicate that certain customer deployments of Windows Server OS might be incompatible with the STS design heuristics, and the feature might not perform as expected in such scenarios.

Information about specific applications, services, or deployments that are incompatible with the STS feature isn't available. If someone experiences time issues on a machine where STS is enabled, we recommend disabling STS to prevent it from potentially changing the system time to an incorrect value.

Customer feedback suggested that the STS feature should be disabled by default on the Windows Server OS, which has been incorporated into the recently released Windows Server 2025 OS.

Some customers noticed incorrect time issues (induced by STS or otherwise) on affected machines while investigating the secondary effects of the incorrect time since they don't monitor the time on such machines. This experience has also been considered in the guidance provided later in this article.

## Disabling the STS feature in Windows Server OS

We're advising all enterprise customers who have deployed Windows Server OS (Windows Server 2016, Windows Server 2019, Windows Server 2022, and all intermediate releases therein) either as standalone machines or as part of ADDS to evaluate disabling the STS feature on those machines. This recommendation to disable STS applies even if you have never faced any prior issues with the STS feature. STS is disabled by default in Windows Server 2025, but make sure to verify that the STS settings on this OS meet the requirements of your deployment.

- We recommend disabling the STS feature on Windows Server machines running any time-sensitive workloads, including these machines in your deployments:

  - ADDS domain controllers

  - Servers that use time for critical functionality

  - Servers that use time for providing connectivity

  - Servers that use time as part of data processing

  - VM hosts

- We recommend that you consider disabling the STS feature by default on Windows Server machines in your deployment, even if these machines don't host time-sensitive workloads and even if you never experienced STS-related time issues on these machines.

- If you have never experienced STS issues on Windows Server machines in your environment and/or choose to continue using STS on those machines, be advised of the timekeeping issues potentially caused by this feature. We recommend that you take note of the STS issues in Windows Server OS and the guidance discussed in this article and plan for eventually disabling the STS feature on those machines in your deployment.

Settings to disable STS:

Disabling (or enabling) STS requires administrators to modify settings on the target machines, either in the registry setting or in the group policy, and reboot those machines.

| Group Policy setting | Local setting |
|----------------------|---------------|
| Path: **Computer Configuration\\Administrative Templates\\System\\Windows Time Service**<br><br>Group Policy: **Global Configuration Settings**<br>Setting: **UtilizeSslTimeData**<br>Values (Reboot required):<br><br>**0** = STS disabled<br>**1** = STS enabled<br><br>For more information, see [Windows Time service tools and settings](/windows-server/networking/windows-time-service/windows-time-service-tools-and-settings?tabs=config#using-local-group-policy-editor). | Back up existing settings before making any registry changes.<br><br>Registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config`<br>Value Name: `UtilizeSslTimeData`<br>Value Type: `REG_DWORD`<br>Values (Reboot required):<br><br>`0` = STS disabled<br>`1` = STS enabled<br><br>For more information, see [Windows Time service tools and settings](/windows-server/networking/windows-time-service/windows-time-service-tools-and-settings?tabs=config#windows-time-registry-reference).<br><br>Command to disable the STS local setting in the registry:<br>`reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config" /v "UtilizeSslTimeData" /t REG_DWORD /d 0 /f` |

Determine the STS setting used by the W32time service:

- Using Services Events (not available on all editions and releases):

  - (Optional) Start the W32time service: `net start w32time`.

  - Locate Time-Service operational event log (log name: **Microsoft-Windows-Time-Service/Operational**; file path: **%SystemRoot%\\System32\\Winevt\\Logs\\Microsoft-Windows-Time-Service%4Operational.evtx**).

  - Locate the latest event among the 257, 260 and 263 events and look for the **UtilizeSslTimeData** text in the event message.

    - **UtilizeSslTimeData: 0** indicates the STS feature is disabled.

    - **UtilizeSslTimeData: X** (**X** is a nonzero number) indicates the STS feature is enabled.

- Through the W32time debug log (available on all editions and releases):

  - (optional) Archive any existing W32time debug log to avoid confusion.

    - Stop the W32time service: `net stop w32time`.

    - Archive the existing W32time debug log: `move c:\w32time.log c:\w32time_archive.log`.

  - Enable the W32time service logging: `w32tm.exe /debug /enable /file:c:\w32time.log /size:100000000 /entries:0-300`.

  - Restart the W32time service:

    - Stop the W32time service: `net stop w32time`.

    - Start the W32time service: `net start w32time`.

  - Look for the text indicating STS status in **W32time.log**:

    - **ReadConfig: 'UtilizeSslTimeData'=0x00000000** indicates STS is disabled.

    - **ReadConfig: 'UtilizeSslTimeData'=0xYYYYYYYY**, where **YYYYYYYY** is any nonzero hexadecimal number that indicates STS is enabled.

Additionally, we recommend that you ensure appropriate time dissemination/synchronization and time monitoring are in place to meet timekeeping requirements in your deployment (see the following discussion regarding various timekeeping approaches). This is essential for machines running time-sensitive workloads. It's also important for other deployments, given the unforeseen dependencies those deployments have on system time.

## Scope for the general recommendations in this article

Recommendations on disabling the STS feature in this article are applicable to deployments running Windows Server OS SKUs (Windows Server 2016 and later releases) only, based on customer feedback. Similar feedback on the STS feature hasn't been received on non-Windows Server OS SKUs. Hence, the recommendations aren't extended to non-Windows Server OS SKUs (various non-server editions and releases of Windows 10, version 1511 or later—for example, various editions and releases of Windows 10 client SKUs, Windows 10 IoT, Windows 11 client SKUs, and Windows 11 IoT).

Different Windows OS SKUs host different components and workloads. They're deployed in various environments, impacting the available SSL/TLS time metadata, the heuristic outcome of STS, and any downstream effects of STS issues. These factors, along with customer feedback received mainly regarding the STS feature in Windows Server OS SKUs, lead us to believe that such issues don't impact all Windows OS SKUs uniformly.

Administrators can apply the general guidance in the following sections to review their own time dissemination and monitoring solutions for all Windows OS SKUs for better timekeeping and insight into their deployment.

Handling issues on Windows SKUs outside the scope of the current for general recommendations:

This part of the note is included for completeness only. There are no current trends of this scenario occurring on non-Windows Server OS SKUs, and there's no current general guidance on disabling STS in non-Windows Server OS SKUs.

There's a small but distinct possibility that machines in a deployment running non-Windows Server OS SKUs (various non-server editions and releases of Windows 10, version 1511 or later—for example, Windows 10 client SKUs, Windows 10 IoT, Windows 11 client SKUs, and Windows 11 IoT) might also experience STS-related time issues based on unique circumstances in that deployment and incidence of such issues can be mitigated only by disabling the STS feature on the affected machines.

Certain machines (for example, portable devices relying solely on aged rechargeable batteries as a power source and experiencing complete power drain before the next battery recharge) running Windows OS might rely on STS to automatically correct gross time errors. If STS feature is disabled, these machines might require alternate intervention to correct the time.

Administrators should consider their deployment requirements and operational data, along with the general guidance provided in this document, when deciding to disable STS on non-Windows Server OS SKUs in their deployment. Thorough testing of any changes to Windows settings or any newly deployed solution is also recommended as part of this process.

## Time synchronization, time monitoring, and disabling STS

Timekeeping and time synchronization are complex topics that are the subjects of several papers and books. Some relevant aspects have been summarized here to help customers review their own time distribution mechanisms and gain operational insight into their deployment.

- Timekeeping on a machine can be influenced by software such as the OS itself, inbox services like the W32time service, admin tools, non-Microsoft applications with sufficient privileges or by the underlying timekeeping firmware or hardware, backup complementary metal-oxide-semiconductor (CMOS) clock, or battery, runtime conditions on the central processing unit (CPU) or memory or even environmental conditions. Various timekeeping and time synchronization features in Windows aim to bring order to this seemingly chaotic timekeeping process and attempt to keep a machine's time within acceptable limits for a given use case.

- Commodity computing equipment typically needs time corrections, and this also applies to devices running various Windows OS SKUs. In-market Windows OS SKUs (Windows Server 2016, Windows Server 2019, Windows Server 2022, Windows Server 2025, Windows 10, Windows 11, Windows 10 IoT, Windows 11 IoT, inclusive of multiple intermediate releases and various other Windows OS SKUs) each has a default W32Time service configuration to maintain and synchronize time on a generic device.

  - As part of this, STS is enabled by default in Windows Server 2016, Windows Server 2019, Windows Server 2022, and intermediate releases and is disabled by default on various editions of Windows Server 2025, based on customer feedback.

- Familiarize yourself with the W32time service registry settings documented in [Windows Time service tools and settings](/windows-server/networking/windows-time-service/windows-time-service-tools-and-settings?tabs=config).

- Many customers modify the default W32Time settings to better suit their deployment and timekeeping requirements. Modifying the STS setting should be considered in a similar vein.

- Capturing the system event logs (among other event logs) on Windows systems in a deployment can be helpful in triaging various issues in the deployment.

  - Setting the system time in Windows OS results in Kernel-General Event #1 being logged in the system event log. The message text in this event has been bolstered over OS releases, and all versions should log or identify the process ID (PID) of the process, setting the time and a way to compute the time change.

  - All events in the system event log include the current Local System Time in the metadata.

  - Some Windows OS SKUs, by default, write the system event logs into this file: **%SystemRoot%\\System32\\Winevt\\Logs\\System.evtx**. These logs can be typically viewed in the Event Viewer application.

  - Several aspects of event logging are configurable by the administrator.

  - Windows OS SKUs without the default event logging component can capture this event log using event listeners.

  - This article and linked video explain various aspects of Windows event logging: [Understanding the Windows Event Log and Event Log Policies](https://techcommunity.microsoft.com/t5/itops-talk-blog/understanding-the-windows-event-log-and-event-log-policies/ba-p/4065107). Further details are available in this Windows training module: [Manage and monitor Windows Server event logs](/training/modules/manage-monitor-event-logs/).

  - Several monitoring solutions available in the market (created by third parties and Microsoft) capture event logs as part of their functionality. This article doesn't recommend any specific solution.

- Time-sensitive workloads are applications and services that require a machine's time to be accurate within a certain margin of error. Hosting time-sensitive workloads in a deployment is an important factor in deciding on further customization of time synchronization and distribution topology described later.

- Managing timekeeping on any deployment makes it necessary to monitor the time on each device in that deployment and have an action plan when the monitoring indicates errors.

  - Sophistication of monitoring is dependent on specific time accuracy requirements (which ranges from high accuracy (less than one ms) to approximate timekeeping (~months/years)).

  - Monitoring is essential in any deployment hosting time-sensitive workloads and potentially important in other scenarios.

  - Monitoring can help identify faulty hardware or poor timekeeping in advance and prevent downstream effects from such situations.

  - Monitoring can be indirect by using event logs or other observable system metrics or direct using Network Time Protocol (NTP) pings against a reference time source.

- Many deployments use external time servers, but certain deployments use dedicated time servers that they control and manage. Such dedicated time servers need to be monitored for any issues arising from failures in the underlying hardware of those devices. External time servers/time sources might allow only limited monitoring.

- There's a large variety of customer networks and deployments, ranging from public internet access points and home networks to advanced private networks. These can be generalized into two broad categories, private/intra networks and public/inter networks, and examine possible time synchronization solutions for each category. This is a high-level abstract view of these deployments, and readers are encouraged to treat the details presented here as such.

  - Private networks often deploy local NTP time servers and distribute the time within the network.

  - Public networks commonly use publicly accessible NTP servers to synchronize time (for example, `time.windows.com`).

  - An NTP server on your private network might be more accommodating to your needs than a public NTP server, but the latter might be readily accessible.

  - The NTP protocol used in most of these scenarios is NTP (plaintext), defined in RFC 1305 and its advanced variations. This protocol is widely used for time synchronization across various OS platforms and the Internet. The W32time service requires an admin to specify an NTP server name or IP address in the settings to be used as a time source. The common (plaintext) NTP source used in W32time settings is `time.windows.com`.

- Active Directory Domain Services (ADDS) uses NTP augmented with ADDS security extensions within the AD domain/forest, and it's typically bridged outside the AD forest through standard plaintext NTP. Time distribution within ADDS uses available domain controllers as primary or intermediate time servers. Most ADDS machines dynamically discover their time server, except the DCs marked "Good Time Server" (forest root primary domain controller defaults to this role) that are either accurate sources of time or are explicitly configured to synchronize from an external time source.

- Customers must first determine whether their Windows Server machines are deployed in a private or public network and then make choices about the specific Windows timekeeping settings they'll use in that deployment.

- Some deployments might need redundancy of time servers to avoid any loss of availability. Relying on an odd number of comparable time servers (more than one) can help meet this goal.

- Customers hosting time sensitive workloads should ensure their time distribution and monitoring in those environments meet their needs.

- Once you have sufficient information about machines that host time-sensitive workloads, time distribution topology and monitoring (including time monitoring) in your deployment, we recommend you gradually roll out disabling STS on Windows Server OS SKUs (various versions/editions), starting with the least significant machine to the most significant machine.

With this background on timekeeping and time synchronization, below is a set of suggested actions to review your deployment and change it, including disabling STS as previously recommended. This sample list must be tailored to suit your specific deployments.

- Review the time distribution/synchronization mechanisms you use for timekeeping on your Windows Server machines.

- Determine if your deployment has time-sensitive workloads and determine the margin of acceptable time error. In general, larger time errors are easier to detect than smaller time errors.

- Determine if you have a time-monitoring mechanism on these machines to meet your timekeeping requirements. This can be an exclusive time-monitoring system or a general monitoring solution that is deployed on each machine in this deployment.

- We recommend deploying time-monitoring mechanisms if they're running time-sensitive workloads. Monitoring the System Event logs on a target machine for Kernel-General Event #1 is one possible way to respond to sudden/large time changes (more than one second) or corrections. There are other ways of monitoring time, all of which are beyond the scope of this document. The higher the time accuracy your deployment needs, the more acute the need to deploy a monitoring solution.

- Familiarize yourself with the STS feature and the recommendations in this document to disable STS.

- If you have a test environment available, test your new settings with STS disabled in that environment to ensure they work as intended. We also recommend that you test your time-monitoring solution in this test environment.

- Gradually disable the STS feature on Windows Server machines via a registry setting change or the Group Policy setting on ADDS-joined machines and schedule a restart to fully apply the change.

- Validate that the W32time service is now running with STS disabled.
