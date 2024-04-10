---
title: InvokeMember throws AmbigousMatchException
description: An AmbigousMatchException may be thrown when you call System.Type.InvokeMember
ms.date: 05/11/2020
---
# InvokeMember throws an AmbigousMatchException

This article helps you resolve the problem where an `AmbigousMatchException` may be thrown when you call `System.Type.InvokeMember` using the `DefaultBinder` to invoke the non-generic version of the function `Check`.

_Original product version:_ &nbsp; Microsoft .NET Framework 4.5  
_Original KB number:_ &nbsp; 2843607

## Symptoms

Assume that you have a class that has a generic overload of a method, as shown in the following sample:

```csharp
class Test
{
    public Boolean Check<T>(String Value)
    {
        return false;
    }
    public Boolean Check(String Value)
    {
        return true;
    }
}
```

If you call `System.Type.InvokeMember` using the `DefaultBinder` to invoke the non-generic version of the function `Check`, an `AmbigousMatchException` is thrown.

## Cause

If there's a generic overload of the method, the `System.Type.DefaultBinder` can't differentiate between the generic and non-generic version of the function.

## Resolution

Create a custom [Binder](/dotnet/api/system.reflection.binder) to return the non-generic overload of the method and use it in the `InvokeMember` call, a sample implementation is below:

```csharp
public class MyBinder : Binder
{
    public MyBinder()
        : base()
    { }

    public override FieldInfo BindToField(
        BindingFlags bindingAttr,
        FieldInfo[] match,
        object value,
        CultureInfo culture
        )
    {
        return System.Type.DefaultBinder.BindToField(bindingAttr, match, value, culture);
    }

    public override MethodBase BindToMethod(
        BindingFlags bindingAttr,
        MethodBase[] match,
        ref object[] args,
        ParameterModifier[] modifiers,
        CultureInfo culture,
        string[] names,
        out object state
        )
    {

        if (match == null)
            throw new ArgumentNullException();

        List<MethodBase> match2 = new List<MethodBase>();

        for (int i = 0; i < match.Length; i++)
        {
            if (!match[i].IsGenericMethod)
            {
                match2.Add(match[i]);
            }
        }

        return System.Type.DefaultBinder.BindToMethod(bindingAttr, match2.ToArray<MethodBase>(), ref args, modifiers, culture, names, out state);
    }
    public override object ChangeType(
        object value,
        Type myChangeType,
        CultureInfo culture
        )
    {

        return System.Type.DefaultBinder.ChangeType(value, myChangeType, culture);
    }
    public override void ReorderArgumentArray(
        ref object[] args,
        object state
        )
    {
        // Return the args that had been reordered by BindToMethod.
        System.Type.DefaultBinder.ReorderArgumentArray(ref args, state);
    }
    public override MethodBase SelectMethod(
        BindingFlags bindingAttr,
        MethodBase[] match,
        Type[] types,
        ParameterModifier[] modifiers
        )
    {
        return System.Type.DefaultBinder.SelectMethod(bindingAttr, match, types, modifiers);
    }
    public override PropertyInfo SelectProperty(
        BindingFlags bindingAttr,
        PropertyInfo[] match,
        Type returnType,
        Type[] indexes,
        ParameterModifier[] modifiers
        )
    {
        return System.Type.DefaultBinder.SelectProperty(bindingAttr, match, returnType, indexes, modifiers);
    }
}
```
