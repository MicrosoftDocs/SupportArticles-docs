---
title: Users can't sign in to Skype for Business Online by using Lync Mobile 2013
description: Describes the conditions under which users can't use Microsoft Lync Mobile 2013 to sign in to Microsoft Skype for Business Online. Provides a solution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.reviewer: dahans
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
---

# Users can't sign in to Skype for Business Online by using Lync Mobile 2013

## Problem

When you try to sign in to Lync Mobile 2013, you may receive one of the following error messages:

- Can't sign in. Please check your account information and try again.   
- Can't connect to the server right now. Please try again.   
- The server name or sign-in address is incorrect. Please check them and retry.

## Solution

You can resolve most sign-in issues in Lync Mobile 2013 by following these steps:

1. Make sure that the sign-in address and password are entered correctly. In most cases, the domain and user name are not required.   
2. Expand **More Details**, and then click **Clear My Sign-in Info** to remove any cached server names or sign-in addresses.   
3. Office 365 Skype for Business Online (formerly Lync Online) administrators can use the [Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/) to make sure that the necessary DNS records for Skype for Business Online are configured. To do this, click the **Office 365** tab, and then click **Office 365 Lync DNS Test**. 

   For more information, see [Troubleshooting Skype for Business Online DNS configuration issues in Office 365](https://support.microsoft.com/help/2566790).   
4. Switch between Wi-Fi and carrier data to try to isolate the issue. Verify connectivity to other websites and services over both kinds of connections.   
5. Try to sign in by using other clients and computers.
6. You recently updated the Operating System (OS) software for your device. Before you applied the update, the Lync Mobile 2013 client worked as expected. After you installed the update, the Lync Mobile 2013 client fails. Be aware that after you contact Microsoft technical support for help, you may have to contact the manufacturer of your device to obtain the correct resources for the issue.   

## More Information

These errors may occur for one or more of the following reasons:

- The user's credentials aren't correct. Either the password is incorrect or the sign-in address was entered incorrectly.   
- The server is too busy or unreachable over your current connection.   
- The server can't be found, based on the sign-in address. Either the domain was typed incorrectly or the necessary DNS records for mobile connectivity aren't set up.   
- You installed updated OS software and resources or settings may have to be configured for Lync Mobile 2013 to work correctly.   

For help with the Microsoft Lync Mobile 2010 clients, see the following Microsoft Knowledge Base articles:

- [2636329 ](https://support.microsoft.com/help/2636329) "Cannot connect to the server" error message when Skype for Business Online users try to sign in to the Lync 2010 mobile client on a mobile device   
- [2636318 ](https://support.microsoft.com/help/2636318) How to troubleshoot issues that you may encounter when you use the Lync 2010 mobile client for Windows Phone 7   
- [2636320 ](https://support.microsoft.com/help/2636320) How to troubleshoot issues that you may encounter when you use the Lync 2010 mobile client for Apple iOS   
- [2636313 ](https://support.microsoft.com/help/2636313) How to troubleshoot issues that you may encounter when you use the Lync 2010 mobile client for Google Android   
- [2636322 ](https://support.microsoft.com/help/2636313) How to troubleshoot issues that you may encounter when you use the Lync 2010 mobile client for Nokia Symbian    

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).