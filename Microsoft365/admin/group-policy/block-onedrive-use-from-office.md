---
title: How to block OneDrive use from within Office 365 ProPlus and Office 2016 applications
description: Describes how to prevent your Office 2016 users from accessing and using OneDrive. This method involves configuring Group Policy settings.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: one-drive
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Office 365 ProPlus
- Office 2016
- OneDrive
---

# How to block OneDrive use from within Office 365 ProPlus and Office 2016 applications

## Summary

When you install Microsoft Office 2016, the OneDrive sync client (OneDrive.exe) is included in the installation package. This article describes how to use Group Policy settings and registry modification to block access to OneDrive from within the Office applications.

## More Information

To block OneDrive access for Office 2016 users in your organization, follow these steps:

1. Download the [Office 2016 Administrative Template files (ADMX/ADML) and Office Customization Tool](https://www.microsoft.com/download/details.aspx?id=49030).

2. Use the Office 2016 Administrative Templates to configure Group Policy settings under **User configuration** > **Administrative Templates** > **Microsoft Office 2016** > **Miscellaneous** as follows:
   1. Set the **Show OneDrive Sign In** setting to **Disabled**:

        ![Show OneDrive Sign-in](https://sawinternal.blob.core.windows.net/gds-images/3120068.png)

    2. Enable the **Block signing into Office** setting, and set it to **Org ID only**:

        ![Org ID only](https://sawinternal.blob.core.windows.net/gds-images/3120069.png)   
   

To prevent users from adding their personal OneDrive account, use one of the following methods:

### Use a Group Policy object
Use the Office 2016 Administrative Templates to configure Group Policy settings.

Under **User configuration** > **Administrative Templates** > **Microsoft Office 2016** > **Miscellaneous**, configure **Hide file locations when opening or saving files** as **Hide OneDrive Personal**.

> [!NOTE]
> This policy setting only applies to Word, PowerPoint, and Excel.


### Modify the registry

Open registry editor and browse to the following registry key:

```
HKCU\Software\Policies\Microsoft\Office\16.0\Common\Internet
```

Modify the DWORD value "OnlineStorage".

Available values are:

* **0** Policy is off (all locations are shown)

* **1** Only OneDrive Personal locations are hidden

* **2** All SharePoint Online locations are hidden

* **3** All Microsoft Online Locations are hidden

If you set other values, the policy is off (all locations are shown).

If the value is set to **1**, uses can no longer see their personal OneDrive location under **Add a place**.


To block the use of OneDrive from within Windows, see [How to block OneDrive.exe from being advertised after you install Office 2016](https://support.microsoft.com/help/3107393). 

To configure the update settings for Office 365 ProPlus, see the following TechNet resource:

[Configure update settings for Office 365 ProPlus](https://technet.microsoft.com/library/dn761708.aspx)

