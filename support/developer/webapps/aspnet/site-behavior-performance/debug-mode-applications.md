---
title: Debug mode in ASP.NET applications
description: This article describes the Debug mode in ASP.NET applications.
ms.date: 12/29/2020
ms.custom: sap:Performance
ms.reviewer: radomirz, jamesche, mlaing, bretb
---
# Debug mode in ASP.NET applications

This article introduces the Debug mode in ASP.NET applications.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 2580348

## Summary

ASP.NET supports compiling applications in a special debug mode that facilitates developer troubleshooting. Debug mode causes ASP.NET to compile applications with extra information that enables a debugger to closely monitor and control the execution of an application. Applications that are compiled in debug mode execute as expected. However, the performance of the application is affected. With Debug mode enabled:

1. Code will execute slower due to additional debug paths being enabled.
2. Compilation will take longer because additional debug information is being generated, such as symbol (.pdb) files.
3. Execution timeout is extended to 30,000,000 seconds.
4. Scripts and images downloaded from the `WebResource.axd` and `ScriptResource.axd` handlers are not cached.
5. Code optimization is disabled.

It is recommended that debug mode is always disabled in a production environment.

## More information

Debug mode is enabled by setting the `debug` attribute of the `compilation` section to **true** in the *web.config* file:

```xml
<system.web>
     <compilation debug="true">
     </compilation>
</system.web>
```

It is important to remember that the setting, if not defined in application's web.config file, can be inherited from the parent application's *web.config* or *web.config* file located in the.NET Framework's config folder.

> [!NOTE]
> Setting the `retail` attribute of the `deployment` element to **true**  will cause debugging to be disabled for all applications. However, even with the `retail` attribute set to **true**, execution timeout will still be 30,000,000 seconds if `debug` attribute is set to **true**.
