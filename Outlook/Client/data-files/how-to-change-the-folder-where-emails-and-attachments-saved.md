---
title: Change the folder where emails and attachments are saved in Outlook
description: Explains that you can change the default folders that are used by Outlook to save e-mail messages and attachments. Requires that you modify the registry by adding a registry value to configure the default folder.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Exchange Mailbox Accounts\Personal folders backup add-in
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: skipb
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
search.appverid: MET150
ms.date: 04/07/2025
---
# Change the folder where emails and attachments are saved in Outlook

_Original KB number:_ &nbsp; 823131

When you use the **Save As** command to save e-mail messages and attachments in Outlook, these items are saved by default in your **Documents** folder in the following path:

`drive:\Users\username\Documents`

Where <i>drive</i> is the drive where Microsoft Windows is installed, and <i>username</i> is your user name.

You can change this default location by adding the following registry value to point to the location of your choice:

 `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Options** **\DefaultPath`

Follow these steps:

[!INCLUDE [Important registry alert](../../../includes/registry-important-alert.md)]

1. Select **Start**, and then select **Run**.
2. In the **Open** box, type *regedit*, and then press Enter.
3. Locate the following subkey in the registry by using Registry Editor:  
   `HKEY_CURRENT USER\Software\Microsoft\Office\16.0\Outlook\Options`

4. On the **Edit** menu, point to **New**, and then select **String Value**.
5. Type *DefaultPath*, and then press Enter.
6. Double-click the `DefaultPath` value.
7. In the **Edit String** dialog box, type the path, including the drive letter, to the folder that you want to use for your saved Outlook items in the **Value data** box, and then select **OK**.
8. Exit Registry Editor.
