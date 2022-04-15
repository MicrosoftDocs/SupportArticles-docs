---
title: I received the error “This update requires Visual Studio 2015 Update 3 to be installed”
description: Provides resolution to this error caused from missing required cumulative servicing update KB3165756 to Visual Studio 2015 Update 3.
ms.date: 04/15/2022
author: jasonchlus
ms.author: jasonchlus
ms.reviewer: terry.g.lee
---

# Error: This update requires Visual Studio 2015 Update 3 to be installed

This article provides a resolution to the error “This update requires Visual Studio 2015 Update 3 to be installed” which is caused by missing required cumlative servicing and performance update KB3165756 to Visual Studio 2015 Update 3.

_Applies to:_&nbsp;Visual Studio 2015

## Symptom
When you try to install Visual Studio 2015 security updates, you receive “This update requires Visual Studio 2015 Update 3 to be installed” error message. You can verify that Visual Studio 2015 Update 3 (KB3022398) is installed by looking in the Installed Updates list in the Control Panel.

## Cause
You are missing the critical required cumulative servicing and performance update [KB3165756](https://aka.ms/vs/14/docs/2015_Update3) to Visual Studio 2015 Update 3.  You will need to explicitly download and install it.

Most of the time, [KB3165756](https://aka.ms/vs/14/release/3165756) is automatically downloaded and installed when you perform a new installation of Visual Studio 2015 Update 3 that is sourced from official Microsoft locations while the machine is connected to the internet.   However, in certain situations, like when organizations create their own offline layout on a network share, or when you’re updating less common SKUs such as Isolated Shell, the KB3165756 is not downloaded and installed automatically.  Rather, it must be independently acquired and explicitly applied.  For more information, refer to [Cumulative Servicing Release KB3165756](https://aka.ms/vs/14/docs/2015_Update3) for Microsoft Visual Studio 2015 Update 3.

## Resolution
- First, make sure that you have [Visual Studio 2015 Update 3](https://aka.ms/vs/14/release/2015_Update3) (KB3022398) installed.
- Next, install the cumulative servicing and performance update [KB3165756](https://aka.ms/vs/14/release/3165756) to Visual Studio 2015 Update 3.
- Verify that everything is installed correctly by either one of these methods:

> - Start the Visual Studio Installer and verify that **Help** > **About** shows version **14.0.25431 or greater**.  
> - Look at the Installed Updates list in the Control Panel and verify that both Visual Studio 2015 Update 3 (KB3022398) and the Update for Microsoft Visual Studio 2015 (KB3165756) are present.
