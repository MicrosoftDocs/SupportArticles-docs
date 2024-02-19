---
title: Description of Shutdown Event Tracker
description: Describes the Shutdown Event Tracker.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, JEFFWADE, ScottMca
ms.custom: sap:event-system, csstroubleshoot
---
# Description of the Shutdown Event Tracker

This article describes the Shutdown Event Tracker.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 293814

## Summary

Shutdown Event Tracker is a Microsoft Windows Server 2003 and Microsoft Windows XP feature that you can use to consistently track the reason for system shutdowns. You can then use this information to analyze shutdowns and to develop a more comprehensive understanding of your system environment. Shutdown Event Tracker logs events that are similar to the following in the system event log:

## More information

- Windows Server 2003 and Windows XP 64-Bit Edition Version 2003

    By default, Shutdown Event Tracker is enabled for all Windows Server 2003 operating systems and for Windows XP 64-Bit Edition Version 2003.

    To disable Shutdown Event Tracker on all Windows Server 2003 operating systems and in Windows XP 64-Bit Edition Version 2003, disable the Display Shutdown Event Tracker policy by using Group Policy. To do it by using Local Group Policy, follow these steps:

    1. Select **Start**, and then select **Run**.
    2. Type gpedit.msc, and then select **OK**.
    3. Expand **Computer Configuration**, expand **Administrative Templates**, and then expand **System**.
    4. Double-click **Display Shutdown Event Tracker**.
    5. Select **Disabled**, and then select **OK**.

- Windows XP Professional

    By default, Shutdown Event Tracker is disabled in Windows XP Professional.

    To enable Shutdown Event Tracker in Windows XP Professional, in Windows XP Tablet PC Edition, and in Windows XP Media Center Edition, enable the Display Shutdown Event Tracker policy by using Group Policy. To do it by using Local Group Policy, follow these steps:

    1. Select **Start**, and then select **Run**.
    2. Type gpedit.msc, and then select **OK**.
    3. Expand **Computer Configuration**, expand **Administrative Templates**, and then expand **System**.
    4. Double-click **Display Shutdown Event Tracker**.
    5. Select **Enabled**.
    6. In the **Shutdown Event Tracker should be displayed** box, select **Always**, and then select **OK**.

    Shutdown Event Tracker isn't a functional component in Windows XP Home Edition. So you can't use Shutdown Event Tracker in Windows XP Home Edition.

    > [!NOTE]
    > Microsoft recommends that you don't enable the Shutdown Event Tracker in Windows XP Professional, Windows XP Tablet PC, or Windows XP Media Center Editions. Microsoft doesn't support the use of this component in these Windows XP environments.

## Custom Options for identifying a shutdown cause

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

Windows provides a list of eight generic reasons why your computer was shut down. You can modify this list to include your own custom reasons. To add your own reasons, follow these steps:

1. Start Registry Editor.
2. Locate and then select the following registry key:
    `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Reliability\UserDefined`
3. On the **Edit** menu, select **New**, and then select **Multi-String Value**. Which creates the new key and gives it the temporary name "New Value."
4. Type the name of the registry key in the following format, and then press **ENTER**:
    **UI_control_flags**; **major_reason_number**; **minor_reason_number**  
    The **UI_control_flags** section of the value name can contain one or more of the following values:
   - P (Indicates that the reason is planned. If this value is omitted, the default is *unplanned*.)
   - C or B (Indicates that a comment is required.)
   - S (Indicates that the reason should be displayed in the user-initiated shutdown dialog box.)
   - D (Indicates that the reason should be displayed in the sudden shutdown dialog box.)For example, if you want a reason to be displayed in the sudden shutdown dialog box, the shutdown is unplanned, and the shutdown corresponds to a major reason 2 and to a minor reason 2, type the following value name: D;2;2

5. Double-click the new key, and then define the value data in the following format:
    > Title  
    Description

    Each value is made up of two strings on separate lines; the first string is the title (it's displayed in the list) and the second string is the description (it's the text that is displayed following the selected reason).

    For example, if you want to create a custom reason for a natural disaster, you can define the value data as follows: Natural Disaster (unplanned)

    A flood, an earthquake, a tornado, or another unplanned natural event requires that the computer shuts down. Specify the natural event in the comment area.

6. Quit Registry Editor.

## Notes

- You can specify both **S** and **D** for **UI_control_flags**, but you must specify at least one of them for the parameters to be valid.
- If the **UI_control_flags** section contains any characters other than the characters that are listed in the "Custom Options for Identifying a Shutdown Cause" section of this article, or if the **UI_control_flags** section exceeds five characters, the message isn't valid and isn't displayed in the user interface. You can specify that the characters appear in any order.
- The **major_reason_number** is a number from 0 through 255. If this section is left blank, if it contains a number that isn't in the valid range, or if it contains a number that isn't an integer, the message isn't valid and isn't displayed in the user interface.
- The **minor_reason_number** is a number from 0 through 65,536. If this section is left blank, if it contains a number that isn't in the valid range, or if it contains a number that is not an integer, the message isn't valid and isn't displayed in the user interface.
- The custom reasons are sorted in the user interface by two keys in the following order: **MajorReasonNumber**, **MinorReasonNumber**.
- The maximum length for the title is 64 characters, and the maximum length for the description is 96 characters.
- If you set the following registry key to any non-zero value, and you've correctly defined at least one custom reason, the standard Windows reasons aren't displayed in the **Shut Down Windows** dialog box:
    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability\ShutdownIgnorePredefinedReasons`
