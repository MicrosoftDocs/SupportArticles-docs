---
title: We can't start this app when installing an Office add-in
description: Describes an issue that installing an Office Add-in from the Office Store fails with error.
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
- Office 365
- Office 2019
- Office 2016
- Office 2013
---

# "We can't start this app..." error installing an Office add-in

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you attempt to install an Office Add-in from the Office Store you receive the following error:

*We can't start this app because it isn't set up properly. This error is shown in the following image.*

![error message dialog box](./media/cannot-install-office-add-in/app-error.png)

## Cause

This problem occurs because of incorrect information in the Windows registry.

## Resolution

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To resolve this problem, please follow these steps. 

1. Exit any open Office programs.    
2. Start Registry Editor. To do this, press the Windows key+R to open the Run window, type regedit in the Open box, and then press OK.    
3. In Registry Editor, locate and then click the following subkey:

    HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\WEF\Providers

    > [!NOTE]
    > Replace x.0 with your version of Office (16.0 = Office 365, Office 2019, Office 2016, and 15.0 = Office 2013).    
4. Select the first subkey under \Providers (for example,\KpwDSnL9jumf9ZJTx_XF_Q==).    
5. Examine the data value for the UniqueID value. You are looking for either of the following values:

    - *guid*_ADAL
    
    - Anonymous

    > [!NOTE]
    > The *guidpreceding* _ADAL is a random set of numbers and letters (for example, 3a975b5d-ad3e-4e3d-84b0-a7e6776ba6a6). 
6. If the data value for UniqueID is either guid_ADAL or Anonymous, delete the parent subkey of UniqueID.

    For example, if UniqueID = 3a975b5d-ad3e-4e3d-84b0-a7e6776ba6a6_ADAL under the \KpwDSnL9jumf9ZJTx_XF_Q== subkey, then you would delete the \KpwDSnL9jumf9ZJTx_XF_Q== subkey.
7. Repeat steps 4-6 for each subkey under the \Providers key.    
8. Exit Registry Editor.    
9. In Windows Explorer, delete the \Wef folder under the following path:

    C:\users\username\AppData\Local\Microsoft\Office\x.0\Wef

    > [!NOTE]
    > *username* is your user name and x.0 is your Office version.

    If you are unable to manually locate the above folder, press the Windows key+R to open the Run window, type the command below for your version of Office in the Open box, and then press OK:  
      - Office 365, Office 2019 and Office 2016
    
        %localappdata%\microsoft\office\16.0\WEF    
      - Office 2013
    
        %localappdata%\microsoft\office\15.0\WEF    
     
