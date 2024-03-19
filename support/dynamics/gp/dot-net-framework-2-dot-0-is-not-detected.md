---
title: .NET Framework 2.0 is not detected 
description: Provides a solution to an error that occurs when you try to install Dexterity or the Visual Studio Tools for Microsoft Dynamics GP 10.0 SDK.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# ".NET Framework 2.0 is not detected. Fatal error during installation" Error message when you try to install Dexterity or the Visual Studio Tools for Microsoft Dynamics GP 10.0 SDK

This article provides a solution to an error that occurs when you try to install Dexterity or the Visual Studio Tools for Microsoft Dynamics GP 10.0 SDK.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 952376

## Symptoms

When you try to install Dexterity for Microsoft Dynamics GP 10.0 or the Microsoft Visual Studio Tools for Microsoft Dynamics GP 10.0 Software Development Kit (SDK), you receive the following error message:

> .NET Framework 2.0 is not detected. Fatal error during installation.
Additionally, the installation process stops.

## Cause

This problem occurs if the Microsoft .NET Framework 2.0 Service Pack 1 (SP1) is installed on the computer.

## Resolution

To resolve this problem, obtain the latest service pack for Microsoft Dynamics GP 10.0.

## Workaround

To work around this problem, use one of the following methods.

### Method 1: If you meet this problem when you try to install Dexterity

To work around this problem, follow these steps:

1. Download the [SkipDotNetCheckDexterity.mst](https://community.dynamics.com/forums/thread/details/?threadid=cf46f462-dcba-4df5-9913-dae7092d2712) file. The following file is available for download from the Microsoft Dynamics File Exchange Server:

    Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.  

2. Copy the SkipDotNetCheckDexterity.mst file to the root directory of drive C.
3. Select **Start**, select **Run**, type **cmd**, and then select **OK**.
4. At the command prompt, type **cd\\**, and then press ENTER.
5. At the command prompt, type the following command, and then press **ENTER**:

    `msiexec /i "<path of VSToolsSDK-GP10-enu-msi>" TRANSFORMS="C:\SkipDotNetCheckVSTools.mst" INSTALLDIR="<installdirpath>" /qb+`

    > [!NOTE]
    >
    > - In this command, **\<path of Dexterity.msi>** is a placeholder for the path of the folder that contains the contents of Microsoft Dynamics GP CD 2 or that contains the Dexterity archive file that was downloaded. For example, if you copied the contents of Microsoft Dynamics GP CD 2 to the `C:\CD2` folder, use the following path in the command:  
       `C:\CD2\Tools\Dex\Bin\Dexterity.msi`
    > - In this command, **\<installdirpath>** is a placeholder for the location where you want to install Dexterity. For example, use the following path in the command:  
        `C:\Program Files\Microsoft Dexterity\Dex 10.0`

6. At the command prompt, type **exit**, and then press **ENTER**.

After you follow these steps, Dexterity is installed in the location that you specify in step 5. The default installation includes all the features of Dexterity.

### Method 2: If you meet this problem when you try to install the Visual Studio Tools for Microsoft Dynamics GP 10.0 SDK

To work around this problem, follow these steps:

1. Download the SkipDotNetCheckVSTools.mst file.
2. Copy the SkipDotNetCheckVSTools.mst file to the root directory of drive C.
3. Select **Start**, select **Run**, type **cmd**, and then select **OK**.
4. At the command prompt, type **cd\\**, and then press **ENTER**.
5. At the command prompt, type the following command, and then press **ENTER**:

    `msiexec /i "**<path of VSToolsSDK-GP10-enu-msi>**" TRANSFORMS="C:\SkipDotNetCheckVSTools.mst" INSTALLDIR="**<installdirpath>**" /qb+`

    > [!NOTE]
    >
    > - In this command, **\<path of VSToolsSDK-GP10-enu-msi>** is a placeholder for the path of the folder that contains the VSToolsSDK-GP10-enu.msi file.
    > - In this command, **\<installdirpath>** is a placeholder for the location where you want to install the Visual Studio Tools for Microsoft Dynamics GP 10.0 SDK. For example, use the following path in the command:  
        `C:\Program Files\Microsoft Dynamics\GP10 VS Tools SDK`

6. At the command prompt, type **exit**, and then press **ENTER**.

After you follow these steps, the Visual Studio Tools for Microsoft Dynamics GP 10.0 SDK is installed in the location that you specify in step 5. The default installation includes all the features of the Visual Studio Tools for Microsoft Dynamics GP 10.0 SDK.

You may want to install Visual Studio Tools SDK Service Pack 1 (SP1) while you install the Visual Studio Tools for Microsoft Dynamics GP 10.0 SDK. To do it by using a slipstream, type the following command in step 5:  
`msiexec /i "**<path of VSToolsSDK-GP10-enu-msi>**" TRANSFORMS="C:\SkipDotNetCheckVSTools.mst" PATCH="**<path of the .msp file>**" INSTALLDIR="**<installdirpath>**" /qb+`

> [!NOTE]
> In this command, **\<path of the .msp file>** is a placeholder for the path of the VSToolsSDK-KB945414-v10-ENU.msp file.

## Status

Microsoft has confirmed that it's a problem in the Microsoft products that are listed in the "Applies to" section. This problem was first corrected in Microsoft Dynamics GP 10.0 Service Pack 2.

## More information

When you use the methods in the [Workaround](#workaround) section, make sure that you type the commands correctly. If you add a space or if you omit a space, you may receive the following error message:
> This installation does not have a native user interface.
