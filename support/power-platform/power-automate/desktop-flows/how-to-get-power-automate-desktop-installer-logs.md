---
title: Power Automate for desktop logs
description: Introduces the locations that contain Power Automate for desktop installation logs.
ms.reviewer: quseleba, guco
ms.date: 09/13/2024
ms.custom: sap:Desktop flows\Working with Power Automate for desktop
---
# Power Automate for desktop logs

During the course of troubleshooting a problem with Power Automate for desktop, you may need to gather logs on the machine for customer support to analyze. These can be for a failed installation, a problem running your desktop flows, or a problem using Power Automate or the machine runtime application.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555577

## Installer logs

The easiest way to get installer logs is to export them using the link provided at the end of a failed installation. When your installation fails and displays "There's a problem installing," click the "installation log files" link located under the **Troubleshooting tips** section.

:::image type="content" source="media/how-to-get-power-automate-desktop-installer-logs/installation-log-files.png" alt-text="Screenshot of the page that contains the installation log files link that you can use to export the installer logs.":::

If you need to get the installer files manually, they can be found _%temp%_ folder of the user who performed the installation. You can find them by typing _%temp%_ in the address bar of File Explorer. The files of interest are:

- _Power Automate for desktop\_*.log_
- _Power Automate for desktop\_\*\_\*\_MicrosoftFlowRPA.log_

The _Power Automate for desktop\_*.log_ file contains the general reason why the installation failed. The _Power Automate for desktop\_\*\_\*\_MicrosoftFlowRPA.log_ file has more detailed information.

:::image type="content" source="media/how-to-get-power-automate-desktop-installer-logs/power-automate-installer-logs.png" alt-text="Screenshot of the Power automate for desktop installer logs.":::

## On-premises product logs

For issues with using Power Automate to create your flows, the Runtime Application to register or configure your machine, or during cloud runtime, you may need to gather on-premises logs.

The easiest way to do this is to use the Power Automate machine runtime application. If you have the application installed, you can [use it to export logs automatically](https://learn.microsoft.com/en-us/power-automate/desktop-flows/troubleshoot#collect-machine-logs).
 
If you need to gather on-premises logs manually, they can be found can be found in _%programdata%\Microsoft\Power Automate\Logs_.

> [!NOTE]
> You need administrator privileges to read or copy these files to another folder. After copying them to a different folder, non-administrator users can open them.

## Event Viewer logs

Event viewer application logs are helpful when an application crashes or a Windows service fails to start.

Follow these steps to view and save the logs:

1. Open the Windows Event Viewer.
2. Go to **Windows Logs** > **Application**, look for an error with the source corresponding to the application that experienced the problem.
3. If needed, use the **Filter Current Log** menu to filter by **Event level** or **Logged** time (such as the last hour).
4. To save the filtered log file, select **Save Filtered Log File As** and save it as an event file.

:::image type="content" source="media/how-to-get-power-automate-desktop-installer-logs/power-automate-event-viewer-logs.png" alt-text="Screenshot of an example error logged in the Event Viewer.":::
