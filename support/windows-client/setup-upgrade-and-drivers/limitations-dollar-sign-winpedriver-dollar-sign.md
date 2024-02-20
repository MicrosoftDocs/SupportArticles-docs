---
title: Limitations of $WinPeDriver$
description: Describes limitations of $WinPeDriver$.
ms.date: 09/01/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:driver-installation-or-driver-update, csstroubleshoot
---
# Limitations of $WinPeDriver$ when used in conjunction with other driver injection methods

This article provides guidance on including drivers into WinPE and the operating system to be installed so that the driver is available in the WinPE portion of installation and also ends up in the completed operating system installation.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2686316

## Summary

When adding a driver into installation media, don't mix versions. Use the same version of each driver throughout the media.

There are several different methods for including out-of-box drivers into Winpe (boot.wim) and the target installing operating system (install.wim). If the driver versions don't match, the first driver loaded into memory will be used regardless of PNP ranking rules. Other versions may be marked as 'Bad' drivers that will prevent these drivers from being selected by PNP at a later time. This includes any driver loaded into memory during the boot to WinPE (Winpe phase) of installation. Examples could include injecting drivers into boot.wim via DISM.exe or loading a driver using Drvload.exe to manually load the driver.

## Purpose

Consider the following scenario: you're creating a custom Windows Pre-installation Environment (WinPE) image for the purposes of installing Windows operating systems that needs an out-of-box storage controller driver before running Setup.exe to manipulate the disks. Additionally, you want to provide "up-to-date" drivers for inclusion via the \\$WinPEDriver$ folder feature of Setup, to include later versions of the same driver.

The $WinPEDriver$ feature is intended as a method to provide drivers at installation time. However, it's a feature of Setup.exe, and as such isn't invoked until after Setup.exe launches. Drivers for present devices that are injected manually into the WinPE boot.wim driverstore using DISM are loaded into memory at boot time. These two mechanisms are separate, and there are some caveats to using them together.

WinPE doesn't have a built-in mechanism to unload drivers that have been loaded into memory, so any drivers for devices that have already been loaded won't be reloaded once setup.exe starts, as there are already drivers for the device loaded. This error will cause Setup to mark the driver in the $WinPEDriver$ folder as a bad driver, even if it's newer than the driver version injected into WinPE and would otherwise outrank it. Setup has no explicit knowledge of drivers that have been loaded into the boot.wim.

_This behavior is by design_; however this article will identify a method of accommodating this scenario so these drivers can still be included in the deployable operating system.

## More information

Given the above scenario, putting WinPE on a bootable USB Flash Device (UFD) hard drive or thumb stick would be most preferable.

In this document, we're going to be highlighting methods for injecting drivers and launching windows. The following chart briefly shows methods and results of including drivers.

|WinPE (in-box native or injected)|  (out-box drivers in $WinPEDriver$)| Result (Post OS) |
|---|---|---|
|If WinPE contains driver version X1 injected via Dism.exe|contains X2 version of driver with same driver name|X1 will be carried in post OS installation and X2 will be ignored|
|If WinPE installs driver X2 using Drvload.exe from \$WinPEDriver$|contains X2 version of driver with same driver name|X2 will be carried in post OS installation|
|if WinPE contains driver X1 that isn't boot-critical (in-box native)|contains no driver|Will use in-box native driver X1. No out of box driver will be available for that device post OS installation|
  
## Driver Limitations

Keep in mind that there are some drivers that can be included and/or loaded that may not be functional during WinPE portion of installation. This would include, but isn't limited too; video drivers, wireless adapter drivers, and audio drivers. The behavior described in this document isn't specific to BootCritical drivers (drivers need during boot-up such as controller drivers for access to hard drive) and is in effect for all drivers loaded during installation/deployment.

### Walk through of loading drivers from StartNet.cmd

It's but one method for including the same driver into Windows Preinstallation Environment (WinPE) as well as making it available to the installing operating system; other methods are possible using the information further in this document.

1. Set up the technician's machine:
    1. Install OPK/AIK to supported technicians machine.
    2. Copy Windows bits to be modified to local HDD c:\\bin.
    3. Locate/download/extract drivers to include into media.
2. Prepare USB device per web page make sure to name device "INSTALL_WIN7". This name is used later and if you change this, you must change the name in the sample script described in step #6 and the example below (web page links are listed at end of document)
3. Create WinPE files for copy to USB device, open Administrative command prompt and run:
    1. `Copype.cmd <arch> <path>`  
    2. `Copy <pathto> winpe.wim to \ISO\sources\boot.wim`
