---
title: System.Net SDP package information
description: Outlines the SDP for System.Net trace.
ms.date: 05/11/2020
ms.reviewer: pphadke
---
# System.Net SDP package information

This article provides information about `System.Net` Support Diagnostic Package (SDP) trace and disable `System.Net` tracing.

_Original product version:_ &nbsp; Microsoft .NET Framework 3.5 Service Pack 1  
_Original KB number:_ &nbsp; 2727094

## Summary

The SDP for `System.Net` is used to configure `System.Net` tracing on the machine that is experiencing an issue with the `System.Net` technology. The SDP package will collect a `System.Net` trace of an application using the `System.Net.HttpWebRequest` or `System.Net.Sockets.Socket` class.

While the SDP package will usually take care of enabling the `System.Net` tracing and disabling the tracing, the trace will need to be manually stopped/disabled only if the user decides to cancel the SDP package before the SDP package gets a chance to do the necessary cleanup. But the output trace file needs to be manually deleted.

## How to enable the System.Net trace

When `System.Net` SDP package enables the trace feature, it asks the .NET application configuration file and `System.Net` output location.

- .NET application configuration file selection dialog box:

    :::image type="content" source="./media/system-dotnet-sdp-package-information/system-dotnet-config-file-location.png" alt-text="Screenshot of the .NET application configuration file selection dialog." border="false":::

- `System.Net` trace output folder:

    :::image type="content" source="./media/system-dotnet-sdp-package-information/system-dotnet-trace-output-folder-location.png" alt-text="Screenshot of the System.Net trace output directory." border="false":::

To enable the `System.Net` trace, the SDP package will have to register following `<system.diagnostics>` entry into your .NET application configuration file.

The additional trace options include, `DateTime`, `ProcessID`, `Callstack`, and `Timestamp`.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <system.diagnostics>
        <switches>
            <add name="System.Net" value="Verbose" />
            <add name="System.Net.Sockets" value="Verbose" />
            <add name="System.Net.Cache" value="Verbose" />
            <add name="System.Net.HttpListener" value="Verbose" />
        </switches>
        <sources>
            <source name="System.Net" tracemode="includehex" maxdatasize="1024">
                <listeners>
                    <add name="System.Net" />
                </listeners>
            </source>
            <source name="System.Net.Sockets" tracemode="includehex" maxdatasize="1024">
                <listeners>
                    <add name="System.Net" />
                </listeners>
            </source>
            <source name="System.Net.Cache" tracemode="includehex" maxdatasize="1024">
                <listeners>
                    <add name="System.Net" />
                </listeners>
            </source>
            <source name="System.Net.HttpListener" tracemode="includehex" maxdatasize="1024">
                <listeners>
                    <add name="System.Net" />
                </listeners>
            </source>
        </sources>
        <sharedListeners>
            <add name="System.Net" initializeData="C:\Traces\SNTrace.6-21-12-17-19.log" type="System.Diagnostics.TextWriterTraceListener" traceOutputOptions="DateTime" />
        </sharedListeners>
        <trace autoflush="true" />
    </system.diagnostics>
</configuration>
```

## Disable System.Net tracing and delete the trace file

`System.Net` SDP package will create a backup of the selected configuration file and the existing configuration content will be combined with the new `<system.diagnostic>` section for `System.Net`. The backup configuration file name will have the original file name appended with the current date, time, and *.sdp.backup*. For example: *CSharpHTTP.exe.config* will be backed up as *CSharpHTTP.exe.config.6-21-12-17-19.sdp.backup* or *web.config* will be backed up as *web.config.6-21-12-17-19.sdp.backup*

To manually disable the `System.Net` trace feature, you just need to copy the configuration backup file back to the original configuration file name.

The SDP package will create a new .NET application configuration file if it doesn't exist. For this scenario, you can remove the .NET application configuration file to disable the `System.Net` trace feature.

Once you restore the original configuration file or remove the trace enabled configuration file, you'll have to restart the application process for the changes to be effective.

The trace file will be located in the trace file folder, which you select in SDP dialog box GUI. You'll need to manually delete the trace file after disabling the tracing feature. `System.Net` SDP package won't delete the trace file for you as the file may still be referenced by the .NET application process.

## References

- [Information about Microsoft Automated Troubleshooting Services and Support Diagnostic Platform](https://support.microsoft.com/help/2598970)

- [How to: Configure network tracing](/dotnet/framework/network-programming/how-to-configure-network-tracing)
