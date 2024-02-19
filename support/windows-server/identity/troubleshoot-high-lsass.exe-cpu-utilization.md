---
title: Troubleshoot high Lsass.exe CPU usage
description: Solves the high Lsass.exe CPU usage issue on Active Directory Domain Controllers.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:domain-controller-scalability-or-performance-including-ldap, csstroubleshoot
---
# How to troubleshoot high Lsass.exe CPU utilization on Active Directory Domain Controllers

This article solves the high Lsass.exe CPU usage on Active Directory Domain Controllers.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2550044

## Symptoms

This problem may be seen in the following ways:

- A System Center Advisor alert has been triggered. It calls out that the Lsass.exe process is using a consistently large percentage of the CPU's capabilities (CPU utilization counter).
- A domain controller is responding slowly, or isn't responding at all to client service requests for authentication or directory lookups.
- Active Directory domain clients consistently or frequently stop requesting service from a domain controller. Instead, they locate a different domain controller to gain services from.
- Performance monitoring using Perfmon.msc or Task Manager reveals that the Lsass.exe process is using a consistently large percentage of the CPU's capabilities (Process Object, % Processor Time counter).

## Cause

This problem can be caused by many different single, or combined issues. Nearly each cause and resolution for these issues are unique. In Windows Server 2008 and later, the following tool is available to help determine the problem cause:

&nbsp;&nbsp;&nbsp;The Performance Monitor's Active Directory Data Collector Set

## Resolution

To fix this issue, run the Performance Monitor's Active Directory Data Collector Set on the domain controller while the problem is occurring. This tool uses performance counters and tracing to monitor the issue. Then it compiles a report that shows details of potential problems. These problems need to be investigated as possible causes.

To run the Active Directory Data Collector, follow these steps:

1. Open Server Manager on a Full version of Windows Server 2008 or later, or go to **Start** > **Run** > **Perfmon.msc** and then press enter.
2. Expand **Diagnostics** > **Reliability and Performance**> **Data Collector Sets** > **System**.
3. Right-click on Active Directory Diagnostics and then select **Start** in the menu that appears.
4. The default setting will gather data for the report for 300 seconds (5 minutes). Then it will take an extra period to compile the report. The amount of time needed to compile the report is proportional to how much data has been gathered.

After the report has compiled, go to **Diagnostics** > **Reliability and Performance** > **Reports** > **System** > **Active Directory Diagnostics**. View the report or reports that have been completed.

The report contains eight broad categories under **Diagnostic Results** that will contain information and conclusions in the report. It won't always tell the exact cause of the problem. But you can use it to determine where to investigate to find the exact cause.

When facing high CPU usage by Lsass.exe, check the **Diagnostic Results** portion of the report. It shows general performance concerns. Also examine the Active Directory category. It details what actions the domain controller is busy doing at that time. For example, what LDAP queries are affecting performance.

Domain controllers are often most effected by remote queries from computers in the environment asking expensive queries. Or they are subject to a higher volume of queries. The **Network** portion of the report is useful to determine the remote clients that are communicating most with the domain controller while the diagnostic was gathering data.

## More information

Local Security Authority Subsystem Service (Lsass.exe) is the process on an Active Directory domain controller. It's responsible for providing Active Directory database lookups, authentication, and replication.

For more information about how to troubleshoot high CPU usage of the Lsass.exe process on an Active Directory domain controller, see [Son of SPA: AD Data Collector Sets in Win2008 and beyond](/archive/blogs/askds/son-of-spa-ad-data-collector-sets-in-win2008-and-beyond).
