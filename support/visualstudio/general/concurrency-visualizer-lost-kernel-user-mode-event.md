---
title: Concurrency Visualizer reports lost kernel
description: This article describes how to adjust ETW buffer to prevent lost kernel and user mode events reported by Visual Studio 2010 Concurrency Visualizer.
ms.date: 04/27/2020
ms.prod-support-area-path: Debuggers and analyzers
ms.reviewer: dangrif
---
# Visual Studio 2010 Concurrency Visualizer prevents lost kernel and user mode events by ETW buffer

This article introduces how to prevent lost kernel and user mode events by adjusting Event Tracing for Windows (ETW) buffer settings in the Windows registry.

_Original product version:_ &nbsp; Visual Studio 2010  
_Original KB number:_ &nbsp; 2019117

## Symptoms

Microsoft Visual Studio 2010 Concurrency Visualizer may report lost kernel and/or user mode events. One can prevent lost kernel and/or user mode events by adjusting ETW buffer settings in the Windows registry.

## Cause

The Concurrency Visualizer in Visual Studio 2010's profiler (Premium and Ultimate editions) consumes events collected via ETW, which uses buffers to cache data before writing to disk. If this tool reports lost kernel and/or user mode events, the default settings for some buffers may be too low for your system or application.

Lost kernel mode events are a critical failure reported in the Output and Report windows. Processing ends with no report.

Lost user mode events show as an error in the Output window, but a report is still generated. Symptoms in the report may include lost custom scenario markers or markers for Parallel Extensions in your code.

## Resolution

Increasing the ETW buffer registry settings and reprofiling can eliminate the symptoms. Larger buffer settings consume more memory; therefore, adjust for optimal performance. Each value below is defined via MSDN.

Create a registry key at `HKEY_CURRENT_USER\SOFTWARE\Microsoft\VisualStudio\10.0\VSPerf\Monitor\EtwConfig` with the following DWORD entries. Start with values shown here:

- FlushTimer 0
- BufferSize 256
- MinBuffers 512
- MaxBuffers 1024

## References

[EVENT_TRACE_PROPERTIES Structure](/windows/win32/api/evntrace/ns-evntrace-event_trace_properties)
