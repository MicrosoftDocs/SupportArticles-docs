---
title: Compute MD5 or SHA-1 cryptographic hash values
description: Discusses how to verify which file you installed on your computer by using the MD5 or SHA-1 cryptographic hash values.
ms.date: 09/22/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Servicing
ms.technology: windows-client-deployment 
---
# How to compute the MD5 or SHA-1 cryptographic hash values for a file

This article describes how and why you can use the MD5 or SHA-1 cryptographic hash values to verify which file you installed on your computer.

_Original product version:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 889768

## Summary

When you apply the hashing algorithm to an arbitrary amount of data, such as a binary file, the result is a hash or a message digest. This hash has a fixed size. MD5 is a hashing algorithm that creates a 128-bit hash value. SHA-1 is a hashing algorithm that creates a 160-bit hash value.

## Use FCIV to compute MD5 or SHA-1 cryptographic hash values

You can use the File Checksum Integrity Verifier (FCIV) utility to compute the MD5 or SHA-1 cryptographic hash values of a file.

To compute the MD5 and the SHA-1 hash values for a file, type the following command at a command line:

```console
FCIV -md5 -sha1 path\filename.ext
```

For example, to compute the MD5 and SHA-1 hash values for the Shdocvw.dll file in your `%Systemroot%\System32` folder, type the following command:

```console
FCIV -md5 -sha1 c:\windows\system32\shdocvw.dll
```
