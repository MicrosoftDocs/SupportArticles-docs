---
title: SharePoint 2013 or Project Server 2013 Setup error if the .NET Framework 4.6 is installed
description: Describes an issue that triggers an error during SharePoint 2013 or Project Server 2013 Setup if the .NET Framework 4.6 is installed. Provides a workaround.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2013
  - SharePoint Foundation 2013
  - Project Server 2013
ms.date: 12/17/2023
---

# Setup error if the .NET Framework 4.6 is installed  

## Symptoms  

When you run Microsoft SharePoint Foundation 2013 with Service Pack 1 Setup, SharePoint Server 2013 with Service Pack 1 Setup, or Project Server 2013 with Service Pack 1 Setup on a computer that has the Microsoft .NET Framework 4.6, 4.6.1, or 4.6.2 installed, you receive the following error message:

**Setup is unable to proceed due to the following error(s): This product requires Microsoft .Net Framework 4.5.**

## Cause  

This problem occurs because the SharePoint Setup and Project Server Setup programs do not recognize the .NET Framework 4.6, 4.6.1, or 4.6.2 as a supported version of the .NET Framework.  

## Resolution  

To resolve this problem, follow these steps:  

1. Extract the installation media to a writable location.  

   - If your installation media is an executable file (.exe), extract the files and folders from the executable file to a writable location by running the following command at a command prompt:  

      ```
      <executable file name> /extract:<path to writable location>
      ```
      For example, run the following command:  

      ```
      sharepoint.exe /extract:C:\SharePointInstaller
      ```

   - If your installation media is an ISO or IMG disc image (.iso or .img), mount the disc image, and then copy the files and folders from the disc image to a writable location.     

2. Download the compressed (.zip) file that contains the fix that matches the product you're installing:  

   - [SharePoint Foundation 2013 with Service Pack 1 fix](https://download.microsoft.com/download/3/6/2/362c4a9c-4afe-425e-825f-369d34d64f4e/wsssetup_15-0-4709-1000_x64.zip)   
   - [SharePoint Server 2013 with Service Pack 1 fix](https://download.microsoft.com/download/3/6/2/362c4a9c-4afe-425e-825f-369d34d64f4e/svrsetup_15-0-4709-1000_x64.zip)   
   - [Project Server 2013 with Service Pack 1 fix](https://download.microsoft.com/download/3/6/2/362c4a9c-4afe-425e-825f-369d34d64f4e/svrsetup_15-0-4709-1000_x64.zip)     

3. Open the .zip file.   
4. Copy the following Setup support file, as appropriate, from the .zip file into the "updates" folder in your writable location.   

   - SharePoint Foundation 2013 with Service Pack 1: wsssetup.dll   
   - SharePoint Server 2013 with Service Pack 1: svrsetup.dll   
   - Project Server 2013 with Service Pack 1: svrsetup.dll     

5. Run Setup.exe from the writable location to start SharePoint Setup or Project Server Setup. Setup will use the support file that contains the fix that you've copied into the "updates" folder.     

## Workaround  

If you can't use the fix method that's provided in the "Resolution" section, an alternative workaround method is available.  

To work around this problem, make sure that the .NET Framework 4.6, 4.6.1, or 4.6.2 is not installed when you run SharePoint Setup.  

If the Microsoft .NET Framework 4.6, 4.6.1, or 4.6.2 is already installed, follow these steps:  

1. Uninstall the .NET Framework 4.6, 4.6.1, or 4.6.2. To do this, go to the location that is specific to your operating system as listed in the following articles in the Microsoft Knowledge Base:
   - [3151800](https://support.microsoft.com/help/3151800) The .NET Framework 4.6.2 offline installer for Windows
   - [3102436](https://support.microsoft.com/help/3102436) The .NET Framework 4.6.1 offline installer for Windows  
   - [3045557](https://support.microsoft.com/help/3045557) Microsoft .NET Framework 4.6 (Offline Installer) for Windows

   **Note** In Windows Server 2012 or Windows Server 2012 R2, the .NET Framework is an operating system component and cannot be independently uninstalled. Updates to the .NET Framework appear in the Installed Updates  tab of the Control Panel Programs and Features  app. For operating systems on which the .NET Framework is not preinstalled, the .NET Framework appears in the Uninstall or change a program  tab (or the Add/Remove programs  tab) of the Program and Features  app in Control Panel. See [Troubleshooting Blocked .NET Framework Installations and Uninstallations](/dotnet/framework/install/troubleshoot-blocked-installations-and-uninstallations) and the Microsoft Knowledge Base articles listed earlier for more information.  
   
2. Restart the computer.   
3. Install the [web installer](https://www.microsoft.com/download/details.aspx?id=42643) for the .NET Framework 4.5.2.   
4. Run SharePoint Setup to install SharePoint.     
After SharePoint is installed successfully, you can upgrade from the .NET Framework 4.5.2 to the .NET Framework 4.6, 4.6.1, or 4.6.2.  

## More Information  

Although you receive the error message during installation, SharePoint Foundation 2013 and SharePoint Server 2013 are still supported after you upgrade to the .NET Framework 4.6, the .NET Framework 4.6.1, or the .NET Framework 4.6.2.  

**Note** Formal support for the .NET Framework 4.5.1, 4.5, and 4.0 ended in January 2016.  

## Status  

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).