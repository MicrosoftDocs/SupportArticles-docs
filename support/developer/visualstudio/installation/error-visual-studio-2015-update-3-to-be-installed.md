---
title: Error - This update requires Visual Studio 2015 Update 3 to be installed
description: Resolves an error that occurs because a required Cumulative Update (KB3165756) to Visual Studio 2015 is missing.
ms.date: 04/15/2024
author: jasonchlus
ms.author: jasonchlus
ms.reviewer: terry.g.lee, jagbal
ms.custom: sap:Installation\Servicing updates and service packs
---

# Error - This update requires Visual Studio 2015 Update 3 to be installed

This article helps you resolve the "This update requires Visual Studio 2015 Update 3 to be installed" error that occurs if a required cumulative servicing and performance update (KB3165756) to Visual Studio 2015 Update 3 is missing.

_Applies to:_&nbsp;Visual Studio 2015

## Symptoms

When you try to install Visual Studio 2015 security updates, you receive the error message:

> This update requires Visual Studio 2015 Update 3 to be installed.

> [!NOTE]
> To determine whether Visual Studio 2015 Update 3 (KB3022398) is installed, check the Installed Updates list in Control Panel.

## Cause

Your computer does not have the required cumulative servicing and performance update [KB3165756](https://aka.ms/vs/14/docs/2015_Update3) to Visual Studio 2015 Update 3 installed. You must explicitly download and install this update.

Usually, [KB3165756](https://aka.ms/vs/14/release/3165756) is automatically downloaded and installed when you install Visual Studio 2015 Update 3 that is sourced from official Microsoft locations while the computer is connected to the Internet. However, in certain situations, when organizations create their own offline layout on a network share, or when you are updating less common products, such as Isolated Shell, KB3165756 is not downloaded and installed automatically. Instead, it must be independently acquired and explicitly applied. For more information, see [Cumulative Servicing Release KB3165756](https://aka.ms/vs/14/docs/2015_Update3) for Microsoft Visual Studio 2015 Update 3.

## Resolution

1. Make sure that you have [Visual Studio 2015 Update 3](https://aka.ms/vs/14/release/2015_Update3) (KB3022398) installed.
1. Install the cumulative servicing and performance update [KB3165756](https://aka.ms/vs/14/release/3165756) to Visual Studio 2015 Update 3.
1. Verify that everything is installed correctly by using one of the following methods:

   - Start the Visual Studio Installer, and verify that **Help** > **About** shows version **14.0.25431 or greater**.  
   - Examine the installed updates list in Control Panel, and verify that both Visual Studio 2015 update 3 (KB3022398) and the update for Microsoft Visual Studio 2015 (KB3165756) are present.
