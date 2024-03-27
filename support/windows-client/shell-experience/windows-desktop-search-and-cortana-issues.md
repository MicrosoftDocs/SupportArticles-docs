---
title: Issues for Windows Desktop Search and Cortana
description: Discusses the known issues that affect Windows Desktop Search and Cortana in Windows 10.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Windows Desktop and Shell Experience\Windows Search, csstroubleshoot
---
# Known issues for Windows Desktop Search and Cortana in Windows 10

This article describes the known issues that may occur when you use Windows Desktop Search or Cortana in Windows 10.

> [!NOTE]
> Home users: This article is intended for use by support agents and IT professionals. If you're looking for more information about website error messages, please see the following Windows website: [Search for anything, anywhere](https://support.microsoft.com/help/17190)

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3206883

## Known issues

### Issue 1

Desktop Search or Cortana can't find shortcut files (.lnk)

#### Symptoms

On a computer that's running Windows 10, Desktop Search, or Cortana, you can't find shortcut files (files with an LNK extension).

The issue occurs regardless of whether the shortcut files are in indexed locations.

#### Status

Microsoft is aware of this issue and is investigating it.

### Issue 2

Desktop Search or Cortana don't find files that have a URL extension.

#### Symptoms

On a computer that's running Windows 10, you can't find files that have a URL extension by using Desktop Search or Cortana.

#### Status

This is by design. The search filters the results to eliminate noise that's caused by non-app shortcuts.

### Issue 3

Windows Desktop Search shows no results if you have your **Internet Options** settings configured to disable website data.

#### Symptoms

When you try to search from the **Start**  menu or from Cortana on a Windows 10-based computer, you receive no results. This behavior occurs if you have your **Internet Options**  settings configured to disable local caches and databases.

You can disable local caches and databases by using one of the following methods:

- Using Internet Explorer:
 **Internet Options** -> **General** tab -> **Browsing History** -> **Settings** -> **Website Data Settings** -> **Caches and databases** tab -> **Allow website caches and databases** (clearing the check box)
- Using Registry Editor:  
`HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\BrowserStorage\AppCache` "AllowWebsiteCaches"=dword:00000000
- Using Group Policy:  
Group Policy under either or both User and Computer configuration:

    Administrative Templates>Windows Components> Internet Explorer>Internet Control Panel>General Page>Browsing History>Allow websites to store application caches on client computers

#### Cause

This issue occurs when the user disables the use of caches and databases through Internet Options or Group Policy. Doing this prevents the application that uses AppCache from storing data locally, and the application must have access to the web content that would have been used initially to populate the cache. If a computer has no Internet access and has the option configured to disallow the Web Platform APIs from using AppCache (The **Allow website caches and databases**  option is cleared), Desktop Search doesn't work.

#### Resolution

To work around this problem, change the configuration of Desktop Search through Group Policy. To do this, follow these steps:

1. Press the Windows key + R to open the **Run**  box.
2. Type *gpedit.msc*, and then press **Enter**.
3. In the Group Policy Editor, navigate to the following location:

    **Computer Configuration** -> **Administrative Templates** -> **Windows Components** -> **Search**  

4. In the pane on the right, double-click. Don't search the web or display web results in Search.
5. Select Enabled.
6. Click **Apply**, and then click OK. Desktop Search will now avoid using any of the Web Platform APIs to acquire content from the web. This also mitigates the impact of disabling website caching and databases.

#### More information

Windows Desktop Search, Internet Explorer, and Microsoft Store Apps use a feature called Application Cache (AppCache), which enables the creation of offline web apps and webpage caching. AppCache also lets the apps that use it boost performance of web content by reducing the number of requests made to the hosting server.
