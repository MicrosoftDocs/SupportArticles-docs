---
title: The %NUMBER_OF_PROCESSORS% environment variable may show incorrect values
description: Helps resolve the issue in which the %NUMBER_OF_PROCESSORS% environment variable may show incorrect values on systems with more than 64 logical processors.
ms.date: 08/01/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, stevepar, praveenr, v-lianna
ms.custom: sap:devices-and-drivers, csstroubleshoot
ms.subservice: deployment
---
# The %NUMBER_OF_PROCESSORS% environment variable may show incorrect values

This article helps resolve the issue in which the `%NUMBER_OF_PROCESSORS%` environment variable may show incorrect values on systems with more than 64 logical processors.

You have a 64-bit Windows system with more than 64 logical processors. When you check the `%NUMBER_OF_PROCESSORS%` environment variable, you find the value is incorrect and is less than the total number of processors in the system. For example, a system with 72 logical processors has two processor groups, and each group contains 36 logical processors. The `%NUMBER_OF_PROCESSORS%` value is 36, but it's expected to be 72.

## Support for systems with greater than 64 logical processors

A logical processor is a logical computing engine from the perspective of the operating system, application, or driver. Support for systems with greater than 64 logical processors was added in Windows 7 based on the creation of processor groups.

A processor group is a set of up to 64 logical processors that's treated as a single scheduling entity by the operating system, and each process is assigned to only one processor group by default.

## Only the current processor group is counted

The `%NUMBER_OF_PROCESSORS%` environment variable reflects the number of processors in the assigned processor group for a process and is inherited from Windows Session Manager (*smss.exe*). Prior to Windows 11 and Windows Server 2022, *smss.exe* wasn't processor group aware. The default scheduler behavior was to assign applications to a single processor group. In this case, only the current processor group is counted.

Only the system process is assigned a multigroup affinity at the system startup. To use the full set of processors in the system, all other processes need to assign threads to a different group.

If an application requires to run on more than 64 processors by using multiple groups, it needs to determine where to run its threads. The application is responsible for setting thread affinities to the desired groups.

## Update the system to Windows 11 or Windows Server 2022

You can update the system to Windows 11 or Windows Server 2022. Starting with Windows 11 and Windows Server 2022, on machines with more than 64 processors, the processes and their threads span all processors in the system across multiple groups by default. Additionally, starting with Windows 11, version 22H2, the `%NUMBER_OF_PROCESSORS%` environment variable reflects the total number of processors on the system, even if they are spread across multiple processor groups.

## Set application thread affinities to the desired groups

If your operating system is prior to Windows 11 or Windows Server 2022, you can set the application thread affinities to the desired groups.

You can specify the thread's affinity at its creation by using the [PROC_THREAD_ATTRIBUTE_GROUP_AFFINITY](/windows/win32/api/processthreadsapi/nf-processthreadsapi-updateprocthreadattribute) extended attribute with the [CreateRemoteThreadEx](/windows/win32/api/processthreadsapi/nf-processthreadsapi-createremotethreadex) function. After the thread is created, you can change its affinity by calling the [SetThreadAffinityMask](/windows/win32/api/winbase/nf-winbase-setthreadaffinitymask) or [SetThreadGroupAffinity](/windows/win32/api/processtopologyapi/nf-processtopologyapi-setthreadgroupaffinity) function.

## More information

- [Processor Groups](/windows/win32/procthread/processor-groups)
- [Supporting Systems That Have More Than 64 Processors - Guidelines for Developers](https://view.officeapps.live.com/op/view.aspx?src=https%3A%2F%2Fdownload.microsoft.com%2Fdownload%2Fa%2Fd%2Ff%2Fadf1347d-08dc-41a4-9084-623b1194d4b2%2FMoreThan64proc.docx&wdOrigin=BROWSELINK)