4. Mount boot.wim:
    1. `Dism /get-wiminfo /wimfile:\<pathto>\boot.wim`
    2. `Dism /mount-wim /wimfile:<pathto>\boot.wim /index:1 /mountdir:<pathto>\Mount`
5. Open an Administrative Command Prompt and edit \\mount\\windows\\system32\\startnet.cmd (using Notepad.exe or similar).
6. The following sample script identifies USB devices and makes drivers available during WinPE using Drvload.exe. Cut and paste the script into the startnet.cmd file that you've open.

    > [!NOTE]
    > You may want to copy the script into notepad.exe or some other text editor first to remove formatting.

    ```console
    wpeinit
    :ChkVar
    :: Locating USB Device
    IF NOT DEFINED usbdrv (  
    ECHO list vol | diskpart | find "INSTALL_WIN7" > pt.txt  
    FOR /F "tokens=3" %%a IN (pt.txt) DO (  
    SET usbdrv=%%a^:  
    )  
    del pt.txt /f /q  
    IF EXIST %usbdrv%\InstallOS.bat call InstallOS.bat  
    ```

7. Save StartNet.cmd and close it.
8. Dismount and commit changes to boot.wim using the following command:

    ```console
    Dism /unmount-wim /mountdir:<pathto>mount /commit
    ```

9. Copy all files in the \\ISO folder to a USB Flash Device (should be formatted FAT32 and marked as Active).
10. Create a folder on root of USB Flash Device named $WinpeDriver$.
11. Copy drivers into this folder (for example \<USB_drv>\\$WinpeDriver$\\DriverX).
12. Open Administrative cmd prompt and create file \<USB_drv>\\InstallOS.bat, cutting and pasting the following line into the batch file:  
 drvload %usbdrv%\\$winpedriver$\\\<device>\\filename.INF  
13. To include Windows OS installation source files from DVD:

    1. Create the following folder on the USB thumbstick: \<USB_drv>\\\<OS>\Sources (for example e:\\Win2008r2x64\\Sources).
    2. Select and copy DVD\\sources\\* to \<USB_drv>\\\<OS>\\sources (you may exclude boot.wim)
    3. To manually launch setup.exe when booted to WinPE, select \<USB_drv>\\\<OS>\\Sources\\Setup.exe and add any appropriate switches as needed.
    4. For fully automated deployment, add the following line to the InstallOS.bat file, adding any appropriate switches:  
        %usbdrv%\\\<OS>\\Sources\\Setup.exe

14. TEST by booting to a USB device on TEST machine

## Methods for making drivers available to WinPE  

Methods for including drivers into WinPE include:

1. Image build time injection via DISM.exe - Places driver in the Driverstore of the WinPE image and it's selected via Plug and Play at WinPE boot time. It doesn't propagate to the installed OS. For this method you must mount the WIM files for access, inject the driver, and then save and commit the changes to the WIM.

    Steps for gathering information, mounting, injecting, and unmounting WIM:

    1. `DISM /get-wiminfo /wimfile:<pathto>boot.wim`
    2. `DISM /mount-wim /wimfile:<pathto>boot.wim /index:n /mountdir:<pathto>mount`
    3. `DISM /add-driver /image:<pathto>mount / driverpath:<pathto>driverINF` [and conversely `/remove-driver` if needed]
    4. `DISM /unmount-wim /commit /mountdir:<pathto>mount`  
2. Runtime driver load via Drvload.exe - Loads driver into memory and starts the device. Doesn't propagate the driver to the installed OS.
3. Runtime driver load via Devcon.exe - Devcon is provided via sample source code in the Windows Device Driver Kit (DDK)/Windows Driver Kit (WDK). You must create and compile your own copy. Devcon is used to manipulate drivers, such as loading drivers into memory and starting devices. Doesn't propagate the driver to the installed OS. (Link in References section)
4. $WinPEDriver$ folder- Setup.exe will attempt to load all drivers in the $WinPEDriver$ directory into memory, and also will schedule them for injection into the installing OS.
5. Runtime answer file (unattend.xml) with DriverPath - Path (and credentials if necessary) must be provided in unattend.xml. It's used to access files in central repository that can be on a network share or local. Setup will attempt to load all drivers in the driver store provided in the unattend.xml and also will schedule them for injection into the installed OS.  

### Launch Windows installation

There are several methods for launching the installation of the operating system from WinPE, including:

1. Injecting setup packages into boot.wim.  
    1. Custom WinPE can be modified to auto launch Windows Setup.exe.  
    2. Can also be used for language packs and scripting support.
