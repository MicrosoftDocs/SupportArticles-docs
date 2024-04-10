---
title: Failed to add favorites and protected mode
description: This article describes a situation where enabling enhanced protection mode in Internet Explorer 10 and redirecting the Favorites folder to another location causes the failure that tries to add a website with CTRL+D or the user interface to your favorites collection.
ms.date: 06/09/2020
ms.reviewer: jeanr
---
# You cannot add favorites with redirected favorites folder and enhanced protected mode in Internet Explorer 10

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information about resolving a problem that favorites and enhanced protected mode can't be added in Internet Explorer 10.

_Original product version:_ &nbsp; Internet Explorer 11, Internet Explorer 10  
_Original KB number:_ &nbsp; 2831093

## Symptoms

Consider the following scenario:

You are using Windows 8 with Internet Explorer 10 and you have enabled Enhanced Protected Mode (EPM). In addition, the users favorites folder has been redirected to another location via GPO or Shell user interface. Then you browse to a website, which belongs to a security zone with enabled protected mode and you try to add this website with CTRL+D or the user interface to your favorites collection.

In this scenario, the operation fails. You will get no dialog at all or the favorites list in the dialog is empty.

## Resolution

1. Locate and then select the following key in the registry:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\MAIN\FeatureControl`

    For 32-bit browsers on 64-bit systems, the registry key is:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\MAIN\FeatureControl`

2. On the **Edit** menu, select **New**, and then select **Key**.
3. Highlight the new Key, right-click, and select **Rename** from the popup menu.
4. Type *FEATURE_BROKER_FAVORITES_FOR_EFS_KB2300135*, and then press **Enter**.
5. On the **Edit** menu, select **New**, and then select **DWORD** Value.
6. Type *iexplore.exe*, and then press **Enter**.
7. On the **Edit** menu, click **Modify**, type *1* in the Value data box, and then click **OK**.
8. Exit Registry Editor.

## More information

The issue happens only on Windows 8 with Internet Explorer 10 and later versions. There is no need to install any hotfix since the feature control key is already available.
