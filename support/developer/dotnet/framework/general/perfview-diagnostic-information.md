---
title: Information collected by PerfView
description: List information that's collected by the PerfView diagnostic tool.
ms.date: 05/08/2020
---
# Information collected by PerfView

This article describes the information that may be collected from a machine when running the PerfView diagnostic tool.

_Original product version:_ &nbsp; Microsoft .NET Framework 4.5  
_Original KB number:_ &nbsp; 3031091

## Summary

PerfView is a performance analysis tool. It focuses on Event Tracing for Windows (ETW) information (event trace log (ETL) files) and common language runtime (CLR) memory information (heap dumps).

## ETL files along with available symbols and activity log

|Description|File Name|
|---|---|
|Event Tracing for Windows (ETL file extension) along with symbol info.|{ApplicationName}{TimeStamp}{Mode}.etl|
|Available symbols for the application and dependent modules|*.pdb|
|PerfView Activity log|PerfViewLogFile.txt|
  
## Other situations that PerfView can detect

In additional to the files collected and listed above, this troubleshooter can detect one or more of the following situations:

- Operating system name.
- Time zone.
- Last Reboot/Uptime.
- Anti-Malware installed.
- User Account Control setting.
- Username logged on during data gathering.
- Computer Model.
- Processor information.
- Computer domain name.
- Computer domain role.
- Physical memory.
- Process summary.
- Top memory usage statistics.

## References

[Information about the Microsoft Automated Troubleshooting Services and Support Diagnostic Platform](https://support.microsoft.com/help/2598970)
