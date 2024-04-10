---
title: COMException occurs in WPF applications
description: This article describes how WPF applications fail and generate a System.Runtime.InteropServices.COMException error, and provides workarounds for this problem.
ms.date: 05/06/2020
---
# COMException from WPF applications after .NET Framework 4.7 is installed on Windows 7 or Windows Server 2008 R2

This article helps you resolve the problem where `System.Runtime.InteropServices.COMException` occurs in Windows Presentation Framework (WPF) applications.

_Original product version:_ &nbsp; .NET Framework 4.7, Windows 7 Service Pack 1, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 4033488

## Symptoms

Consider the following scenario:

- You have a touch device that is running Microsoft Windows 7 Service Pack 1 (SP1) or Windows Server 2008 R2 SP1.
- Some WPF applications are running on the device.
- You install the [May 2017 Preview of Quality Rollup for the .NET Framework 4.6, 4.6.1, and 4.6.2](https://support.microsoft.com/help/4014606) (KB 4104606) on the device.
- You then install the .NET Framework 4.7 on the device.

In this scenario, the WPF applications fail and generate error messages:

> Exception type: System.TypeInitializationException  
> Message: The type initializer for 'MS.Win32.Penimc.UnsafeNativeMethods' threw an exception.  
> InnerException: System.Runtime.InteropServices.COMException  
> Message of the inner exception: Class not registered (Exception from HRESULT: 0x80040154 (REGDB_E_CLASSNOTREG))

## Resolution

To resolve this problem, install the July 25, 2017, update for the .NET Framework 4.6, 4.6.1, 4.6.2, and 4.7 from the Microsoft Update Catalog.

- Windows 7 SP1 and Windows Server 2008 R2 SP1

    [Download the stand-alone package](https://catalog.update.microsoft.com/v7/site/Search.aspx?q=4035510) from the Microsoft Update catalog. For more information about this update, see [KB 4035510](https://support.microsoft.com/help/4035509).

- Windows 8.1 and Windows Server 2012 R2

    [Download the stand-alone package](https://catalog.update.microsoft.com/v7/site/Search.aspx?q=4035509) from the Microsoft Update catalog. For more information about this update, see [KB 4035509](https://support.microsoft.com/help/4035509).

- Windows Server 2012

    [Download the stand-alone package](https://catalog.update.microsoft.com/v7/site/Search.aspx?q=4035508) from the Microsoft Update catalog. For more information about this update, see [KB 4035508](https://support.microsoft.com/help/4035508).

## Workaround

To work around this problem, uninstall and then reinstall the .NET Framework 4.7. Alternatively, temporarily disable the affected WPF touch component.

### Uninstall the .NET Framework 4.7

1. In Control Panel, select **Uninstall a program** in the **Programs** category.
2. In the list of programs, locate and select **Microsoft .NET Framework 4.7**, and then select **Uninstall/Change**.
3. In the .NET Framework 4.7 Maintenance wizard, select **Remove.NET Framework 4.7 from this computer**, and then select **Next**.
4. If the following warning window appears, select **Continue**.

    :::image type="content" source="./media/comexception-error-from-wpf-app/warning.png" alt-text="Screenshot of the warning window, which shows uninstalling Microsoft .NET Framework may cause some applications to cease to function.":::

5. Wait for the uninstallation to complete.

### Reinstall the .NET Framework 4.7

To reinstall the Microsoft .NET Framework 4.7, use one of the following methods.

#### Method 1: Manually download and install the .NET Framework 4.7

1. Download the [web installer for the .NET Framework 4.7](https://go.microsoft.com/fwlink/?LinkId=825299).
2. Install the .NET Framework 4.7.

#### Method 2: Use Windows Update to install the .NET Framework 4.7

1. Open Windows Update.
2. Select **Check online for updates from Windows Update**.
3. After the search for updates is complete, select **Optional Updates available**.

    :::image type="content" source="./media/comexception-error-from-wpf-app/optional-updates.png" alt-text="Screenshot of the Windows Update panel, showing the link of optional updates available.":::

4. Locate and select **Microsoft .NET Framework 4.7 for Windows 7 and Windows Server 2008 R2**, and then select **OK**.

    :::image type="content" source="./media/comexception-error-from-wpf-app/dot-net-update.png" alt-text="Screenshot shows the optional updates, where Microsoft .NET Framework 4.7 for Windows 7 and Windows Server 2008 R2 for x64 (KB3186497) is selected.":::

5. Wait for the installation to complete.

### Temporarily disable touch and stylus support for WPF applications  

To temporarily disable touch and stylus support, use one of the following methods.

- Add the following entry to the **application configuration** to disable touch and stylus support for WPF applications.

    ```xml
    <runtime>
        <AppContextSwitchOverrides value=" Switch.System.Windows.Input.Stylus.DisableStylusAndTouchSupport=true"/>
    </runtime>
    ```

- Apply the following registry subkey to disable touch and stylus support for WPF applications machine-global.

    > [!WARNING]
    > Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft can't guarantee that these problems can be solved. Modify the registry at your own risk.  

  - Location: `HKEY_LOCAL_MACHINE\Software\[Wow6432Node\]Microsoft\.NETFramework\AppContext\Switch.System.Windows.Input.Stylus`
  - Name: `DisableStylusAndTouchSupport`
  - Type: String  
  - Value: `true`

## Reference

For more information about known issues in the .NET Framework 4.7, see [Known issues for .NET Framework 4.7](https://support.microsoft.com/help/4015088).
