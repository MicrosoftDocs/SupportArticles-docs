---
title: Filter drivers cause performance and consistency
description: This article provides a resolution for the problem that occurs when certain filter drivers are loaded on a computer that is running SQL Server.
ms.date: 09/25/2020
ms.prod-support-area-path: Performance
ms.reviewer: SureshKa
ms.prod: sql
---
# Use of system filter drivers can lead to SQL Server Database Engine performance degradation and consistency problems

This article helps you resolve the problem that occurs when certain filter drivers are loaded on a computer that is running SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2454053

## Symptoms

You might encounter the following symptoms when certain filter drivers are loaded into a system that is running Microsoft SQL Server components:

- High CPU usage for the SQL Server process, especially privileged processor time
- Slow response from SQL Server even when the concurrent amount of load/activity is not unusually heavy
- Reports of various hang-related error messages and conditions (SQL Server scheduler messages such as 17883, application time-out messages, and severe blocking in SQL Server)

## Cause

Filter drivers can be installed on a system as part of the Setup program of an application to provide a certain kind of functionality. Examples include antivirus protection, online backups, encryption services, and data compression or defragmentation facilities. These filter drivers insert themselves into the Windows driver stack to enhance or alter the behavior of requests that pass through the driver stack and that are intended for a device.

Under some conditions, these requests may either take a long time to complete or consume excessive resources. When this occurs, various problems occur that are discussed in the [Symptoms](#symptoms) section. Also, there might be some form of incompatibility between the different filter drivers that are present in the same driver stack and that could also lead to some of the problems that are discussed in the [Symptoms](#symptoms) section.

## Resolution

The general approach to resolve these situations is as follows.

> [!NOTE]
> See the [More Information](#more-information) section for more information about each of the following steps:

1. Identify the filter driver that is causing the problem.
2. Perform the following actions for that filter driver in question:

   1. Configure the filter driver or its associated software in such a way that it does not interfere with the SQL Server workload or operations.
   2. Disable the filter driver from loading into the system.
   3. Contact the vendor of the filter driver or application software, check for updates, and apply them.
   4. In rare situations, you may have to remove the filter driver and the associated software to make sure that the system and SQL Server can function without the issues that are discussed in the [Symptoms](#symptoms) section.

   > [!WARNING]
   > This workaround may make a computer or a network more vulnerable to attack by malicious users or by malicious software such as viruses. We do not recommend this workaround but are providing this information so that you can implement this workaround at your own discretion. Use this workaround at your own risk.

In some instances, you may have to perform all these actions. Refer to the [More information](#more-information) section for instructions that are specific to certain filter drivers.

## More information

Microsoft Customer Support and Services team (CSS) had identified the following filter drivers that can cause the symptoms that are mentioned in this article. This list will be updated when new issues are found. This list is provided to help with the identification process that was described in the [Resolution](#resolution) section. Finding the problematic filter driver typically involves collecting an iterative set of diagnostic and tracing data when the problem occurs.

The following filter drivers that can cause performance and stability issues for SQL Server:

- MFEBOPK.SYS

  This filter driver is used for the Buffer Overflow Protection feature in McAfee VirusScan Enterprise. If you have this feature enabled, you will notice that sqlservr.exe is among the [list of processes protected by Buffer Overflow Protection](https://kc.mcafee.com/corporate/index?page=content&id=kb58007). If you have this filter driver on a system that is running SQL Server, you must perform the actions that are specified in the [Resolution](#resolution) section. You can also refer to the following link for more information:

  - [High Impact Issue: Servers may become unresponsive due to multiple issues](https://techcommunity.microsoft.com/t5/ask-the-performance-team/high-impact-issue-servers-may-become-unresponsive-due-to/ba-p/374567)

- NLEMSQL64.SYS and NLEMSQL.SYS

  This filter driver is installed by the NetLib Encryptionizer software. When this filter driver is installed on a computer that is running SQL Server, and you perform backup to a network share, you might encounter failures that return **Operating system error 1 : Incorrect function**. To resolve this problem, contact the software vendor to obtain updates to the filter driver.

- MFETDIK.SYS

  This filter driver is used for the McAfee Anti-Virus Mini-Firewall feature in the products McAfee VirusScan Enterprise and McAfee McShield. If you have this feature enabled, you will notice that sqlservr.exe is among the list of processes monitored by the Anti-Virus feature. If you have this filter driver on a system that is running SQL Server, you must perform the actions that are specified in the [Resolution](#resolution) section. You could also consider adding SQL Server processes to the low risk process list in the Anti-Virus configuration.

For more general information about filter drivers, please refer to the following links:

- [Types of WDM Drivers](/windows-hardware/drivers/kernel/types-of-wdm-drivers)

- [How to temporarily deactivate the kernel mode filter driver in Windows](/troubleshoot/windows-server/performance/deactivate-kernel-mode-filter-driver)

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.

The information and the solution in this document represents the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft does not specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article does not describe. Because Microsoft must respond to changing market conditions, this information should not be interpreted to be a commitment by Microsoft. Microsoft cannot guarantee or endorse the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.

Microsoft makes no warranties and excludes all representations, warranties, and conditions whether express, implied, or statutory. These include but are not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition, merchantability, and fitness for a particular purpose, with regard to any service, solution, product, or any other materials or information. In no event will Microsoft be liable for any third-party solution that this article mentions.

## Applies to

- All versions of SQL Server
