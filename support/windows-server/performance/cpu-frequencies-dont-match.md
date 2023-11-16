---
title: CPU frequencies shown in System property page do not match
description: Provides a solution to an issue where the CPU name is shown and two identical frequencies don't match on the System property page.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:performance-monitoring-tools, csstroubleshoot
ms.technology: windows-server-performance
---
# CPU frequencies shown in System property page do not match

This article provides a solution to an issue where the CPU name is shown and two identical frequencies don't match on the System property page.

_Applies to:_ &nbsp; Windows 10, version 2004, Windows 10, version 1903, Windows 10, version 1909, Windows 7 Service Pack 1, Windows Server 2016, Windows Server 2019, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2878342

## Symptoms

Consider the following scenario:

- You have a Windows computer with multiple Intel processors.
- You open the System property page.
- Under the **Processor** section, the CPU name is shown and two identical frequencies are listed. For example, \<CPU Name> @ 2.00 GHz 2.00 GHz.
- You then install the Intel Collaborative Processor Performance Control (CPPC) driver, which provides additional power management and increases battery life.

After the Intel CPPC driver is installed, the second CPU frequency listed in the System properties page does not match the first one.

## Cause

The first frequency that is listed for the processor is fixed and part of the name of the processor. The second frequency is normally computed by Windows using P-states or the frequency of the time stamp counter. However, when the Intel CPPC driver is installed, the system uses CPPC to manage the frequency of the processor and not P-states. As a result, Windows uses the time stamp counter frequency to determine processor frequency. On systems with Intel-based processors that support configurable thermal design power (TDP), this may result in the second frequency listed being different from the first.

## Resolution

This is a cosmetic issue and does not affect how Windows manages the processor frequencies. Windows is aware of the processor frequency at any given point in time and will manage it accordingly.

## More information

For more information on Intel's Collaborative Processor Performance Control (CPPC) feature, P-states and thermal design power (TDP), visit the following links on Intel's website:

- [Mobile fourth Generation Intel® Core™ Processor Family: Product Brief](http://www.intel.com/content/www/us/en/processors/core/4th-gen-core-family-mobile-brief.html?wapkw=%22collaborative+processor+performance+control%22)
- [What exactly is a P-state? (Pt. 1)](https://software.intel.com/content/www/us/en/develop/blogs/what-exactly-is-a-p-state-pt-1.html)
- [Measuring Processor Power](http://www.intel.com/content/dam/doc/white-paper/resources-xeon-measuring-processor-power-paper.pdf)

