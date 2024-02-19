---
title: Add OEM PnP drivers to Windows installations
description: Provides the steps to add OEM Plug and Play drivers to Windows installations.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# Add OEM Plug and Play drivers to Windows installations

This article describes the steps to add Original Equipment Manufacturer (OEM)-supplied drivers to Windows installations.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 254078

## Summary

This article only includes drivers that are typically installed during graphical user interface (GUI)-mode Setup or after Setup by Plug and Play enumeration. This lets you pre-load OEM Plug and Play drivers that you can use if the associated hardware is added to the system later.

This article describes how to add OEM Plug and Play drivers in the following situations:

- Unattended Setup
- Sysprep Setup
- Remote Installation Service (RIS) installations
- Riprep images
- Existing Windows installations  

## More information

Drivers that are installed during the "Installing Devices" part of GUI-mode Setup have to be found in certain locations. At this point, Setup is installing the devices by using Plug and Play IDs that have been enumerated by Windows Plug and Play. Setup searches a predefined path on the drive, looking in .inf files to find the best match for the Plug and Play ID of the device. By default, this path is defined in the following registry location and is set to %SystemRoot%\Inf:  
`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\DevicePath: REG_EXPAND_SZ:%SystemRoot%\Inf`  
Setup uses this path to locate .inf files for device installation. After Setup, this path is also used for any new hardware that is found and installed. If you modify this key during Setup by using the Sysprep.inf file or the Unattended answer file, the value is saved and is also used after Setup.

The following sections contain steps to add OEM-supplied drivers to unattended or Sysprep Setup installations of Windows.

### For Microsoft Windows 2000

#### Unattended setup

When you add drivers to unattended Setup, follow these steps. If the OEM-supplied drivers are not digitally signed, you may receive a message about the drivers during Setup.  

1. Create your distribution share on a server by copying the contents of the Windows installation disc I386 folder. You can use the Setupmgr.exe program to create this share and the Unattended.txt file. You can find the Setupmgr.exe program on the Windows installation disc in the Support\Tools folder in the Deploy.cab file and the Unattend.doc file that contains information about Windows unattended Setup.

2. Create a $oem$\$1\Drivers folder in the I386 folder. You may want to create additional folders in the Drivers subfolder, depending on the hardware that you want to install. For example, you may install a network adapter, a modem, or a video. The $1 folder resolves to %SystemDrive%. During text-mode Setup, these folders and files are copied to the %SystemDrive%\Drivers folders as follows:
      > \i386  
        \\$oem$  
        - - \\$1  
        - - - \Drivers  
        - - - - - \network adapter  
        - - - - - \MODEM  
        - - - - - \VIDEO

3. Copy all the OEM-supplied driver files for the device in the folders that you created in the previous step.
4. Add the OemPnPDriversPath = Driver_Paths entry in the [Unattended] section of the Setup answer file. You can list multiple paths in this key by separating them with a semicolon (;). For example, add the following entry.

   > [Unattended]  
   > OemPnPDriversPath = "Drivers\network adapter;Drivers\Modem;Drivers\Video"

    > [!NOTE]
    > The %SystemDrive% environment variable string is automatically inserted before each of the listed search paths.

5. Save the answer file.  

