---
title: Microsoft Store Apps fail to start
description: Event ID 5961 and event ID 1000 are logged when trying to start a Microsoft Store App. Provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, warrenw
ms.custom: sap:modern-inbox-and-microsoft-store-apps, csstroubleshoot
---
# Microsoft Store Apps fail to start if default registry or file permissions modified

This article helps fix an issue where you can't start a Microsoft Store App if the default registry or file permissions is modified.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2798317

> [!NOTE]
> This article is intended for IT professionals. For home users who encounter Microsoft Store App issues, go to [Fix problems with apps from Microsoft Store](https://support.microsoft.com/help/4027498).

## Issue 1

When you select a Microsoft Store App, the App begins to start, and then Windows just returns to the start screen. No on-screen error is displayed.

Microsoft-Windows-Immersive-Shell event 5961 is logged under the *Applications and Services Logs\Microsoft\Windows\Apps\Microsoft-Windows-TWinUI/Operational event log* path:

```output
Log Name:      Microsoft-Windows-TWinUI/Operational  
Source:        Microsoft-Windows-Immersive-Shell  
Date:          DateTime  
Event ID:      5961  
Task Category: (5961)  
Level:         Error  
Keywords:  
User:          UserName  
Computer:      ComputerName  
Description:  
Activation of the app <app name> for the Windows.Launch contract failed with error: The app didn't start.
```

> [!NOTE]
> The app portion of the example event, \<app name>, will change depending on the application that fails to start.

Possible values for \<app name> include but aren't limited to:

> microsoft.windowscommunicationsapps_8wekyb3d8bbwe!Microsoft.WindowsLive.Chat

Prefixes for other built-in Microsoft Store Apps include:

> Microsoft.BingFinance_8wekyb3d8bbwe!\<app identifier>  
Microsoft.BingMaps_8wekyb3d8bbwe!\<app identifier>  
Microsoft.BingNews_8wekyb3d8bbwe!\<app identifier>  
Microsoft.BingSports_8wekyb3d8bbwe!\<app identifier>  
Microsoft.BingTravel_8wekyb3d8bbwe!\<app identifier>  
Microsoft.BingWeather_8wekyb3d8bbwe!\<app identifier>  
Microsoft.Bing_8wekyb3d8bbwe!\<app identifier>  
Microsoft.Camera_8wekyb3d8bbwe!\<app identifier>  
Microsoft.Media.PlayReadyClient_8wekyb3d8bbwe!\<app identifier>  
microsoft.microsoftskydrive_8wekyb3d8bbwe!\<app identifier>  
Microsoft.Reader_8wekyb3d8bbwe!\<app identifier>  
Microsoft.VCLibs.110.00_8wekyb3d8bbwe!\<app identifier>  
microsoft.windows.authhost.a_8wekyb3d8bbwe!\<app identifier>  
microsoft.windowscommunicationsapps_8wekyb3d8bbwe!\<app identifier>  
microsoft.windowsphotos_8wekyb3d8bbwe!\<app identifier>  
Microsoft.WinJS.1.0.RC_8wekyb3d8bbwe!\<app identifier>  
Microsoft.WinJS.1.0_8wekyb3d8bbwe!\<app identifier>  
Microsoft.XboxLIVEGames_8wekyb3d8bbwe!\<app identifier>  
Microsoft.ZuneMusic_8wekyb3d8bbwe!\<app identifier>  
Microsoft.ZuneVideo_8wekyb3d8bbwe!\<app identifier>

## Issue 2

You can't start a Microsoft Store App, open Start screen, and use Search in Windows. Additionally, you receive the following event log in Application logs:

```output
Log Name: Application  
Source: Application Error  
Event ID: 1000  
Task Category: (100)  
Level: Error  
Keywords: Classic  
User: N/A  
Description:  
Faulting application name: xxxx.exe, version: 10.1605.1606.6002, time stamp: 0x5755acef  
Faulting module name: xxxxxx.dll, version: 10.0.14393.1198, time stamp: 0x5902836c  
Exception code: 0xc000027b  
Fault offset: 0x00000000006d5eab  
Faulting process id: 0x29c4  
0xc000027b: An application-internal exception has occurred. This error occurs when an access denied error happens during app initialization that is fatal and cause an exception that leads to the crash.
```

If you use Process Monitor to track the Apps' executable or related files, you may see **access denied** is logged. It points to the missing permissions for the current logon user. It includes:

1. Registry hives and its subkeys:

      1. HKEY_CLASSES_ROOT
      2. HKEY_LOCAL_MACHINE\Drivers
      3. HKEY_LOCAL_MACHINE\HARDWARE
      4. HKEY_LOCAL_MACHINE\SAM
      5. HKEY_LOCAL_MACHINE\SOFTWARE
      6. HKEY_LOCAL_MACHINE\SYSTEM
      7. HKEY_USERS

2. For file subsystem:

   1. **Program Files** - Read, Read and Execute, and List folder Contents
   2. **Windows** - Read, Read and Execute, and List folder Contents
   3. **Users\\\<userName>\AppData\Local\Microsoft\Windows\WER** - Special Permissions (List folder/read data, and Create Folders/Append Data)

## Cause for issue 1

Registry and or file system permissions may have been changed from their defaults.  

The All Application Packages group is a well-known group with a predefined SID. The group must have specific access to certain locations of the registry and file system for Microsoft Store Apps to function properly.

## Cause for issue 2

This issue occurs because the read permission is missing from any or all the keys. In this case, **0xc000027b** is logged. This error without exception is missing permission for ALL APPLICATION PACKAGES at registry location or file subsystem locations.

## Registry and file system permission must be reverted to a state that will allow Microsoft Store App to function

> [!NOTE]
> Only change the permission of the registry keys that are known to cause the access denied error. Incorrectly changing registry keys' permission might cause serious problems or unintentionally weaken security settings.
>
> Extensive permission changes that are propagated throughout the registry and file system cannot be undone. Microsoft will provide commercially reasonable efforts in line with your support contract. However, you cannot currently roll back these changes. We can guarantee only that you can return to the recommended out-of-the-box settings by reformatting the hard disk drive and by reinstalling the operating system.

If you use Group Policy to manage permissions, or if you're unsure whether Group Policy is used to manage permissions, follow these steps:

- Unjoin the computer from the domain or put the computer in a test OU with block policy inheritance enabled. This action prevents the domain-based Group Policy from reapplying the permission changes and breaking the modern applications again after you've fixed them.
- Add permissions where they're required per the following details.
- Edit the Group Policy that manages to permissions so that it no longer breaks modern application.

Registry and File System permission must be reverted back to a state that will allow Microsoft Store App to function. Follow this method to resolve the issue:

1. Determine if file system permissions have been changed. If not, see the [More information](#more-information) section below.
2. If so, how were they changed? Manually or with Group Policy?
3. Determine if registry permissions have been changed If not, see the [More information](#more-information) section below.
4. If so, how were they changed? Manually or with Group Policy?
5. Verify secpol and GPPs specifically.

### Determine if file system permissions have been changed

Check the folders listed below. Determine if the All Application Packages group has the access indicated. Most but not all sub directories of Windows, Program Files, and WER also grant permissions to the All Application Packages group.

- Program Files - Read, Read and Execute, and List folder Contents
- Windows - Read, Read and Execute, and List folder Contents
- Users\<userName>\AppData\Local\Microsoft\Windows\WER - Special Permissions (List folder/read data, and Create Folders/Append Data)

### Determine if registry permissions have changed

Check the registry keys listed below. Make sure the All Applications Packages group has the Read permissions to the following registry paths:

- HKEY_CLASSES_ROOT
- HKEY_LOCAL_MACHINE\Drivers
- HKEY_LOCAL_MACHINE\HARDWARE
- HKEY_LOCAL_MACHINE\SAM
- HKEY_LOCAL_MACHINE\SOFTWARE
- HKEY_LOCAL_MACHINE\SYSTEM
- HKEY_USERS

Most but not all of the subkeys of the registry keys listed above will grant the All Application Packages group read access.

### Determine if Group Policy is being used to manage permissions

1. Sign in to a PC as a user experiencing the problem.
2. Open an administrative command prompt then run the following command:

    ```console
    gpresult /h <path>\gpreport.html
    ```

3. Open the file gpreport.html and expand the following path:

    **Computer Settings** > Policies\Windows Settings\Security Settings. Look for **File System** and Registry. If these exist, then GP is assigning permission. You must edit the GP to include the necessary permissions for the All Application Packages group.

## Steps to fix the problem

Depending on how the file system permissions were changed will determine how to recover from the problem. The most common ways permissions are changed manually and by Group Policy.

> [!IMPORTANT]
> Make sure that you test your resolution in a lab before widely deploying. Always backup any important data before changing registry and file system permissions.

### Fix file system permissions that's changed manually

1. Open File Explorer.
2. Browse to c:\Program Files.
3. Right click and select **properties**.
4. Select the **Security** tab.
5. Select the **Advanced** button.
6. Select the **Change permissions** button.
7. Select the **Add** button.
8. Select the **Select a principal** link.
9. Select the locations button and select the local computer.
10. Add the All Applications Packages group name and select **ok**.
11. Make sure that Type = allow and Applies to = This folder, subfolder, and files.
12. Check Read & Execute, List folder contents, and Read.
13. Check the **Replace all child object permissions with inheritable permission entries from this object** checkbox.
14. Select **Apply** and **OK**.
15. Repeat for c:\Windows.
16. Repeat for c:\Users but grant the All Application Packages group Full Control.
17. Select **Apply** and **OK**.

### Fix file system permissions that's changed by Group Policy

Have a Group Policy administrator do the following steps:

- Open Group Policy Administrative Console.
- Locate the GPO identified in the step [Determine if Group Policy is being used to manage permissions](#determine-if-group-policy-is-being-used-to-manage-permissions).
- Right-click and select **edit**.
- Go to the location Computer `Configuration\Policy\Windows Settings\Security Settings\File System`.
- If there's an entry for the paths already created, you can edit it. If no entry exists, create a new entry for each path.
- To create a new entry, right-click file system and select **add file**.
- Browse to the path c:\Program Files, select **OK**.
- Select the **Add** button.
- Select the locations button and select the local machine name.
- Add the All Application Packages group and grant them the Read, Read and Execute, and List folder Contents permissions.
- Select **Apply** and **OK**.
- Select the **Replace existing permissions on all subfolders and files with inheritable permissions** option.
- Repeat for C:\Windows.
- Repeat for C:\Users, however, grant the All Application Packages group Full Control.

You'll need to wait for the Group policy change to replicate to all Domain Controllers and for all clients to update their Group Policy settings.

> [!NOTE]
> Processing the File System changes will incur some logon delay the first time this policy is processed. Subsequent logons will not be impacted unless changes are made to the policy. As an alternative you can use a script that is called post logon by the user is run as a scheduled task.

### Fix registry permissions that's changed manually

- Open regedit.exe.
- Right click on HKEY_Users and select **properties**.
- Make sure that All Application Packages has Read.
- Repeat for HKEY_CLASSES_ROOT.
- Expand HKEY_LOCAL_MACHINE. Check the subkeys HARDWARE, SAM, SOFTWARE, SYSTEM. Make sure that All Application Packages has the Read permission.

### Fix Registry Permissions that's changed by Group Policy

Have a Group Policy administrator do the following steps:

- Open Group Policy Administrative Console.
- Locate the GPO identified in the step [Determine if Group Policy is being used to manage permissions](#determine-if-group-policy-is-being-used-to-manage-permissions).
- Right-click and select **edit**.
- Go to the location Computer `Configuration\Policy\Windows Settings\Security Settings\Registry`.
- Right Click and select **Add Key**.
- Select CLASSES_ROOT.
- Select the **Add** button.
- Select the **locations** button and select the local machine name.
- Add the All Application Packages group and grant them Read.
- Repeat for **Users**.
- Repeat for MACHINE\HARDWARE, MACHINE\SAM, MACHINE\SOFTWARE, and MACHINE\SYSTEM.

## More information

For more information, see [Microsoft Store Apps Fail to Start if the User Profiles or the ProgramData directory are Moved from their Default Location](https://support.microsoft.com/help/2787623).

### File system and registry access control list modifications

Windows XP and later versions of Windows have tightened permissions throughout the system. So extensive changes to default permissions shouldn't be necessary.

Extra discretionary access control list (DACL) changes may invalidate all or most of the application compatibility testing done by Microsoft. Frequently, changes such as these haven't undergone the thorough testing that Microsoft has done on other settings. Support cases and field experience have shown that DACL edits change the fundamental behavior of the operating system, frequently in unintended ways. These changes affect application compatibility and stability and reduce functionality, about both performance and capability.

Because of these changes, we don't recommend you modify file system DACLs on files that are included with the operating system on production systems. We recommend you evaluate any other ACL changes against a known threat to understand any potential advantages that the changes may lend to a specific configuration. For these reasons, our guides make only minimal DACL changes and only to Windows 2000. For Windows 2000, several minor changes are required. These changes are described in the Windows 2000 Security Hardening Guide.

Extensive permission changes propagated throughout the registry and file system can't be undone. New folders, such as user profile folders that weren't present at the original installation of the operating system, may be affected. So you can't roll back the original DACLs if you:

- remove a Group Policy setting that performs DACL changes
- apply the system defaults

Changes to the DACL in the %SystemDrive% folder may cause the following scenarios:

- The Recycle Bin no longer functions as designed, and files cannot be recovered.
- A reduction of security that lets a non-administrator view the contents of the administrator's Recycle Bin.
- The failure of user profiles to function as expected.
- A reduction of security that provides interactive users with read access to some or to all user profiles on the system.
- Performance problems when many DACL edits are loaded into a Group Policy object that includes long logon times or repeated restarts of the target system.
- Performance problems, including system slowdowns, every 16 hours or so as Group Policy settings are reapplied.
- Application compatibility problems or application crashes.

To help you remove the worst results of such file and registry permissions, Microsoft will provide commercially reasonable efforts in line with your support contract. However, you can't currently roll back these changes. We can guarantee only that you can return to the recommended out-of-the-box settings by reformatting the hard disk drive and by reinstalling the operating system.

For example, modifications to registry DACLs affect large parts of the registry hives and may cause systems to no longer function as expected. Modifying the DACLs on single registry keys poses less of a problem to many systems. We recommend you carefully consider and test these changes before you implement them. And we can guarantee only that you can return to the recommended out-of-the-box settings if you reformat and reinstall the operating system.
