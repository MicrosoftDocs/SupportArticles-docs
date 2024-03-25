---
title: Can't launch Service Manager console in Windows 7 32-bit
description: Describes an issue in which the System Center Service Manager console fails to launch on a system running Windows 7 32-bit.
ms.date: 03/14/2024
ms.reviewer: manojpa, jchornbe, khusmeno
---
# The Service Manager console fails to launch on a computer running Windows 7 32-bit

This article helps you work around an issue in which you can't launch the System Center Service Manager console on a computer running Windows 7 32-bit.

_Original product version:_ &nbsp; Microsoft System Center Service Manager 2010, System Center 2012 Service Manager  
_Original KB number:_ &nbsp; 2278267

## Symptoms

On a system that's running Windows 7 32-bit, the System Center Service Manager console fails to launch and the following event is logged in the Application log:

> Event Type: Error  
> Event Source: Application Error  
> Event Category: (100)  
> Event ID: 1000  
> Description:  
> Faulting application Microsoft.EnterpriseManagement.ServiceManager.UI.Console.exe, version \<version number>, faulting module igdumd32.dll, version \<version number>, fault address \<address>.

The system also has one of the following Intel GPU chipsets:

- Intel Q43 Express Chipset
- Intel Q45 Express Chipset
- Mobile Intel 4 Series Express Chipset Family

## Workaround

As an alternative workaround you can disable graphics rendering hardware acceleration. For more information, see [Graphics Rendering Registry Settings](/dotnet/desktop/wpf/graphics-multimedia/graphics-rendering-registry-settings?view=netframeworkdesktop-4.8&preserve-view=true).

[!INCLUDE [Third-party information disclaimer](../../includes/third-party-disclaimer.md)]
