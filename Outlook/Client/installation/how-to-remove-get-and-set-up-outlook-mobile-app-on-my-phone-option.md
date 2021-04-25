---
title: Remove Get and set up Outlook Mobile app on my phone option
description: Discusses how to disable the Get and set up Outlook Mobile app on my phone option from Outlook.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
- Outlook for Windows
- CSSTroubleshoot
ms.reviewer: tasitae, meerak
appliesto:
- Outlook 2019
- Outlook 2016
- Outlook for Office 365
search.appverid: MET150
---
# How to remove the Get and set up Outlook Mobile app on my phone option from Outlook

_Original KB number:_ &nbsp; 4010175

## About the Get and set up the Outlook Mobile app on my phone option

Microsoft Outlook 2016, Outlook 2019, and Outlook for Office 365 offer an option to set up the Outlook Mobile app for your phone. The option appears in three places in Outlook:

- When you select the **Drafts** folder in Outlook 2016, Outlook 2019, or Outlook for Office 365, the following link appears in the right side panel:

   **Get to your drafts on the go with the Outlook mobile app**

   :::image type="content" source="media/how-to-remove-get-and-set-up-outlook-mobile-app-on-my-phone-option/get-to-your-drafts-on-the-go-with-the-outlook-mobile-app.png" alt-text="the Get to your drafts on the go with the Outlook mobile app link":::

- When you select the **File** tab in Outlook 2016, Outlook 2019, or Outlook for Office 365, the following link appears under **Account Settings**:

   **Get the Outlook app for iPhone, iPad, Android, or Windows 10 Mobile.**

   :::image type="content" source="media/how-to-remove-get-and-set-up-outlook-mobile-app-on-my-phone-option/get-the-outlook-app-for-iphone-ipad-android,-or-windows-10-mobile.png" alt-text="Outlook 2016 - Get the Outlook app for iPhone, iPad, Android, or Windows 10 Mobile" border="false":::

- The final page of the **Add Account** wizard in Outlook 2016, Outlook 2019, or Outlook for Office 365 contains a check box that has the following label:

  **Set up Outlook Mobile on my phone, too.**

  :::image type="content" source="media/how-to-remove-get-and-set-up-outlook-mobile-app-on-my-phone-option/set-up-outlook-mobile-on-my-phone.png" alt-text="Outlook 2016 - Set up Outlook Mobile on my phone too" border="false":::

## How to remove this option in Outlook 2016, Outlook 2019, and Outlook for Office 365

### Method 1

You can remove this option by adding and configuring the `DisableOutlookMobileHyperlink` registry entry, as follows.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

1. Exit Outlook 2016, Outlook 2019, or Outlook for Office 365.
2. Start Registry Editor. (To do this, press Windows logo key+R, type *regedit.exe* in the **Open** box, and then select **OK**.)
3. In Registry Editor, locate and select one of the following subkeys:

   - HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Options\General\  
   - HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\Outlook\Options\General\

4. On the **Edit** menu, select **New**, and then select **DWORD (32-bit) Value**.
5. Type **DisableOutlookMobileHyperlink**.
6. Select and hold (or right-click) **DisableOutlookMobileHyperlink**, and then select **Modify**.
7. In the **Value data**  box, type *1*, and then select **OK**.
8. Exit Registry Editor.

### Method 2

You can remove this option in the Local Group Policy Editor by setting **Disable Outlook Mobile Hyperlink** to **Enabled**.

1. Select **Search**, type *gpedit*, and then select **Edit Group Policy**.
2. Select **User Configuration** > **Policies** > **Administrative Templates**, and then select **Microsoft Outlook 2016** > **Outlook Options** > **Other**.

   :::image type="content" source="media/how-to-remove-get-and-set-up-outlook-mobile-app-on-my-phone-option/other.png" alt-text="Other" border="false":::

3. Right-click **Disable Outlook Mobile Hyperlink**, and select **Edit**.
4. Select **Enabled**, and then select **OK**.
5. Exit Local Group Policy Editor.
