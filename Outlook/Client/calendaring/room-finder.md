---
title: How to control the Room Finder in Outlook
description: Provides information about how to hide or display the Room Finder in Outlook.
author: helenclu
ms.author: gabesl
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.service: o365-proplus-itpro
localization_priority: Normal
ms.custom: 
- Outlook for Windows
- CI 113857
- CSSTroubleshoot
ms.reviewer: gabesl
appliesto:
- Outlook for Office 365
- Outlook 2016
- Outlook 2013
- Outlook 2010
search.appverid: 
- MET150
---

# How to control the Room Finder in Outlook

## Summary

By default, when you open a new meeting form in Microsoft Outlook 2016, Microsoft Outlook 2013, or Microsoft Outlook 2010, the Room Finder panel is displayed on the right side of the **Appointment** screen and the **Scheduling Assistant** screen, as shown in the following screenshots.

:::image type="content" source="./media/room-finder/image1.png" alt-text="Room Finder feature in Outlook 2016 in the Appointment view.":::

:::image type="content" source="./media/room-finder/image2.png" alt-text="Room Finder feature in Outlook 2016 in the Scheduling Assistant view.":::

In Outlook for Office 365, the Room Finder control button can be found next to the **Location** field on the **Meeting** tab, or on the ribbon when you view the **Scheduling Assistant** screen.

:::image type="content" source="./media/room-finder/image3.png" alt-text="A screenshot of a social media post Description automatically generated.":::

:::image type="content" source="./media/room-finder/image4.png" alt-text="A screenshot of a computer Description automatically generated.":::

You can hide the Room Finder by selecting the **Room Finder** control in the **Options** group of the ribbon. However, the Room Finder remains hidden only if you hide it on the **Appointment** screen. If you hide it on the **Scheduling Assistant** screen, switch to the **Appointment** screen and then back to the **Scheduling Assistant** screen, the Room Finder is visible again.  

> [!NOTE]
> There is a known issue in which no available rooms are displayed in the Room Finder pane when you start a meeting outside your working hours.  
  
For more information, see [No available rooms for a meeting outside working hours](https://support.microsoft.com/help/2932395).

## Manually controlling the Room Finder

When you hide the Room Finder on the **Appointment** tab of a meeting form, the following data is written into the Windows registry.

```
Subkey: HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Outlook\Preferences
DWORD: RoomFinderShow
Value: 0 (If you subsequently display the Room Finder, this value is changed to 1)
```

> [!NOTE]
> In this subkey path, the **x.0** placeholder represents your version of Office (16.0 = Office 2016, 15.0 = Office 2013, 14.0 = Office 2010).

If you hide the Room Finder on the **Scheduling Assistant** screen of a meeting form, this registry data is never used.

## Administering the Room Finder through Group Policy

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry](https://support.microsoft.com/help/322756) for restoration in case problems occur.

There are two different policy values that affect the Room Finder. Which one you use depends on the level of control that you want to have over the Room Finder and the version of "Microsoft Exchange Add-In" that you have installed.

- RoomFinderShow

    The **RoomFinderShow** policy value is a DWORD value under the following registry paths (by Outlook version):

    `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\Outlook\Preferences`

    The *x.0* placeholder represents your version of Office (16.0 = Office 2016, 15.0 = Office 2013, 14.0 = Office 2010).

    If RoomFinderShow = 0 in these registry paths, the Room Finder behaves in the following manner when you start Outlook:

    - By default, the Room Finder is not shown on the **Appointment** screen.
    - You can manually enable the Room Finder on the **Appointment** screen.
    - By default, If you open a new meeting form after you enable the Room Finder in another meeting form, the Room Finder is not shown on the **Appointment** screen of the new meeting form.
    - If you manually enable and then disable the Room Finder on the **Appointment** screen, nothing is written to the registry.

- RoomFinderForceDisabled

    The **RoomFinderForceDisabled** policy value was introduced in an update to the "Microsoft Exchange Add-in". It is used by Outlook only after you install the update for your version of Outlook.

    [<span class="underline">Hotfix KB2880477 for Office 2013 July 8, 2014 (Outexum-x-none.msp)</span>](https://support.microsoft.com/help/2880477)  

    [<span class="underline">Hotfix KB2794760 for Outlook 2010 July 8, 2014 (Outexum-x-none.msp)</span>](https://support.microsoft.com/help/2794760)

    After the update is installed, use the following registry data to completely disable the Room Finder. This gives you even greater control over the Room Finder than the **RoomFinderShow** policy.

    ```
    Subkey: HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\Outlook\Preferences  
    DWORD: RoomFinderForceDisabled  
    Values: 1 = hide the Room Finder, 0 (or missing DWORD) = show the Room Finder  
    ```

    After the required update is installed, and you set **RoomFinderForceDisabled=1**, Outlook does not display the Room Finder pane on either the **Scheduling Assistant** or **Appointment** screens in a meeting form.

Another way to completely disable (hide) the Room Finder on the **Scheduling Assistant** and **Appointment** screens is to disable the "Microsoft Exchange Add-in" add-in. To do this, follow these steps.  
  
> [!IMPORTANT]
> We do not recommend that you disable the Microsoft Exchange Add-in because this also disables other features (such as "Protect before send" and "Voicemail integration").

1. On the **File** tab, select **Options**.
2. In the **Outlook Options** dialog box, select **Add-Ins**.
3. In the **Add-ins** section of the **Outlook Options** dialog box, select **Go**.
4. In the **COM Add-Ins** dialog box, clear the check box for **Microsoft Exchange Add-in**, and then select **OK**.

Loading the Microsoft Exchange Add-in is controlled by the following registry entry:

```
Subkey: HKEY_LOCAL_MACHINE\Software\Microsoft\Office\x.0\Outlook\Addins\UmOutlookAddin.FormRegionAddin  
DWORD: LoadBehavior  
Values: 3 = add-in is loaded when Outlook starts, 2 = add-in is not loaded on startup (and may never load), 0 = add-in is disabled
```
