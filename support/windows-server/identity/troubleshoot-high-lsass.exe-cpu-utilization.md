---
title: Troubleshoot high Lsass.exe CPU utilization
description: Introduces a resolution for the high Lsass.exe CPU utilization issue on an Active Directory Domain Controllers.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Domain controller scalability or performance (including LDAP)
ms.technology: windows-server-active-directory
---
# How to troubleshoot high Lsass.exe CPU utilization on an Active Directory Domain Controllers

This article provides a resolution to solve the high Lsass.exe CPU utilization on an Active Directory Domain Controllers.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2550044

## Symptoms

This problem may be seen in the following ways:

- A System Center Advisor alert has triggered which calls out that the Lsass.exe process is utilizing a consistently large percentage of the CPU's capabilities (CPU utilization counter).
- During normal operation, a domain controller is responding slowly or not at all to client service requests for authentication or directory lookups.
- Active Directory domain clients consistently or frequently stop requesting service from a domain controller and instead locate a different domain controller to gain services from.
- Performance monitoring using Perfmon.msc or Task Manager reveals that the Lsass.exe process is utilizing a consistently large percentage of the CPU's capabilities (Process Object, % Processor Time counter).

## Cause

High LSASS.exe CPU utilization can be caused by many different single or combined issues. Nearly each cause and resolution for these issues are unique. However, included in Windows Server 2008 and later is the tool that assists in determining what the problem cause is. That tool is the Performance Monitor's Active Directory Data Collector Set.

## Resolution

To begin resolving this issue, run the Performance Monitor's Active Directory Data Collector Set on that domain controller while the problem is occurring. This tool uses performance counters and tracing to monitor the issue and then compiles a report that will show details of potential problems that need to be investigated as possible causes.

To run the Active Directory Data Collector, follow these steps:

1. Open Server Manager on a Full version of Windows Server 2008 or later, or go to **Start** > **Run** > **Perfmon.msc** and then press enter.
2. Expand **Diagnostics** > **Reliability and Performance**> **Data Collector Sets** > **System**.
3. Right-click on Active Directory Diagnostics and then select **Start** in the menu that appears.
4. The default setting will gather data for the report for 300 seconds (5 minutes), after which it will take an additional period to compile the report. The amount of time needed to compile the report is proportional to how much data has been gathered during the period.

Once the report has compiled, look under **Diagnostics** > **Reliability and Performance** > **Reports** > **System** > **Active Directory Diagnostics** to view the report or reports that have been completed.

The report contains eight broad categories under **Diagnostic Results** that will contain information and conclusions in the report. These will not always tell the exact cause of the problem but can be used to determine where to investigate in order to find the exact cause.

Items to look at when facing high CPU utilization by Lsass.exe are the **Diagnostic Results** portion of the report, which will show general performance concerns. In addition, examining the Active Directory category will detail what actions-such as what LDAP queries are affecting performance-the domain controller is busy doing at that time.

Domain controllers are often most effected by remote queries from computers in the environment asking expensive queries, or subjecting them to a higher volume of queries. The **Network** portion of the report can be useful in determining the remote clients that are communicating most with the domain controller while the diagnostic was gathering data.

## More information

Lsass.exe (Local Security Authority Subsystem Service) is the process which, on an Active Directory domain controller, is responsible for providing Active Directory database lookups, authentication, and replication.

Additional information on how to troubleshoot the Lsass.exe process using a great deal of CPU utilization on an Active Directory domain controller is available at [Son of SPA: AD Data Collector Sets in Win2008 and beyond](/archive/blogs/askds/son-of-spa-ad-data-collector-sets-in-win2008-and-beyond).
