---
title: Serialization on OnAssemblyResolve causes recursion
description: OnAssemblyResolve event is re-entrant by nature and if caution isn't taken unsuspected actions as serialization can force undesired recurrences issues and stack overflow.
ms.date: 05/11/2020
---
# Serialization on an OnAssemblyResolve handler may cause recursion

This article helps you resolve the problem where the serialization will cause the assembly resolver handler to be called recursively.

_Original product version:_ &nbsp; .NET Framework 3.5 Service Pack 1, 4.5  
_Original KB number:_ &nbsp; 2756498

## Symptoms

Assume that you have a class marked with the `XmlSerializerAssembly` attribute as in the following example:

```csharp
[Serializable, XmlRoot(ElementName="Bindings", IsNullable=false), XmlSerializerAssembly(AssemblyName="Contoso.ObjectLoaders.Bindings")]
public class Bindings
{
    (...)
}
```

The generated assembly is signed and placed in Global Assembly Cache (GAC) instead of in the *bin* folder. You also implement a handler for `AppDomain.AssemblyResolve` event and you serialize an instance of the class in the assembly resolver handler method as follows:

```csharp
private static Assembly ResolveAssemblies(object sender, ResolveEventArgs args)
{
    // Some code here
    var serializer = new XmlSerializer(typeof(Bindings));
    // Some more code here
}
```

In this scenario, the serialization will cause the assembly resolver handler to be called recursively, which may result in a stack overflow.

## Cause

This behavior is by design. Assemblies with the `XmlSerializerAssembly` attribute are loaded with `Assembly.LoadWithPartialName(string)`, which will call the `OnResolveAssembly` handler again.

## Workaround 1: Remove XmlSerializerAssembly attribute

This method will prevent the assembly from being loaded by `Assembly.LoadWithPartialName(string)`.

## Workaround 2: Write a more robust Assembly Resolve handler

It's the recommended workaround and will resolve any issues related to recursion. The following example is a simple code template for this workaround. The main idea is to add the already resolved assemblies into a generic list (the concurrent bag was chosen because its thread safe) and return if the assembly is already in the process of being resolved.

```csharp
static ConcurrentBag<string> listOfAssemblies = new ConcurrentBag<string>();
private static Assembly ResolveAssemblies(object sender, ResolveEventArgs args)
{
    if (listOfAssemblies.Contains(args.Name))
    {
        // Already resolving this assembly, return now
        return null;
    }
    try
    {
        listOfAssemblies.Add(args.Name);
        // Add your handler code here
    }
    finally
    {
        // Assembly was handled, remove from list
        listOfAssemblies.Remove(args.Name);
    }
}
```

## References

- [AppDomain.AssemblyResolve Event](/dotnet/api/system.appdomain.assemblyresolve)

- [Collections and Synchronization (Thread Safety)](/previous-versions/dotnet/netframework-3.0/573ths2x(v=vs.85))

- [ConcurrentBag\<T> Class](/dotnet/api/system.collections.concurrent.concurrentbag-1)