2. Launching setup.exe from startnet.cmd or winpeshl.ini.
    1. locate USB stick/Hdd  
    2. Launch \\path\\setup.exe \</switches>
3. Custom front end to replace cmd.exe (see links for Windows RE in reference section).
4. Booting from regular Windows Setup media, which first boots up to WinPE (Boot.wim) and can take input from attached USB device or network storage. This method isn't discussed in this article.

### Methods for adding drivers to Windows

Next, following the progression from installation to inclusion of out-of-box drivers, there are a few methods available to include out-of-box drivers in Windows:

1. Dism.exe
    1. `Dism /get-wiminfo /wimfile:<pathto>Install.wim`  
    2. `Dism /mount-wim /wimfile:<pathto>Install.wim /index:n /mountdir:<pathto>mount`
    3. `Dism /add-driver [and conversely /remove-driver] /image:<pathto>mount /driverpath:<pathto>driverINF`
    4. `Dism /unmounts-wim /commit /mountdir:<pathto>mount`  
2. \\$WinPEDriver$
3. Running a script during unattended installation
    1. unattend.xml (driverstore) in WinPE and Audit Mode (more information is in the References and Links section).  
    2. Setupcomplete.cmd can be used for driver injection, but is advised against as it's a poor user experience and can cause delays in booting to the desktop for the first time.
4. Drvload.exe
    1. Only injects drivers into the currently running OS, which if there's WinPE is typically RAM disk.  
    2. Drvload \<pathto.INF> (can be scripted in startnet.cmd (see examples))

> [!NOTE]
> If the driver to be used has the same name as an in-box driver (natively included in image) these newly injected drivers will not be used by the booting operating system and you should contact the driver manufacture for updated drivers. (If familiar with the Windows Logo Kit (WLK), see Devfund0005)
>
> If a driver is loaded during WinPE pass (initial boot) there is no native mechanism in place to remove that driver until the operating system reboots.

There are multiple methods for each step of the process of adding drivers to Windows. The methods provide for an extensible and malleable deployment scenario. You'll want to determine which method below works best for the given situation.

## Detailed instructions for including out of box drivers in WinPE

Necessary setup/tools:

- Technicians computer - computer used to build/manipulate installation media
- OPK / AIK installed
- USB/UFD or DVD

Using DISM.exe:

1. Install either the OEM Preinstallation Kit (OPK) or the Windows Automated Installation Kit (Windows AIK)
2. Click on **Start** > **Programs** > **Windows OPK** (or **Windows AIK**) and open an Administrative Deployment Tools Command Prompt.
3. Copy boot.wim to the hard drive (ex. c:\\Bin). You can also generate new WinPE using Copype.cmd; however, this will not automatically launch setup.exe without additional customizations.
4. Use DISM to identify the number of indexes in the boot.wim. If you're copying the boot.wim from installation media it will have two indexes. Typically we'll modify index #2; otherwise, index #1.  
    `dism /get-wiminfo /wimfile:<wim_file>`  
    > [!NOTE]
    > Files injected into one index will not be available to other indices.
5. Create a 'Mount' folder (ex. c:\\Bin\\mount)
6. Use DISM to mount the wim.  
    `DISM /mount-wim /wimfile:c:\bin\boot.wim /index:1 /mountdir:c:\bin\mount`
7. Place driver in locatable folder (ex. c:\\bin\\driver).
8. Use DISM to add the driver to the mounted WIM image.  
    `dism /image:c:\bin\mount /Add-Driver /driverpath:<path to INF>`
9. Confirm success by checking the DISM log or ensuring that DISM returns completion at the command prompt.
10. Unmount and commit changes to Boot.wim. Close all handles to any open windows that may be open below c:\\bin\\mount before running this command (also make sure that the command prompt is at or above the c:\\bin directory structure).  
    `dism /unmount-wim /mountdir:c:\bin\mount /commit`  
11. Once DISM successfully unmounts WIM, we can set up things for moving to USB/DVD. If you get an error during dismount, you may want to remount the wim to confirm that the packages were injected. DISM parameters `/cleanup-wim` and `/get-packages` may be helpful here. Refer to the References and Links section at the end of this document for instructions on creating bootable WinPE media on an optical or USB flash drive.

### Using \\$WinpeDriver$

$WinpeDrivers$ is an additional folder structure that Setup.exe looks for and if found, is parsed to pull in additional drivers. Setup will recursively parse files and folders under this \\$WinpeDriver$ folder looking for *.INF files and attempts to install these discovered drivers into the driverstore.

Folder structure can look something like this on the root of the USB device:

