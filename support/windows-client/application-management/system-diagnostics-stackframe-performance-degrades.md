---
title: Performance of System.Diagnostics.StackFrame decreases in Windows 10 and .NET Framework 4.7.1
description: Fixes an issue that occurs after you upgrade to Windows 10 or .NET Framework 4.7.1 in which applications that use System.Diagnostics.StackFrame run much slower than before.
ms.date: 04/11/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:.net-framework-installation, csstroubleshoot
ms.subservice: application-compatibility
---
# Performance of System.Diagnostics.StackFrame decreases in Windows 10 and .NET Framework 4.7.1

This article helps fix an issue where applications that use `System.Diagnostics.StackFrame` run slower than before after you upgrade to Windows 10 or Microsoft .NET Framework 4.7.1.

_Applies to:_ &nbsp; Windows 10, version 1803, Windows 10, version 1709  
_Original KB number:_ &nbsp; 4057154

## Symptoms

Starting in October 2017, after you upgrade to Windows 10 or .NET Framework 4.7.1, you notice a significant decrease in performance when you run .NET Framework applications that use the `System.Diagnostics.StackFrame` class.

Applications typically rely on `StackFrame` when they throw .NET exceptions. If this occurs at a high rate (more than 10 incidents per second), applications can slow down significantly (tenfold) and run noticeably slower than before.

To determine your version of Windows, see [Which Windows operating system am I running?](https://support.microsoft.com/windows/which-version-of-windows-operating-system-am-i-running-628bec99-476a-2c13-5296-9dd081cdd808).

## Resolution

This issue is fixed in the following Windows updates.

- For Windows 10 Version 1709  

    [January 31, 2018-KB4058258 (OS Build 16299.214)](https://support.microsoft.com/help/4058258)

- For all other supported Windows versions  

    [.NET Framework 4.7.1 Update (KB4054856)](https://support.microsoft.com/help/4054856)

To work around this issue, use one of the following methods.

## Workaround 1 (preferred): Use a different constructor for StackFrame that takes a Boolean argument

If application developers are able to make changes to their applications, call the `System.Diagnostics.StackTrace.#ctor(Boolean)` constructor by using a false argument to avoid capturing source information. This avoids the section of the code in which performance is decreased.

## Workaround 2: Roll back the system version

Roll back the system to the previous version of Windows 10 or .NET Framework. To do this, follow these steps.

### How to roll back to the previous version of Windows 10

1. Open **Settings**, select **Update & Security**, and then select **Recovery**.
2. Under **Go back to the previous version of Windows 10**, select **Get started**.

    :::image type="content" source="media/system-diagnostics-stackframe-performance-degrades/get-started-button.png" alt-text="Screenshot of the Go back to the previous version option in Windows 10 Recovery." border="false":::

3. Select a reason for rolling back, and then select **Next**.

    :::image type="content" source="media/system-diagnostics-stackframe-performance-degrades/next-button.png" alt-text="Screenshot of the Why are you going back page.":::

4. Select **No, thanks** to skip installing updates.
5. Select **Next** two times, and then select **Go back to earlier build**.

After you complete these steps, Windows 10 restores the previous version of the system.

:::image type="content" source="media/system-diagnostics-stackframe-performance-degrades/restoring-previous-verion.png" alt-text="Screenshot of the Restoring your previous version of Windows screen.":::

### How to roll back to the previous version of .NET Framework

Steps for Windows 7 SP1 and Windows Server 2008 R2 SP1:

1. Open the **Programs and Features** item in Control Panel.
2. In the **Uninstall or change a program** list, locate and select **Microsoft .NET Framework 4.7.1**, and then select **Uninstall/Change**.

    :::image type="content" source="media/system-diagnostics-stackframe-performance-degrades/uninstall-donet-framework-4dot-7dot1.png" alt-text="Screenshot of Uninstall/Change option of .Net Framework 4.7.1 in Programs and Features in Control Panel." border="false":::

3. Select **Remove .NET Framework 4.7.1 from this computer**, and then select **Next**.

    :::image type="content" source="media/system-diagnostics-stackframe-performance-degrades/remove-dotnet-4dot-7dot-1.png" alt-text="Screenshot of the Remove .NET Framework 4.7.1 from this computer option." border="false":::

4. Select **Continue** to confirm uninstallation.
5. Select **Finish** after the uninstallation is finished.

    :::image type="content" source="media/system-diagnostics-stackframe-performance-degrades/select-finish-button.png" alt-text="Screenshot shows .NET Framework 4.7.1 has been removed from this computer.":::

6. Restart your computer if you are prompted to do this.

> [!NOTE]
> After you uninstall .NET Framework 4.7.1, your computer no longer has any version of .NET Framework 4 installed. You must reinstall a version of .NET Framework 4.

Steps for Windows 8.1, Windows Server 2012, Windows Server 2012 R2, and Windows 10 Version 1607:

1. Open the **Programs and Features** item in Control Panel. To do this, type *appwiz.cpl* in the **Search** box.
2. Select **View installed updates**.

    :::image type="content" source="media/system-diagnostics-stackframe-performance-degrades/view-installed-updates.png" alt-text="Screenshot of the View installed updates page in Programs and Features." border="false":::

3. Right-click one of the following items, depending on your Windows version, and then click **Uninstall**:

    - Windows Server 2012: **Update for Microsoft Windows (KB4033345)**  
    - Windows 8.1 or Server 2012 R2: **Update for Microsoft Windows (KB4033369)**  
    - Windows 10 Version 1607: **Update for Microsoft Windows (KB4033369)**

4. Click **Yes** to confirm uninstallation.
5. Restart your computer if you are prompted to do this.

## More information

For more information about how many .NET exceptions a particular application throws, see [Exception Performance Counters](/previous-versions/dotnet/netframework-4.0/kfhcywhs(v=vs.100)).

For more information about how to measure the rate of exceptions for an application, see [Runtime Profiling](/previous-versions/dotnet/netframework-4.0/w4bz2147(v=vs.100)).

> [!NOTE]
> This issue does not change the number of exceptions that are thrown. However, it does significantly decrease the ability of applications to handle those exceptions. For more information about this issue, see [this GitHub post](https://github.com/Microsoft/dotnet/blob/master/releases/net471/KnownIssues/517815-BCL%20Applications%20making%20heavy%20use%20of%20System.Diagnostics.StackTrace%20might%20run%20more%20slowly%20on%20.NET%204.7.1.md).

Applications that use IKVM library are known to be affected by this issue if they probe for assemblies. Probing for assemblies is known to cause exceptions.