During GUI-mode Setup when the system is searching .inf files for Plug and Play IDs, it also looks in the paths that are noted in the OemPnPDriversPath and the standard default path of %WinDir%\Inf. The %WinDir%\Inf path is listed first in the search order, but if you have a device that is supported by more than one .inf file, Setup continues to search all paths that are specified in the OemPnPDriversPath entry. ((Windows may include a driver that offers generic functionality.) Although it may find multiple matches, Plug and Play uses the .inf file that has the best match, and then installs the associated device driver to support the device.

#### Sysprep setup

The steps to add OEM-supplied drivers to a Windows Sysprep Setup resemble the steps in the "Unattended Setup" section, except that you do not have to create the distribution share. To add drivers to the mini-wizard of Sysprep, follow these steps.

> [!NOTE]
> To add OEM third-party mass-storage drivers to the Sysprep image that you use to start the computer, you require at least version 1.1 of Sysprep. There have been many updates to the Sysprep tool and to the deployment tools that include Sysprep. Therefore, we recommend that you use the latest version of the Sysprep tool and the deployment tools that are specific to the operating system that you deploy.

1. On the root of the volume where the %WinDir% folder is located, create a folder structure to hold the OEM-supplied drivers as follows:

      > \Drivers  
        - - \network adapter  
        - - \VIDEO  
        \Sysprep  
        \WINNT  

2. Copy the OEM-supplied drivers to their appropriate subfolders.
3. Add the OemPnPDriversPath = Driver_Paths entry in the [Unattended] section of the Sysprep.inf file. You can list multiple paths in this key by separating them with a semicolon (;) as shown in the following example.

    > [Unattended]  
    OemPnPDriversPath = "Drivers\network adapter;Drivers\Video"

    > [!NOTE]
    > The %SystemDrive% environment variable string is automatically inserted before each of the listed search paths.  

If you do not want the OEM-supplied drivers to remain on the volume after the mini-wizard is completed, you can add the folder structure that you created in the previous step under the Sysprep folder. You have to adjust the OemPnPDriversPath = key appropriately. The Sysprep folder and its subfolders are automatically removed after Setup is complete.

Save the Sysprep.inf file in the Sysprep folder, and then run Sysprep.exe. Any Plug and Play devices are automatically installed during the mini-setup wizard on the target computers. (These files include those found by using the OEM driver .inf files.)

> [!NOTE]
> You do not have to specify the -pnp command-line switch unless there are earlier (ISA) devices on the target computers. If you use the -pnp command-line switch, a full Plug and Play re-enumeration of all devices is performed that adds 5-10 minutes to the Sysprep mini-wizard process. Also, if you specify additional mass-storage controllers by using Sysprep version 1.1 or later versions, the -pnp command-line switch may cause some additional hard disk controllers to appear in Device Manager.
>
> If the OEM-supplied drivers are not digitally signed, the mini-wizard postpones the installation of the device until an administrator logs on to the computer. This is referred to as client-side versus server-side installation that occurs during mini-wizard Setup.

#### RIS installations

Adding OEM Plug and Play drivers to RIS installations involves the same steps that are listed in the "Unattended Setup" section, with two small adjustments:

1. Put the $oem$ folder at the same level as the \I386 folder of the RIS image. For example, use the following folder structure:

    > RemoteInstall\Setup\%language\Images\%dir_name%\i386  
    RemoteInstall\Setup\%language\Images\%dir_name%\$oem$\$1\Drivers  
     \network adapter  
     \MODEM  
     \VIDEO

2. Modify the RIS image default template (Ristndrd.sif). In the [Unattended] section, change the OemPreinstall = key value from No to Yes, and then add the OemPnPDriversPath = Driver_Path entries. You can list multiple paths in this key by separating them with a semicolon (;) as shown in the following example.

    > [Unattended]  
    OemPreinstall = Yes  
    OemPnPDriversPath = "Drivers\network adapter;Drivers\Modem;Drivers\Video"

    > [!NOTE]
    > The %SystemDrive% environment variable string is automatically inserted before each of the listed search paths.  
    > If one of the OEM-supplied drivers is for a network adapter device, the RIS server must have this file available when it restarts in text-mode Setup.  

3. If you copy the additional network adapter or mass-storage drivers to the \i386 folder as described in Knowledge Base article 246184, stop and restart the BINL service on the RIS server. To stop and restart the BINL service, type the following commands at the command prompt, and then press ENTER after each command:
   - net stop "boot information negotiation layer"
   - net start "boot information negotiation layer"

#### Riprep images

Riprep and Sysprep share much of the same functionality. Therefore, adding OEM Plug and Play drivers to computers that will be imaged involves steps that resemble those that are used for Sysprep. Before you run Riprep against the image computer to copy it to the RIS server, follow these steps:

1. Create a folder named Sysprep on the %SystemDrive% folder. (This is most likely drive C because Riprep.exe can only copy one volume/partition.)
2. On the root of the same volume, create a folder structure to hold the OEM-supplied drivers as follows:  

      > \Drivers  
        - - \network adapter  
        - - \VIDEO  
        \Sysprep  
        \WINNT  

3. Copy the OEM-supplied drivers to their appropriate subfolders.
4. Create a Sysprep.inf file in the Sysprep folder, and then add the [Unattended] and OemPnPDriversPath = Driver_Path entries. You can list multiple paths in this key by separating them with a semicolon (;). For example:

    > [Unattended]  
    OemPnPDriversPath = "Drivers\network adapter;Drivers\Video"

    > [!NOTE]
    > The %SystemDrive% environment variable is automatically inserted before each of the listed search paths that are specified.  
    > If the device has already been recognized by the operating system as a known or unknown device, you must remove the device by using Device Manager before you run Sysprep or the updated drivers are not installed on startup during mini-Setup.
5. Run the Riprep.exe program from the \\**RisServer** \Reminst\Admin\I386 folder on the client computer to copy the image to the selected RIS server. Riprep looks in the Sysprep folder for a Sysprep.inf file, reads the OemPnPDriversPath= key, and then updates the following registry subkey:  
 `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Devicepath`
Then, Riprep copies the registry up to the server so that it can be used during the mini-Setup wizard.

    > [!NOTE]
    > The default Riprep.sif file that is created during this process is not affected by the entry in the Sysprep.inf file that was created in the previous steps.

    > [!NOTE]
    > If one of the OEM-supplied drivers is for the primary network adapter, the RIS server must also have this file available from a typical RIS flat image before the Riprep image is downloaded.  
    If the image is already created and you want to add OEM-supplied Plug and Play drivers, we recommend that you use RIS to download the image to a computer, follow the steps listed in the previous "Riprep Images" section, and then Riprep the image back to the RIS server.
    >
    > One side effect is that the driver paths are entered two times in the Software\Microsoft\Windows\CurrentVersion\DevicePath key.

#### Existing Windows installations

You may have to add new hardware devices to existing Windows-based computers that require OEM-supplied drivers. Although this process requires that you install the new device, you may want the OEM-supplied drivers to be distributed in a controlled manner or to be centrally located on one server. To do this, follow these steps:

1. Decide whether you want to copy the drivers locally or if you want to store them on a central distribution server. If you want to store the drivers locally on the computer's hard disk, you must have a procedure to copy the drivers to the computer. (For example, use logon scripts, Microsoft Systems Management Server (SMS) batch jobs, or other methods.)
2. After the distribution method is determined, obtain the path for the device drivers. If you want to copy them locally, the path may be C:\Drivers\network adapter. If you want them copied to a centrally located server, the path may be \\\\**ServerName**\\**Drivers** \network adapter (where **Drivers** is a shared folder).
3. The DevicePath key in the local computer's registry has to be updated to reflect the new OEM driver locations. You must have an automated method of remotely updating the registry key. You can use Regedit files together with logon scripts or with an SMS batch job. The default value is located in the following registry key:  
 `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\DevicePath:  REG_EXPAND_SZ:%SystemRoot%\Inf`

4. Edit the DevicePath key by using Regedt32.exe so that path where the drivers are located is included in the search path.

    > [!IMPORTANT]
    > This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

    For example, if the drivers are copied locally to the root of the drive where the %WinDir% folder resides (Drivers\network adapter), the DevicePath final value must read:  
    `DevicePath: REG_EXPAND_SZ:%SystemRoot%\Inf;%SystemRoot%\Drivers\network adapter`
    If the drivers are kept on a centrally located server or distribution point, you have to add the UNC path to the OEM-supplied drivers. For example:  

    DevicePath: REG_EXPAND_SZ:%SystemRoot%\Inf;\\\\**ServerName**\\**ShareName**\Drivers\network adapter
    > [!NOTE]
    > %SystemRoot% is not automatically appended because the Setup process does not add the values. You must manually type the value of %SystemRoot% if you edit the registry.  

After you have completed these steps and new hardware is installed, when a user logs on, Plug and Play locates the new hardware and searches the device paths you specified to locate the OEM-supplied drivers. Notice that all the rules that apply to signed/unsigned drivers also apply to devices that are installed after Setup. If the OEM-supplied drivers for the new device are not digitally signed and a non-administrator user logs on to the computer after the new hardware is installed, the user cannot complete the installation of the device until an administrator logs on to the computer.

> [!NOTE]
> If the device has already been recognized by the operating system as a known or unknown device, you must remove the device through Device Manager before you run Sysprep or the updated drivers are installed on startup during mini-setup.

### For Windows Server 2003

#### Unattended setup

When you add drivers to unattended Setup, follow these steps. If the OEM-supplied drivers are not digitally signed, you may receive a message about the drivers during Setup.  

1. Create your distribution share on a server by copying the contents of the Windows installation CD-ROM I386 folder. You can use Setupmgr.exe to create this share and your Unattended.txt file. You can find Setupmgr.exe on the Windows or service pack CD-ROM in the Support\Tools folder in the Deploy.cab file and the deploy.chm and ref.chm Help files that contain information about Windows unattended Setup. You can also download the latest files from the Microsoft Web site.
2. Create a $oem$\$1\Drivers folder in the I386 folder. You may want to create additional folders in the Drivers subfolder, depending on the hardware that you want to install (for example, network adapter, modem, or video). The $1 folder resolves to %SystemDrive%. During text-mode Setup, these folders and files are copied to the %SystemDrive%\Drivers folders. For example:

      > \i386  
        \$oem$  
        - - \$1  
        - - - \Drivers  
        - - - - - \network adapter  
        - - - - - \MODEM  
        - - - - - \VIDEO  

3. Copy all the OEM-supplied driver files for the device in the folders that you created in the previous step.
4. Add the OemPnPDriversPath = Driver_Paths entry in the [Unattended] section of the Setup answer file. You can list multiple paths in this key by separating them with a semicolon (;). For example:

    > [Unattended]  
    OemPnPDriversPath = Drivers\network adapter;Drivers\Modem;Drivers\Video
    UpdateInstalledDrivers = Yes | No

    > [!NOTE]
    > The %SystemDrive% environment variable string is automatically inserted before each of the listed search paths.
5. Save the answer file.  

During GUI-mode Setup when the system is searching .inf files for Plug and Play IDs, it also looks in the paths that are noted in the OemPnPDriversPath and the standard default path of %WinDir%\Inf. The %WinDir%\Inf path is listed first in the search order, but if you have a device that is supported by more than one .inf file (Windows may include a driver that offers generic functionality), Setup continues to search all paths that are specified in the OemPnPDriversPath entry. Although it may find multiple matches, Plug and Play uses the .inf file that has the best match, and then installs the associated device driver to support the device.

#### Sysprep setup

The steps to add OEM-supplied drivers to a Windows Sysprep Setup resemble the steps in the "Unattended Setup" section, except that you do not have to create the distribution share. To add drivers to the mini-wizard of Sysprep, follow these steps.

> [!NOTE]
> We recommend that you use the latest version of Sysprep that is available for your operating system.

1. On the root of the volume where the %WinDir% folder is located, create a folder structure to hold the OEM-supplied drivers. For example:  

      > \Drivers  
        - - \network adapter  
        - - \VIDEO  
        \Sysprep  
        \WINNT  

2. Copy the OEM-supplied drivers to their appropriate subfolders.
3. Add the OemPnPDriversPath = Driver_Paths entry in the [Unattended] section of the Sysprep.inf file. You can list multiple paths in this key by separating them with a semicolon (;). For example:

    > [Unattended]  
    OemPnPDriversPath = Drivers\network adapter;Drivers\Video
    UpdateInstalledDrivers = Yes | No

    > [!NOTE]
    > The %SystemDrive% environment variable string is automatically inserted before each of the listed search paths.  

If you do not want the OEM-supplied drivers to remain on the volume after the mini-wizard is complete, you can add the folder structure that you created in the previous step under the Sysprep folder. You have to adjust the OemPnPDriversPath = key appropriately. The Sysprep folder (and its subfolders) is automatically removed after Setup is finished.

Save the Sysprep.inf file in the Sysprep folder and run Sysprep.exe. Any Plug and Play devices (including those found by using the OEM driver .inf files) are automatically installed during the mini-setup wizard on the target computers. Notice that you do not have to specify the -pnp command-line switch unless there are earlier (ISA) devices on the target computers. If you use the -pnp command-line switch, a full Plug and Play re-enumeration of all devices is performed, that adds 5-10 minutes to the Sysprep mini-wizard process. Also, if you specify an additional mass-storage controller, the -pnp command-line switch may cause some additional hard disk controllers to appear in Device Manager.

> [!NOTE]
> If the OEM-supplied drivers are not digitally signed, the mini-wizard postpones the installation of the device until an administrator logs on to the computer. This is referred to as client-side versus server-side installation that occurs during mini-wizard Setup.

#### RIS installations

Adding OEM Plug and Play drivers to RIS installations involves the same steps that are listed in the "Unattended Setup" section, with two small adjustments:

1. Put the $oem$ folder at the same level as the \I386 folder of the RIS image. For example, use the following structure:

    > RemoteInstall\Setup\%language\Images\%dir_name%\i386  
    RemoteInstall\Setup\%language\Images\%dir_name%\$oem$\$1\Drivers  
     \network adapter  
     \MODEM  
     \VIDEO

2. Modify the RIS image default template (Ristndrd.sif). In the [Unattended] section, change the OemPreinstall = key value from No to Yes, and then add the OemPnPDriversPath = Driver_Path entries. You can list multiple paths in this key by separating them with a semicolon (;) as follows:

    > [Unattended]  
    OemPreinstall = Yes  
    OemPnPDriversPath = "Drivers\network adapter;Drivers\Modem;Drivers\Video"  
    UpdateInstalledDrivers = Yes | No

    > [!NOTE]
    > The %SystemDrive% environment variable string is automatically inserted before each of the listed search paths.

    > [!NOTE]
    > If one of the OEM-supplied drivers is for a network adapter device, the RIS server must have this file available when it restarts in text-mode Setup.  

3. If you copy the additional network adapter or mass-storage drivers to the \i386 folder as described in Knowledge Base article 246184, stop and restart the BINL service on the RIS server. To stop and restart the BINL service, type the following commands at the command prompt, and then press ENTER after each command:
   - net stop "boot information negotiation layer"
   - net start "boot information negotiation layer"

#### Riprep images

Riprep and Sysprep share much of the same functionality. Therefore, adding OEM Plug and Play drivers to computers that will be imaged involves steps that resemble those that are used for Sysprep. Before you run Riprep against the image computer to copy it to the RIS server, follow these steps:

1. Create a folder named Sysprep on the %SystemDrive% folder. (This is most likely drive C because Riprep.exe can only copy one volume or partition.)
2. On the root of the same volume, create a folder structure to hold the OEM-supplied drivers as follows:

      > \Drivers  
        - - \network adapter  
        - - \VIDEO  
        \Sysprep  
        \WINNT  

3. Copy the OEM-supplied drivers to their appropriate subfolders.
4. Create a Sysprep.inf file in the Sysprep folder, and then add the [Unattended] and OemPnPDriversPath = Driver_Path entries. You can list multiple paths in this key by separating them with a semicolon (;) as follows:

    > [Unattended]  
    OemPnPDriversPath = Drivers\network adapter;Drivers\Video
    UpdateInstalledDrivers = Yes | No

    > [!NOTE]
    > The %SystemDrive% environment variable is automatically inserted before each of the listed search paths that are specified.

    > [!NOTE]
    > If the device has already been recognized by the operating system as a known or unknown device, you must remove the device through Device Manager before you run Sysprep or the updated drivers are not installed on startup during mini-Setup.
5. Run the Riprep.exe program from the \\\\**RisServer**\Reminst\Admin\I386 folder on the client computer to copy the image to the selected RIS server. Riprep looks in the Sysprep folder for a Sysprep.inf file, reads the OemPnPDriversPath= key, and then updates the following registry subkey:  
 `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Devicepath`  
Then, Riprep copies the registry up to the server so that it can be used during the mini-Setup wizard.

    > [!NOTE]
    > The default Riprep.sif file that is created during this process is not affected by the entry in the Sysprep.inf file that was created in the previous steps.

#### Existing Windows installations

You may have to add new hardware devices to existing Windows-based computers that require OEM-supplied drivers. Although this process requires that you install the new device, you may want the OEM-supplied drivers to be distributed in a controlled manner or to be centrally located on one server. To do this, follow these steps:

1. Decide whether you want to copy the drivers locally or if you want to store them on a central distribution server. If you want to store the drivers locally on the computer's hard disk, you must have a procedure to copy the drivers to the computer. For example, use logon scripts, Microsoft Systems Management Server (SMS) batch jobs, or other methods.
2. After the distribution method is determined, obtain the path for the device drivers. If you want to copy them locally, the path may be C:\Drivers\network adapter. If you want them copied to a centrally located server, the path may be \\\\**ServerName**\\**Drivers**\network adapter. (**Drivers** are a shared folder.)
3. The DevicePath key in the local computer's registry has to be updated to reflect the new OEM driver locations. You must have an automated method of remotely updating the registry key. You can use Regedit files together with logon scripts or with an SMS batch job. The default value is located in the following registry subkey:  
`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\DevicePath: REG_EXPAND_SZ:%SystemRoot%\Inf`

4. Edit the DevicePath key by using Registry Editor so that path where the drivers are located is included in the search path.

    > [!IMPORTANT]
    > This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

    For example, if the drivers are copied locally to the root of the drive where the %WinDir% folder resides (Drivers\network adapter), the DevicePath final value must read as follows:  
    `DevicePath: REG_EXPAND_SZ:%SystemRoot%\Inf;%SystemRoot%\Drivers\network adapter`
    If the drivers are kept on a centrally located server or distribution point, you have to add the UNC path to the OEM-supplied drivers. For example:

    `DevicePath: REG_EXPAND_SZ:%SystemRoot%\Inf;\\\\**ServerName**\\**ShareName**\Drivers\network adapter`
    > [!NOTE]
    > %SystemRoot% is not automatically appended because the Setup process does not add the values. You must manually type the value of %SystemRoot% if you edit the registry.  

Assume that you have completed these steps and new hardware is installed. When a user logs on, Plug and Play locates the new hardware and searches the device paths that you specified to locate the OEM-supplied drivers. Notice that all the rules that apply to signed and unsigned drivers also apply to devices that are installed after Setup. Assume that the OEM-supplied drivers for the new device are not digitally signed and a non-administrator user logs on to the computer after the new hardware is installed. In this case, the user cannot complete the installation of the device until an administrator logs on to the computer.

> [!NOTE]
> If the device has already been recognized by the operating system as a known or unknown device, you must remove the device by using Device Manager before you run Sysprep or the updated drivers are installed on startup during mini-Setup.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
