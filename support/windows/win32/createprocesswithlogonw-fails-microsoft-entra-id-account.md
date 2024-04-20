---
title: CreateProcessWithLogonW fails when called on a Microsoft Entra account 
description: Describes an error that may occur when an application calls CreateProcessWithLogonW on a Microsoft Entra account in UPN format.
author: cts-davean
ms.author: davean
ms.reviewer: mihayash, v-sidong
ms.custom: sap:System Services Development\Process, thread, and DLL APIs
ms.date: 12/19/2023
---

# CreateProcessWithLogonW fails when called on a Microsoft Entra account

The [CreateProcessWithLogonW function](/windows/win32/api/winbase/nf-winbase-createprocesswithlogonw) may fail when you call it by setting `lpDomain` to a Microsoft Entra ID (formerly known as Azure Active Directory) account in UPN format.

## Symptoms

The [CreateProcessWithLogonW function](/windows/win32/api/winbase/nf-winbase-createprocesswithlogonw) documentation states that the `lpDomain` parameter must be set to `NULL` if `lpUsername` is in UPN format.

However, the `CreateProcessWithLogonW` function may fail, and the `GetLastError` function returns `ERROR_LOGON_FAILURE (1326)` or another error code on Windows 10 and Windows 11 when the following conditions are met:

- The `lpUsername` parameter is set to a Unicode string containing a Microsoft Entra account, specified in UPN format.

- The `lpDomain` parameter is set to `NULL`.

## Cause

Microsoft has confirmed this is a problem in Windows 10 and Windows 11.

## Workaround

To work around this issue, follow these steps:

1. Call `CreateProcessWithLogonW` by setting the `lpUsername` parameter to a user account in UPN format and the `lpDomain` parameter to `NULL`.

1. If step 1 fails, call `CreateProcessWithLogonW` again with the `lpDomain` parameter set to `AzureAD`.
