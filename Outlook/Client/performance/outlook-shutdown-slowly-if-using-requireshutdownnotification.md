---
title: Outlook shut down slowly with RequireShutdownNotification
description: Provides a resolution for the slow shutdown issue if an add-in is set to use RequireShutdownNotification in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gbratton, aruiz
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# Outlook may shutdown more slowly if an add-in is configured to use RequireShutdownNotification

_Original KB number:_ &nbsp; 2790282

## Symptoms

When you exit Microsoft Outlook, the time to shutdown completely may take longer than expected.

## Cause

This problem can occur if you have one or more add-ins configured to use the `RequireShutdownNotification` registry value.

## Resolution

To resolve this problem, you can disable the `RequireShutdownNotification` registry value.

However, the effect of the change on an add-in by using this value depends on what the add-in does during shutdown events. At shutdown time, most add-ins release references to Outlook COM objects and clear memory that was allocated during the session. In these cases, the effect on the add-ins is minimal; Outlook releases the remaining COM object references and shuts down, and Windows reclaims the memory when the Outlook process exits.

For some add-ins, the changes have a greater effect. If an add-in commits data during the shutdown process (for example, to store user settings or to report usage to a web server), those activities will no longer occur if you disable the `RequireShutdownNotification` registry value. Depending on the scenario, the effect may not be visible.

Based on the previous information, we recommend that you first contact your add-in developer to see whether there is an updated version of the add-in that does not require the `RequireShutdownNotification` registry value, or if the disabling of the `RequireShutdownNotification` registry value will cause additional problems.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

If you decide to disable the `RequireShutdownNotification` registry value, you can make the change by using the following steps.

1. Exit Outlook.
2. Start Registry Editor. To do this, use one of the following procedures, as appropriate for your version of Windows.

   - Windows 10, Windows 8.1, and Windows 8: Press Windows Key+R to open a **Run** dialog box. Type *regedit.exe* and then press **OK**.
   - Windows 7: Select **Start**, type *regedit.exe* in the search box, and then press Enter.

3. Locate and select the following registry key:

   `HKEY_CURRENT_USER\Software\Microsoft\Office\Outlook\Addins`
4. Select the first subkey under the `\Addins` key. (Each subkey under `\Addins` represents a separate registered add-in)

    > [!NOTE]
    > If the subkey referenced in this step is called one of the following values, you may consider skipping it as the following articles recommend configuring *RequireShutdownNotification=1.*
    >
    > Microsoft.OutlookBackup.1  
    > VbaAddinForOutlook.1  
    > OutlookChangeNotifierAddin

5. Examine the values under the subkey.
6. If you see `RequireShutdownNotification` and its value is 1, right-click **RequireShutdownNotification** and then select **Modify**.
7. In the **Value data** box, type *0* and then select **OK**.
8. Repeat steps 4-7 for every subkey under `\Addins`.
9. Locate and select the following registry key.

    `HKEY_LOCAL_MACHINE\Software\Microsoft\Office\Outlook\Addins`
10. Repeat steps 4-7 for each subkey under `\Addins`.
11. Locate and select the following registry key:

    `HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Office\Outlook\Addins`
12. Repeat steps 4-7 for each subkey under `\Addins`.

## More information

The design of Outlook 2010 and later versions is changed to have a much faster shutdown process. This was achieved by changes to the way add-ins are notified that Outlook is about to shut down. Add-in developers were informed of these changes in Outlook and advised of the best practices to follow for add-in development. Most developers updated their add-ins to correctly account for these architectural changes in Outlook. However, you may have one or more add-ins installed that are not updated yet and the developer has instead decided to use the `RequireShutdownNotification` registry value to revert Outlook to the earlier-version shutdown process. And, if the `RequireShutdownNotification` registry value is used for even one add-in, the shutdown process for Outlook may take longer than expected.

For more information on the shutdown changes that were introduced in Outlook 2010, see [Shutdown Changes for Outlook 2010](/previous-versions/office/developer/office-2010/ee720183(v=office.14)).
