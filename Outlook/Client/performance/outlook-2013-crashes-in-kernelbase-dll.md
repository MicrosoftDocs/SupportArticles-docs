---
title: Outlook crashes in KERNELBASE.dll due to corrupt data file
description: Resolves the Outlook 2013 crash issue in KERNELBASE.dll due to corrupt data file.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tmoore, gregmans
appliesto: 
  - Outlook 2013
search.appverid: MET150
ms.date: 10/30/2023
---
# Outlook 2013 crashes in KERNELBASE.dll due to corrupt data file

_Original KB number:_ &nbsp; 3002649

## Symptoms

Microsoft Outlook 2013 crashes. If you then review the events in the Application Event log, you find any of the following crash signatures for Event ID 1000.

| Faulting application name| Faulting module name| Faulting module version| Offset |
|---|---|---|---|
|Outlook.exe|KERNELBASE.dll|6.2.9200.16384|0x00000000000A43DA|
|Outlook.exe|KERNELBASE.dll|6.3.9600.17055|0x00000000000D9E3A|
|Outlook.exe|KERNELBASE.dll|6.3.9600.17055|0x000B3425|
|Outlook.exe|KERNELBASE.dll|6.1.7601.18229|0x00013219|
|Outlook.exe|KERNELBASE.dll|6.3.9600.17278|0x00000000000DA26A|
|Outlook.exe|KERNELBASE.dll|6.3.9600.16656|0x000B33B7|
|Outlook.exe|KERNELBASE.dll|6.3.9600.17055|0x000B9DFA|
|Outlook.exe|KERNELBASE.dll|6.3.9600.17031|0x000B34C5|
|Outlook.exe|KERNELBASE.dll|6.3.9600.17278|0x000B3C5F|
|Outlook.exe|KERNELBASE.dll|6.3.9600.16384|0x000B2BCD|
|Outlook.exe|KERNELBASE.dll|6.3.9600.16408|0x00000000000D9532|

## Cause

This behavior has been seen by Microsoft Support as the result of a corrupt Personal Data File (PST) or Offline Data File (OST) in the affected Outlook profile.

## Resolution - Create a new Outlook profile

Use the steps below to create a new Outlook profile.

1. Exit Outlook (if running).
2. Launch Control Panel.

    **In Windows 8 and Windows 8.1**

    Swipe in from the right to open the charms, tap or select **Search**, and then type *control panel* in the search box.
    Or, type *control panel* at the **Start** screen, and then tap or select Control Panel in the search results.

    **In Windows Vista and Windows 7**

    Select **Start**, type *Control Panel* in the **Start Search** box, and then press Enter.

3. In Control Panel, select **View by**, and then select **Small icons**.
4. Double-click **Mail**.

    > [!NOTE]
    > If you have more than one version of Outlook installed you may see two icons labeled **Mail** in Control Panel, as shown in the following figure.
    >
    > :::image type="content" source="media/outlook-2013-crashes-in-kernelbase-dll/two-icons-labeled-mail-in-control-panel.png" alt-text="Screenshot of two icons labeled Mail in Control Panel 1.":::
    >
    > In this situation, double-click the icon for the version of Outlook that is crashing

5. Select **Show Profiles**, and select **Add**.
6. Enter a name for the new profile and select **OK**.
7. In the **Add New Account** dialog, if Your Name and E-mail Address are correctly populated, select **Next**; otherwise change the e-mail address and update additional information as necessary, and select **Next**.
8. Once the configuration completes, you can select **Add another account** or select **Finish**.
9. Select **Prompt for a profile to be used**, or select **Always use this profile**, select the new profile from the dropdown, as shown in the following figure.  

    :::image type="content" source="media/outlook-2013-crashes-in-kernelbase-dll/new-test-profile.png" alt-text="Screenshot of the new profile option from the dropdown." border="false":::

10. Select **OK**, and restart Outlook.

If a new Outlook profile resolves the issue, you may wish to return to your original profile. However, you will need to remove PST files from the original profile or create a new OST file for the original profile. Select one of the links below for steps to accomplish either of these changes.