\\$WinpeDriver$  
 └\\WiFi  
  └\\Wireless1  
   └Wireless.INF  
   └Wireless.SYS  
   └Wireless.CAT (Needed by operating system)

> [!NOTE]
> If you look in the \\Windows\\Panther\\Setupact.log you can see reference to this folder:
    _PnPIBS: Checking for pre-configured driver paths ..._  
    *PnPIBS: Checking for pre-configured driver directory C:\$WinPEDriver$.*  
    *PnPIBS: Checking for pre-configured driver directory D:\$WinPEDriver$.*  
    *PnPIBS: Checking for pre-configured driver directory E:\$WinPEDriver$.*  
    *PnPIBS: Checking for pre-configured driver directory X:\$WinPEDriver$.*  

### Using Unattended answer file (unattend.xml/autounattend.xml)

Windows can automatically look for an unattended answer file on the root of mounted drives if the files are named autounattend.xml. Windows will also pick up an unattended answer file if launched with Setup.exe using switches. This answer file can provide information to the installing operating system for such things as drive configuration, product key, computer name, and path to driver store, OEM company information, and many other things. Documentation on how to add a driver to the unattend.xml can be found at the end of this document in the References and Links section.

Below is an example snippet of an AutoUnattend.xml with Drvstore from an AIK Unattend.chm. The XML output specifies the UNC path to additional locations for device drivers and the credentials used to access the network paths.

```xml
<DriverPaths>
<!-- First PathAndCredentials list item -->
   <PathAndCredentials wcm:action="add" wcm:keyValue="1">
        <Path>\\myFirstDriverPath\DriversFolder</Path>
        <Credentials>
                <Domain>MyDomain</Domain>
                <Username>MyUsername</Username>
                <Password>MyPassword</Password>
        </Credentials>
   </PathAndCredentials>
<!-- Second PathAndCredentials list item -->
   <PathAndCredentials wcm:action="add" wcm:keyValue="2">
      <Path>C:\Drivers</Path>
      <Credentials>
         <Domain>MyComputerName</Domain>
         <Username>MyUsername</Username>
         <Password>MyPassword</Password>
      </Credentials>
   </PathAndCredentials>
</DriverPaths>
```

### Using Drvload.exe

Drvload is a tool in WinPE used to add in drivers once you're booted up to the built-in WinPE Command Prompt. When using Drvload, the drivers will need to be identified and placed somewhere. WinPE's startnet.cmd can be used to script Drvload, as well as either of the following actions while booting or booted to WinPE:

1. Running scripts to:
    1. Identify installation media, usually a USB device.  
    2. Add out of box drivers  
    3. Configure hard drives and recovery partitions  
    4. Launch setup.exe or apply WIMs as needed.
2. Post deployment/application of WIM validationFor developers that want to create their own tool to use for injecting or manipulating drivers, DevCon.exe may be a useful utility. For more information on DevCon.exe, see the References and Links section.

### Example startnet.cmd

As a means of scripting/automating the installation, the USB device needs to be identified since this is the location of the additional drivers. This example uses a script in WinPE that is autorun on startup to detect the USB drive. This script launches another script to install drivers using Drvload.exe in the WinPE stage of setup. The script is outside of the WIM file so it can easily be modified.

Methods for identifying installation media using WinPE Startnet.cmd (first file launched in default WinPE):

1. First there needs to be a way to automate the identification of the installation media in the WinPE Startnet.cmd, which is the first file launched in a default WinPE configuration. There are one of two ways you can do this:

    - Create a bootable WinPE USB flash drive with a disk volume label of "INSTALL_WIN7". Then put the following lines at the beginning of startnet.cmd to look for the "INSTALL_WIN7" disk volume label:

        ```console
        "INSTALL_WIN7" disk volume label:
        :ChkVar
        :: Locating USB Device
        IF NOT DEFINED usbdrv (
        ECHO list vol | diskpart | find "INSTALL_WIN7" > pt.txt
        FOR /F "tokens=3" %%a IN (pt.txt) DO ( 
        SET usbdrv=%%a^:
        )
        del pt.txt /f /q
        ```

    - Create 'tag' files on the media as an alternative drive location method for comparison:

        ```console
        :SetOSvar
        @echo off
        IF NOT DEFINED usbdrv (
        ECHO locating OS drive
        FOR %%b IN ( C D E F G H I J K L M N O ) DO (
        IF EXIST %%b:\<specialfilename1> IF EXIST %%b:\ <specialfilename2>  (
        SET usbdrv=%%b^:
        )
        )
        )
        ```

        > [!NOTE]
        > You will need to ensure that \<specialfilename1 & specialfilename2> exist in designated location on USB Flash Device.

