---
title: ASP.NET 2.0 and 3.5 not working
description: This article describes an issue in which uninstalling ASP.NET 4.5 from Windows 8 or Windows Server 2012 causes ASP.NET 2.0 and ASP.NET 3.5 to not work.
ms.date: 04/07/2020
ms.custom: sap:General Development
ms.reviewer: meyoun
---
# ASP.NET 2.0 and 3.5 not working after you uninstall ASP.NET 4.5 in Windows 8 or Windows Server 2012

This article helps you resolve the problem where uninstalling ASP.NET 4.5 from Windows 8 or Windows Server 2012 causes ASP.NET 2.0 and ASP.NET 3.5 not working.

_Original product version:_ &nbsp; Windows Server 2012, Hyper-V Server 2012, .NET Framework 4.5  
_Original KB number:_ &nbsp; 2748719

## Symptoms

ASP.NET 2.0 and ASP.NET 3.5 require the ASP.NET 4.5 feature to be enabled on a computer that is running Windows 8 or Windows Server 2012. If you remove or disable ASP.NET 4.5, then all ASP.NET 2.0 and ASP.NET 3.5 applications on the computer will not run.

## Resolution

To enable the ASP.NET 4.5 feature in Windows 8 or 8.1, follow these steps:

1. Press the Windows logo key, type *control panel*, and then click the **Control Panel** icon.

    > [!NOTE]
    > If you are not using a keyboard, swipe in from the right edge of the screen, tap **Search**, type control panel in the search box, and then tap the displayed **Control Panel** icon.

2. Click **Programs**, and then click **Turn Windows features on or off**.
3. Expand **.NET Framework 4.5 Advanced Services**.
4. Select the **ASP.NET 4.5** check box.
5. Click **OK**.

## More information

For more information about how to enable the ASP.NET 4.5 feature on Windows Server 2012, see [IIS 8.0 using ASP.NET 3.5 and ASP.NET 4.5](/iis/get-started/whats-new-in-iis-8/iis-80-using-aspnet-35-and-aspnet-45).