[Remove PST files from original profile](#remove-psts-from-the-outlook-profile)

[Create new OST file for original profile](#recreate-the-ost-in-the-outlook-profile)

### Remove PSTs from the Outlook profile

If you have one or more pst files in your profile, you can use the following steps to remove them.

1. Exit Outlook (if running).
2. Launch Control Panel.

    **In Windows 8 and Windows 8.1**

    Swipe in from the right to open the charms, tap or select **Search**, and then type *control panel* in the search box.
    Or, type *control panel* at the **Start** screen, and then tap or select Control Panel in the search results.

    **In Windows Vista and Windows 7**

    Select **Start**, type *Control Panel* in the **Start Search** box, and then press Enter.

3. In Control Panel, select **View by**, and then select **Small icons**.
4. Double-click **Mail**.

    > [!NOTE]
    > If you have more than one version of Outlook installed you may see two icons labeled **Mail** in Control Panel, as shown in the following figure.
    >
    > :::image type="content" source="media/outlook-2013-crashes-in-kernelbase-dll/two-icons-labeled-mail-in-control-panel.png" alt-text="Screenshot of two icons labeled Mail in Control Panel 2.":::
    >
    > In this situation, double-click the icon for the version of Outlook that is crashing.

5. Select **Show Profiles**, select the affected Outlook profile, and then select **Properties**.
6. Select **Data Files**, and then note the location of any PST files you have in the list.
7. Select a PST file in the list, and then select **Remove**.

    > [!NOTE]
    > This does not delete the PST file, but only removes it from the currently selected profile.

8. Close all Mail Control Panel windows, and restart Outlook.
9. If the problem no longer occurs, you have identified the problematic PST.

    You can attempt to recover the affected PST using the Inbox Repair Tool (Scanpst.exe) as described in the article [How to repair your Outlook personal folder file (.pst)](../data-files/how-to-repair-personal-folder-file.md).

10. If the behavior persists, repeat steps 1 through 9 for additional PST files (as needed).

### Recreate the OST in the Outlook profile

1. Exit Outlook (if running).
2. Launch Control Panel.

    **In Windows 8 and Windows 8.1**

    Swipe in from the right to open the charms, tap or select **Search**, and then type *control panel* in the search box.
    Or, type *control panel* at the **Start** screen, and then tap or select Control Panel in the search results.

    **In Windows Vista and Windows 7**

    Select **Start**, type *Control Panel* in the **Start Search** box, and then press Enter.

3. In Control Panel, select **View by**, and then select **Small icons**.
4. Double-click **Mail**.

    > [!NOTE]
    > If you have more than one version of Outlook installed you may see two icons labeled **Mail** in Control Panel, as shown in the following figure.
    >
    > :::image type="content" source="media/outlook-2013-crashes-in-kernelbase-dll/two-icons-labeled-mail-in-control-panel.png" alt-text="Screenshot of two icons labeled Mail in Control Panel 3.":::
    >
    > In this situation, double-click the icon for the version of Outlook that is crashing.

5. Select **Show Profiles**, select the affected Outlook profile, and then select **Properties**.
6. Select **Data Files** and then note the location of the OST file in the list.
7. Select the OST file in the list, then select **Open File Location**.

    A Windows Explorer window should open with the chosen OST file selected.

8. Leave the Explorer window open, and select **Close on the Account Settings Data Files** window in the **Mail Control Panel**.

    > [!NOTE]
    > You must close the **Account Settings Data Files** window in order to complete step 9 below. If this window is not closed, you will receive the following error message when attempting to rename the file:
    >
    > The action can't be completed because the file is open in Windows host process (Rundll32)  
    > Close the file and try again.

9. Right-click the selected OST file in Windows Explorer, select **Rename**, type a new name for the OST, and press Enter.
10. Close the Windows Explorer window and any remaining Mail Control Panel windows, and restart Outlook.

    This will create a new OST, which may take some time to synchronize with the mailbox on the server, depending on the size of the mailbox.

> [!NOTE]
> The information contained herein is provided as-is in response to emerging issues. As a result of the speed in making it available, the materials may include typographical errors and may be revised at any time without notice. See [Terms of Use](/legal/termsofuse) for other considerations.

## More information

You can use the following steps to review the Application event log:

1. In Control Panel, open Administrative Tools.
2. Double-click **Event Viewer**.
3. In the left pane, select **Application under Windows Logs**.
4. In the **Actions** pane, select **Filter Current Log**.
5. In the **Filter Current Log** dialog box, enter *1000* (as shown in the following figure) and then select **OK**.

   :::image type="content" source="media/outlook-2013-crashes-in-kernelbase-dll/enter-1000-into-task-category.png" alt-text="Screenshot of the Filter Current Log dialog box.":::
