---
title: Folder redirection doesn't work correctly
description: Discusses a problem in which folder redirection does not work correctly after you restart a Windows Server 2008-based computer or a Windows Vista-based computer. A workaround is provided.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, philibla
ms.custom: sap:folder-redirection-and-offline-files-and-folders-csc, csstroubleshoot
---
# Folder redirection does not work correctly after you restart the computer

This article provides workarounds for an issue where folder redirection doesn't work correctly after you restart computers.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 951049

## Problem description

On a computer that is running Windows Server 2008 or Windows Vista, folder redirection is enabled. You log on immediately after you restart the computer. In this case, Windows Explorer tries to display the desktop before the Workstation service starts, and you experience one of the following problems:

- When you try to access redirected folders, you receive the following error message: **\\**servername**\**Username**\**sharename**** is currently unavailable.

- The Documents, Pictures, Music, and Desktop folders are not visible.

## Workaround

To work around this problem, use one of the following methods.

### Method 1: Log off, and then log on again

Windows Explorer uses the Well-Known folder cache. The Well-Known folder cache is initialized during logon. When you log off and then log on again, Windows rebuilds the cache. At this point, you can apply Group Policy settings correctly. Additionally, the cache is populated correctly.

> [!NOTE]
> For more information about Group Policy settings and about the Well-known folder cache, see the "[More information](#more-information)" section.

### Method 2: Wait for 12 minutes

The default update interval for the Well-Known folder cache is 12 minutes. To gain access to the redirected folders, wait for the 12-minute update interval to end.

### Method 3: Decrease the update interval

You can change the registry to decrease the update interval for the Well-Known folder cache.

To have us fix this problem for you, go to the "Fix it for me" section. If you'd rather fix this problem yourself, go to the "Let me fix it myself" section.

#### Fix it for me

To fix this problem automatically, click the
 **Fix this problem** link. Then click
 **Run** in the
 **File Download** dialog box, and follow the steps in this wizard.

> [!NOTE]
> This wizard may be in English only; however, the automatic fix also works for other language versions of Windows.

> [!NOTE]
> If you are not on the computer that has the problem, you can save the automatic fix to a flash drive or a CD so that you can run it on the computer that has the problem.

Now go to the "Did this fix the problem?" section.

##### Let me fix it myself

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

You can decrease the update interval for the Well-Known folder cache by changing two registry values for the KnownFolderSettings subkey. These values control the intervals that are used to update the Well-Known folder cache, based on the success or failure of queries. By default, there is no KnownFolderSettings subkey. Instead, you must create this subkey. To create the KnownFolderSettings subkey and its values, follow these steps:

1. Click **Start**, click **Run**, type regedit, and then click **OK**.
2. Locate and then click the following registry key: `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer` 
3. On the **Edit** menu, point to **New**, and then click **Key**.
4. Type KnownFolderSettings, and then press ENTER.
5. Right-click KnownFolderSettings, point to **New**, click **DWORD Value**, and then type CachetimeoutSuccess.
6. Right-click CachetimeoutSuccess, and then click **Modify**.
7. In the **Value Data** field, type a value from 0 to 720000 milliseconds (ms).

    > [!NOTE]
    > The CachetimeoutSuccess registry value controls the time-out for cache entries that are populated successfully when the cache is built. We recommend that you set this value to the maximum value of 720000 ms (12 minutes) except when you have to configure the cache to repopulate the settings more frequently. Decreased values may cause an increase in processor and network load. (This increased load is associated with Windows Explorer.)
8. Right-click KnownFolderSettings, point to **New**, click **DWORD Value**, and then type CachetimeoutFailure.
9. Right-click CachetimeoutFailure, and then click **Modify**.
10. In the **Value Data** field, type a value from 0 to 720000 ms.

> [!NOTE]
> The CachetimeoutFailure registry value controls the time-out for cache entries that are not populated successfully when the cache is built. We recommend that you set this value to 60000 ms. When you do this, Windows Explorer tries to repopulate failed cache entries after 1 minute. This time frame is sufficient for the Workstation service to complete the initialization process.

##### Did this fix the problem?

Check whether the problem is fixed. If the problem is fixed, you are finished with this article. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus/).

## More information

Windows Server 2008 and Windows Vista use the Well-Known folders feature to determine the location of folders in the user profile. By using this feature, Windows redirects Well-Known folders to other locations as needed. Specifically, Windows Explorer queries the Well-Known folder GUID. This query returns the actual folder location, whether on a hard disk drive or on a remote server.

Windows Explorer optimizes Well-Known folder lookups by caching the Well-Known folders and their locations. Queries are performed against the cache, and the location is then returned to the application or to Windows Explorer.

When you use folder redirection, you receive the folder redirection settings from Group Policy. This process cannot occur unless the Workstation service has started. If the Workstation service has not started, the Well-Known folder cache is unavailable. This causes queries for redirected folder locations to fail. Additionally, the cache remains unavailable until the next update. By default, this cache is updated every 12 minutes (after the cache is first initialized and built during logon).

## Status

Microsoft has confirmed that this is a problem.
