---
title: How to control the Room Finder in Outlook
description: Provides information about how to hide or display the Room Finder in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CI 113857
  - CSSTroubleshoot
ms.reviewer: gabesl
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
search.appverid: 
  - MET150
ms.date: 01/30/2024
---

# How to control the Room Finder in Outlook

## Summary

By default, when you open a new meeting form in Microsoft Outlook 2016, Microsoft Outlook 2013, or Microsoft Outlook 2010, the **Room Finder** panel is displayed on the right side of the **Appointment** screen and the **Scheduling Assistant** screen, as shown in the following screenshots. The **Room Finder** control button can be found in the **Options** group on the **Meeting** tab.

> [!NOTE]
> You can hide the Room Finder by selecting the **Room Finder** control in the **Options** group of the ribbon. However, the Room Finder remains hidden only if you hide it on the **Appointment** screen. If you hide it on the **Scheduling Assistant** screen, switch to the **Appointment** screen and then back to the **Scheduling Assistant** screen, the Room Finder is visible again. The **Room Finder** control button isn't available when you create an appointment. You can select **Invite Attendees** on the **Appointment** tab to make it available.  
> :::image type="content" source="./media/room-finder/invite-attendees.png" alt-text="Screenshot that shows the Invite Attendees option on the Appointment tab.":::

**The Appointment screen in Outlook**

:::image type="content" source="./media/room-finder/room-finder-outlook-2016-appointment.png" alt-text="Screenshot that shows the Room Finder feature in the Appointment view in Outlook 2016.":::

**The Scheduling Assistant screen in Outlook**

:::image type="content" source="./media/room-finder/room-finder-outlook-2016-scheduling-assistant.png" alt-text="Screenshot that shows the Room Finder feature in the Scheduling Assistant view in Outlook 2016.":::

In Outlook for Microsoft 365, the **Room Finder** control button can be found next to the **Location** field on the **Meeting** tab, or on the ribbon when you view the **Scheduling Assistant** screen.

**The Meeting tab of Outlook in Outlook for Microsoft 365**

:::image type="content" source="./media/room-finder/room-finder-microsoft-365-meeting.png" alt-text="Screenshot that shows the Room Finder feature in the Meeting view in Microsoft 365.":::

**The Scheduling Assistant tab in Outlook for Microsoft 365**

:::image type="content" source="./media/room-finder/room-finder-microsoft-365-scheduling-assistant.png" alt-text="Screenshot that shows the Room Finder feature in the Scheduling Assistant view in Microsoft 365.":::

> [!NOTE]
> There's a known issue in which no available rooms are displayed in the **Room Finder** pane when you start a meeting outside your working hours. For more information, see [No available rooms for a meeting outside working hours](https://support.microsoft.com/help/2932395).

## Manually controlling the Room Finder

When you hide the Room Finder on the **Appointment** tab of a meeting form, the following data is written into the Windows registry.

- Subkey: `HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Outlook\Preferences`
- DWORD: RoomFinderShow
- Value: 0 (If you subsequently display the Room Finder, this value is changed to 1)

> [!NOTE]
> In this subkey path, the *x.0* placeholder represents your version of Office (16.0 = Office 2016 and Microsoft 365, 15.0 = Office 2013, 14.0 = Office 2010).

If you hide the Room Finder on the **Scheduling Assistant** screen of a meeting form, this registry data is never used.

## Administering the Room Finder through registry

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry](https://support.microsoft.com/help/322756) for restoration in case problems occur.

There are two different registry values that affect the Room Finder. Which one you use depends on the level of control that you want to have over the Room Finder and the version of "Microsoft Exchange Add-In" that you have installed.

- RoomFinderShow

  The `RoomFinderShow` value is a DWORD value under the following registry path (by Outlook version):
  
  `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\Outlook\Preferences`

  The *x.0* placeholder represents your version of Office (16.0 = Office 2016 and Microsoft 365, 15.0 = Office 2013, 14.0 = Office 2010).

  If RoomFinderShow = 0 in these registry paths, the Room Finder behaves in the following manner when you start Outlook:

  - By default, the Room Finder isn't shown on the **Appointment** screen.
  - You can manually enable the Room Finder on the **Appointment** screen.
  - By default, If you open a new meeting form after you enable the Room Finder in another meeting form, the Room Finder isn't shown on the **Appointment** screen of the new meeting form.
  - If you manually enable and then disable the Room Finder on the **Appointment** screen, nothing is written to the registry.

- RoomFinderForceDisabled

  The `RoomFinderForceDisabled` value was introduced in an update to the "Microsoft Exchange Add-in". It's used by Outlook only after you install the update for your version of Outlook.

  - [Hotfix KB2880477 for Office 2013 July 8, 2014 (Outexum-x-none.msp)](https://support.microsoft.com/help/2880477)
  - [Hotfix KB2794760 for Outlook 2010 July 8, 2014 (Outexum-x-none.msp)](https://support.microsoft.com/help/2794760)

  After the update is installed, use the following registry data to completely disable the Room Finder. It gives you even greater control over the Room Finder than the `RoomFinderShow` value.

  - Subkey: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\Outlook\Preferences`
  - DWORD: `RoomFinderForceDisabled`
  - Values: 1 = hide the Room Finder, 0 (or missing DWORD) = show the Room Finder

  After the required update is installed and you set the `RoomFinderForceDisabled` value to `1`, Outlook doesn't display the **Room Finder** pane on either the **Scheduling Assistant** or **Appointment** screens in a meeting form.

Another way to completely disable (hide) the Room Finder on the **Scheduling Assistant** and **Appointment** screens is to disable the "Microsoft Exchange Add-in" add-in. To do so, follow these steps.

> [!IMPORTANT]
> We don't recommend that you disable the Microsoft Exchange Add-in, because it also disables other features, such as "Protect before send" and "Voicemail integration".

1. On the **File** tab, select **Options**.
2. In the **Outlook Options** dialog box, select **Add-Ins**.
3. In the **Add-ins** section of the **Outlook Options** dialog box, select **Go**.
4. In the **COM Add-Ins** dialog box, clear the check box for **Microsoft Exchange Add-in**, and then select **OK**.

Loading the Microsoft Exchange Add-in is controlled by the following registry entry:

- Subkey: `HKEY_LOCAL_MACHINE\Software\Microsoft\Office\x.0\Outlook\Addins\UmOutlookAddin.FormRegionAddin`
- DWORD: LoadBehavior
- Values: 3 = add-in is loaded when Outlook starts, 2 = add-in is not loaded on startup (and may never load), 0 = add-in is disabled
