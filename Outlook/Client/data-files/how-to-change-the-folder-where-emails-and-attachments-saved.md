---
title: Change the folder where emails and attachments saved
description: Explains that you can change the default folders that are used by Outlook to save e-mail messages and attachments. Requires that you modify the registry by adding a registry value to configure the default folder.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: skipb
appliesto: 
  - Outlook
search.appverid: MET150
ms.date: 01/30/2024
---
# How to change the folder where e-mail messages and attachments are saved in Outlook

> [!IMPORTANT]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, see [Windows registry information for advanced users](https://support.microsoft.com/help/256986).

_Original KB number:_ &nbsp; 823131

## Summary

This article discusses how to configure the default folders that are used by Outlook when you save e-mail messages and attachments.

## More information

By default, when you use the **Save As** command to save e-mail messages and attachments in Outlook, these items are saved in your **My Documents** folder. The following is the path where e-mail messages and attachments are saved in Outlook 2003 by default:

**drive**:\Documents and Settings\\**username**\My Documents

Where **drive** is the drive where Microsoft Windows is installed, and where **username** is your user name.

You can change the location where e-mail messages and attachments are saved in Outlook by adding the following registry value:

Outlook 2003

`HKEY_CURRENT USER\Software\Microsoft\Office\11.0\Outlook\Options\DefaultPath`

Outlook 2007

`HKEY_CURRENT USER\Software\Microsoft\Office\12.0\Outlook\Options\DefaultPath`

Outlook 2013

 `HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Outlook\Options** **\DefaultPath`

Outlook 2016 and 2019

 `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Options** **\DefaultPath`

To do this, follow these steps:

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.

1. Select **Start**, and then select **Run**.
2. In the **Open** box, type *regedit*, and then press Enter.
3. Locate the following subkey in the registry by using Registry Editor:  
   `HKEY_CURRENT USER\Software\Microsoft\Office\1x.0\Outlook\Options`

4. On the **Edit** menu, point to **New**, and then select **String Value**.
5. Type *DefaultPath*, and then press Enter.
6. Double-click the `DefaultPath` value.
7. In the **Edit String** dialog box, type the path, including the drive letter, to the folder that you want to use for your Outlook saved items in the **Value data** box, and then select **OK**.
8. Quit Registry Editor.
