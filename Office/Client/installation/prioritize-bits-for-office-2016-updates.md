---
title: Prioritize BITS by Office 2016 clients for downloading updates
description: Describes how to use BITS for Office 2016 clients to download updates.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: meerak
appliesto: 
  - Microsoft 365 Apps for enterprise
  - Microsoft 365 Business
  - Office Professional 2016
  - Office Professional Plus 2016
  - Visio Professional 2016
  - Project Professional 2016
ms.date: 05/29/2025
---

# How to prioritize the use of BITS by Office 2016 clients for downloading updates

## Summary

When you download updates from Microsoft Content Delivery Network (CDN) to update Microsoft Office 2016 clients, you may have to prioritize the use of Windows Background Interface Transfer Service (BITS) to better manage network bandwidth.

## More information

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, back up the registry for restoration in case problems occur.

### Method 1: Use the Office administrative template and customization tool

1. Download the latest templates ([Office 2016 Administrative Template files (ADMX/ADML) and Office Customization Tool](https://www.microsoft.com/download/details.aspx?id=49030)). A new GPO item (Prioritize BITS) is added to the Office16.admx file.
2. Start the Group Policy Management Console, enable **Prioritize BITS** under **Computer Configuration**, expand **Administrative Templates**, expand **Microsoft Office 2016 (machine)**, and then select **Updates**.

    :::image type="content" source="media/prioritize-bits-for-office-2016-updates/prioritize-bits.png" alt-text="Screenshot to enable the Prioritize BITS item under the Computer Configuration.":::

### Method 2: Add a registry entry

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

Create the following registry entry:

Registry subkey: 
- HKEY_LOCAL_MACHINE\SOFTWARE\policies\microsoft\office\16.0\common\officeupdate
- Registry Value name: setbitsasprimary
- Registry Type: REG_DWORD
- Enabled Value: 1 (default)

**Notes** 

- This item applies to only the following Office client build:
    - **Office version 2002 (16.0.12527.*x*) and later**: Effective for both Office installations and updates on supported Windows 10 platforms.
    - **Office version 1908 (16.0.11929.*x*)**: The policy is ineffective for both Office installations and updates on Windows 10 platforms starting at version 1709.
    - **The policy will cause installation failures for Office version 1902 (16.0.11328.*x*) and is ineffective for Office updates on Windows 10 platforms starting at version 1709.**

- This policy setting applies to only Microsoft 365 clients that are installed by using Click-to-Run (Office 2016 Click-to-Run editions). This includes Microsoft 365 Apps for enterprise, Microsoft 365 Business, Visio Pro for Microsoft 365, and Project Pro for Microsoft 365. It doesn't apply to Office products that use Windows Installer (MSI).    
- If the policy setting is enabled, BITS is used on devices that are downloading Office updates directly from the Office CDN.    
- The devices won't use BITS if updates are obtained from a local Universal Naming Convention (UNC) share.    
- BITS can be used if Microsoft 365 Apps for enterprise is updated from a local HTTP server. For more information, see the following section, "How to set up an internal HTTP site to distribute Office sources."    
- If the policy setting is disabled or not configured, BITS isn't prioritized, and the HTTP will be the primary transport for downloading updates.    
 
### How to set up an internal HTTP site to distribute Office sources

1. Download the latest Office BITS (by using [Office Deployment Tool (ODT)](/deployoffice/office-deployment-tool-configuration-options)). BITS will resemble the following:

    [Drive:\<my-download-directory>\<new-office-download>\office\data\*.cab]

    [Drive:\<my-download-directory>\<new-office-download>\office\data\16.0.*.*\*]

    For future reference, you'll call Drive:\your-download-directory\new-office-download as the root directory.    
2. Set up a local HTTP server (by using IIS, Apache, or other software).    
3. Add the .dat MIME type as **application/octet-stream**. 

    :::image type="content" source="media/prioritize-bits-for-office-2016-updates/iis-page.png" alt-text="Screenshot of the I I S page to edit the .dat M I M E Type.":::
4. Copy the root directory from step 1 to the HTTP server. Then, the server can be accessed from the following website: 

    https://servername/directory1/directory2/office/xxx

    That is, everything in directory2 is the contents of the root directory.    
5. Copy the URL (https://servername/directory1/directory2) to access the Office BITS.    
6. Set up a policy in Group Policy to use the URL from step 5 (https://servername/directory1/directory2) as the update path.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
