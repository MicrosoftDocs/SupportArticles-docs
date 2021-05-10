---
title: Disable Internet Explorer on Windows
description: This article describes how to disable any supported version of Internet Explorer on Windows.
ms.date: 01/21/2021
ms.prod-support-area-path: installation
ms.reviewer: 
ms.topic: how-to
---
# Disable Internet Explorer on Windows

This article describes how to disable any supported version of Internet Explorer on Windows.

_Applies to:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 4013567

## More information

To disable Internet Explorer, use one of the following methods.

> [!NOTE]
> If you want to restore the program on the same computer, we recommend that you use the same method that you first used (Control Panel or DISM). Because Internet Explorer remains installed on the computer after you disable it, you should continue to install security updates that apply to Internet Explorer.

## Method 1 - Use Control Panel (client systems only)

On client systems, you can use the **Program and Features** item in Control Panel to disable Internet Explorer. To do this, follow these steps:

1. Press the Windows logo key+R to open the **Run** box.
1. Type *appwiz.cpl*, and then select **OK**.
1. In the **Programs and Features** item, select **Turn Window features on or off**.
1. In the **Windows Features** dialog box, locate the entry for the installed version of Internet Explorer. For example, locate the **Internet Explorer 11** entry. Then, clear the check box.
1. Select **OK** to commit the change.
1. Restart the computer.

## Method 2 - Use DISM (client and server systems)

On client and server systems, you can use the Deployment Image Servicing and Management (DISM) command-line tool to disable Internet Explorer. For example, to disable Internet Explorer 11, follow these steps.

- Disable the feature

    To disable Internet Explorer 11, run the following command at an elevated command prompt: `dism /online /Disable-Feature /FeatureName:Internet-Explorer-Optional-amd64`.

    The following message is returned:

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

- Enable the feature

    If you want to re-enable Internet Explorer 11, run the following command at an elevated command prompt: `dism /online /Enable-Feature /FeatureName:Internet-Explorer-Optional-amd64`.

    The following message is returned:

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
- Windows 10, version 1903, all editions
- Windows Server, version 1903, all editions
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
- Windows Vista Service Pack 2
- Windows Vista Ultimate
- Windows Vista Enterprise
- Windows Vista Business
- Windows Vista Home Premium
- Windows Vista Home Basic, Windows Vista Starter
