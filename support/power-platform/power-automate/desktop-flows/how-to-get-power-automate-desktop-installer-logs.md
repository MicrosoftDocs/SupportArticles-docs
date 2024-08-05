---
title: How to get Power Automate for desktop installer logs
description: Introduces the locations that contain Power Automate for desktop installer logs.
ms.reviewer: quseleba
ms.date: 09/21/2022
ms.custom: sap:Desktop flows\Working with Power Automate for desktop
---
# How to get Power Automate for desktop installer logs

This article introduces how to get Microsoft Power Automate for desktop installer logs.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555577

## Symptoms

When you install Microsoft Power Automate for desktop, the installation fails and you want to resolve the issue by using the installer logs.

## More information

The following locations contain logs that are related to the installer.

#### %temp%

The files that start with Power_Automate_Desktop contain part of the installer's logs.

:::image type="content" source="media/how-to-get-power-automate-desktop-installer-logs/installer-logs-in-temp.png" alt-text="Files that contain part of the installer's logs in the temp folder.":::

#### %programdata%\Microsoft\Power_Automate_Desktop\Logs\Installer

Admin privileges are required to read these files. You can either start a text editor as an admin to open one of the files, or you can copy them to a different location on disk to open them as a non-admin.

:::image type="content" source="media/how-to-get-power-automate-desktop-installer-logs/installer-logs-in-programdata.png" alt-text="The Installer folder under programdata contains the installer's logs.":::

> [!NOTE]
> During installation, the installer starts the UIFlowService service, and depending on the problem, you may need to look at logs from this service as well. You can find them in _%programdata%\Microsoft\Power_Automate_Desktop\Logs_.
