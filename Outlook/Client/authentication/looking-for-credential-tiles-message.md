---
title: Looking for credential tiles when starting Outlook
description: When you launch Microsoft Outlook 2013 or 2010, you receive a Looking for credential tiles message but the OK button is not available.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae, rakeshs
appliesto: 
  - Outlook 2013
  - Outlook 2010
search.appverid: MET150
ms.date: 10/30/2023
---
# Looking for credential tiles message when launching Outlook 2013 or 2010

_Original KB number:_ &nbsp; 2938468

## Symptoms

When you launch Outlook 2013 or Outlook 2010, the following message stating **Looking for credential tiles...** appears:

:::image type="content" source="media/looking-for-credential-tiles-message/looking-for-credential-tiles.png" alt-text="Screenshot of the Looking for credential tiles message." border="false":::

The **OK** button remains greyed out, and if you select **Cancel** on this message, Outlook is not able to launch successfully. Outlook will stay on the **Loading Profile** step of the launch process.

## Cause

This issue may occur when you are connected to Exchange using Outlook Anywhere and have a third-party authentication service application installed on the computer. Microsoft Product Support teams have seen this issue occur in some cases with the Lenovo VeriFace program.

> [!NOTE]
> The use of a third-party authentication service application does not necessarily mean you will see these symptoms, even if you have the application specified above. There may be other causes for these symptoms. This article is merely intended to help you identify possible causes of these symptoms when using Outlook.

## Resolution

If you are experiencing this issue, either disable or uninstall the third-party authentication service application. Uninstalling the application can be performed in the **Programs and Features** in **Control Panel**.

If you are unable to locate the program in **Control Panel**, check the program's installation folder for an uninstalled program. By default, the Lenovo VeriFace program is installed in the `C:\Program Files\Lenovo\VeriFace` or `C:\Program Files (x86)\Lenovo\VeriFace` folder.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-information-disclaimer.md)]
