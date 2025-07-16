---
title: Office for Mac activation An unknown error has occurred
description: Troubleshooting steps when an error occurs when trying to activate Office for Mac.
author: Cloud-Writer
ms.reviewer: vikkarti
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\An unknown error has occurred. error code is: 0x
  - CSSTroubleshoot
  - CI 157588
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 06/06/2024
---

# Office for Mac activation error: "An unknown error has occurred"

When you're trying to activate Microsoft 365 on a Mac, you might encounter the message "An unknown error has occurred" followed by an error code.

Before trying the following troubleshooting steps, make sure the internet is working on the Mac you're trying to activate on. You can do this by opening your internet browser and going to `https://microsoft.com`. If the page loads, your internet connection is working.

## For error code 0xD0001043

This is a server issue that occurs when trying to activate Microsoft 365 for Mac. Try restarting your Mac and activate again. If you're still seeing this error, try this:

1. Run the [Office for Mac License Removal Tool](https://support.microsoft.com/en-us/office/how-to-remove-office-license-files-on-a-mac-b032c0f6-a431-4dad-83a9-6b727c03b193).

1. [Uninstall Office for Mac](https://support.microsoft.com/office/uninstall-office-for-mac-eefa1199-5b58-43af-8a3d-b73dc1a8cae3) and then reinstall Office from https://office.com/signin.

1. Restart your Mac and then activate Office.

## For error code 0xD000001c

If you're trying to activate Office for Mac and have received error code 0xD000001c, this is because your Mac's name contains invalid characters when being sent to our server. To fix this issue, update your Mac's name to remove the invalid characters:

1. In the top menu bar, select the Apple icon > **System Preferences** > **Sharing** (third row.)

1. In the **Computer Name** text box, update your Mac's name and then close the window.

1. Restart your Mac, and then activate Office.

## For error code 0x8A010101

See [Error 0x8A010101 when activating Office for Mac](https://support.microsoft.com/office/error-0x8a010101-when-activating-office-for-mac-804de2bd-12d8-40a9-95fd-03dc3e4d262f).

**For other error codes**, or if the steps above didn't solve the problem, try the following troubleshooting methods.

## Make sure Office for Mac is updated

See [Update history for Office for Mac](/officeupdates/update-history-office-for-mac).

## Use the Mac License removal tool

See [How to remove Office license files on a Mac](https://support.microsoft.com/office/how-to-remove-office-license-files-on-a-mac-b032c0f6-a431-4dad-83a9-6b727c03b193).

## Sign in with your local user account

If you've signed in to your Mac using a Network account such as Open directory accounts, this error might occur because Office for Mac can't write your credentials into the keychain as it is "read-only."  

1. If you're signed in with a network account, sign out and sign back in with your local user account. Try activation again.  

1. If you don't have a local user account, you must create one:  

    - From the Apple menu, select **System Preferences** > **Users & Groups**.  

    - Select **Click the lock to make changes**, and type your password. Select **Unlock**.  

    - Select **+**, and then fill in the new account information, and then select **Create User**.  

    - Log in to your local user account and activate again.  


## References

- [What to try if you can't install or activate Office for Mac](https://support.microsoft.com/office/what-to-try-if-you-can-t-install-or-activate-office-for-mac-5efba2b4-b1e6-4e5f-bf3c-6ab945d03dea)
