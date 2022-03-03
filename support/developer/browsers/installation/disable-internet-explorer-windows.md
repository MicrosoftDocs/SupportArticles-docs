---
title: Disable and enable Internet Explorer on Windows
description: This article describes how to disable and enable any supported version of Internet Explorer on Windows.
ms.date: 03/03/2022
ms.custom: sap:installation
ms.reviewer: haiyingyu
ms.topic: how-to
ms.technology: internet-explorer-installation
---
# Disable and enable Internet Explorer on Windows

[!INCLUDE [](../../../includes/browsers-important.md)]

This article describes how to disable and enable any supported version of Internet Explorer on Windows.

_Applies to:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 4013567

## More information

To disable Internet Explorer, use one of the following methods.

If you remove Internet Explorer by using DISM, the iexplore.exe entry point is removed from the file system, but its rendering engine remains on the system. Therefore, you should continue to install security updates that apply to Internet Explorer even after you disable it, as applicable.

To restore the program on your computer, we recommend that you use the same method that you used to disable it (Control Panel or DISM).

> [!IMPORTANT]
> If you disable Internet Explorer by using any of the following methods, the Internet Explorer (IE) mode in Microsoft Edge also won't be available. To continue using IE mode in Microsoft Edge to access legacy applications, disable Internet Explorer by using group policy instead, as described in [Disable Internet Explorer 11 as a standalone browser](/deployedge/edge-ie-disable-ie11).

## Method 1 - Use Control Panel (client systems only), Feature On Demand

_Applies to:_ &nbsp; Windows 10, version 1703 and later versions  

We recommend that you use the Feature On Demand method on devices for which it's available.

On client systems, you can use the **Program and Features** item in Control Panel to disable Internet Explorer. To do this, follow these steps:

1. Go to **Start** and select **Settings**.
1. Select **Apps**.
1. Select **Optional features**.
1. In the list of installed features, find **Internet Explorer 11**, select it, and then select **Uninstall**.
1. Restart the computer when the Latest Actions section indicates reboot required.

To enable Internet Explorer:

1. Go to **Start** and select **Settings**.
1. Select **Apps**.
1. Select **Optional features**.
1. Select **Add a feature**.
1. Select the box next to **Internet Explorer 11**.
1. Select **Install (1)**.
1. Restart the computer when the Latest Actions section indicates reboot required.

## Method 2 - Use DISM (client and server systems), Feature On Demand

_Applies to:_ &nbsp; Windows 10, version 1703 and later versions  

We recommend that you use the Feature On Demand method on devices for which it's available.

On client and server systems, you can use the Deployment Image Servicing and Management (DISM) command-line tool to disable Internet Explorer. For example, to disable Internet Explorer 11, follow these steps.

- **Disable the feature**

    To disable Internet Explorer 11, run the following command at an elevated command prompt: `dism /online /Remove-Capability /CapabilityName:Browser.InternetExplorer~~~~0.0.11.0`.

    You see the following message:

    ```output
    Deployment Image Servicing and Management tool
    Version: 10.0.19041.844
    Image Version: 10.0.19041.985
    [==========================100.0%==========================]
    The operation completed successfully.
    Restart Windows to complete this operation.
    Do you want to restart the computer now? (Y/N)
    ```

- **Enable the feature**

    To re-enable Internet Explorer 11, run the following command at an elevated command prompt: `dism /online /Add-Capability /CapabilityName:Browser.InternetExplorer~~~~0.0.11.0`.

    You see the following message:

    ```output
    Deployment Image Servicing and Management tool
    Version: 10.0.19041.844
    Image Version: 10.0.19041.985
    [==========================100.0%==========================]
    The operation completed successfully.
    Restart Windows to complete this operation.
    Do you want to restart the computer now? (Y/N)
    ```

## Method 3 - Use Control Panel (client systems only), Windows Feature

On client systems, you can use the **Program and Features** item in Control Panel to disable Internet Explorer. To do this, follow these steps:

1. Press the Windows logo key+R to open the **Run** box.
1. Enter *appwiz.cpl*, and then select **OK**.
1. In the **Programs and Features** item, select **Turn Window features on or off**.
1. In the **Windows Features** dialog box, clear the checkbox for the installed version of Internet Explorer. For example, find the **Internet Explorer 11** feature and then clear its check box.
1. Select **OK**.
1. Restart the computer.

## Method 4 - Use DISM (client and server systems), Windows Feature

On client and server systems, you can use the Deployment Image Servicing and Management (DISM) command-line tool to disable Internet Explorer. For example, to disable Internet Explorer 11, follow these steps.

- **Disable the feature**

    To disable Internet Explorer 11, run the following command at an elevated command prompt: `dism /online /Disable-Feature /FeatureName:Internet-Explorer-Optional-amd64`.

    You see the following message:

    ```output
    Deployment Image Servicing and Management tool  
    Version: 6.1.7600.16385  
    Image Version: 6.1.7600.16385  
    Disabling feature(s)  
    [===================100.0%===================]  
    The operation completed successfully.  
    Restart Windows to complete this operation.  
    Do you want to restart the computer now (Y/N)?
    ```

    > [!NOTE]
    > You must restart the computer to implement the change.

- **Enable the feature**

    To re-enable Internet Explorer 11, run the following command at an elevated command prompt: `dism /online /Enable-Feature /FeatureName:Internet-Explorer-Optional-amd64`.

    You see the following message:

    ```output
    Deployment Image Servicing and Management tool  
    Version: 6.1.7600.16385  
    Image Version: 6.1.7600.16385  
    Enabling feature(s)  
    [===================100.0%===================]  
    The operation completed successfully.  
    Restart Windows to complete this operation.  
    Do you want to restart the computer now (Y/N)?
    ```

    > [!NOTE]
    > You must restart the computer to implement the change.

## Applies to

- Windows 10, version 2004, all editions
- Windows Server, version 2004 all editions
- Windows 10, version 1909, all editions
- Windows 10, version 1809, all editions
- Windows Server 2019, all editions
- Windows 10, version 1803, all editions
- Windows Server version 1803
- Windows 10, version 1709, all editions
- Windows 10, version 1703, all editions
- Windows 10, version 1607, all editions
- Windows 10, version 1511, all editions
- Windows Server version 1709
- Windows Server version 1803
- Windows Server 2016
- Windows 10
- Windows Server 2012 R2 Datacenter
- Windows Server 2012 R2 Standard
- Windows Server 2012 R2 Essentials
- Windows Server 2012 R2 Foundation
- Windows 8.1 Enterprise
- Windows 8.1 Pro
- Windows 8.1
- Windows Server 2012 Datacenter
- Windows Server 2012 Standard
- Windows Server 2012 Essentials
- Windows Server 2012 Foundation
- Windows Server 2012 for Embedded Systems
- Windows Server 2008 R2 Service Pack 1
- Windows Server 2008 R2 Datacenter
- Windows Server 2008 R2 Enterprise
- Windows Server 2008 R2 Standard
- Windows Server 2008 R2 Foundation
- Windows Server 2008 R2 for Itanium-Based Systems
- Windows 7 Service Pack 1
- Windows 7 Enterprise
- Windows 7 Ultimate
- Windows 7 Professional
- Windows 7 Home Premium
- Windows 7 Home Basic
- Windows Server 2008 Service Pack 2
- Windows Server 2008 Datacenter
- Windows Server 2008 Enterprise
- Windows Server 2008 Standard
- Windows Server 2008 Foundation
- Windows Server 2008 for Itanium-Based Systems