2. Include the files into the boot.wim that are being used in the startnet.cmd. This will then put the files to the X: drive where they can be accessed via X:\\\<file name>. As you add files to the boot.wim, this will increase the WIM memory footprint.
3. Once USB drive letter is known, additional scripts for injection of drivers can be launched. Since it is difficult to modify boot.wim frequently (you must mount/unmount and commit changes each time), it is easier to run scripts outside of startnet.cmd. For example, if we create a script called 'InstallOS.bat' at the root of the USB flash drive, we can easily modify this file to make changes to the bootup/automation process as needed.

    Below is an example of the text needed in the startnet.cmd file that will look for 'InstallOS.bat' and if found, launch it:

    ```console
    IF EXIST %usbdrv%\InstallOS.bat call InstallOS.bat  
    Echo %time% %date%
    ```

    > [!NOTE]
    > As indicated by its name, InstallOS.bat can do much more than just add drivers to WinPE. However, for the purpose of this document additional scripting detail will not be discussed.
4. At this point %usbdrv% is defined with the drive letter for the USB flash device so drivers present in %usbdrv%\\$WinpeDriver$ folder can be injected through scripting in the InstallOS.bat.

    For example, in InstallOS.bat add `Drvload.exe %usbdrv%\$winpedriver$\<device>\filename.INF`.

Using this method, the driver that is made available for the operating system is first picked up and used by WinPE.

### Windows Recovery Environment (WinRE)

WinRE is typically going to be static on the hard drive, either auto-installed during installation or created/customized by OEMs for recovery scenarios. If the WinRE is used to recover the machine to factory defaults, then there really is no method to dynamically update drivers to the latest version. You will have to create an image using injected drivers into all relevant WIM files such as the WinRE.wim/Boot.wim as well as the image to be applied for the operating system. Ensure that these drivers are all the same versions.

## Conclusion

If your requirement is to create a WinPE environment that loads out of box drivers prior to running setup.exe, follow the guidelines described in this document in order to end up with the driver you want in the resulting installed operating system. Writing scripts which leverage Drvload.exe launched by startnet.cmd to load specific drivers located in the \$WinPeDriver$ folder on a USB flash drive is the most flexible method available. This method allows you to load a driver during the WinPE phase that carries over into the installed operating system. In addition, it allows for maintaining of a central repository for drivers that will allow for flexibility to update these drivers (so as to maintain the latest drivers in your driver store).

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).

## References and Links

- [Add Device Drivers during Windows Setup](/previous-versions/windows/it-pro/windows-vista/cc766485(v=ws.10))

- [What Is Deployment Image Servicing and Management?](/previous-versions/windows/it-pro/windows-7/dd744566(v=ws.10))

- [Deployment Image Servicing and Management Command-Line Options](/previous-versions/windows/it-pro/windows-7/dd744382(v=ws.10))

- [Drvload Command-Line Options](/previous-versions/windows/it-pro/windows-7/dd744511(v=ws.10))

- [DevCon](/windows-hardware/drivers/devtest/devcon)

- [Understanding Device Drivers and Deployment](/previous-versions/windows/it-pro/windows-7/dd744517(v=ws.10))

- [Driver Paths in Unattend.xml](/previous-versions/windows/it-pro/windows-vista/cc749300(v=ws.10))

- [Add a Package to a Windows PE Image](/previous-versions/windows/it-pro/windows-7/dd799312(v=ws.10))

- [What Is Windows RE?](/previous-versions/windows/it-pro/windows-7/dd744514(v=ws.10))

- [How Windows RE Works](/previous-versions/windows/it-pro/windows-7/dd744291(v=ws.10))

- [Walkthrough: Create a Bootable Windows PE RAM Disk on CD-ROM](/previous-versions/windows/it-pro/windows-7/dd799303(v=ws.10))

- [Walkthrough: Create a Bootable Windows PE RAM Disk on a USB Flash Disk](/previous-versions/windows/it-pro/windows-7/dd744530(v=ws.10))

- [How Configuration Passes Work](/previous-versions/windows/it-pro/windows-7/dd744341(v=ws.10))

- [Copype.cmd](/previous-versions/windows/embedded/ff794790(v=winembedded.60))

- [Windows Automated Installation Kit (AIK) for Win7/2008r2](https://www.microsoft.com/download/en/details.aspx?id=5753)

- [Windows OEM Preinstallation Kit (OPK)](https://www.microsoft.com/oem/en/downloads/pages/technical-downloads.aspx)

> [!NOTE]
> You will need an account to be able to download files from the OEM site.
