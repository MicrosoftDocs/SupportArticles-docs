---
title: WCF service using a non-default ETW provider ID
description: This article discusses a problem where WCF service using a non-default ETW provider ID when you view ETW traces.
ms.date: 08/24/2020
---
# Viewing ETW traces for WCF service using a non-default ETW provider ID

This article describes a problem where Windows Communication Foundation (WCF) service using a non-default Event Tracing for Windows (ETW) provider ID when you view ETW traces.

_Original product version:_ &nbsp; Windows Communication Foundation  
_Original KB number:_ &nbsp; 2120508

## Summary

WCF 4.0 emits traces to ETW. See [Analytic Tracing with ETW](/dotnet/framework/wcf/diagnostics/etw/) for more details. By default the ETW traces are emitted using the default provider ID ({`C651F5F6-1C0D-492E-8AE1-B4EFD7C9D503`}). The .NET Framework 4 registers an ETW manifest for this provider ID. If a manifest is registered, the ETW events can be decoded and viewed in the Windows Event viewer.

WCF allows events to be emitted on a non-default provider ID by changing the provider ID in the config. In this case, the events are non-decodable in the event viewer since a manifest is not registered for this provider ID.

## More information

WCF allows events to be emitted on a specific provider ID by changing configuration as follows:

```xml
<configuration>
    <system.serviceModel>
        <diagnostics etwProviderId="52A3165D-4AD9-405C-B1E8-7D9A257EAC9F" />
    </system.serviceModel>
</configuration>
```

Now since the manifest with provider ID `52A3165D-4AD9-405C-B1E8-7D9A257EAC9F` is not registered the events are not decodable. To read the events, there are two options:

- Option 1:

    1. Create and start an ETW session that listens for events with the specific provider ID.

        ```console
        > logman create trace myETWSession -o "C:\Temp\mylog.etl" -ets -p {52A3165D-4AD9-405C-B1E8-7D9A257EAC9F} -mode Append -ft 1
        > Logman start myETWSessionconfiguration>
        ```

    1. When ready to view the logs, stop the session.

        ```console
        > Logman stop myETWSession
        ```

    1. Copy the ETW manifest file from .NET Framework 4 directory to the logs directory and modify the provider ID in the manifest. Copy `Microsoft.Windows.ApplicationServer.Applications.man` from the .NET Framework 4 directory to `c:\Temp`.

    1. Modify the provider ID in `Microsoft.Windows.ApplicationServer.Applications.man` to `52A3165D-4AD9-405C-B1E8-7D9A257EAC9F`.  
    In the manifest located in `C:\Temp` change the guid:

        ```xml
        <provider name="Microsoft-Windows-Application Server-Applications"
                  guid ="{c651f5f6-1c0d-492e-8ae1-b4efd7c9d503 }" ...../>
        ```

    1. Format the trace file with this command:

        ```console
        tracerpt -l <tracefile name>.etl -import Microsoft.Windows.ApplicationServer.Applications.man -of EVTX
        ```

    1. Open the generated evtx file in Event Viewer.

- Option 2:

    Register the ETW manifest with the non-default provider ID as described in
    [Configuring Tracking for a Workflow](/dotnet/framework/windows-workflow-foundation/configuring-tracking-for-a-workflow) under the section **Registering an application-specific provider ID**
