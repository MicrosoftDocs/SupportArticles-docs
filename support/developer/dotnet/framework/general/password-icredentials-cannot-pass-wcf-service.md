---
title: Password in ICredentials isn't passed to Windows Communication Foundation (WCF) service
description: When you try to pass an `ICredentials` object to the WCF service, the serialized object will no longer contain the password value. This behavior is by design.
ms.date: 05/08/2020
ms.reviewer: amymcel
---
# Password data in `ICredentials` can't be passed from a WCF client to the WCF service in the .NET Framework 4.5

This article helps you resolve the problem where password data in `ICredentials` can't be passed from a WCF client to the WCF service.

_Original product version:_ &nbsp; .NET Framework 4.5  
_Original KB number:_ &nbsp; 3082119

## Symptoms

In a WCF client, you create a new `ICredentials` interface from the `NetworkCredential` class by using the username and password that are specified. Then, you make a call to a WCF contract method that takes `ICredentials` as an argument. You find that after you cast the `ICredentials` that are received in the WCF service back to a network credential, the `Password` property holds an empty string. However, the `Username` property is still holding a valid, correct value.

## Cause

It is a known issue that was introduced in Microsoft .NET Framework 4.0, when a new property `SecurePassword` was added to the `NetworkCredential` class. This property overwrites the original password string when the `SecurePassword` property is deserialized on the service side. The `SecurePassword` property is of type `SecureString`. By design, it isn't serialized and sent. However, it overwrites the original password string by using an empty value. This behavior is also by design.

## Resolution

To fix this issue, you must pass the username and password information to the service independently of the network credential. You can do it by creating an application-defined object to hold the credentials. Then, pass the credentials to a new WCF service method that accepts the object as a method argument. This application-defined object contains sensitive information. We recommend that you send the data over an encrypted connection to the WCF service by using either https transport security or message layer security.

## Code that reproduces the issue

The following example shows a WCF service that reproduces the issue. The WCF service has the following contract:

```csharp
[ServiceContract]
[ServiceKnownType(typeof(NetworkCredential))]
public interface IService
{
    [OperationContract]
    string GetData(ICredentials value);
}
```

A client is using the service as follows:

```csharp
iCredService.ServiceClient svcClient = new iCredService.ServiceClient();
ICredentials iCred = new System.Net.NetworkCredential("ABC", "1234");
string outCome = outCome = svcClient.GetData(iCred);
```

Using Visual Studio and setting a breakpoint at the service, the `value.Password` will be empty. When you examine the Microsoft Visual Studio locals windows, you see the following text:

```console
value {System.Net.NetworkCredential} System.Net.ICredentials {System.Net.NetworkCredential}
[System.Net.NetworkCredential] {System.Net.NetworkCredential} System.Net.NetworkCredential
Domain "" string
Password "" string
+ SecurePassword {System.Security.SecureString} System.Security.SecureString
UserName "ABC" string
```
