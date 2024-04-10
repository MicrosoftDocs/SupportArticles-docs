---
title: Fail to get security descriptor from native image
description: Fatal exception occurs when an instantiated generic type in a domain-neutral native image is accessed from an application domain. This problem occurs in a .NET Framework environment if the native image hasn't been loaded and if the CLR tries to obtain a security descriptor.
ms.date: 05/08/2020
ms.reviewer: leecow, davidwr
---
# Fatal Execution Engine Error when you obtain the security descriptor of a generic class from a native image module in a .NET Framework environment

This article helps you resolve the **Fatal Execution Engine Error** that occurs when you obtain the security descriptor of a generic class from a native image module in a .NET Framework environment.

_Original product version:_ &nbsp; Microsoft .NET Framework 3.5 Service Pack 1  
_Original KB number:_ &nbsp; 2468429

## Symptoms

When you try to obtain the security descriptor of a generic class from a native image (Ngen.exe) module in a Microsoft .NET Framework environment, you receive a **Fatal Execution Engine Error** error message. This problem may occur if the following conditions are true:

- The application includes an assembly that is loaded domain-neutral (`LoaderOptimization.MultiDomain` or `LoaderOptimization.MultiDomainHost`).
- The assembly contains an instantiation of a generic class.
- The assembly has been compiled into a native image by using the Native Image Generator (Ngen.exe) tool.
- The application loads the native image into an application domain.
- The application tries to use the generic class from a second application domain without loading the native image into that application domain.

## Cause

The common language runtime (CLR) could allow code in the domain-neutral native image to run in the second application domain even though the native image hasn't yet been loaded into that application domain. If the CLR tries to obtain a security descriptor before the native image is loaded (for example, when a delegate is created for a method of the instantiated generic type), a fatal execution engine error may occur.

This problem is difficult to reproduce. The CLR aggressively loads assemblies into application domains. For example, if a `Type` object is passed into an application domain, this causes the CLR to load the assembly that defines the type. Therefore, it is not easy for the second application domain to obtain information about the instantiated generic class without causing the CLR to load the assembly. The code paths that contribute to this problem occur only in complex scenarios.

## Workarounds

To work around this problem, use one of the following methods:

- Explicitly load the assembly into each application domain that will use it. For example, load the assembly by calling the `Assembly.Load` method.
- Don't load the assembly as domain-neutral.

    > [!NOTE]  
    > This workaround might affect the size of the application's working set.
- Don't use the Ngen.exe tool to create a native image for the assembly.

    > [!NOTE]  
    > This workaround might affect the application's performance.
- Upgrade the application to the .NET Framework version 4. All issues that are known to contribute to this problem have been addressed in the .NET Framework 4.
