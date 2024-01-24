---
title: IIS ETW logs diagnostic
description: This article describes the information that may be collected from a machine when running the IIS logs diagnostic.
ms.date: 04/07/2020
ms.custom: sap:Health, diagnostic, and performance features
ms.topic: article
ms.technology: health-diagnostic-performance
---
# IIS ETW logs diagnostic

This article introduces the Microsoft Internet Information Services (IIS) Event Tracing for Windows (ETW) logs diagnostic collects various IIS-related logs.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2697604

## Summary

This IIS ETW logs diagnostic collects various related logs, event logs, and allows the user to capture an IIS ETW trace log. The following tables list collected information.

## Operating system

| Description |
|-----|
|Machine Name:<br/>OS Name:<br/>Last Reboot/Uptime:<br/>AntiMalware:<br/>User Account Control:<br/>Username:|
||

## Computer system

| Description |
|---|
|Computer Model:<br/>Processor(s):<br/>Machine Domain:<br/>Role:|
||

## Event log files

| Description| File Name |
|---|---|
|Application Event Log|{Computername}_evt_Application.evtx|
|System Event Log|{Computername}_evt_System.evtx|
|Security Event Log|{Computername}_evt_Security.evtx|
|IIS Configuration Administrative Event Log|{Computername}_evt_IISConfiguration-Administrative.evtx|
|IIS Configuration Operational Event Log|{Computername}_evt_IISConfiguration-Administrative.evtx|
  
## IIS log files

| Description| File Name |
|---|---|
|Http Error Logs|{Computername}_HttpErrorLogs.zip|
|IIS Log Files|{Computername}_IISLogs.zip|
|IIS/HTTP ETW Log|{Computername}_IISEtwLogFiles.zip|
  
## Installation setup logs for IIS

| Description| File Name |
|---|---|
|IIS Setup Log|{Computername}_IIS7.log|
|CBS Setup Log|{Computername}_CBS.log|
  
## More information

If the user selects to collect an IIS/HTTP ETW log, the IIS ETW logs diagnostic will enable an IIS ETW Trace named _IIS ETW SDP Trace_. The diagnostic will automatically stop this trace when the user is clicks **next** while the trace is running. If the user clicks **Cancel**, they should stop the trace with the following command from an Administrative command prompt:

``` console
LogMan.exe stop "IIS ETW SDP Trace" -ets
```

References

- [Information about Microsoft Automated Troubleshooting Services and Support Diagnostic Platform](https://support.microsoft.com/help/2598970)

- [Frequently asked questions about the Microsoft Support Diagnostic Tool (MSDT)](https://support.microsoft.com/help/926079)
