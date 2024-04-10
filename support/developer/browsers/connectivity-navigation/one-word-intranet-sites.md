---
title: Access intranet sites via one-word
description: In order to get an excellent search experience, we are changing the behavior for corporate users, who only need to enter one-word to access intranet sites without entering http://.
ms.date: 04/20/2020
ms.reviewer: bhaskerk, davidcon, axelr, joelba, jmann
---
# One-word intranet sites take you to your default search engine with Internet Explorer 9 and later versions

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides solutions about using one-word to access the intranet in Internet Explorer 9 and later versions.

_Original product version:_ &nbsp; Internet Explorer 9 and later versions  
_Original KB number:_ &nbsp; 2411821

## Symptoms

You are trying to access an intranet site and the name of the site comprises of just one-word. When you attempt to browse to this site by using Internet Explorer 9 or a later version, it responds by taking you to your default search engine to look for that word.

## Cause

Internet Explorer 9 or a later version introduces the OneBox feature, which combines the address bar and the search box. In order to achieve a great search experience for all users, the default behavior is for OneBox to use a single word entry as search criteria. This can be changed by users or controlled by Group Policy as described in the resolution.

## Resolution

If users want to go directly to the intranet site, then they can either type `http://` before the intranet site name or append / to the site name.

Alternatively, you can configure Internet Explorer to go to the intranet site directly by using one of the following methods.

### Method 1: Using Tools menu in Internet Explorer

Click **Internet Options**, click the **Advanced** tab, check the options go to an intranet site for a single word entry in the **Address** bar.

### Method 2: Using Group Policy

Local or Domain Administrators can configure this setting by using Group Policy.

1. Click **Start**, click **Run**, type *gpedit.msc*, and then click **OK**.

2. Expand **User Configuration**, expand **Administrative Templates**, expand **Windows Components**, expand **Internet Explorer**.

3. Then expand **Internet Settings**, expand **Advanced Settings**, expand **Browsing**, set **Go to an intranet site for a single word entry in the Address bar** according to your desired settings. You have to update policies or restart the computer to apply changes.

### Method 3: Using registry key

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [322756](https://support.microsoft.com/help/322756).

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. Locate and then click the registry subkey: `HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main`

3. On the **Edit** menu, point to **New**, click **DWORD Value**, and then add the following registry value:  
    Value Name: `GotoIntranetSiteForSingleWordEntry`  
    Value Type: `REG_DWORD`  
    Value Data: **1**

## More information

Here is how the default behavior works. When a user types in just one word into the address bar, Internet Explorer 9 or a later version responds by taking the user to their default search engine to look for that word.

If Internet Explorer detects that it is also an intranet site, then it will suggest the intranet site through the notification bar, situated at the bottom of the Internet Explorer window. The notification bar would say 'Do you want to go to `http://<sitename>`?'. When you click **yes**, Internet Explorer 9 or a later version automatically adds the site to the inline autocomplete list.

The next time the intranet site name is typed in, Internet Explorer 9 or a later version will offer it with a / at the end of the word automatically and pressing Enter will take you to the intranet site.
