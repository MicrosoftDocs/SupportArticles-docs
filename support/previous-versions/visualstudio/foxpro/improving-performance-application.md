---
title: Improving Performance in Visual FoxPro Applications
description: This article offers suggestion for improving and troubleshooting performance problems with custom applications written in Visual FoxPro 8.0 or 9.0.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.prod: visual-studio-family
---
# Improving Performance in Visual FoxPro Applications

This article offers suggestion for improving and troubleshooting performance problems with custom applications written in Visual FoxPro 8.0 or 9.0.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 2671338

## Symptoms

You have a custom application written in either Visual FoxPro 8.0 or 9.0. Users report performance that does not meet their expectations. The goal of this article is to offer suggestions for improving performance and some tools the developer can use to identify areas of code that contribute to performance bottlenecks.

## Cause

The root cause(s) of poor application performance are many and varied. They include, but are not limited, to the following:

- Visual FoxPro memory usage and configuration
- Software Design (inefficient code)
- Antivirus software configuration
- Local area network performance
- Wide Area Network performance

## Resolution

Often, troubleshooting a performance issue in any application is best done using a holistic approach. It means closely examining all factors that potentially affect performance. These issues include the application, operating system, software that runs concurrently in the environment with the FoxPro executable, and the network.

The troubleshooting framework proposed in this article begins with the application. We look at the various factors regarding setting and design that impact performance. We then look at software running on the machines (both server and local work station), and finally, we exam the network.

## More information

To effectively troubleshoot poor performance of a Visual FoxPro custom application, you need a through understand of the operating system environment and the source code for the custom application. If a third-party vendor created the FoxPro application, please contact them for support. They have the requisite understanding of the source code, which might be vital to resolving a performance issue

Visual FoxPro memory usage and configuration  

You can often improve the performance of FoxPro code by adding one or more of the following commands at the beginning (in the main program) of your application:

```console
SET REFRESH TO 0,0

SET TABLEVALIDATE TO 2

SET DELETED OFF

SYS(3054) function

Temp files directed locally
```

You should test any changes individually to best gauge their impact on performance.

Software Design (inefficient code)

Non-optimized application code severely hampers application performance. However, inefficient code is not always obvious. Fortunately, Visual FoxPro 8.0 and 9.0 have a tool, the Coverage Profiler, that allows you to run code and list the time needed for each line to execute. The Coverage Profiler is available in the development environment, both VFP 8.0 and 9.0, and in a compiled executable, in VFP 9.0.

Code design often comes to the fore as a factor hampering performance if you have legacy (FoxPro 2.x procedural code) that runs under VFP. For example, one might use a LOCATE command instead of a SEEK command or SEEK() function. Since the LOCATE commands read each record of a table, it will naturally be slower under nearly all circumstances. The Coverage Profiler helps you to identify such bottlenecks.

Another common code-related area for performance issue is non-optimized SELECT-SQL commands. Again, the Coverage Profiler can identify if the SELECT-SQL command is taking an inordinate amount of time. However, it does not tell you how to optimize the query. The goal is to make sure that the SELECT-SQL commands use `Rushmore` optimization to the greatest extent possible.

See these articles and MSDN link for more information:

- [Optimizing Applications](/previous-versions/visualstudio/foxpro/w198s41w(v=vs.80))

- [Coverage Profiler Application](/previous-versions/visualstudio/foxpro/aa979123(v=vs.71))

Antivirus software configuration

Antivirus software can drastically impact the performance of VFP applications. While no one disputes the need for antivirus software, if the software scans VFP data files, your performance may suffer. While we are not experts on all possible configuration settings of antivirus software, we can provide some general suggestions:

- Disable autoscan.
- Prevent the antivirus software from scanning VFP data files.
- Ensure you have the most recent build of antivirus software.

Local area network performance

A slow local area network (LAN) can cause slow application performance. There is no function or utility in VFP that allows you to monitor network performance, there are troubleshooting steps that remove LAN performance from the environment thus allowing you to test only the application performance. First, you can run the application from a Terminal Server machine. The application runs in the memory spaces of the Terminal Server machine (not the client operating system) and only the screen image needs transmitting over the LAN.
Secondly, you could also run the application locally and eliminate the network. (This option works if only one client experiences slow performance.)

Network issue can be complex and often involve hardware (routers, switches, NIC cards), settings (`Oplocks`, `network transmission rates`) and software (operating system versions, Virtual machines). Often network-related issues require involving the Platforms team to take netmon traces and running other operating system diagnostic tools.

Wide Area Network performance

Wide Area Networks typically cover a much larger geographic area and a LAN. A LAN might connect a site where a WAN might connect sites in two states or countries. With the increased distance comes more potential bottlenecks for application performance. The same problems shooting suggestion for LANs applies to a WAN (test the application on a Terminal Server or locally if possible). Consulting with the Platforms teams or hardware specialists may be needed as well.
