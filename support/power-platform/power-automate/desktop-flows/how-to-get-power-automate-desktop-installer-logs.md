---
title: Power Automate for desktop installation logs
description: Introduces the locations that contain Power Automate for desktop installation logs.
ms.reviewer: quseleba, guco
ms.date: 08/28/2024
ms.custom: sap:Desktop flows\Working with Power Automate for desktop
---
# Power Automate for desktop installation logs

If your Power Automate for desktop installation fails, you can use the logs described in this article to diagnose and resolve issues. If you need to contact [Microsoft Support](/power-platform/products/power-automate/) for assistance with installation issues, collect the following logs in a .zip file and include them with the support request to expediate the investigation.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555577

## Installer logs

These logs can be found in the _%temp%_ folder of the user who performs the installation. You can find them by typing _%temp%_ in the address bar of File Explorer. The files of interest are:

- Power Automate for desktop_*.log
- Power Automate for desktop_\*_\*_MicrosoftFlowRPA.log

The _Power Automate for desktop\_*.log_ file contains the general reason why the installation failed. The _Power Automate for desktop\_\*\_\*\_MicrosoftFlowRPA.log_ file has more detailed information.

:::image type="content" source="media/how-to-get-power-automate-desktop-installer-logs/power-automate-installer-logs.png" alt-text="Screenshot of the installer logs of the Power automate for desktop.":::

## Program data logs

These are logs of the components installed on your machine. You can find them by typing the path _%programdata%\Microsoft\Power Automate\Logs_ in the address bar of File Explorer.

> [!NOTE]
> You need administrator privileges to read these files or copy them to another folder. After they're copied to a different folder, they can be opened by a non-administrator.

## Event Viewer logs

These logs are helpful when a Windows service fails to start.

Follow these steps to view and save the logs:

1. Open the Windows Event Viewer
2. Go to **Windows Logs** > **Application**, find the error, and review the information in the **General** and **Details** tabs.
3. If needed, use the **Filter Current Log** menu to filter by **Event level** or **Logged** time (such as the last hour).
4. To save the filtered log file, select **Save Filtered Log File As** and save it as an event file.

:::image type="content" source="media/how-to-get-power-automate-desktop-installer-logs/power-automate-event-viewer-logs.png" alt-text="An example of an error that's logged in the Event Viewer.":::
