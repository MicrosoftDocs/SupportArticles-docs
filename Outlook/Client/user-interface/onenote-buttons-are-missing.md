---
title: OneNote buttons are missing in Outlook
description: Describes an issue that may occur when the OneNote 2007 or OneNote 2010 add-in is disabled in Outlook. Provides a resolution.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Outlook
search.appverid: MET150
ms.reviewer: v-six
author: cloud-writer
ms.author: meerak
ms.date: 10/30/2023
---
# OneNote buttons may be missing in Outlook

## Symptoms

When you work in Microsoft Outlook, Microsoft Office OneNote 2007 buttons or OneNote 2010 buttons may be missing as follows:

- When you work in an e-mail item, the **Send to OneNote** button is missing.
- When you work in a calendar item or in a task item, the **Notes About This Item** or the **Linked Meeting Notes** button is missing.

## Cause

This issue may occur when the OneNote add-in is disabled in Outlook or if the Outlook Integration has not been installed.

## Resolution

To install the Outlook integration. follow these steps.

For Windows XP or Windows Server 2003

1. Select **Start**, select **Run**, type _control appwiz.cpl_ in the **Open** box, and then select ENTER.

For Windows Vista or Windows 7

1. Select **Start**, type _programs and features_ in the **Search** box, and then press ENTER.
2. Right-click on the version of Office or OneNote that is installed, and then select **Change**.
3. Select **Add or Remove Features**, and then select **Continue**.
4. Expand **Microsoft OneNote**.
5. Expand **Send to OneNote Add-ins**.
6. If there is an X next to Outlook Integration, select the X, and then select **Run from My Computer**.
7. Select **Continue**.

To enable the OneNote add-in in Outlook, follow these steps.

For Outlook 2010

1. On the File menu, select **Options**.
2. Select **Add-ins**.
3. If **OneNote Notes about Outlook Items** is listed under **Inactive Application Add-ins**, follow these steps:
   1. In the **Manage** box, select **COM Add-Ins**, and then select **Go**.
   2. In the **COM Add-Ins** dialog box, select the **OneNote Notes about Outlook Items** check box, and then select **OK**.

For Outlook 2007

1. On the **Tools** menu, select **Trust Center**.
2. In the **Trust Center** dialog box, select **Add-ins**.
3. If **OneNote Notes about Outlook Items** is listed under **Inactive Application Add-ins**, follow these steps:
   1. In the **Manage** box, select **COM Add-Ins**, and then select **Go**.
   2. In the **COM Add-Ins** dialog box, select the **OneNote Notes about Outlook Items** check box, and then select **OK**.
  
To do this in Outlook 2003, follow these steps:

1. On the **Tools** menu, select **Options**.
2. Select the **Other** tab.
3. Select **Advanced Options**.
4. Select **COM Add-Ins**.
5. Select the **OneNote Notes about Outlook Items** check box.
6. Select **OK** to close the **COM Add-Ins** dialog box.
7. Select **OK** to close the **Advanced Options** dialog box.
8. Select **OK** to close the **Options** dialog box.
