---
title: Unsupported folder class error when Outlook starts
description: After you configure Outlook 2007 or Outlook 2010 to access your Apple iCloud email, contacts, or calendar, and you try to configure the iCloud data file as the default, Outlook displays an error at startup.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz
appliesto: 
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 01/30/2024
---
# Unsupported folder class error when Outlook starts

_Original KB number:_ &nbsp; 2668932

## Symptoms

Consider the following scenario:

You install the Apple iCloud Control Panel for Windows Vista or for Windows 7. You configure the Apple iCloud Control Panel to enable one or more iCloud services, and you synchronize them with Microsoft Outlook 2007 or from Outlook 2010. You use either the Outlook client or the Windows Control Panel Mail item to set the iCloud data file as the default.

In this scenario, when you start Outlook, you receive the following error:

> Cannot start Microsoft Outlook. Cannot open the Outlook window. The set of folders cannot be opened. Unsupported folder class (IPF.Contact)

## Cause

The Apple iCloud data file uses a custom data file (.aplzod) structure. Outlook cannot use the data file as the default data file.

## Resolution

To set an Outlook Data File (.pst) as the default, follow these steps:

1. Select **Start**, and then select **Run**.
2. Copy and paste, or type *control panel* in the **Open** box, and then press Enter:

    > [!NOTE]
    > If you are using a 64-bit version of Windows, double-click **View 32-bit Control Panel** in Control Panel to display the **Mail** icon.

3. Open the **Mail Setup** dialog box:

    For Windows 7:

      - If Control Panel is in either Large icons or Small icons view, select **Mail**. The **Mail Setup** dialog box appears.
      - If Control Panel is in Category view, under **View by**, select either **Large icons** or **Small icons**, and then select **Mail**. The **Mail Setup** dialog box appears.

    For Windows Vista or for Windows XP:
      - If Control Panel is in Classic View, double-click **Mail**. The **Mail Setup** dialog box appears.
      - If Control Panel is in Category View, under **Control Panel**, select **Switch to Classic View** for Windows XP, or select **Classic View** for Windows Vista, and then double-click **Mail**. The **Mail Setup** dialog box appears.

4. In the **Mail Setup** dialog box, select **Show Profiles**.
5. Select your current Outlook profile, and then select **Properties**.
6. In the **Mail Setup - profile name** dialog box, select **Data Files**.
7. In the **Account Settings** dialog box, select the **Data Files** tab.
8. Select an Outlook Data File. Outlook Data Files have .pst extensions.
9. Select the **Set as Default** button.
10. Select **Close**.
11. Start Outlook.

## More information

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.
