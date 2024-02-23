---
title: Compact Navigation options aren't saved
description: Fixes an issue in which Compact Navigation settings are not saved when you close Outlook 2013.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, laurentc
appliesto: 
  - Outlook 2013
search.appverid: MET150
ms.date: 10/30/2023
---
# Outlook 2013 Compact Navigation options are not saved

_Original KB number:_ &nbsp; 2977974

## Symptoms

In Microsoft Outlook 2013, the Compact Navigation settings are not saved when you close Outlook.

## Cause

There may be a conflict between the Outlook Fast Shutdown functionality and one or more COM add-ins.

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To work around this issue, find the affected add-in or add-ins by enabling shutdown notifications for all the add-ins, then disabling shutdown notifications one add-in at a time. To do this, follow these steps:

1. Close Outlook.
2. Start Registry Editor.

    - Windows 8

        Press the Windows logo key+R.

    - Windows 7, Windows Vista, or Windows XP

        On the **Start** menu, click **Run**.

3. Type `Regedit.exe`, and then click **OK**.
4. Locate the following key in the registry:

    `HKEY_CURRENT_USER\Software\Microsoft\Office\Outlook\Addins`

5. Double-click to open the first subkey.
6. Click **New**, and then click **DWORD Value**.
7. Type `RequireShutdownNotification`, and then press Enter.
8. Double-click **RequireShutdownNotification**, type **1** in the **Value data**, and then click **OK**.
9. Repeat steps 6 through 8 for each subkey under the `Addins` key.
10. Start Outlook, change the Compact Navigation options, and then restart Outlook.

11. If the customizations are saved, delete the `RequireShutdownNotification` registry value from the first add-in subkey under the `Addins` key. If the customizations are not saved, leave the `RequireShutdownNotification` registry value set to **1**, and then move to the next add-in subkey in the `Addins` key.

12. Start Outlook, change the Compact Navigation options, and then restart Outlook.

13. If the customizations are saved, delete the `RequireShutdownNotification` registry value from the add-in subkey under the `Addins` key. If the customizations are not saved, leave the `RequireShutdownNotification` registry value set to **1**, and then move to the next add-in subkey in the `Addins` key.

14. Repeat steps 12 and 13 until you complete testing all the add-ins.

> [!NOTE]
> Some add-ins are loaded from the HKEY_LOCAL_MACHINE registry hive. Use the same steps, but then check the following registry key at step 4:  
> `HKEY_LOCAL_MACHINE\Software\Microsoft\Office\Outlook\Addins`

If you have a 32-bit version of Outlook or Office installed on a 64-bit version of Windows, navigate to the following registry key:   `HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Office\Outlook\Addins`

If you cannot narrow down the specific add-in that's causing the conflict, you can globally enable shutdown notifications for all add-ins. To enable global shutdown notifications, follow these steps:

1. Start Registry Editor.
   - Windows 8

     Press the Windows logo key+R.

   - Windows 7, Windows Vista, or Windows XP

     On the **Start** menu, click **Run**.

2. Type `Regedit.exe` and click **OK**.

3. Locate the following key in the registry:

    `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\15.0\Outlook\Options\Shutdown`

    > [!NOTE]
    > Manually create any registry keys or values if they don't exist.

4. Click **New**, and then click **DWORD Value**.
5. Type `AddinFastShutdownBehavior`, and then press Enter.
6. Double-click `AddinFastShutdownBehavior`, type **1** in the **Value data** box, and then click **OK**.
7. Close Registry Editor.

> [!NOTE]
> If an add-in still conflicts with the Compact Navigation settings after you follow the workaround steps, we recommend that you contact the add-in vendor.

## More information

Microsoft Outlook 2010 introduced changes to help Outlook shut down faster. These changes are discussed in [Shutdown Changes for Outlook 2010](/previous-versions/office/developer/office-2010/ee720183(v=office.14)).

Some add-ins may still conflict with the Compact Navigation settings even after you follow the steps in the [Workaround](#workaround) section. If this occurs, disable the add-in or multiple add-ins temporarily while you set the desired Compact Navigation settings. To temporarily disable one or more add-ins, follow these steps:

1. Click **File**, click **Options**, and then click **Add-Ins**.
2. In the **Manage** list, click **COM Add-Ins**, and then click **Go**.
3. Clear one or more of the add-ins in the list, and then click **OK**.
4. Restart Outlook.

After you set your Compact Navigation settings, restart Outlook. Then, enable the add-ins by following the same steps. However, at step 3, select the add-ins that were not selected the first time.
