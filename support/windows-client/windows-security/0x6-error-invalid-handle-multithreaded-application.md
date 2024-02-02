---
title: 0x6 ERROR_INVALID_HANDLE error when a multithreaded application accesses a smart card
description: Describes how to troubleshoot and fix the 0x6 ERROR_INVALID_HANDLE error, which occurs when a multithreaded application accesses a smart card.
ms.date: 11/25/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, milanmil, herbertm
ms.custom: sap:smart-card-logon, csstroubleshoot
---
# (0x6 ERROR_INVALID_HANDLE) error when a multithreaded application accesses a smart card

This article describes how to troubleshoot and fix the "0x6 ERROR_INVALID_HANDLE" error that occurs when a multithreaded application accesses a smart card.

_Applies to:_ &nbsp; Windows 10

## Symptoms

Consider the following scenario:

- You have a smart card-enabled multithreaded application.
- The application is accessing a smart card that is based on the Microsoft Base Smart Card Cryptographic Service Provider (basecsp.dll/scksp.dll).
- The application runs for a while.

In this scenario, you receive a **0x6 ERROR_INVALID_HANDLE** error.

This problem occurs if a call is made to any Crypto API that uses the transaction manager, such as `CryptGetKeyParam()` and `CryptGetUserKey()`, to precede another call that releases the context.

The **ERROR_INVALID_HANDLE** error does not appear immediately. Depending on the load, it takes time for threads to encounter the synchronization problem.

## Cause

This problem occurs because BaseCSP is not designed for high-load scenarios. Therefore, BaseCSP smart cards are neither thread-safe nor supported in high-load scenarios.

## More information

BaseCSP can achieve thread safety only in typical usage scenarios, such as single user, smart card logon, email encryption or decryption, and code signing.

In typical usage scenarios, BaseCSP should be thread-safe per context. In high-load scenarios, BaseCSP smart cards encounter transaction manager synchronization problems.

## Workaround

To work around this problem, use one of the following methods.

### Method 1

Develop a vendor CSP or KSP provider, and implement a transaction manager in it. In this manner, the smart card subsystem will not use a transaction manager that is implemented in BaseCSP.

### Method 2

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

A shorter transaction time-out can reduce the frequency of the problem. To achieve this, start **regedit**, and change the **TransactionTimeoutMilliseconds** value under the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\Defaults\Provider\<provider_name>` subkey.

> [!Note]
> In this subkey, \<provider_name\> is the BaseCSP or ksp, depending on the provider.

For detailed registry description, see [Base CSP and Smart Card KSP registry keys](/windows/security/identity-protection/smart-cards/smart-card-group-policy-and-registry-settings#base-csp-and-smart-card-ksp-registry-keys).

For example, reducing **TransactionTimeoutMilliseconds** from its default value 1500 ms to 100 ms could reduce the frequency of the problem.

> [!IMPORTANT]
> This change is only a recommendation that’s based on limited test results. There is no guarantee that reducing the **TransactionTimeoutMilliseconds** value will help to control this problem. Additionally, changing the default value of **TransactionTimeoutMilliseconds** might cause some other problems to affect BaseCSP cards. Make sure that you thoroughly test your card for the relevant application and load before you deploy this change.

## References

[Base CSP and Smart Card KSP registry keys](/windows/security/identity-protection/smart-cards/smart-card-group-policy-and-registry-settings#base-csp-and-smart-card-ksp-registry-keys)

[Smart Card Minidrivers](/windows-hardware/drivers/smartcard/smart-card-minidrivers)

[winscard.h header](/windows/win32/api/winscard/)

[CryptGetKeyParam function (wincrypt.h)](/windows/win32/api/wincrypt/nf-wincrypt-cryptgetkeyparam)

[CryptGetUserKey function (wincrypt.h)](/windows/win32/api/wincrypt/nf-wincrypt-cryptgetuserkey)
