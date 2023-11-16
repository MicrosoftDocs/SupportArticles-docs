---
title: Use and troubleshoot CryptAcquireContext function
description: Provides information about when to use specific flags when you call CryptAcquireContext and the reasons for using these flags.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:certificates-and-public-key-infrastructure-pki, csstroubleshoot
ms.technology: windows-server-security
---
# CryptAcquireContext() use and troubleshooting

This article provides information about when to use specific flags when you call CryptAcquireContext and the reasons for using these flags.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 238187

## Summary

Calls to the `CryptAcquireContext` function can include various flags. It is important to know when to use these flags. This article provides information on when to use specific flags when you call `CryptAcquireContext` and the reasons for using these flags.

## More information

### Private key operations are not performed

When you are not using a persisted private key, the CRYPT_VERIFYCONTEXT (0xF0000000) flag can be used when CryptAcquireContext is called. This tells CryptoAPI to create a key container in memory that will be released when CryptReleaseContext is called. When this flag is used, the pszContainer parameter must be NULL. The CRYPT_VERIFYCONTEXT flag can be used in the following scenarios:

- You are creating a hash.
- You are generating a symmetric key to encrypt or decrypt data.
- You are deriving a symmetric key from a hash to encrypt or decrypt data.
- You are verifying a signature. It is possible to import a public key from a PUBLICKEYBLOB or from a certificate by using CryptImportKey or CryptImportPublicKeyInfo.
- You plan to export a symmetric key, but not import it within the crypto context's lifetime.

    > [!NOTE]
    > A context can be acquired by using the CRYPT_VERIFYCONTEXT flag if you only plan to import the public key for the last two scenarios.

- You are performing private key operations, but you are not using a persisted private key that is stored in a key container.

### Private key operations are performed

If you plan to perform private key operations, there are many issues that you must consider.

The best way to acquire a context is to try to open the container. If this attempt fails with "NTE_BAD_KEYSET", then create the container by using the CRYPT_NEWKEYSET flag.

> [!NOTE]
> Applications must not use the default key container by passing *NULL* for the container name to store private keys. When multiple applications use the same container, one application can change or destroy the keys that another application needs to have available. If applications use key containers with a unique name, the risk is reduced of other applications tampering with keys that are necessary for proper function.

```cpp
// Acquire Context of container that is unique to each user.
if (!CryptAcquireContext(&hProv,  
 "Container",  
 NULL,  
 PROV_RSA_FULL,  
 0))
{
 if (GetLastError() == NTE_BAD_KEYSET)
 {
 if (!CryptAcquireContext(&hProv,  
 "Container",  
 NULL,  
 PROV_RSA_FULL,  
 CRYPT_NEWKEYSET))
 {
 // Error ...
 }
 }
}

// Or, acquire Context of container that is shared across the machine.
if (!CryptAcquireContext(&hProv,  
 "Container",  
 NULL,  
 PROV_RSA_FULL,  
 CRYPT_MACHINE_KEYSET))
{
 if (GetLastError() == NTE_BAD_KEYSET)
 {
 if (!CryptAcquireContext(&hProv,  
 "Container",  
 NULL,  
 PROV_RSA_FULL,  
 CRYPT_NEWKEYSET|CRYPT_MACHINE_KEYSET)
 {
 // Error ...
 }
 }
}

```

### Using the CRYPT_MACHINE_KEYSET flag

If you are not performing private key operations on a per-user basis and you need global private key operations, then CRYPT_MACHINE_KEYSET should be used. This method creates the private/public key pair on a per-computer basis. Some specific scenarios in which CRYPT_MACHINE_KEYSET should be used are:

- You are writing a service.
- Your component is running under an Active Server Pages (ASP) page.
- Your component is a Microsoft Transaction Server (MTS) component. For these examples, CRYPT_MACHINE_KEYSET is used because the security context in which the application is running does not have access to a user profile. For example, an MTS client may impersonate a user but the user's profile is not available because the user is not logged on. The same is true for a component that is running under an ASP page.

### Providing access to your container

By default, when a key container is created, the local system and the creator are the only users who have access to the container. The exception to this is when an administrator creates the key container. The local system and all other administrators will have access to the key container. Any other security context cannot open the container.  

If your code will run under more than one security context, you must give the appropriate users access to your container.

To set the security on the container, call the CryptSetProvParam function with the PP_KEYSET_SEC_DESCR flag after the container is created. This method allows you to set the security descriptor on the container.  

The following code demonstrates how to call CryptSetProvParam. This is done immediately after creation of the key container.

```cpp
// Acquire Context  
if (!CryptAcquireContext(&hProv,  
 "Container",  
 NULL,  
 PROV_RSA_FULL,  
 0))
{
 if (GetLastError() == NTE_BAD_KEYSET)
 {
 if (!CryptAcquireContext(&hProv,  
 "Container",  
 NULL,  
 PROV_RSA_FULL,  
 CRYPT_NEWKEYSET))
 {
 // Error ...
 }

// Create Security Descriptor (pSD)...

// Set the Security Descriptor on the container
 if (!CryptSetProvParam(hProv,
 PP_KEYSET_SEC_DESCR,
 pSD,
 DACL_SECURITY_INFORMATION))
 {
 // Error ...
 }
 }
}

```

### CryptAcquireContext errors

The following are the most common error codes and possible reasons for the error.

- NTE_BAD_KEYSET (0x80090016)
  - Key container does not exist.
  - You do not have access to the key container.
  - The Protected Storage Service is not running.
- NTE_EXISTS (0x8009000F)
  - The key container already exists, but you are attempting to create it. If a previous attempt to open the key failed with NTE_BAD_KEYSET, it implies that access to the key container is denied.
- NTE_KEYSET_NOT_DEF (0x80090019)
  - The Crypto Service Provider (CSP) may not be set up correctly. Use of Regsvr32.exe on CSP DLLs (Rsabase.dll or Rsaenh.dll) may fix the problem, depending on the provider being used.
