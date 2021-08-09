---
title: Web application Performance Data Collector
description: This article describes the web application Performance Data Collector.
ms.date: 12/11/2020
ms.prod-support-area-path: Health, Diagnostic, and Performance Features
ms.topic: article
---
# Web application Performance Data Collector

This article introduces the web application Performance Data Collector.

_Original product version:_ &nbsp; Internet Information Services 8.0  
_Original KB number:_ &nbsp; 2839613

## Summary

This Diagnostic package is for collecting data that will help to troubleshoot slow performance issues in a web application. This article describes the instructions to run the SDP package and the information that may be from a machine when running Web application Performance Data Collector.

For this SDP to run, you should have Debug Diagnostic 1.2 and Microsoft Network Monitor 3.4 tool pre-installed on the server where you are going to execute this SDP package. If you don't install the tools, the SDP gives you a message with a link to download the tools.

You execute this SDP on the server only at the time of issue because it collects diagnostic information from the server, which helps in troubleshooting the problem.

## More information

When you run the Web application Performance Data Collector SDP, you are presented with an option to choose the host process, which is running your web application. For an IIS hosted web application, it is best to choose the application Pool option in this wizard. If you are hosting a WCF service in a self-hosted process, then choose the Process option and if the service is running as a Window Service then choose the Windows Service option. The SDP package takes memory dumps of the process that you choose in this option.

![troubleshoot](./media/web-application-performance-data-collector/2846149.png)

If you chose the application pool option in the SDP, then you receive a list of currently running web application pools and you can select the application pool that is facing the problem. You can also multi-select more than one application pool in this window.

![troubleshoot2](./media/web-application-performance-data-collector/2846152.png)

Once you hit NEXT, the SDP detects all the web sites that are running in the application pool that you choose and it checks whether the time-taken field is enabled in the IIS logs for those web sites or not. If you don't enable the time-taken field, then the SDP enables the time-taken filed in IIS logs. Post that, the SDP asks you the number of memory dumps you want to collect for the process in question. By default, the option 3 is in selected status and it collects three or more memory dumps for troubleshooting a slow response or a hung process.

![troubleshoot3](./media/web-application-performance-data-collector/2846153.png)

After choosing the number of dumps to collect, the SDP asks you what should be the duration between the memory dump collections. This step is important and choosing this option depends upon the symptoms that you are facing. For example, if the requests are taking more than 2 minutes to load then you can choose the duration as 30 seconds so that the SDP collects dumps, which are 30 seconds apart. For smaller delays, a lesser duration should be chosen.

![troubleshoot4](./media/web-application-performance-data-collector/2846154.png)

After configuring the memory dump options, the SDP finally asks you whether you want to collect a PERFVIEW trace of the machine. PERFVIEW is a tool that is used for diagnosing slow performance, HIGH CPU, and memory-related issues in .NET applications and the SDP can collect a PERFVIEW trace for the duration you specify in the below dialog. You get this option only if you are running this SDP on Windows Server 2008 and above and only if .NET Framework 4.0 is installed on the server where you are running the SDP.

![troubleshoot5](./media/web-application-performance-data-collector/2846155.png)

By this time you have configured the SDP to run it in the way you want on the machine and once you hit NEXT, the packages starts a network trace, a PERFMON log with the relevant IIS and WCF counters, an ETW trace with the IIS and ASP.NET providers. All these traces will be started when you hit the NEXT button in the below screen so it is important either the issue is happening or you should be ready to reproduce the problem after hitting next. This article describes the information that may be collected from a machine when running Web application Performance Data Collector.

![troubleshoot6](./media/web-application-performance-data-collector/2846156.png)

After starting all the relevant tracing, the SDP gives another dialog before it starts collecting memory dumps. The moment you hit NEXT on the below dialog, the SDP starts collecting memory dumps of the process you configured. Once memory dumps have been collected, the SDP then starts a PERFVIEW trace on the server and collects it for the duration you specified in the previous dialogs.

![troubleshoot7](./media/web-application-performance-data-collector/2846157.png)

Once the memory has been collected the SDP starts a PERFVIEW trace and waits for the time period that you specified in the SDP package

![troubleshoot8](./media/web-application-performance-data-collector/2846158.png)

After collecting the PERFVIEW traces, the SDP starts compressing all the data that is collected so far and in the end it tries to merge the various ETW traces that the PERFVIEW collected. This process can take a few minutes to run if the data collected by the PERFVIEW tool becomes too large. If the SDP packaged enabled time-taken field for any of the web sites that were running in the application pool that you chose, then a dialog is presented for all those web sites and you can choose whether you want to leave the time-taken field enabled or if you want, you can disable the time-taken field.

## Information collected

- *Operating System*  

    | Description |
    |---|
    |Machine Name|
    |OS Name|
    |Build|
    |Time Zone/Offset|
    |Last Reboot/Uptime|
    |User Account Control|
    |Username|
    ||

- *Computer System*  

    | Description |
    |---|
    |Computer Model|
    |Processor(s)|
    |Machine Domain|
    |Role|
    |RAM (physical)|
    ||

- *Diagnostic Logs*  

    | Description| File Name |
    |---|---|
    |DebugDiag logs|{Computername}_DebugDiag_Logs.cab|
    |ETW Logs|{Computername}_IISEtwLogFiles.cab|
    |DebugDiag Dumps|{Computername}_SDPHangDumps_{Date}_{Time}.zip|
    |Perfmon Logs|{Computername}_IISPerfmonLogFiles.cab|
    |NETMON Logs|{Computername}_IISNetmonLogFiles.cab|
    |Perfview Logs|{Computername}_ PerfViewLogFiles.cab|
    |||

- *IIS Log Files*  

    | Description| File Name |
    |---|---|
    |Http Error Logs|{Computername}_HttpErrorLogs.zip|
    |IIS Log Files|{Computername}_IISLogs.zip|
    |||

- *Networking Information*  

    | Description| File Name |
    |---|---|
    |TCP/IP Basic Information|{Computername}_TcpIp-Info.txt|
    |SMB Basic Information|{Computername}_SMB-Info.txt|
    |||

In addition to collecting the information that is described above, this diagnostic package can detect one or more of the following symptoms:

- Detect current version of strmfilt.dll

    Additional Information.

    This SDP enables much diagnostic logging and if the user clicks **Cancel**, then all this logging will be left ON and the user has to manually stop this logging. These steps should be followed to stop the logging that is turned ON by this SDP package.

- To stop the ETW tracing, run the following command from an elevated command prompt

    ```console
    Logman.exe stop "IIS ETW SDP Trace" -ets
    ```

- Hit `CTRL+C` in the command window for the network monitor capture to stop the Network Monitor trace.
- Stop the perfmon logging by opening Performance Monitor from Administrative tools and stop the Data Collector set named *IIS_SDP_HANG* under the User-Defined node below the Data Collector Sets.

### References

For more information about the Microsoft Automated Troubleshooting Services and about the Support Diagnostics Platform, see [Information about Microsoft Automated Troubleshooting Services and Support Diagnostic Platform](https://support.microsoft.com/help/2598970).
