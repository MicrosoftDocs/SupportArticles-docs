---
title: Outlook cannot connect or web services cannot work after migrated to Microsoft 365
description: Describes an issue that generates performance and connection problems for Outlook 2013. Occurs after your mailbox is migrated to Microsoft 365. A resolution is provided.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Outlook 2019
- Outlook 2016
- Outlook 2013
- Outlook for Microsoft 365
search.appverid: MET150
ms.reviewer: tasitae, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# Outlook doesn't connect or web services don't work after migration to Microsoft 365

## Symptoms

After your mailbox is migrated to Microsoft 365, you may experience the following issues:

- Outlook cannot connect to Exchange Server.
- You cannot use features such as Out of Office, meeting availability, mail tips, the online archive, or any other web services feature that relies on Autodiscover.
- You receive the following error message when you open Outlook:

  > Outlook cannot log on. Verify you are connected to the network and are using the proper server and mailbox name. The Microsoft Exchange information service in your profile is missing required information. Modify your profile to ensure that you are using the correct Microsoft Exchange information service.

## Cause

This issue occurs when the name of the pre-migration Autodiscover server is cached in your Outlook profile in the registry.

## Resolution

To resolve this issue, use one of the following methods.

Method 1: Use **ExcludeLastKnownGoodUrl** to prevent Outlook from using the last known good AutoDiscover URL

Configure one of the following registry subkeys as follows:

`HKEY_CURRENT_USER\Software\Microsoft\Office\<x.0>\Outlook\Autodiscover`  
DWORD: **ExcludeLastKnownGoodUrl**  
Value: 1

`HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<x.0>\Outlook\Autodiscover`  
DWORD: **ExcludeLastKnownGoodUrl**  
Value: 1

> [!NOTE]
> The <x.0> place holder represents your version of Office (**16.0** = Office 2016, Microsoft 365 and Office 2019, **15.0** = Office 2013).
>
> When the **ExcludeLastKnownGoodUrl** value is set to **1**, Outlook does _not_ use the last known working AutoDiscover URL.

Method 2: Create a new Outlook profile

1. Exit Outlook.
2. In Control Panel, select or double-click **Mail**.

    > [!NOTE]
    > To locate the *_Mail_* item, open Control Panel, and then in the **Search** box at the top of window, type _Mail_. In Control Panel in Windows XP, type _Mail_ in the **Address** box.

3. Select **Show Profiles**.
4. Select **Add**.
5. Type a name for the profile, and then select **OK**.
6. Follow the Add Account wizard to add your email account. When you're done, select **Finish**.
7. In **Mail**, make sure that **Always use this profile** is selected, and then select your new profile name from the list.

   :::image type="content" source="media/cannot-connect-web-service-not-working-migrated-to-office-365/outlook-mail-new-profile.png" alt-text="Creating a new Outlook profile." border="false":::

8. Select **OK**.

## More information

If you prefer, you can use Group Policy to control whether Outlook uses the last known working AutoDiscover URL. To do this, follow these steps:

1. Download the Office Group Policy template appropriate for your version of Office from the following Microsoft website:

    Office 2016: [Office 2016 Administrative Template files (ADMX/ADML) and Office Customization Tool](https://www.microsoft.com/download/details.aspx?id=49030)  
    Office 2013: [Office 2013 Administrative Template files (ADMX/ADML) and Office Customization Tool](https://www.microsoft.com/download/details.aspx?id=35554)

2. Add the Outlk##.admx and Outlk##.adml files to your domain controller.

    > [!NOTE]
    > To load the Administrative Template files, download the files, and then follow the instructions for "Loading the ADMX templates" in [Use Group Policy to enforce Office 2010 settings](/previous-versions/office/office-2010/cc179081(v=office.14)). Although this article targets Office 2010, the Administrative Templates information also applies to later versions of Office.
    >
    > The **##** placeholder represents your version of Office (**16** = Office 2016, Microsoft 365 and Office 2019, **15** = Office 2013).

3. Under **User Configuration**, expand **Administrative Templates**, expand your version of **Microsoft Outlook**, expand **Account Settings**, and then select **Exchange**.

4. Under **Exchange**, locate and then double-click the **Disable AutoDiscover** setting.

    Screenshot for Outlook 2016:

    :::image type="content" source="media/cannot-connect-web-service-not-working-migrated-to-office-365/disable-autodiscover-setting-in-outlook-2016.png" alt-text="Disable AutoDiscover Group Policy object for Outlook 2016.":::

    Screenshot for Outlook 2013:

    :::image type="content" source="media/cannot-connect-web-service-not-working-migrated-to-office-365/disable-autodiscover-setting-in-outlook-2013.png" alt-text="Disable AutoDiscover Group Policy Setting for Outlook 2013.":::

5. Select **Enabled**, and then in the **Options** pane, select **Exclude the last known good URL**.

   :::image type="content" source="media/cannot-connect-web-service-not-working-migrated-to-office-365/exclude-the-last-known-good-url-option.png" alt-text="The Exclude the last known good URL option.":::

6. Select **OK**.
