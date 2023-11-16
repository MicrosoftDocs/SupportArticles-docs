---
title: Computer screen goes black during setup
description: Fixes an issue where a black screen is displayed during Windows 7 setup on systems with embedded DisplayPort from AMD/ATI.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup, csstroubleshoot
ms.technology: windows-client-deployment
---
# Computer screen goes black during the Windows 7 installation process

This article provides a solution to an issue where a black screen is displayed during Windows 7 setup on systems with embedded DisplayPort from AMD/ATI.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 978226

> [!NOTE]
> This article is intended for advanced computer users. If you purchased a retail copy of Windows 7, click the support link on the right side of your screen.

## Symptoms

Your computer has an AMD/ATI Radeon graphics processing unit (GPU) that uses the embedded DisplayPort (eDP) technology. When you install Windows 7 on the computer, a black screen is displayed during the installation process. However, the installation is still running. In this situation, you may be unable to complete the installation.

> [!NOTE]
> If you have multiple displays, only the primary screen is black when you encounter this issue.

## Cause

AMD implemented eDP support after the Windows 7 DVD was finished. Therefore, the AMD Radeon graphics driver on the Windows 7 retail DVD does not support eDP.

AMD has released an updated driver that fixes the eDP issue. The update must be incorporated into the setup process for setup to complete successfully.

## Resolution

To resolve this problem, follow these steps:

1. Save the Autounattend.xml answer file and the latest graphics driver to a USB flash drive. To do this, follow these steps:

     1. Copy an Autounattend.xml file to the root of a USB flash drive. If you want to create an Autounattend.xml file yourself, go to the [Create an Autounattend.xml file](#create-an-autounattendxml-file) section.
     2. Copy the uncompressed graphics driver onto the USB flash drive. To do this, follow these steps:
        1. Download the latest driver for your graphics adapter from the [AMD Web site](https://www.amd.com/).

        2. Run the downloaded program (.exe) to extract the driver. The program will prompt for an installation location, such as c:\ati\support\.
        3. After the extraction is complete, locate the installation folder that is noted in the previous step.
        4. Copy the installation folder onto the USB flash drive.

2. From the Windows 7 installation DVD, start the computer that has the AMD Radeon GPU that uses eDP.
3. Immediately connect the USB flash drive after the computer starts from DVD.
4. Follow the instructions to complete the installation process.
5. When the system restarts for the first time, disconnect the USB flash drive.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]  

## Workaround

If you have a secondary monitor, connect the monitor to the computer before you install Windows 7. Then, you will be able to complete the setup process. After Windows 7 is installed, you can install an updated driver that corrects the eDP issue through Windows Update or through the [AMD Web site](https://www.amd.com/).

## Affected systems

The issue is known to occur with the following system:

- Apple iMac 27"

The issue also affects systems that have one of the following AMD/ATI Radeon GPU's:

- ATI Mobility Radeon HD 4650 (PCI\VEN_1002&DEV_9480)
- ATI Mobility Radeon HD 4670 (PCI\VEN_1002&DEV_9488)
- ATI Mobility Radeon HD 4870 (PCI\VEN_1002&DEV_945A)
- ATI Mobility Radeon HD 4850 (PCI\VEN_1002&DEV_944A)
- ATI Mobility Radeon HD 4330 (PCI\VEN_1002&DEV_9552)

## Create an Autounattend.xml file

To create an Autounattend.xml file yourself, follow these steps:

1. On any computer that you can use, start Notepad, and then paste the following text in the Notepad window:

    ```xml
    <?xml version="1.0" encoding="utf-8"?>
    <unattend xmlns="urn:schemas-microsoft-com:unattend">
         <servicing></servicing>
         <settings pass="windowsPE">
             <component name="Microsoft-Windows-PnpCustomizationsWinPE" processorArchitecture="x86" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                 <DriverPaths>
                     <PathAndCredentials wcm:keyValue="1" wcm:action="add">
                         <Path>%configsetroot%</Path>
                     </PathAndCredentials>
                 </DriverPaths>
             </component>
             <component name="Microsoft-Windows-Setup" processorArchitecture="x86" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                 <UseConfigurationSet>true</UseConfigurationSet>
             </component>
             <component name="Microsoft-Windows-PnpCustomizationsWinPE" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                 <DriverPaths>
                     <PathAndCredentials wcm:keyValue="1" wcm:action="add">
                         <Path>%configsetroot%</Path>
                     </PathAndCredentials>
                 </DriverPaths>
             </component>
             <component name="Microsoft-Windows-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                 <UseConfigurationSet>true</UseConfigurationSet>
             </component>
         </settings>
         <settings pass="offlineServicing">
             <component name="Microsoft-Windows-PnpCustomizationsNonWinPE" processorArchitecture="x86" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                 <DriverPaths>
                     <PathAndCredentials wcm:keyValue="2" wcm:action="add">
                         <Path>%configsetroot%</Path>
                     </PathAndCredentials>
                 </DriverPaths>
             </component>
             <component name="Microsoft-Windows-PnpCustomizationsNonWinPE" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                 <DriverPaths>
                     <PathAndCredentials wcm:keyValue="2" wcm:action="add">
                         <Path>%configsetroot%</Path>
                     </PathAndCredentials>
                 </DriverPaths>
             </component>
         </settings>
         <settings pass="auditSystem">
             <component name="Microsoft-Windows-PnpCustomizationsNonWinPE" processorArchitecture="x86" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                 <DriverPaths>
                     <PathAndCredentials wcm:keyValue="3" wcm:action="add">
                         <Path>%configsetroot%</Path>
                     </PathAndCredentials>
                 </DriverPaths>
             </component>
             <component name="Microsoft-Windows-PnpCustomizationsNonWinPE" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                 <DriverPaths>
                     <PathAndCredentials wcm:keyValue="3" wcm:action="add">
                         <Path>%configsetroot%</Path>
                     </PathAndCredentials>
                 </DriverPaths>
             </component>
         </settings>
         <cpi:offlineImage cpi:source="wim:d:/sources/install.wim#Windows 7 ULTIMATE" xmlns:cpi="urn:schemas-microsoft-com:cpi" />
    </unattend>
    ```

2. Save the file as **Autounattend.xml** by using the UTF-8 encoding format.

## References

For more information about unattended installations, see [Windows Automated Installation Kit for Windows 7](/previous-versions/windows/server/dd349343(v=ws.10)).

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
