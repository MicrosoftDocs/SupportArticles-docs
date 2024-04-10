---
title: Install a PFX file by using X509Certificate
description: An error occurs when you install a PFX file using X509Certificate from a standard .NET application. This article provides resolutions.
ms.date: 05/06/2020
---
# Install a PFX file by using X509Certificate from a standard .NET application

This article helps you resolve exceptions when you install a PFX file by using `X509Certificate` from a standard .NET application.

_Original product version:_ &nbsp; .NET Framework  
_Original KB number:_ &nbsp; 950090

## Symptom

A standard .NET application tries to install a certificate in a PFX file (PKCS12) programmatically by using the `X509Certificate` or `X509Certificate2` class with code like the following example:

```csharp
X509Certificate2 cert = new X509Certificate2("a.pfx", "password");
X509Store store = new X509Store(StoreName.My);
store.Open(OpenFlags.ReadWrite);
store.Add(cert);
```

or

```csharp
X509Certificate2 cert = new X509Certificate2("a.pfx", "password", X509KeyStorageFlags.MachineKeySet);
X509Store store = new X509Store(StoreName.My, StoreLocation.LocalMachine);
store.Open(OpenFlags.ReadWrite);
store.Add(xCertificate);
```

The following type of exception will occur when you try to use the certificate's private key within another application:

> Unhandled Exception: System.Security.Cryptography.CryptographicException: Keyset does not exist  
> at System.Security.Cryptography.Utils.CreateProvHandle(CspParameters parameters, Boolean randomKeyContainer)  
> at System.Security.Cryptography.Utils.GetKeyPairHelper(CspAlgorithmType keyType, CspParameters parameters, Boolean randomKeyContainer, Int32 dwKeySize, SafeProvHandle& safeProvHandle, SafeKeyHandle& safeKeyHandle)  
> at System.Security.Cryptography.RSACryptoServiceProvider.GetKeyPair()  
> at System.Security.Cryptography.RSACryptoServiceProvider..ctor(Int32 dwKeySize, CspParameters parameters, Boolean useDefaultKeySize)  
> at System.Security.Cryptography.RSACryptoServiceProvider..ctor(CspParameters parameters)  
> at System.Security.Cryptography.X509Certificates.X509Certificate2.get_PrivateKey()  
> at UseCertPrivateKey.Program.Main(String[] args) in C:\\UseCertPrivateKey\Program.cs:line 20  

## Cause

When the certificate is installed by using the `X509Certificate` or `X509Certificate2` class, `X509Certificate` or `X509Certificate2` by default creates a temporary container to import the private key. The private key is deleted when there's no longer a reference to the private key.

## Resolution

To create a permanent key container for the private key, the `X509KeyStorageFlags.PersistKeySet` flag must be used to prevent .NET from deleting the key container. The following code should be used instead.

```csharp
X509Certificate2 cert = new X509Certificate2("a.pfx", "password", X509KeyStorageFlags.PersistKeySet);
X509Store store = new X509Store(StoreName.My);
store.Open(OpenFlags.ReadWrite);
store.Add(cert);
```

or

```csharp
X509Certificate2 cert = new X509Certificate2("a.pfx", "password", X509KeyStorageFlags.MachineKeySet | X509KeyStorageFlags.PersistKeySet);
X509Store store = new X509Store(StoreName.My, StoreLocation.LocalMachine);
store.Open(OpenFlags.ReadWrite);
store.Add(xCertificate);
```
