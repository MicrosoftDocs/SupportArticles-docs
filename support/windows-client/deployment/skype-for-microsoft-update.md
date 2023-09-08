---
title: Skype for Microsoft Update
description: Describes how to keep Skype updated through Microsoft Update and through the Upgrade function in Skype.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:servicing, csstroubleshoot
ms.technology: windows-client-deployment
---
# Skype for Microsoft Update

This article describes how to keep Skype updated through Microsoft Update and through the Upgrade function in Skype.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2876229

## Summary

Skype releases new versions of Skype for Windows throughout the year. To help you stay current with new functionality and features of the Skype experience, Skype is available through Microsoft Update.

Skype includes the following:

- Chat every day with free instant messages.
- Share photos and see them inline, right in the chat.
- See your family come together over a free group video call.
- Switch between calling and messages - or do both at the same time.
- Make low-cost calls and text messages to mobiles and landlines

To make it simple and fast for Skype users to upgrade to the latest version of Skype for Windows, we've integrated Skype into Microsoft Update. If you have Skype installed on your PC already, either directly from [Skype website](https://www.skype.com/) or through a preinstalled version on your PC, you'll receive the latest version of Skype through Microsoft Update.

## More information

To check whether Skype is already installed on your PC, follow these steps:

1. Select **Start**, select **Run**, type *regedit* in the **Open** window, and then select **OK**.
2. In the navigation pane of the **Registry Editor** window, look for the following registry key: `HKEY_CURRENT_USER\Software\Skype\Phone`

3. If the registry key exists, select the `Phone` folder. If the registry key doesn't exist, Skype isn't installed on the computer.
4. In the main pane of the **Registry Editor** window, you should see an entry that is named `SkypePath`. The value in the **Data** column will tell you where Skype is installed on the computer. If the `SkypePath` entry doesn't exist, go to step 5.
5. If the `SkypePath` key doesn't exist, look for the following registry key, and then repeat steps 3 and 4: `HKEY_LOCAL_MACHINE\Software\Skype\Phone`

> [!NOTE]
> If the `HKEY_CURRENT_USER\Software\Skype\Phone` key doesn't exist, and if the `HKEY_LOCAL_MACHINE\Software\Skype\Phone` key does exist, Skype was installed from an administrator account but was not used from the current account. If neither key exists, Skype is not installed on the computer.

If you're planning to upgrade from an earlier version of Skype for Windows, you can learn more about the updates on the [Skype blog](https://www.skype.com/en/blogs/).

You can obtain the update in two ways:

- Through Microsoft Update.
- Through the Upgrade function in the Skype application. To use the Upgrade function, follow these steps:
  1. On the menu bar, select **Help**, and then select **Check for Updates**.
  2. After you check the version, select **Download**, and then select **Upgrade**.

> [!NOTE]
> Skype will automatically be updated only on PCs on which Skype is already installed. Skype will not automatically be updated on any PC that doesn't already have Skype installed.

How can I install the latest version of Skype for Windows?

To install Skype for Windows, follow these steps:

1. Download the latest version from the [Skype website](https://www.skype.com/).
2. Select **Run** to run Skype directly from your browser.
3. Follow the steps in the setup wizard to complete the installation.
4. Start Skype, and then sign in by entering a [Microsoft Account](https://support.skype.com/en/faq/fa12059/what-is-a-microsoft-account?frompage=search&q=microsoft+account&fromsearchfirstpage=false) user name and password.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
