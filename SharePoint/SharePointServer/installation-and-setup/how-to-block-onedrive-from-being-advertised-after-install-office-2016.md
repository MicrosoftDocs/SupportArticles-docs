---
title: How to block OneDrive.exe from being advertised after you install Office 2016
description: Describes how to block OneDrive.exe from being advertised after you install Microsoft Office 2016.
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
  - OneDrive
ms.date: 12/17/2023
---

# How to block OneDrive.exe from being advertised after you install Office 2016  

## Summary  

The OneDrive sync client (OneDrive.exe) is included in the installation of Microsoft Office 2016. This article describes how to block OneDrive.exe from being advertised after you install Office 2016.  

**Note** OneDrive.exe is used to synchronize both OneDrive.com and OneDrive for Business files. If OneDrive.exe is blocked, it prevents users from synchronizing files with both services. To learn how to disable syncing OneDrive.com files but allow OneDrive for Business to continue to sync, see the following Microsoft website: [Use Group Policy to control OneDrive sync client settings](https://support.office.com/article/administrative-settings-for-the-onedrive-for-business-next-generation-sync-client-0ecb2cf5-8882-42b3-a6e9-be6bda30899c?ui=en-us&rs=en-us&ad=us&fromar=1)  

This article contains information that applies when you use the OneDrive for Business Next Generation Sync Client (OneDrive.exe).  

**Note** To determine which OneDrive sync client you're using, see the following Microsoft website: [Which OneDrive sync client am I using?](https://support.office.com/article/which-onedrive-sync-client-am-i-using-19246eae-8a51-490a-8d97-a645c151f2ba?ui=en-us&rs=en-us&ad=us)  

## More Information   

Use the following workarounds to block OneDrive.exe from being advertised on your computer.   

### Method 1: Delete shortcuts for starting OneDrive.exe

After OneDrive.exe is installed, you will see shortcuts to the product added to your system. If you want, you can delete these shortcuts from the following locations.  

> [!NOTE]
> You may see only a subset of the shortcuts.   

- %APPDATA%\Microsoft\Windows\Start Menu\Programs\Microsoft OneDrive.lnk  

- %APPDATA%\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk   

- %USERPROFILE%\Links\OneDrive.lnk  
   
   In Windows 10 and Windows 7, the views of Windows Explorer and the Start menu should resemble the following screen shots after you install Office 2016.  

   :::image type="content" source="media/how-to-block-onedrive-from-being-advertised-after-install-office-2016/windows-10-explorer-start-menu.png" alt-text="Screenshot shows the views of Windows Explorer and the Start menu, after installing Office 2016 in Windows 10." border="false":::

   :::image type="content" source="media/how-to-block-onedrive-from-being-advertised-after-install-office-2016/windows-7-explorer-start-menu.png" alt-text="Screenshot shows the views of Windows Explorer and the Start menu, after installing Office 2016 in Windows 7." border="false":::

### Method 2: Uninstall OneDrive.exe

> [!NOTE]
> OneDrive.exe is used to synchronize both OneDrive.com and OneDrive for Business files. If OneDrive.exe is blocked, it prevents users from synchronizing files with both services.  

You can run the OneDrive client setup package (OneDriveSetup.exe) with the /uninstall  command line switch as follows to uninstall OneDrive.exe:

```
OneDriveSetup.exe /uninstall
```

For example, see the following screen shot:  

:::image type="content" source="media/how-to-block-onedrive-from-being-advertised-after-install-office-2016/command-uninstall-onedrive.png" alt-text="Screenshot shows the command to uninstall OneDrive.":::

To download OneDriveSetup.exe, make sure that you use the link under the OneDrive client heading on the [home page of OneDrive](https://onedrive.live.com/about/download/), as shown in the following screen shot.  

:::image type="content" source="media/how-to-block-onedrive-from-being-advertised-after-install-office-2016/home-page.png" alt-text="Screenshot to download OneDrive on the home page of OneDrive.":::

If you aren't running Windows 10, [uninstall OneDrive.exe by using Control Panel](https://windows.microsoft.com/windows/uninstall-change-program#uninstall-change-program=windows-7).   

> [!IMPORTANT]
> If you install an older build of Office 2016 (OneDrive.exe bundled with an Office 2016 build that's older than 16.0.6001.1033), OneDrive.exe will have to be updated in order to respect the Group Policy setting. To update OneDrive, download the latest version of the OneDrive client setup package (OneDriveSetup.exe) through the OneDrive home page, and then run the following command at a command prompt: OneDriveSetup.exe /silent Note  In this command, the /silent  switch installs the latest build without having any UI displayed.   

### Administrator tasks

If you are an administrator of OneDrive for Business, you may want to deploy scripts to allow the following actions.   

#### Windows 7  
If you want to delete the shortcuts in Windows 7 so that OneDrive does not appear after you install Office 2016, run the following scripts.   

> [!NOTE]
> These scripts are provided without any formal support SLA, but we have verified that they work in the system.   

```  
@ECHO OFF  
DEL "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Microsoft OneDrive.lnk"  
DEL "%APPDATA%\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"  
DEL "%USERPROFILE%\Links\OneDrive.lnk"  
```  

#### Windows 10  

In addition to the steps for Windows 7, you must run the following scripts to delete the OneDrive icon from the navigation pane in Windows Explorer.  

```  
Stop-Process -processname OneDrive  
Set-Location "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace"  
Get-ChildItem | ForEach-Object {Get-ItemProperty $_.pspath} | ForEach-Object {  
    $leftnavNodeName = $_."(default)";  

if (($leftnavNodeName -eq "OneDrive") -Or ($leftnavNodeName -eq "OneDrive - Personal")) {  
        if (Test-Path $_.pspath) {  
            Remove-Item $_.pspath;  
        }  
    }  
}  
```  

If you want to block OneDrive.exe, first make sure that you're using version 16.0.6001.1033 of Office 2016 or a later version. After you install Office 2016, enable the **Prevent the usage of OneDrive for file storage** policy.   

If you have to reinstall OneDrive.exe in the future, make sure that you perform the following tasks:  

- If you use the Group Policy setting to block OneDrive.exe from being advertised, you must delete or disable that setting before you install Office 2016.   

- If you delete the shortcuts for starting OneDrive.exe after you install Office 2016, you must again deploy and run the latest OneDrive setup package (OneDriveSetup.exe) on your users' computer to restore the shortcuts.     

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
