---
title: Prioritize BITS by Office 2016 clients for downloading updates
description: Describes how to use BITS for Office 2016 clients to download updates.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- Office 365 ProPlus
- Office 365 Business
- Office Professional 2016
- Office Professional Plus 2016
- Visio Professional 2016
- Project Professional 2016

---

# How to prioritize the use of BITS by Office 2016 clients for downloading updates

## Summary

When you download updates from Microsoft Content Delivery Network (CDN) to update Office 2016 clients, you may need to prioritize the use of Windows Background Interface Transfer Service (BITS) to better manage network bandwidth.

## More Information

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, back up the registry for restorationin case problems occur.

### Method 1: Use the Office administrative template and customization tool

1. Download the latest templates ([Office 2016 Administrative Template files (ADMX/ADML) and Office Customization Tool](https://www.microsoft.com/download/details.aspx?id=49030)). A new GPO item (Prioritize BITS) is added to the Office16.admx.
2. Start the Group Policy Management Console, enable Prioritize BITS under Computer Configuration, expand Administrative Templates, expand Microsoft Office 2016 (machine) and choose Updates.

    ![Screenshot for step two](https://sawinternal.blob.core.windows.net/gds-images/3194164.jpg)

### Method 2: Add a registry entry

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

Create the following registry entry.

Registry subkey: HKEY_LOCAL_MACHINE\software\policies\microsoft\office\16.0\common\officeupdate
Registry Value name: setbitsasprimary
Registry Type: REG_DWORD
Enabled Value: 1 (default)

**Notes** 
 
- This item only applies for Office client build that's greater than or equals to 16.0.7213.6925.
- This policy setting only applies to Office 365 clients that are installed by using Click-to-Run (Office 2016 Click-to-Run editions). This includes Office 365 ProPlus, Office 365 Business, Visio Pro for Office 365 and Project Pro for Office 365. It doesn't apply to Office products that use Windows Installer (MSI).    
- If the policy setting is enabled, BITS is used on devices that are downloading Office updates directly from the Office CDN.    
- The devices won't use BITS if updates are obtained from a local Universal Naming Convention (UNC) share.    
- BITS can be used when Office 365 ProPlus is updated from a local HTTP server. For more information, see the following section, "How to set up an internal HTTP site to distribute Office sources."    
- If the policy setting is disabled or not configured, BITS isn't prioritized and the HTTP will be the primary transport for downloading updates.    
 
### How to set up an internal HTTP site to distribute Office sources

1. Download the latest Office BITS (by using [Office Deployment Tool (ODT)](https://technet.microsoft.com/library/jj219426.aspx)). BITS will resemble the following:

    [Drive:\<my-download-directory>\<new-office-download>\office\data\*.cab]

    [Drive:\<my-download-directory>\<new-office-download>\office\data\16.0.*.*\*]

    For future reference, you'll call Drive:\your-download-directory\new-office-download as the root directory.    
2. Set up a local HTTP server (by using IIS, Apache, or other software).    
3. Add the .dat MIME type as **application/octet-stream**. 

    ![A screenshot of the IIS page to edit the .dat Mime Type](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4042611_en_2)    
4. Copy the root directory from step 1 to the HTTP server. Then, the server can be accessed from the site: 

    https://servername/directory1/directory2/office/xxx

    That is, everything in directory2 is the contents of the root directory.    
5. Copy the URL (https://servername/directory1/directory2) to access the Office BITS.    
6. Set up a Group Policy to use the URL as cited above (https://servername/directory1/directory2) as the update path.    
