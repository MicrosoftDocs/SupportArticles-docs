---
title: Event ID 1530 Is Logged in the Application Log
description: Provides information about Event ID 1530 that might be logged in the application log.
ms.date: 08/06/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:user logon and profiles\user profiles
- pcy:WinComm Directory Services
---
# Event ID 1530 may be logged in the application log in Windows

## Symptoms

In Windows, the following event may be logged in the application log:

```output
Provider
[Name] Microsoft-Windows-User Profiles Service
[Guid] {GUID}
[EventSourceName] profsvc

EventID 1530
message similar to
3 user registry handles leaked from \Registry\User\S-1-5-21-1049297961-3057247634-349289542-1004_Classes:
Process 2428 (\Device\HarddiskVolume1\myprocess.exe) has opened key \REGISTRY\USER\S-1-5-21-1123456789-3057247634-349289542-1004
If a service or background service uses a user specific hive because it runs under a specific user identity and the relevant user account logs out.
```

## Cause

This behavior occurs because Windows automatically closes any registry handle to a user profile that is left open by an application. Windows does this when Windows tries to close a user profile.

> [!Note]
> Event ID 1530 is logged as a Warning event. The application that is listed in the event detail is leaving the registry handle open and should be investigated.

## Status

This behavior is by design.
