---
title: Lync becomes the default application for protocols after user signs in
description: Describes an issue in which the registry settings for multiple protocols are overwritten. This causes Lync 2013, Lync 2010, or Office Communicator 2007 R2 to become the default application for these protocols. This issue occurs after you sign in to the client of any of these applications.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: v-six
ms.reviewer: pankajr， genli
appliesto: 
  - Office Communicator 2007 R2
  - Lync 2010
  - Lync 2013
ms.date: 03/31/2022
---

# Lync 2013, Lync 2010, or Office Communicator 2007 R2 becomes the default application for protocols after user signs in

## Summary

When you sign in to Microsoft Lync 2013, Microsoft Lync 2010, or Microsoft Office Communicator 2007 R2, registry settings for the following protocols are overwritten: 

- TEL   
- CALLTO   
- SIP   
- SIPS   
- IM   
- CONF   

When this occurs, the application that you signed in to becomes the default application that supports these protocols. 

##  Workaround

By default, the protocols give priority to use the Microsoft unified communications (UC) clients that are described in the "Symptoms" section. This may affect usability of third-party UC client software. 

To work around this issue, you must configure registry settings for these protocols. To do this, follow these steps.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Open Registry Editor. To do this, follow these steps:
   1. In Windows 8.0 or Windows 8.1, press the Windows Function key to open the **Start** screen. If you are running Windows 7, click **Start**.   
   2. Search for regedit.exe by using the Windows Search feature.   
   3. Right-click regedit.exe, and then click **Run as administrator**.     
2. If you have installed Lync 2010 or Office Communicator 2007 R2, locate and then right-click the following registry subkey:

   **HKEY_CURRENT_USER\Software\Microsoft\Communicator**

   If you have installed Lync 2013, locate and then right-click the following registry subkey:

   **HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Lync**   
1. Point to **New**, and then click **DWORD (32-bit) Value**.   
1. Type DisabledProtocolHandlerRegistrations as the name of the new registry entry, and then press Enter.   
1. Input the correct information about the third-party application that you want in the registry. For example, to change the default application that supports SIP from Office Communicator 2007 R2 to a third-party application that you want, follow these steps:
   1. Locate and then click the following registry subkey:

      **HKEY_CURRENT_USER\Software\Classes\sip\shell\open\command**
   1. Double-click the default registry entry. Then, change the value to reflect the application that you want to use instead of the Microsoft UC clients.

      **Note** The default value in the registry entry points to the Microsoft UC client.
  
   1. Prevent Microsoft UC client information from being rewritten to the registry setting that you changed in step B. To do this, add one of the following values to the DisabledProtocolHandlerRegistrations registry entry:
      - TEL: 0x0001   
      - CALLTO: 0x0002   
      - SIP: 0x0004   
      - SIPS: 0x0008   
      - IM: 0x0010   
      - CONF: 0x0020   

   > [!NOTE]
   > - You can sum the values in the list if you want to prevent a Microsoft UC client from being the default application for multiple protocols. For example, to prevent the Microsoft UC client from being the default application for SIP, enter 0x0004. To prevent the Microsoft UC client from being the default application for CALLTO, enter 0x0002. To prevent the Microsoft UC client from being the default application for both SIP and CALLTO, enter 0x0006. To prevent the Microsoft UC client from being the default application for all the protocols, enter 3f.   
   > - The values in the DisabledProtocolHandlerRegistrations registry entry will be unavailable if you change them when you sign in to the Microsoft UC client.       
   
6. Sign in to the Microsoft UC client. Make sure that the client has not overwritten the registry data that you modified in the previous steps. 

   For example, if you use a third-party application as the default application for SIP, make sure that the application is in the registry under the following registry subkey:

   **HKEY_CURRENT_USER\Software\Classes\sip\shell\open\command**   
7. Make sure that the value in in the DisabledProtocolHandlerRegistrations registry entry is correct. For example, the value for SIP should be 0x0004.   

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
