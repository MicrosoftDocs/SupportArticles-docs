---
title: AutoComplete not working correctly
description: AutoComplete not working correctly? Fix AutoComplete not working with a few clicks of the mouse.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 10/30/2023
---
# AutoComplete not working correctly in Outlook 2010

_Original KB number:_ &nbsp; 2682333

## Resolution

AutoComplete (not to be confused with Suggested Contacts) displays names and email addresses as you start to type them. These are possible matches to names and email addresses gathered from the email that you have sent in the past. If AutoComplete isn't working, try these fixes:

### Check to see if AutoComplete is turned on

Here's how to see if AutoComplete is turned on:

1. In Outlook, select **File** > **Options**.
2. Select the **Mail** tab.
3. Scroll roughly halfway down until you see Send messages. Ensure the Use AutoComplete List to suggest names when typing in the To, Cc, and Bcc lines box is checked.

   :::image type="content" source="media/autocomplete-not-working-correctly-in-outlook-2010/check-if-autocomplete-is-turned-on.png" alt-text="Screenshot of the Send messages window, and the Use Auto-Complete List to suggest names when typing in the To, Cc, and Bcc lines box is checked.":::

4. If it's already turned on, your first troubleshooting step should be to clear out the Auto-Complete list. Select the **Empty AutoComplete List** button.
5. You'll see a confirmation window about clearing the AutoComplete list, select **Yes**.
6. Try sending a few test emails to the same email address. If AutoComplete doesn't start working, try the other steps listed in this article.

## If you have a home email account

If AutoComplete is enabled and still not working correctly, there may be a problem with a file in your RoamCache folder. Rename the folder to reset AutoComplete. To do this, follow these steps:

> [!WARNING]
> You will lose all addresses stored in AutoComplete.

1. Start Outlook.
2. Select **File** > **Info** > **Account Settings**.
3. An Account Settings window will open, if it says Microsoft Exchange (under Type), use the Microsoft Exchange Server accounts portion of this article.
4. Exit Outlook.
5. Next we need to find the Outlook folder.
6. Select **Start**, type in or copy and paste %LOCALAPPDATA%\Microsoft\Outlook into **Search program and files**.

   :::image type="content" source="media/autocomplete-not-working-correctly-in-outlook-2010/search-program-and-files.png" alt-text="Screenshot shows the path pasted in Search program and files.":::

7. Select the Outlook folder listed at the top of the window.

   :::image type="content" source="media/autocomplete-not-working-correctly-in-outlook-2010/select-the-outlook-folder.png" alt-text="Screenshot of the search result which the Outlook folder is listed at the top of the window.":::

8. Right-click the RoamCache folder, select **Rename**, and change the folder name to *old_RoamCache*.

   :::image type="content" source="media/autocomplete-not-working-correctly-in-outlook-2010/change-the-roamcache-folder-name.png" alt-text="Screenshot of the RoamCache folder under the Outlook folder which you can rename.":::

9. When Outlook restarts, it will create a new RoamCache folder.
10. Start Outlook.

## iTunes, Outlook Change Notifier add-in interfering with Auto-Complete

iTunes also installs an add-in called Outlook Change Notifier. If you have iTunes Version 10.0.0.22, it had several issues that caused Outlook to not shut down gracefully, causing AutoComplete to not work correctly. Updating your iTunes software to version 10.1.0.56 or newer will take care of the Outlook Change Notifier issue.

If you no longer use iTunes or want to manually disable the add-in:

1. From within Outlook, select **File** > **Options** and select **Add-Ins**.
2. At the bottom of the dialog press the button **Go...**.
3. Scroll down the list until you find **Outlook Change Notifier** and uncheck it.
4. Press **OK** to confirm and close the dialog.

## If you have a Microsoft Exchange Server account

If Auto-Complete is enabled and still not working correctly, there may be a problem with a file in your RoamCache folder. Rename the folder to reset AutoComplete. To do this, follow these steps:

> [!WARNING]
> You will lose all addresses stored in AutoComplete.

1. Open Outlook
2. Select **File** > **Info** > **Account Settings**.
3. An Account Settings window will open, if does not say Microsoft Exchange (under Type), use the home email account portion of this article.
4. Prepare Outlook to run without Cached Exchange Mode.
   1. Select the **File** tab, and then select **Account Settings**.
   2. Select **Account Settings**.
   3. Select your Microsoft Exchange Server account, and then select **Change**.
   4. Clear the **Use Cached Exchange Mode** check box, select **Next**, and then select **Finish**.
   5. On the **Account Settings** dialog box, select **Close**.
5. Exit Outlook.
6. Next we need to find the Outlook folder.
7. Select **Start**, type in or Copy and Paste %LOCALAPPDATA%\Microsoft\Outlook into Search program and files.

   :::image type="content" source="media/autocomplete-not-working-correctly-in-outlook-2010/search-program-and-files.png" alt-text="Screenshot shows the path pasted in Search program and files.":::

8. Select on the Outlook folder listed at the top of the window.

   :::image type="content" source="media/autocomplete-not-working-correctly-in-outlook-2010/select-the-outlook-folder.png" alt-text="Screenshot of the search result of step 7, which shows the Outlook folder on the top.":::

9. Right-click the RoamCache folder, select **Rename**, and change the folder name to *old_RoamCache*.

   :::image type="content" source="media/autocomplete-not-working-correctly-in-outlook-2010/change-the-roamcache-folder-name.png" alt-text="Screenshot of the selected RoamCache folder under the Outlook folder.":::

10. When Outlook restarts, it will create a new RoamCache folder.
11. Start Outlook.
12. Turn on Cached Exchange Mode.
    1. Select the **File** tab, and select **Account Settings**.
    2. Select Account Settings.
    3. Highlight your Microsoft Exchange Server account, and then select **Change**.
    4. Select the **Use Cached Exchange Mode** check box, select Next, and then select **Finish**.
    5. On the **Account Settings** dialog box, select **Close**.
13. Exit and then restart Outlook.

What is the difference between AutoComplete and Suggested Contacts

Outlook also adds a folder to Contacts labeled Suggested Contacts. Addresses get added to this folder as you send or reply to messages addressed to people who don't exist in your Contacts folder. Outlook doesn't look in Suggested Contacts for names during the AutoComplete process. It only stores addresses that you might want to add to your Contacts. You can double-click an entry in Suggested Contacts and a Contact Form opens that allows you to save it to your Contacts Folder.

Need more help?

Get help from the [Microsoft Community](https://answers.microsoft.com/) online or visit contact [Microsoft Support](https://support.microsoft.com/contactus/?ws=support) to learn more about your support options.
