---
title: Can't create standalone or prestaged media
description: Describes an issue in which you receive the Not enough memory resources error when you create Configuration Manager standalone or prestaged media.
ms.date: 12/05/2023
ms.custom: sap:Bootable, stand-alone, pre-staged, and WTG media
ms.reviewer: kaushika
---
# Not enough memory resources error when you create standalone or prestaged media in Configuration Manager

This article fixes an issue in which you receive the **Not enough memory resources** error when you create standalone or prestaged media in Configuration Manager.

_Original product version:_ &nbsp; Configuration Manager  
_Original KB number:_ &nbsp; 4511621

## Symptoms

In Configuration Manager, you use the Create Task Sequence Media Wizard to create standalone or prestaged media that contain a large system image. When you try to create the media, you receive the following error message:

> Media creation failed with error message: 'Not enough memory resources are available to process this command.'  
> Refer to CreateTsMedia.log file to find more details.

Additionally, the following error entries are logged in CreateTSMedia.log:

> Capturing volume <Temp_Dir>\\_tsmedia\_<#>\stage  
> WIM has entered capture phase for <#> items  
> Unable to load volume image 1 (0x80070008)  
> Error setting WIM image header info  
> Closing image file \\\\<Path_to_OS_WIM>\\\<OS>.wim
> Error writing volume by image writer  
> Deleting output files  
> Error executing first single pass  
> Failed to create media (0x80070008)  
> CreateTsMedia failed with error 0x80070008, details=''  
> CreateMedia.exe finished with error code 80070008

## Cause

CreateMedia.exe is a 32-bit executable that's used to create media in Configuration Manager. If the media contains a large system image, CreateMedia.exe may exceed the 2 GB memory limit and generate the error that is mentioned in the Symptoms section.

## Resolution

To fix this issue, follow these steps:

1. If Microsoft Visual Studio isn't already available in your environment, [download and install Visual Studio](/visualstudio/install/install-visual-studio). Select the **Desktop development with C++** workload when you install Visual Studio.

   > [!NOTE]
   > We recommend that you install Visual Studio on a client computer instead of on a site server.

2. Copy the CreateMedia.exe file to the computer that has Visual Studio installed. You can locate the CreateMedia.exe file on the site server under the <*ConfigMgr_Install_Directory*>\AdminConsole\bin\i386 folder.
3. On the computer that has Visual Studio installed, [open the Developer Command Prompt](/cpp/build/building-on-the-command-line#developer_command_prompt) as an elevated Command Prompt window.
4. In the Developer Command Prompt, go to the directory where the CreateMedia.exe file is located, and then run the following command to check whether CreateMedia.exe can handle addresses that are larger than 2 GB:

   ```console
   dumpbin.exe /headers CreateMedia.exe
   ```

   For more information about the `/HEADERS` DUMPBIN option, see [/HEADERS](/cpp/build/reference/headers).

   If you see the following result under **FILE HEADER VALUES**, go to step 6:

   > Application can handle large (>2GB) addresses

   Otherwise, go to step 5.

5. In the Developer Command Prompt, run the following command to enable Createmedia.exe to handle addresses that are larger than 2 GB:

   ```console
   editbin.exe /largeaddressaware createmedia.exe
   ```

   For more information about the `/LARGEADDRESSAWARE` EDITBIN option, see [/LARGEADDRESSAWARE](/cpp/build/reference/largeaddressaware).

6. On the site server, create a backup of the <*ConfigMgr_Install_Directory*>\AdminConsole\bin\i386\CreateMedia.exe file.
7. Copy the modified version of CreateMedia.exe from the computer that has Visual Studio installed to the <*ConfigMgr_Install_Directory*>\AdminConsole\bin\i386 folder on the site server.
8. If there's a central administration site and multiple primary sites in your environment, repeat steps 6 and 7 on all site servers so that you can create media from any site server.
9. Create the standalone or prestaged media by using the Create Task Sequence Media Wizard.

> [!NOTE]
> If you install an update or hotfix on the site server after you make these changes, CreateMedia.exe may be replaced. If this occurs, the replacement will have the default behavior and will not be able to handle large addresses. In this case, follow these steps again for the new instance of CreateMedia.exe.
