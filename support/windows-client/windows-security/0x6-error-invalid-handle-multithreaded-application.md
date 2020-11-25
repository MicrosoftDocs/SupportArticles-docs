---
title: 0x6 ERROR_INVALID_HANDLE error when a multithreaded application accesses a smart card
description: Describes how to troubleshoot and fix the 0x6 ERROR_INVALID_HANDLE error, which occurs when a multithreaded application accesses a smart card.
ms.date: 11/25/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, milanmil, herbertm
ms.prod-support-area-path: Smart card logon
ms.technology: WindowsSecurity
---
# 0x6 ERROR_INVALID_HANDLE error when a multithreaded application accesses a smart card

This article describes how to troubleshoot and fix the 0x6 ERROR_INVALID_HANDLE error, which occurs when a multithreaded application accesses a smart card.

## Symptoms

Consider the following scenario:

- You have a smart card enabled multithreaded application.
- The application is accessing a Microsoft Base Smart Card Cryptographic Service Provider (basecsp.dll/scksp.dll) based smart card.
- The application runs for a while.

In this scenario, you receive an 0x6 **ERROR_INVALID_HANDLE** error.

Additionally, an application that produces high load on the basecsp smart card can reach the limit of 10000 contexts before the winscard component (wincard.dll) stops accepting new contexts even when old contexts are destroyed. In this scenario, this error is expected to happen as well if the application is stressing basecsp calls in extremely short burst instead of extended period. 

This situation can be identified by checking the number of handles assigned to the application that is using the smart card. If the number of handles nears 10000, it indicates the situation happens.

## Cause

This issue occurs because basecsp is not designed for high load scenarios so basecsp smart cards are neither thread safe nor supported in high load scenarios.

## More information 

The most frequently affected Crypto API functions are `CryptGetKeyParam()` and `CryptGetUserKey()`. Other Crypto APIs can have this issue as well.

The **ERROR_INVALID_HANDLE** error does not appear immediately. Depending on the load, it takes time for threads to run into the synchronization issue.

Basecsp can only achieve thread safety in normal usage scenarios, for example, single user, smart card logon, email encryption or decryption, code signing and other similar scenarios. In normal usage scenarios, basecsp should be thread safe per context.

In high load scenarios, there are two areas in which the issue starts to occur:

- In basecsp’s transaction manager synchronization
- Winscard context exhaustion (winscard stops accepting new context after smart card application reaches limit of about 10000 contexts.)

## Workarounds

To work around this issue, follow one of these methods.

### Method 1

Develop a vendor CSP or KSP provider and implement transaction manager in it. In this way, smart card subsystem will not use transaction manager that is implemented in basecsp. 

### Method 2

Shorter transaction timeout can reduce frequency of the problem. This can be achieved by changing the **TransactionTimeoutMilliseconds** value under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\Defaults\Provider\<provider_name>`.

> [!Note]
> \<provider_name\> is the basecsp or ksp, depending on the provider.

For detailed registry description, see [Base CSP and Smart Card KSP registry keys](/windows/security/identity-protection/smart-cards/smart-card-group-policy-and-registry-settings#base-csp-and-smart-card-ksp-registry-keys).

For example, reducing **TransactionTimeoutMilliseconds** from its default value 1500 ms to 100 ms could reduce the frequency of the problem. 

> [!Important]
> This is just a recommendation based on limited test results. There is no guarantee that **TransactionTimeoutMilliseconds** change will help. Additionally, changing default value for **TransactionTimeoutMilliseconds** might cause some other problems with basecsp cards. Make sure to thoroughly test your card with the relevant application and load before deploying this change.

## References

[Base CSP and Smart Card KSP registry keys](/windows/security/identity-protection/smart-cards/smart-card-group-policy-and-registry-settings#base-csp-and-smart-card-ksp-registry-keys)

[Smart Card Minidrivers](/windows-hardware/drivers/smartcard/smart-card-minidrivers)

[winscard.h header](/windows/win32/api/winscard/)

[CryptGetKeyParam function (wincrypt.h)](/windows/win32/api/wincrypt/nf-wincrypt-cryptgetkeyparam)

[CryptGetUserKey function (wincrypt.h)](/windows/win32/api/wincrypt/nf-wincrypt-cryptgetuserkey)


