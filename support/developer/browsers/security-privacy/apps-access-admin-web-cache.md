---
title: Applications try to access web cache content that belongs to the local Administrator account
description: Describes an issue where IE or Edge does not function correctly because the user's profile is owned by the Administrator account.
ms.date: 08/28/2020
ms.reviewer: joelba, DEV_Triage, v-tappelgate
ms.custom: 
  - CI 122170
  - CSSTroubleshooting
---

# Applications try to access web cache content that belongs to the local Administrator account

[!INCLUDE [](../../../includes/browsers-important.md)]

This article describes how to resolve an issue in which browsers or applications that use browser modules try to access files that belong to a computer's Administrator profile in addition to files that belong to the current user's profile.

_Original product version:_&nbsp;Internet Explorer, Windows 10; Microsoft Edge, Windows 10  

## Symptoms

Enterprise users of Internet Explorer, Microsoft Edge, or applications that use the modules of either browser are reporting the following symptoms:

- Long delays occur when users sign in to the Windows desktop.
- The application can't save content to the browser cache.
- The application can't access content from the browser cache.

In this scenario, an affected user records a Process Monitor log while experiencing the issue. When you analyze the log, you notice that the browsers or applications try to access files and folders that are located in the *C:\Users\Administrator* folder in addition to files and folders that are located in the user's profile folder.

:::image type="content" source="media/apps-access-admin-web-cache/ie-mse-procmon-log.png" alt-text="Process Monitor log that shows attempts to access the Administrator folders.":::

## Cause

The first time that the user signs in to Windows, the system uses information from the default user profile to configure the new user profile. Windows also creates a cache container as part of the user profile, for browsers and other applications to use.

This access issue may occur if the default user profile was changed to create custom settings for new user profiles. this is true especially if the modification process includes copying profile information from the Administrator profile. In particular, some imaging or deployment tools copy some or all of the Administrator profile content to the default user profile.

The Administrator profile has its own cache container. If this part of the Administrator profile is copied to the Default user profile, new users receive a copy of the Administrator cache container instead of a new cache container. The Administrator account owns the cache container. The user account does not. As a result, the user does not have full access to the cache container.

## Resolution

On affected computers, you have to separately fix the affected user profile and the default user profile.

> [!CAUTION]  
> We strongly recommend that you back up any profile folder locations or registry entries before you make any modifications.

> [!NOTE]  
> By default, these profile files and folders are hidden from view. To make them visible, you have to temporarily change the folder view options of the C:\Users\Default folder and the C:\Users\\<*user name*> folder (in which \<*user name*> is the name of the affected user's profile). To do this, follow these steps:
>  
> 1. Open Windows File Explorer, and locate the appropriate profile folder location.
> 2. Select **View** > **Options** > **View**.
> 3. In the **Advanced settings** list, select **Show hidden files, folders, and drives**.
> 4. In the same list, clear the **Hide protected operating system files (Recommended)** check box, and then select **Yes**.
>   :::image type="content" source="media/apps-access-admin-web-cache/ie-mse-show-hidden-files.png" alt-text="An alert appears when you clear the option to hide protected files.":::
> 5. Select **Apply** > **OK**.

### Step 1: Repair the default user profile

To prevent new user profiles from receiving a copy the cache container from the default user profile, delete the following file and folders (if they exist):

- *C:\Users\Default\AppData\Local\Microsoft\Windows\WebCacheLock.dat*
- *C:\Users\Default\AppData\Local\Microsoft\Windows\WebCache*
- *C:\Users\Default\AppData\Local\Microsoft\Windows\INetCache*
- *C:\Users\Default\AppData\Local\Microsoft\Windows\INetCookies*

:::image type="content" source="media/apps-access-admin-web-cache/ie-mse-delete-folders-and-files.png" alt-text="File and folders to delete to repair the Default user profile.":::

### Step 2: Repair each affected user profile

Several files and folders that are part of the user profile can't be deleted while the user is signed in to Windows. Because of this restriction, the user has to sign out of Windows, and then an administrator can sign in and fix the profile. To fix the profile, delete the following file and folders (if they exist):

- *C:\Users\\<*user name*>\AppData\Local\Microsoft\Windows\WebCacheLock.dat*
- *C:\Users\\<*user name*>\AppData\Local\Microsoft\Windows\WebCache*
- *C:\Users\\<*user name*>\AppData\Local\Microsoft\Windows\INetCache*
- *C:\Users\\<*user name*>\AppData\Local\Microsoft\Windows\INetCookies*  
  
  > [!NOTE]  
  > In these file paths, \<*user name*> is the name of the affected user's profile.

After you delete these items, follow these steps:

- Restore the folder view options to their previous values.
- Restart the computer, and then have the affected user sign in (or you can sign in by using a new user account).

## More information

The files and folders that are listed in this article make up part of the Internet Explorer and Microsoft Edge browser cache. These content locations are designed to be created for each user individually. Therefore, we recommend that you do not try to customize, change, or relocate them. We do not support doing this.
