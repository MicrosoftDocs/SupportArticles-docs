---
title: Error when you call the eConnect_EntryPoint in eConnect
description: This article provides a resolution for the problem that occurs when you call the eConnect_EntryPoint method in eConnect for Microsoft Dynamics GP 10.0.
ms.topic: troubleshooting
ms.reviewer: dclauson
ms.date: 03/13/2024
---
# Error message when you call the eConnect_EntryPoint method in eConnect for Microsoft Dynamics GP 10.0 (System Error)

This article helps you resolve the problem that occurs when you call the eConnect_EntryPoint method in eConnect for Microsoft Dynamics GP 10.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 943133

## Symptoms

Consider the following scenario. You build an application in the Microsoft .NET Framework 2.0. Then, you call the **eConnect_EntryPoint** method in eConnect for Microsoft Dynamics GP 10.0. Currently, eConnect is part of the Developer Toolkit for Microsoft Dynamics GP. When you call the **eConnect_EntryPoint** method, an exception occurs, and you receive the following error message:

> System Error

## Cause

This problem occurs because the application's exception handling is configured by using the **System.Exception** base class. The exception that is thrown by the **eConnect_EntryPoint** method is an SqlException exception. Details for this kind of exception are not available through the **System.Exception** base class.

## Resolution

To resolve this problem, add a handler to the application to catch the SqlException exceptions. The following code is an example of how to do this.

```csharp
catch (eConnectException ex)
{ 
    Console.WriteLine(ex.Message); 
}
catch (System.Data.SqlClient.SqlException ex) 
{ 
    foreach (System.Data.SqlClient.SqlError myError in ex.Errors) 
    { 
        Console.WriteLine(myError.Message); 
    } 
} 
catch (System.Exception ex) 
{ 
    Console.WriteLine(ex.Message);
}
```
