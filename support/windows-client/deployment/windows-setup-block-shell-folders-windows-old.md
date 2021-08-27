---
title: Windows setup block if shell folders are redirected to Windows.old
description: Provides a workaround to the issue in which Windows setup is blocked when shell folders are redirected to Windows.old.
ms.date: 8/27/2021
author: v-lianna 
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, arrenc, v-erchev, zhongyl, carladi, josr, calinn, aaronfa, jtrox
ms.prod-support-area-path: Setup
ms.technology: windows-client-deployment
---
# Windows setup is blocked when shell folders are redirected to Windows.old

_Original KB number:_ &nbsp; 4616084

When performing an in-place upgrade to Windows 10, version 20H2, Windows 10, version 20H1, or Windows 10, version 2004, you receive this error message:

> This PC can't be upgraded to Windows 10.  
> Your PC settings need to be adjusted before upgrading to the latest version of Windows 10.

:::image type="content" source="media/windows-setup-block-shell-folders-windows-old/windows-setup-bolck-error.png" alt-text="The screenshot of the setup block error.":::

This issue occurs when a user shell folder on the device has been configured to use the *Windows.old* folder. During the in-place upgrade process, the *Windows.old* folder will be deleted and replaced with the current *Windows* folder.

If you perform an in-place upgrade within the first 10 days of the last upgrade, the new upgrade will overwrite the *Windows.old* folder. If you upgrade more than 10 days after the last upgrade, the *Windows.old* folder will be cleaned up automatically. In both cases, the redirected user shell folders won't contain any data. The setup block is applied to prevent data loss.

## Copy and move the Windows.old content to a new location

Here's how to mitigate the safeguard. Follow these steps for each user profile on the device:

1. Go to Search, type *File Explorer*, and then select **File Explorer**.
2. On the left pane, select **This PC**.
3. In the **Folders** section on the right pane, select and hold (or right-click) a folder, and then select **Properties** > **Location**.

    If the location path starts with *Windows.old*, select **Move…**, select the destination location to move the content to, and then select **Select Folder**.

    > [!NOTE]
    > You can also select **New Folder** in the **Select a Destination** dialog box to move the content to a new location.

4. Select **OK**, and then select **Yes** to answer the question ''**Do you want to move all the files from the old location to the new location?**''.
5. After the operation is completed, go back to step 3 for the next folder.

Before an in-place upgrade, make sure all user shell folders locations have been moved out of the *Windows.old* folder.

> [!NOTE]
> If no other safeguard affects the device, it might take up to 48 hours before the update is offered.

For more information about the redirection of user shell folders, see [How to redirect user shell folders to a specified path by using Profile Maker](https://support.microsoft.com/topic/how-to-redirect-user-shell-folders-to-a-specified-path-by-using-profile-maker-ed6289ae-1f9c-b874-4e8c-20d23ea65b2e).

## More information

User shell folders (for example, Desktop, Documents, or Downloads folders) are special Windows folders. They're used as the default location to save specific user data types. The default locations of these folders are *C:\\Users\\<user name\>\\*, but they can be redirected to other folder locations.

Don't use the *Windows.old* folder to keep any user data because Windows' [Disk Cleanup](https://support.microsoft.com/windows/disk-cleanup-in-windows-10-8a96ff42-5751-39ad-23d6-434b4d5b9a68) might delete it.
