---
title: Can't remove a mobile device partnership
description: Provides a workaround for an issue in which you receive an error message when you try to remove a mobile device partnership from a user's mailbox by using the Exchange admin center in Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: svincent, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Items you're trying to open couldn't be found when you remove a mobile device partnership

_Original KB number:_ &nbsp; 2958418

## Problem

When you try to remove a mobile device partnership from a user's mailbox in the Exchange admin center in Exchange Online, you receive the following error message:

> The items you're trying to open couldn't be found

Additionally, when you connect to Exchange Online by using the remoting features in Windows PowerShell, and then you run the `Get-MobileDevice` cmdlet, the mobile device that you're trying to remove doesn't appear in the output. For example, you run the following command to retrieve the list of mobile devices that have a partnership with *Tony*'s mailbox, but the mobile device that you're trying to remove doesn't appear in the output:

```powershell
Get-MobileDevice -Identity "Tony"
```

## Workaround

Use the light version of Outlook Web App to remove the device from the user's mailbox. To do this, follow these steps:

1. Have the user sign in to Outlook Web App.
2. In the upper-right corner of the page, select **Settings** (:::image type="icon" source="media/cannot-remove-mobile-device-partnership/icon.png" border="false":::), and then select **Display settings**.
3. Click the **Outlook Web App version** tab, select the **Use the light version of Outlook Web App** check box, and then click **OK**.
4. Sign out of Outlook Web App, and then close all browser windows.
5. Open a new browser window, and then sign in to Outlook Web App.

    > [!NOTE]
    > Outlook Web App should open in the light version. If it doesn't, close the browser window, and then sign in again.

6. In the upper-right corner of the page, select **Options**.
7. In the left pane, select **Mobile Devices**, select the device that you want to remove, and then select **Remove Device from List**.
8. Click **Close**.

To return from the light version of Outlook Web App to the standard version, follow these steps:

1. In the upper-right corner of the page, select **Options**.
1. In the navigation pane, select **Outlook Web App version**, clear the **Use the light version of Outlook Web App** check box, and then click **Save**.
1. Sign out of Outlook Web App, close all browser windows, open a new browser window, and then sign in to Outlook Web App again.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
