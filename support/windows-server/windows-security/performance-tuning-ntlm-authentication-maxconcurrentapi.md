---
title: performance tuning for NTLM authentication
description: Describes how to do performance tuning for NTLM authentication by using the MaxConcurrentApi setting.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, tspring
ms.custom: sap:legacy-authentication-ntlm, csstroubleshoot
---
# How to do performance tuning for NTLM authentication by using the MaxConcurrentApi setting

This article describes how to do performance tuning for NTLM authentication by using the MaxConcurrentApi setting.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2688798

## Introduction

An increase in consumerization of enterprise information technology (increase in consumer-oriented devices such as smartphones and tablets used in the corporate enterprise) has led to increasing the number of scenarios in which businesses may experience a large increase in legacy authentication in their enterprise environments. This increase in legacy authentication could lead to performance problems such as delays or time-outs for clients.

When you discover authentication time-outs or delays (also known as MaxConcurrentApi bottlenecks) in an environment, the typical way to resolve the problem is to raise the maximum allowed worker threads that service that authentication. You do it by altering the MaxConcurrentApi registry value and then restarting the Net Logon service on the servers.

Identifying which servers are victims of the bottleneck and which servers are actually the source of the bottleneck delays can be difficult. This article describes how to do performance tuning for NT LAN Manager (NTLM) authentication by using the MaxConcurrentApi setting. This article contains guidance for administrators in identifying the servers on which to raise the MaxConcurrentApi value and the amount to which that value should be set.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756)  How to back up and restore the registry in Windows  

To resolve this issue, you must review the performance data that was taken from the all servers that are involved in the scenario. Then, you can try to increase the MaxConcurrentApi setting on those servers that show a loss in performance.

