---
title: Fail to build mixed mode assembly
description: An error occurs when you build .NET 3.5 or lower projects on .NET 4.0 MSBuild.
ms.date: 05/06/2020
ms.prod-support-area-path: 
ms.reviewer: teodoras
---
# Mixed mode assembly is built against version v2.0.50727 of the runtime

This article provides information about resolving an issue that you fail to build .NET Framework 3.5 or lower projects on .NET Framework 4.0 MSBuild or team build where references require Serializer Generator (SGEN).

_Original product version:_ &nbsp; .NET Framework 3.5, 4.0  
_Original KB number:_ &nbsp; 2572158

## Symptoms

You may receive the following error when building .NET Framework 3.5 or lower projects on .NET Framework 4.0 MSBuild or team build where references require Serializer Generator (SGEN):

> SGEN: Mixed mode assembly is built against version v2.0.50727 of the runtime and cannot be loaded in the 4.0 runtime without additional configuration information.

## Cause

To use mixed mode assemblies in .NET Framework 4.0, it must be configured in configuration file for SGEN.

## Resolution

Add the information below to the *sgen.exe.config* file located at the following location:  
`..\Program Files\Microsoft SDKs\Windows\v7.0A\bin\NETFX 4.0 Tools\`

```xml
<?xml version ="1.0"?>
<configuration>
    <startup useLegacyV2RuntimeActivationPolicy="true">
        <supportedRuntime version="v4.0" />
    </startup>
</configuration>
```
