---
title: Outlook 2016 and Outlook 2013 hang when a user tries to create a profile
description: Describes a problem that makes Outlook 2016 and Outlook 2013 freeze when a user tries to create a profile.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# Outlook 2016 and Outlook 2013 hang when a user tries to create a profile

## Problem 

When a user creates a profile in Microsoft Outlook 2016 or Outlook 2013, Outlook hangs. 

This problem occurs if the root domain of the user's SMTP address points to a web host that doesn't use Secure Sockets Layer (SSL), and if port 443 is closed. In this scenario, the web host doesn't respond to https://contoso.com/Autodiscover/Autodiscover.xml. Therefore, Outlook hangs while the profile is being created.

To verify that this is the cause of the issue that you're experiencing, follow these steps:

1. Locate the Outlook icon in the notification area on the right side of the taskbar, hold the CTRL key, click the icon, and then click **Test E-mail AutoConfiguration** on the menu that appears.   
2. Enter the user's email address and password, and then click **Test**.   
3. View the results on the **Log** tab. If you see multiple retry entries that contain one of the following error messages, you're experiencing this issue:
   - Outlook 2016: 

     **Autodiscover to https://contoso.com/autodiscover/autodiscover.xml starting
GetLastError=2147954402; httpStatus=0.**   
   - Outlook 2013:

     **Autodiscover to https://contoso.com/autodiscover/autodiscover.xml starting
GetLastError = 12002, httpStatus = 0.**   
   
## Solution 

### Outlook 2016

#### For MSI installations of Office 2016

This is fixed in Outlook version 16.0.4351.1000 and later versions. To obtain version 16.0.4351.1000, install the update that's documented in the following Microsoft Knowledge Base article:

[3114861](https://support.microsoft.com/help/3114861) MS16-029: Description of the security update for Outlook 2016: March 8, 2016

#### For Click-to-Run installations of Office 2016

This is fixed in version 16.0.6741.1014 of Office 2016 for the Current Channel and First Release Deferred Channel. By default, Click-to-run installations are automatically updated.

Make sure that your Office 2016 Click-to-Run installation is at version 16.0.6741.1014 or later. If it's not, update your Office 2016 installation. To do this, follow these steps:

1. Start any Office application, such as Outlook or Word.   
2. Click **File**, and then click **Office Account** or **Account**.   
3. Under **Office Updates**, view the version.    
4. If the version isn't at 16.0.6741.1014 or later, click **Update Options**, and then click **Update Now**.   

For more information about update channels for Office 365 clients, see [Version numbers of update channels for Office 365 clients](https://technet.microsoft.com/library/mt592918.aspx?f=255&mspperror=-2147217396).

### Outlook 2013

Install the December 8, 2015 update for Outlook 2013. For more information, see the following Microsoft Knowledge Base article:

[3114349](https://support.microsoft.com/help/3114349) December 8, 2015, update for Outlook 2013 (KB3114349) 

> [!NOTE]
> You must be running Outlook version 15.0.4779.1001 or a later version to install this update.

## Workaround 

If you can't install the update that's mentioned in the "Solution" section for Outlook 2016, you can use the following workaround. 

### Outlook 2016: Exclude the root domain from Autodiscover lookup in Outlook

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur. 

To prevent Outlook 2016 from using the root domain of the user's SMTP address to locate the Autodiscover service, set the ExcludeHttpsRootDomain registry subkey to a value of **1**. To do this, follow these steps:

1. Open Registry Editor.    
2. Locate and then click the following registry subkey:

    **HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Autodiscover**
1. On the **Edit** menu, point to **New**, and then click **DWORD Value**.   
1. Type ExcludeHttpsRootDomain, and then press Enter.   
1. On the **Edit** menu, click **Modify**, type 1 in the **Value data** box, and then click **OK**.   
1. Exit Registry Editor.   

## More information

For more information, see the following Microsoft Knowledge Base article:

[2212902](https://support.microsoft.com/help/2212902) Unexpected Autodiscover behavior when you have registry settings under the \Autodiscover key 

### How to determine whether you have a Click-to-Run or MSI installation

On the **File** tab in Outlook, click **Office Account** or **Account**. 
- If you see **Office Updates** in the **Product Information** area, you have a Click-to-Run installation    
- If you do notsee **Office Updates** in the **Product Information** area, you have an MSIinstallation.   

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).