There are `Netlogon` Events available that report NTLM authentication problems, see:  
[2654097](https://support.microsoft.com/help/2654097)  New event log entries that track NTLM authentication delays and failures in Windows Server 2008 R2 are available

The Events indicate activity for two counters:

- Events 5818/5819: There are "Semaphore Waiters", if the events are enabled.
- Events 5816/5817: There are "Semaphore Timeouts".  

In order to determine the best MaxConcurrentApi value for your servers, several data points must be brought together and calculated by using a formula. The data to be used to estimate MaxConcurrentApi is as follows:  

- Net Logon semaphore acquires
- Net Logon semaphore time-outs
- Net Logon average semaphore hold time
- Duration of the performance logging that is completed, measured in seconds  

After the data is obtained, the following formula can be used to estimate the correct MaxConcurrentApi value:(**semaphore_acquires** + **semaphore_time-outs**) * **average_semaphore_hold_time** / **time_collection_length** = < **New_MaxConcurrentApi_setting**  
After you collect the Net Logon performance data from when the server was under authentication load, you should determine the duration of the data-collecting process by looking at the Line View beginning and end times.  

>[!Note]  
>The placeholders **semaphore_acquires** and **semaphore_time-outs**  represent cumulative numbers that indicate how many time-outs occurred during the lifetime of a security channel. Therefore, the numbers will most likely not start at zero in the data that is collected. The starting number must be subtracted from the ending number when you use Line View in the Performance Monitor (Perfmon.msc). Then, you use this calculated number in the formula for the new MaxConcurrentApi setting. To determine the number of time-outs that occurred during data collection, use Line View in Perfmon.msc, and rest the mouse pointer over the line for that counter at the end and the start, and then subtract the starting number from the ending number. That result is the number to put into the equation.

The average semaphore hold time can be determined by changing the default view from Line View to Report View in Perfmon.msc. For example, consider the following scenario:  

- The semaphore acquires value is 8,286.
- The semaphore time-outs value is 883.
- The average semaphore hold time is `.5` (that is, a half second).
- The duration of reporting is 90 seconds.  

In this scenario, the formula would be as follows:  
(8,286 + 883) *.5 / 90 =< 51  

If the value that is derived from the formula is 150 or larger, you should add more servers to service the legacy authentication load.  

If the value is less than 150, you should alter the MaxConcurrentApi registry value on that server to the value that is suggested by the formula or to a larger value.

>[!NOTE]
>If you decide to increase the MaxConcurrentApi value to greater than 10, the load and the performance of the desired setting should be tested in a nonproduction environment before you implement the change in a production environment. This is recommended to make sure that increasing this value does not cause other resource bottlenecks. Additionally, be aware that load conditions may change based on each scenario and business environment. Therefore, the MaxConcurrentApi value may have to have a different setting at a later date if the service load changes.

To change the MaxConcurrentApi setting, follow these steps:  

1. Click **Start**, click **Run**, type regedit, and then click **OK**.
2. Locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`  

3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
4. Type MaxConcurrentApi, and then press Enter.  
5. On the **Edit** menu, click **Modify**.
6. Type the new MaxConcurrentApi setting in decimal, and then click **OK**.
7. At a command prompt, type the following command, and then press Enter:  
`net stop netlogon`  

8. Type the following command, and then press Enter:  
`net start netlogon`  

## More information

You can use the following Knowledge Base article to identify the client-side symptoms of legacy authentication bottlenecks in more detail:  
[975363](https://support.microsoft.com/help/975363) You are intermittently prompted for credentials or experience time-outs when you connect to Authenticated Services
The authentication bottleneck may be on multiple servers in the scenario. Therefore, you must make sure that all servers in a given scenario have their performance data reviewed while they are busy servicing heavy loads.

The counters for semaphore acquire, for semaphore time-outs, and for average semaphore hold time must be reviewed on all application servers, domain controllers, and trusted domain controllers that are involved in servicing client requests.  

The performance data must be tracked while the servers are under heavy load. Heavy load occurs when the servers see the most client requests. For example, in an email server scenario, the best time to collect the performance data is when users arrive at work and check their email messages.

Additional items for consideration are as follows:  

- No values mean no action is needed. The **Semaphore Holders** and **Semaphore Hold Time** counters will not show any values unless there is sustained load on a server. If there are no values present, no change in the MaxConcurrentApi value is needed.
- One size does not fit all.  The MaxConcurrentApi value may have to be a different value for each server. This situation can be caused by multiple application servers gaining authentication from a single domain controller or by similar scenarios in which multiple servers provide a larger volume of load with which the domain controller must deal.  
- Trusts. If the users who are being authenticated are from trusted domains, it can cause longer delays, because the local domain controller must wait for the reply from the trusted domain controller before the local domain controller provides the response to the application server.
- Network latency.  Network latency can also play a major part in causing MaxConcurrentApi bottlenecks.  This issue can occur when the MaxConcurrentApi semaphore uses a time-based time-out counter so that clients do not wait indefinitely for legacy authentication.
- Collocation. If network latency exists and is causing delays and bottlenecks in completing MaxConcurrentApi threads, a common solution is to put the servers in the same physical location so that network latency is reduced. In a domain model in which a trusted domain has Microsoft Exchange CAS servers, for example, and the user's domain is in another region or Active Directory site, it would mean putting the user's domain controllers into the same physical location and Active Directory site as the Exchange CAS servers and their domain controllers.
- Possible downstream delay. If the **Semaphore Waiters** counter value is continually greater than 0 (zero) for any time and the **Semaphore Holders** value is less than the MaxConcurrentApi setting on that server, the bottleneck is not located on that server. In this case, look to the domain controller that is cited in the counter name that is listed as a host computer fully qualified domain name. That domain controller's **Semaphore Waiters** and **Semaphore Holders** performance data should be reviewed.
- Changes in load or in network configuration.  Future changes in the load that is being serviced or in network configurations may produce network latency and could lead to a need for gauging the correct MaxConcurrentApi setting again. For environments in which legacy authentication volume is seen to the extent that MaxConcurrentApi settings are being examined, we strongly recommend that you continually monitor and review the Net Logon performance object counters. You can do it by using scheduled custom Perfmon.msc data collectors, by using Microsoft System Center Operations Manager, or by using other methods.
- Windows Server 2008 maximum.  The maximum setting that is allowed for MaxConcurrentApi in Windows Server 2008 and in later versions of Windows is 150. Apply the hotfix that is described in the following Knowledge Base article to have the 150 maximum available setting if the server that you are using is not running Windows Server 2008 R2:  
[975363](https://support.microsoft.com/help/975363) You are intermittently prompted for credentials or experience time-outs when you connect to Authenticated Services

- Windows Server 2003 maximum. The maximum setting that is allowed for MaxConcurrentApi in Windows Server 2003 and in earlier versions is 10.
- Windows Server 2012 and newer Defaults. The default for MaxConcurrentApi has been changed in Windows Server 2012. It is 10 for member Servers and Domain Controllers. It remains at 1 for member Workstations.
- Windows Server 2003 and performance counters.  The original release of Windows Server 2003 did not contain the Net Logon performance counters. You can apply a hotfix to add it.  

Identifying unauthorized or unknown clients or services that are performing repeated and continuous NTLM authentication can be useful when you want to reduce the overall NTLM authentication load and therefore ultimately decrease the number of MaxConcurrentApi semaphore uses. Repeated authentication in that manner can be identified by using Net Logon service debug logging. For more information about how to use the Netlogon.log file to debug the Net Logon service, click the following article number to view the article in the Microsoft Knowledge Base:  
[109626](https://support.microsoft.com/help/109626) Enabling debug logging for the Net Logon service  

The Perfmon.msc counter for NTLM authentications under the Security System-Wide Statistics  object is not a reflection of the number of uses of the MaxConcurrentApi tracked thread. There is no one-to-one correlation between the MaxConcurrentApi semaphore usage that is shown in the Net Logon performance counter and the NTLM authentication counter increments. The NTLM authentication counter is not useful in determining the best MaxConcurrentApi value.  

Additionally, it is likely that legacy authentication performance time-outs that are related to MaxConcurrentApi will be seen but not reflected in any performance counter other than the Net Logon counter. It means that other performance metrics such as CPU use and disk and network use may show no load even though the MaxConcurrentApi load is heavy and users are having problems.

An additional minimizing procedure can be performed on domain controllers that have entries in their Net Logon service debug log that indicate that clients are submitting `<null>\username` instead of `domainname\username`. This procedure is described in the following article in the Microsoft Knowledge Base:  
[923241](https://support.microsoft.com/help/923241)  The Lsass.exe process may stop responding if you have many external trusts on an Active Directory domain controller
