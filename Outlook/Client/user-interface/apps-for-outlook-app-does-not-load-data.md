---
title: Apps for Outlook app does not load data
description: Describes an issue that blocks Apps for Outlook apps from being loaded correctly in an Outlook 2013 or Outlook 2016 environment. A resolution is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Data Protection and Security\Other
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: TasitaE
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Apps for Outlook app does not load data in Outlook 2013 or Outlook 2016

_Original KB number:_ &nbsp; 3035127

## Symptoms

When you view an Apps for Outlook app in Microsoft Outlook 2016 or Outlook 2013, the app does not load correctly, as shown in the following screenshot.

:::image type="content" source="media/apps-for-outlook-app-does-not-load-data/apps-for-outlook-app-not-loading-correctly.png" alt-text="Screenshot shows Bing Maps for Outlook app not loading correctly." border="false":::

> [!NOTE]
> This image shows an example of the issue in the Bing Maps app. However, other apps may also be affected.

## Cause

This problem occurs if the following registry data exists on the Outlook client:

Subkey:

`HKEY_CURRENT_USER\Software\Microsoft\Office\<x.0>\Common\Internet`

or

`HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<x.0>\Common\Internet`

DWORD: **UseOnlineContent**  
Value: **0** or **1**  

0 = Do not allow user to access Office 2013 resources on the Internet
1 = Allow user to opt in to access of Office 2013 resources on the Internet

> [!IMPORTANT]
> In the subkey path, the **x.0** placeholder represents your version of Office (16.0 = Office 2016, 15.0 = Office 2013).

This issue prevents the app from obtaining data from the Internet.

> [!NOTE]
> This problem does not occur if the `UseOnlineContent` value is **2**, because 2 means *Use Office Online content whenever available*.

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To resolve this issue, change the `UseOnlineContent` registry value data to **2**. To do this follow these steps.

1. Exit Outlook.
2. Start Registry Editor. To do this, use one of the following procedures, as appropriate for your version of Windows:

   - Windows 10, Windows 8.1 and Windows 8: Press Windows logo key+R to open a **Run** dialog box. Type *regedit.exe*, and then press **OK**.
   - Windows 7: Select **Start**, type *regedit.exe* in the **Start search** box, and then press **Enter**.

3. Type *regedit.exe*, and then press **Enter**.
4. Locate and then select the following registry subkey:

    `HKEY_CURRENT_USER\Software\Microsoft\Office\<x.0>\Common\Internet\`

    > [!NOTE]
    > In the subkey path, the *x.0* placeholder represents your version of Office (16.0 = Office 2016, 15.0 = Office 2013).

5. Locate and then double-click the following value:

   `UseOnlineContent`
6. In the **Value Data** box, type *2*, and then select **OK**.
7. Exit Registry Editor.

> [!NOTE]
> If the `UseOnlineContent` value is located under the Policies hive, it may have been created through Group Policy. In this case, your administrator will have to modify the policy to change this setting.

## More information

When this issue occurs, you find an event that resembles the following in the Microsoft Office Alerts log:

> Log Name: Microsoft Office Alerts  
Source: Microsoft Office 15 Alerts  
Event ID: 300  
Level: Error  
Details:  
App Error  
This app could not be started. Close this dialog to ignore the problem or click "Restart" to try again.  
P1: Apps for Office  
P2: 15.0.4675.1003  
P3: 0x80042FAE  
P4:
