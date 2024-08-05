---
title: Orchestrator integration packs stop working
description: Describes an issue in which System Center Orchestrator integration packs don't work together with TLS 1.2 connections.
ms.date: 06/26/2024
---
# System Center Orchestrator integration packs stop working if TLS 1.2 is used

This article helps you fix an issue where Orchestrator integration packs stop working if TLS 1.2 protocol is used for connections.

_Applies to:_ &nbsp; All versions of Orchestrator  
_Original KB number:_ &nbsp; 4494803

## Symptoms

After you set Microsoft System Center Orchestrator to use only the TLS 1.2 protocol for connections, the following integration packs stop working:

- Integration pack for Exchange users
- Integration pack for SharePoint

When an activity from the integration pack for Exchange users is run, you receive the following error message:

> The request failed. The underlying connection was closed: An unexpected error occurred on a receive.  
> Exception: ServiceRequestException  
> Target site: ServiceRequestBase.ValidateAndEmitRequest

When you select the **Properties** of an activity from the integration pack for SharePoint, you receive the following error message:

> Details: The underlying connection was closed: An unexpected error occurred on a receive.  
> Exception: WebException  
> Target Site: HttpWebRequest.GetResponse

## Resolution

To fix this issue, follow these steps:

1. Start Registry Editor.
2. Locate the following registry subkey:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319`

3. Check whether the `SystemDefaultTlsVersions` value exists.

   - If the value exists, make sure that its data is set to **1**.
   - If the value doesn't exist, create a **DWORD (32-bit)** value, and specify the following values:

     |Value name|Value data|
     |---|---|
     |`SystemDefaultTlsVersions`|1|

4. Click **OK**.

## References

[TLS 1.2 Protocol Support Deployment Guide for System Center 2016](https://support.microsoft.com/help/4051111)
