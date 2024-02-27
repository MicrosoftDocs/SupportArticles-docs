---
title: Permissions error when importing Outlook 2011 identity
description: Error occurs when you import an Outlook 2011 identity into Outlook 2016 for Mac.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2016 for Mac
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 01/30/2024
---
# Permissions error when you import an Outlook 2011 identity

_Original KB number:_ &nbsp; 3053602

## Symptoms

When you import an Outlook 2011 identity into Outlook 2016 for Mac, you may receive the following error message:

> Your identity cannot be imported as you do not have sufficient permissions on your 2011 identity.

## Resolution

To resolve this issue, follow these steps:

1. Open **Terminal** using one of the following methods:

   - With **Finder** as the selected application, on the **Go** menu select **Utilities**. Double-click **Terminal**.
   - In **Spotlight Search**, type *Terminal* and then double-click **Terminal** from the search results.

2. Go to the parent directory of your Outlook 2011 identity in Terminal by typing the following command.

   ```console
   cd ~/Documents/Microsoft\ User\ Data/Office\ 2011\ Identities
   ```

3. Type chmod -R 755 <**Identity_Name**>, and then press Enter. Steps 2 and 3 are represented in this screenshot:

    :::image type="content" source="media/permissions-error-when-importing-outlook-2011-identity/terminal-commands.png" alt-text="Screenshot of the Outlook 2011 identity directory Terminal window after you type the commands.":::

    > [!NOTE]
    > If you do not know your Identity name, you can type LS in Terminal and then press Enter for a list of the Identity names.

This should set the correct permissions for your identity. You should now be able to launch Outlook and import your 2011 identity by selecting **Import** on the **File** menu.
