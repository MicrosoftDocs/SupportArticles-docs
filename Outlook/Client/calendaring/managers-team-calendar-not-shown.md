---
title: Manager's team calendars not shown
description: Describes an issue that prevents your manager's Outlook team calendars from displaying in the Calendar module of the navigation pane. Occurs in Outlook 2016, Microsoft Outlook 2013, Microsoft Outlook 2010, and Microsoft Exchange Online. Provides resolutions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: monish, bobz
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Exchange Online
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook doesn't display your manager's team calendars

_Original KB number:_ &nbsp; 3163350

## Symptoms

In Microsoft Outlook, your manager's team calendars aren't displayed in the Calendar module of the navigation pane.

## Cause

This issue may occur for one of the following reasons:

- The **Show Manager's Team Calendar** setting isn't enabled in Outlook.
- You have a registry setting configured to disable the manager's team calendar.
- The Manager attribute in Active Directory isn't configured.
- The manager has more than 100 direct reports.

To resolve this issue, use one of the following methods, depending on the cause of the issue. If you don't know the cause of the issue, try each method in the order in which they are listed.

## Method 1 - Enable the Show Manager's Team Calendar setting in Outlook

1. In Outlook, open the Calendar.
2. On the **Home**  tab, select **Calendar Groups**.
3. Select **Show Manager's Team Calendars**.

Note If the **Show Manager's Team Calendars** setting is unavailable, follow the steps in the remaining methods until the issue is resolved.

## Method 2 - Modify the registry to enable the Manager's Team Calendar

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you incorrectly modify the registry. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

1. Exit Outlook.
2. Open Registry Editor. To do this, use one of the following procedures, depending on the version of Windows you're using:
   - Windows 10, Windows 8.1, and Windows 8: Press Windows key+R to open a **Run** dialog box. Type *regedit.exe*, and then select **OK**.
   - Windows 7: Select **Start**, type *regedit.exe* in the search box, and then press Enter.

3. In Registry Editor, locate the `DisableReportingLineGroupCalendar` registry value. It's located in one of the following registry subkeys:
   - `HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Outlook\Options\WunderBar`
   - `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\Outlook\Options\WunderBar`

   > [!NOTE]
   > The **x.0** placeholder represents your version of Office (for example, 16.0 = Office 2016, 15.0 = Office 2013, and 14.0 = Office 2010).

4. Double-click `DisableReportingLineGroupCalendar`.
5. In the **Value Data** box, type 0 (zero), and then select **OK**.
6. Exit Registry Editor.

> [!NOTE]
> If the `DisableReportingLineGroupCalendar` registry value is located under the `\Policies` hive of the registry, it may have been created by using Group Policy. Your administrator must modify the policy to change this setting.

## Method 3 - Set the Manager attribute

> [!NOTE]
> You must be an administrator to complete these steps.

To set the Manager  attribute on an on-premises Active Directory server, follow these steps:

1. In Active Directory Users and Computers, open the **Properties** dialog box of the user account.
2. On the **Organization** tab, under the **Manager** area, select **Change**.
3. Browse the directory to find the user's manager, and then select the manager.
4. Select **OK**.

To set the Manager attribute in Exchange Online, follow these steps:

1. In the Microsoft 365 admin center, select **Users**, and then select **Active users**.
2. Select the user's name, and then select **Mail**.
3. In the **More settings** section, select **Edit Exchange properties**, and then select **organization**.
4. Next to **Manager**, select **Browse**.
5. Select the user's manager, and then select **OK**.
6. Select **Save**, and then select **OK**.

## Method 4 - Reduce the number of direct reports to fewer than 100

> [!NOTE]
> You must be an administrator to complete these steps.

If a manager has more than 100 direct reports listed in Active Directory, Outlook doesn't display the manager's team calendar. This is by design. If it's possible, reduce the number of direct reports listed in Active Directory for each manager to fewer than 100.
