---
title: Applications attempt to access web cache content that belongs to the local Administrator account
description: Describes an issue where IE or Edge does not function correctly because the user's profile is configured to use the Administrator cache.
ms.date: 08/28/2020
ms.prod-support-area-path: 
ms.reviewer: joelba;DEV_Triage
author: Teresa-Motiv
ms.author: davean
ms.custom: 
- CI 122170
- CSSTroubleshooting
---

# Applications attempt to access web cache content that belongs to the local Administrator account

_Original product version:_&nbsp;Internet Explorer, Windows 10; Microsoft Edge, Windows 10  

## Symptoms

Enterprise users of Internet Explorer, Microsoft Edge, or applications that use the modules of either browser report the following symptoms:

- Long delays when signing in to the Windows desktop
- The browser can't save content to the browser cache
- The browser can't access content from the browser cache

An affected user records a Process Monitor log while experiencing the issue. When you analyze this log, you notice that the browsers or applications attempt to access files and folders that are located in the C:\Users\Administrator folder as well as files and folders that are located in the user's profile folder.

:::image type="content" source="./media/apps-access-admin-web-cache/ie-mse-procmon-log.png" alt-text="Process Monitor log that shows attempts to access the Administrator folders":::

## Cause

A Windows computer has an Administrator profile and a Default user profile. Each profile has an associated cache container. The first time that the user signs in to Windows, Windows uses the information from the Default user profile to configure the user's profile. The user's profile includes the cache container that was defined for the Default user profile.

In the case of this issue, the Default User profile uses the cache container that was originally created for the Administrator profile. In other words, the user's profile is configured to use the Administrator's cache container.

This issue may occur if the Default user profile has been modified to create custom settings for new user profiles. For example, some imaging or deployment utilities copy some or all of the Administrator profile content to the Default user profile.

## Resolution

On affected computers, you need to separately fix the affected user profile and the Default user profile.

> [!CAUTION]  
> Microsoft strongly recommends that you back up any profile folder locations or registry entries before you make any modifications.

> [!NOTE]  
> By default, these profile files and folders are hidden from view. To make them visible, you have to temporarily modify the folder view options of the C:\Users\Default folder and the C:\Users\\<*user name*> folder (where \<*user name*> is the name of the affected user's profile). To do this, follow these steps:
>  
> 1. Open Windows File Explorer, and go to the appropriate profile folder location.
> 1. Select **View** > **Options** > **View**.
> 1. In the **Advanced settings** list, select **Show hidden files, folders, and drives**.
> 1. In the same list, clear the **Hide protected operating system files (Recommended)** checkbox, and then select **Yes**.
>   :::image type="content" source="./media/apps-access-admin-web-cache/ie-mse-show-hidden-files.png" alt-text="An alert appears when you clear the option to hide protected files":::
> 1. Select **Apply**, and then select **OK**.

### Step 1 - Repair the Default user profile

To prevent new user profiles from receiving a copy the cache container from the Default user profile, delete the following file and folders (if they exist):

- C:\Users\Default\AppData\Local\Microsoft\Windows\WebCacheLock.dat
- C:\Users\Default\AppData\Local\Microsoft\Windows\WebCache
- C:\Users\Default\AppData\Local\Microsoft\Windows\INetCache
- C:\Users\Default\AppData\Local\Microsoft\Windows\INetCookies

:::image type="content" source="./media/apps-access-admin-web-cache/ie-mse-delete-folders-and-files.png" alt-text="File and folders to delete to repair the Default user profile":::

### Step 2 - Repair each affected user profile

A number of the files and folders that are part of the user profile can't be deleted while the user is signed in to Windows. Because of this restriction, the user has to sign out of Windows, and then an administrator can sign in and fix the profile. To fix the profile, delete the following file and folders (if they exist):

- C:\Users\\<*user name*>\AppData\Local\Microsoft\Windows\WebCacheLock.dat  
- C:\Users\\<*user name*>\AppData\Local\Microsoft\Windows\WebCache  
- C:\Users\\<*user name*>\AppData\Local\Microsoft\Windows\INetCache  
- C:\Users\\<*user name*>\AppData\Local\Microsoft\Windows\INetCookies  
  
  > [!NOTE]  
  > In these file paths, \<*user name*> is the name of the affected user's profile.

After you delete these items, follow these steps:

- Restore the folder view options to their previous values
- Restart the computer, and then have the affected user sign in (or sign in by using a new user account).

## More information

The files and folders that are listed in this article comprise part of the Internet Explorer and Microsoft Edge browser cache. These content locations are designed to be created for each user individually. Therefore, Microsoft recommends that you do not attempt to customize, modify, or re-locate them, and Microsoft does not support such attempts.
