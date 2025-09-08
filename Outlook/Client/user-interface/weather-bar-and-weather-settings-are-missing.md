---
title: Missing Weather Bar and Weather settings
description: Article documenting a scenario where the Weather Bar and Weather settings are missing in Microsoft Outlook 2019, 2016, 2013 or Outlook for Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:User Interface features and Configuration\Other
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tmoore, gregmans
appliesto: 
  - Outlook LTSC 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Weather Bar and Weather settings missing in Outlook 2019, 2016, 2013, or Outlook for Microsoft 365

_Original KB number:_ &nbsp; 2975407

## Symptoms

In Microsoft Outlook LTSC 2021, Outlook 2019, Outlook 2016, Outlook, 2013 or Outlook for Microsoft 365, the Weather Bar doesn't appear above the calendar. Also, the Weather settings aren't displayed in the Calendar section of Outlook Options.

## Cause

This behavior occurs if the option to allow Office to connect to online services is disabled.

## Resolution

To restore the Weather Bar settings and functionality, follow these steps to enable the option to allow Office to connect to online services:

1. In Outlook, from the **File** tab, select **Options**.
2. Select **Trust Center**, and then select **Trust Center Settings**.

3. Select **Privacy Options**, and then enable the following setting depending on your version of Outlook:
   - Outlook LTSC 2021, Outlook 2019, Outlook 2016, or Outlook for Microsoft 365: Let Office connect to online services from Microsoft to provide functionality that's relevant to your usage and preferences.
   - Outlook 2013: Allow Office to connect to the Internet.

4. Select **OK** twice.

> [!NOTE]
> If the **Allow Office to connect to the Internet** checkbox is grayed out, see the More information section for more information about this setting.

## More information

The setting documented in the Resolution section corresponds to the following registry value:

`HKEY_CURRENT_USER\Software\Microsoft\Office\<x.0>\Common\Internet`

Or

`HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<x.0>\Common\Internet`

DWORD: UseOnlineContent  
Value:

0  - Don't allow user to access Office resources on the Internet (checkbox is unchecked and grayed out)  
1  - Allows the user to opt in to access of Office resources on the Internet (checkbox is unchecked)  
2  - (Default) Allows the user to access Office resources on the Internet (checkbox is checked)

> [!NOTE]
> The <x.0> placeholder represents your version of Office (16.0 = Office 2016, Office 2019, Office LTSC 2021, or Outlook for Microsoft 365, 15.0 = Office 2013).

This option can also be configured by using a Group Policy setting. This Group Policy setting is located here:

Group Policy Setting path: **Administrative Templates\Microsoft Office 20\<xx>\Tools \| Options \| General \| Service Options...**  
Group Policy Setting name: **Online Content Options**

> [!NOTE]
> The \<xx> placeholder represents your version of Office (16 = Office 2016, Office 2019, Office LTSC 2021, or Outlook for Microsoft 365, 13 = Office 2013).

:::image type="content" source="media/weather-bar-and-weather-settings-are-missing/online-content-options.png" alt-text="Screenshot of a Group Policy setting Online Content Options.":::

This setting also affects other features in Microsoft Office, including:

- Insertion of Online Pictures.
- Insertion of Online Video.
- Search for online templates.
- Certain document review and proofing resources.
