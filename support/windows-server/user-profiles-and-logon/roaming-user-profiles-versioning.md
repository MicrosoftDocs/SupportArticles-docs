---
title: Roaming user profiles versioning
description: Roaming user profiles in Windows 10, Windows Server 2016, and later versions are incompatible with roaming user profiles in earlier versions of Windows.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-profiles, csstroubleshoot
ms.technology: windows-server-user-profiles
---
# Roaming user profiles of earlier versions of Windows are incompatible with Windows 10, Windows Server 2016, and later versions

This article describes incompatibilities of roaming user profiles between Windows 10 or Windows Server 2016 and earlier versions of Windows.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2016  
_Original KB number:_ &nbsp; 3056198

## Symptoms

Roaming user profiles in Windows 10, Windows Server 2016, and later versions are incompatible with roaming user profiles in earlier versions of Windows.

For example, when you try to deploy Windows 10 in an environment that uses roaming profiles in Windows 7, you experience the following behavior:

- You use a user account that has an existing Windows 7 or Windows 8.1 profile to log on to a Windows 10 computer for the first time. In this situation, the components from Windows 10 read and change the profile state.

- Certain Windows 7, Windows 8.1, or Windows 10 features may not work as expected because the expected profile state isn't present.
For example, Start menu does not start. Cortana, Taskbar is unresponsive, and taskbar icons are missing.

- You try to use the same user account to log on to a Windows 7 computer. The user profile modification that was performed in Windows 10 may not work as expected in Windows 7 or Windows 8.1.

You use a user account that has an existing Windows 7, Windows 8, or Windows 8.1 profile to log on to a Windows 10 computer for the first time. In this situation, a *v5* or *v6* version of the profile is created.

By default, Windows 10 clients use a *v5* profile folder extension. On earlier versions of Windows, the default version was *v2*.

> [!NOTE]
> Roaming, mandatory, super-mandatory, and domain default user profiles that were created in one version of Windows must be kept isolated from those that were created in another version of Windows. Each version of Windows will have its own profile version.

## Resolution

Make sure that you didn't disable [Profile Versioning](https://support.microsoft.com/help/2890783/incompatibility-between-windows-8-1-roaming-user-profiles-and-those-in).

By default, profile versioning is enabled in Windows 10, Windows Server 2016, and later versions of Windows. This behavior is by design and was implemented because of the incompatibilities between profile versions. If user accounts that use roaming profiles log on to both Windows 10 and earlier versions of Windows, there must be a profile for each version type.

## More information

For more information about profile versions and how to deploy roaming user profiles, see [Deploy Roaming User Profiles](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj649079(v=ws.11)).

For more information about Mandatory Profiles, see [Create mandatory user profiles](/windows/client-management/mandatory-user-profile).  

## Status

This behavior is by design.
