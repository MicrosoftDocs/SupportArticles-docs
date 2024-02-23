---
title: Room Finder isn't available on shared calendars that have multiple accounts added to Outlook profile
description: When you access an existing meeting on a shared calendar that you are a delegate for, Outlook doesn't respond if you select the Room Finder button.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CI 111779
  - CSSTroubleshoot
ms.reviewer: gabesl, aruiz
appliesto: 
  - Outlook for Microsoft 365
search.appverid: 
  - MET150
ms.date: 10/30/2023
---

# Room Finder isn't available on shared calendars when multiple Exchange accounts are added to the same Outlook profile

## Symptom

When you access an existing meeting on a shared calendar that you are a delegate for, Outlook doesn't respond if you select the **Room Finder** button. However, when you access existing meetings on your own calendar, Outlook responds as expected.

## Cause

This issue occurs after you add an additional Exchange account to your Outlook profile. To verify the additional account, follow these steps:

1. On the **File** menu, select **Info**.
2. Select **Account Settings**, and then select **Account Settings**.

:::image type="content" source="./media/room-finder-is-not-available-shared-calendars-outlook/outlook-account-setting.png" alt-text="Screenshot of the Email tab on Account Settings window.":::

In this example, the delegate has added a second Exchange email account to the Outlook profile.

## Workaround

If all your delegate mailboxes need to be accessed from the same Outlook profile, and if you have Full Access permission to the additional Exchange account, use the following workaround:

1. Remove the second Exchange account from your profile

    - On the **File** menu, select **Info**.
    - Select **Account Settings**, and then select **Account Settings**.
    - Select the account that you want to remove, and then select **Remove**.
    - Select **Yes** when you are prompted to confirm that you want to remove the account.
    - In the **Account Settings** dialog box, select Close.

2. Add the second mailbox as an additional mailbox to the primary email account. (An additional mailbox is different from an additional account.)

    - On the **File** menu, select Info.
    - Select **Account Settings**, and then select **Account Settings**.
    - Select your primary account, and then select **Change**.
    - In the **Change Account** dialog box, select **More Settings**.
    - On the **Advanced** tab, select **Add**.
    - Enter the name of the mailbox, and then select **OK**. After you make this change, the additional mailbox is listed on the **Advanced** tab in the **Microsoft Exchange** dialog box.
    - In the **Microsoft Exchange** dialog box, select **OK**.
    - In the **Change Account** dialog box, select **Next**.
    - Select **Finish**, and then select **Close**.
