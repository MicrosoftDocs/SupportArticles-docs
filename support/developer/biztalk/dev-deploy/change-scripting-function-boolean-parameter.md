---
title: Change in scripting function boolean parameter behavior
description: This article provides a resolution for the problem where the behavior of boolean param within a scripting function has changed.
ms.date: 09/27/2020
ms.custom: sap:Development and Deployment
ms.reviewer: shaheera
---
# Change in scripting function boolean parameter behavior

This article helps you resolve the problem where the behavior of boolean param within a scripting function has changed.

_Original product version:_ &nbsp; BizTalk Server 2013 Branch, BizTalk Server 2013 Developer, BizTalk Server 2013 Enterprise, BizTalk Server 2013 Standard  
_Original KB number:_ &nbsp; 2887564

## Symptoms

In BizTalk Server 2013, the behavior of boolean parameters within scripting functions in BizTalk Maps has changed.

For example, consider the following code within a scripting function:

```csharp
public int AddIfTrue(int param1, int param2, bool addNum)
{
    if (addNum)
    return param1+param2;
    else return param1;
}
```

- In BizTalk Server 2013, the behavior is as follows:

  - If `addNum` is **true**, **false**, or any other value the output is `param1+param2`.
  - If `addNum` is **empty**, the output is `param1`.

- In prior versions of BizTalk, the behavior was as follows:

  - If `addNum` is **false** the output is `param1`.
  - If `addNum` is **true**, the output is `param1+param2`.
  - If `addNum` is **empty** or any other value the function fails with error **String was not recognized as a valid Boolean**.

## Cause

Starting with BizTalk Server 2013, the BizTalk Transform Engine uses the .NET `XSLCompiledTransform` class rather than the older `XSLTransform` class due to the many performance benefits.

The Boolean parameter behavior in `XSLCompiledTransform` class is different from `XSLTransform` class. This new behavior is documented here: [boolean Function](/previous-versions/dotnet/netframework-4.0/ms256159(v=vs.100)).

## Resolution

In order to revert to the previous behavior, the scripting function code can be modified to take a String parameter instead of Boolean and then convert the String to Boolean within the function code as follows:

```csharp
public int AddIfTrue(int param1, int param2, string addNum)
{
    bool addNumBool = System.Convert.ToBoolean(addNum);
    if (addNumBool)
    return param1+param2;
    else return param1;
}
```

## More information

It is also possible to configure the BizTalk 2013 Transform Engine to use the older `XSLTransform` class. This approach is not recommended since the environment will lose the many performance and memory usage improvements provided by the `XSLCompiledTransform` class. This change can be made by adding `DWORD UseXslTransform` with value **1** at the following locations:

- For 64-bit BizTalk host instances: `HKLM\SOFTWARE\Microsoft\BizTalk Server\3.0\Configuration`
- For 32-bit BizTalk host instances and Visual Studio's Test Map functionality: `HKLM\SOFTWARE\Wow6432Node\Microsoft\BizTalk Server\3.0\Configuration`
