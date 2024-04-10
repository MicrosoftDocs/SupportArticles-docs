---
title: Password is empty when NetworkCredential is deserialized
description: This article describes a problem that occurs when you deserialize a NetworkCredential object that was passed as a parameter to a WCF service operation. In this situation, the password field is empty. A resolution is provided.
ms.date: 05/12/2020
ms.reviewer: amymcel, khdang
---
# Password field is empty when a NetworkCredential object is deserialized at the WCF service

This article helps you working around the problem that the password field is empty when you deserialize a `NetworkCredential` object that's passed as a parameter to a Windows Communication Foundation (WCF) service operation.

_Original product version:_ &nbsp; Microsoft .NET Framework 4.5  
_Original KB number:_ &nbsp; 3021166

## Symptoms

When you deserialize a `NetworkCredential` object that was passed as a parameter to a WCF service operation, you discover that the password field is empty.

For example, you have a WCF Contract defined as follows:

```csharp
[ServiceContract] public interface IService
{
    [OperationContract] string GetData(NetworkCredential myCredential);
}
```

When the `GetData` operation is called from a client that passes a `NetworkCredential` string, the `myCredential.Password` value is empty.

## Cause

It's a known issue that was introduced in the .NET Framework 4.0. The issue occurs when a new property `SecurePassword` value is added to `NetworkCredential`. This property overwrites the original password string when the `NetworkCredential` object is deserialized on the service side.

## Workaround

To work around this issue, pass the user name and password as strings, and then create a `NetworkCredential` object at the service.
