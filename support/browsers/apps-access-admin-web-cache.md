---
title: Applications attempt to access web cache content that belongs to the local Administrator account
description: in progress
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

_Original product version:_ &nbsp; Internet Explorer, Windows 10;Microsoft Edge, Windows 10  

## Symptoms

Enterprise users of Internet Explorer, Microsoft Edge, or applications that leverage the modules of either browser report the following symptoms:

- Long delays when signing in to the Windows desktop
- The browser cannot save content to the browser cache
- The browser cannot access content from the browser cache

If you analyze a Process Monitor log that was recorded on and affected computer while the user experienced this issue, you notice that the browsers or applications attempt to access files and folders in the C:\Users\Administrator profile location in addition to files and folders in the user's profile location.

image 1

## Cause

When 
The impacted user has a cache container that was originally created for the local Administrator account and the C:\Users\Administrator profile location. The user likely received this cache from the local machine Default User profile during the first logon of the user.  

In enterprise environments, the inclusion of the C:\Users\Administrator cache content may be the result of intended or unintended Default user profile customization.

For example, an administrator may have intended to create a customized Default user profile to be used as the basis for all new users to log on to Windows machine.

In some circumstances, the unintended cache inclusion can be the result of imaging or deployment utilities that copy some or all of the Administrator profile content to the Default user profile location.

## Resolution

On impacted machines, there will need to be separate procedures performed to address the problem for an impacted user profile as well as for the Default user profile.

CAUTION:  Microsoft strongly recommends making a backup of any folder or registry locations before making any modifications.

NOTE:  By default, these profile files and folders will be hidden from view.  To enable them to be seen, you will need to temporarily modify the Folder Options View of each profile location using the following steps:

1. Open Windows File Explorer to the appropriate profile folder location
1. From the ribbon at the top of the window, select the ‘View’ tab
1. Click the Options button to open the Folder Options dialog
1. Click the View tab and then locate the ‘Hidden Files and Folders’ radio-button options.
1. Select the radio-button option to ‘Show hidden files, folders, and drives’
1. Now locate the checkbox option to ‘Hide protected operating system files (Recommended)’
1. Uncheck the box.  A warning dialog should appear.  Read the warning, and then choose Yes
1. Click Apply and then click OK to close the folder options.

image

### For the Default User Profile

To prevent new user profiles from receiving a copy of a Default user profile cache, delete the 
following file and folders if they exist:

- C:\Users\Default\AppData\Local\Microsoft\Windows\WebCacheLock.dat
- C:\Users\Default\AppData\Local\Microsoft\Windows\WebCache
- C:\Users\Default\AppData\Local\Microsoft\Windows\INetCache
- C:\Users\Default\AppData\Local\Microsoft\Windows\INetCookies

### For each impacted user profile

While the user is logged on to Windows, a number of their files and folders cannot be deleted or renamed while in use.  To correct this issue, the user will need to log off of Windows completely and then have an administrator delete the following file and folders if they exist:

- C:\Users\username\AppData\Local\Microsoft\Windows\WebCacheLock.dat
- C:\Users\username\AppData\Local\Microsoft\Windows\WebCache
- C:\Users\username\AppData\Local\Microsoft\Windows\INetCache
- C:\Users\username\AppData\Local\Microsoft\Windows\INetCookies
  \* where username is the impacted profile user name

Once these files and folders are deleted, perform the following recommended steps:

- Revert the Folder Options View settings to their prior values
- Restart the machine, before logging onto Windows as either a new or impacted user.

## More information

The files and folders identified above, make up part of the Internet Explorer and Microsoft Edge browser cache. As these content locations are designed to be created for each user individually, Microsoft does not support nor recommend attempts to customize, modify, or re-locate them.
