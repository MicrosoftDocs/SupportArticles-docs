---
title: Error 0x8004010F when sending or receiving email
description: Resolves an issue in which you receive a 0x8004010F error when you try to send or receive email messages.
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
ms.reviewer: danv
appliesto:
- Outlook 2013
- Microsoft Outlook 2010
search.appverid: MET150
---
# Error 0x8004010F when you try to send or receive email in Outlook 2010 or Outlook 2013

_Original KB number:_ &nbsp; 2659085

## Summary

This issue is caused by the corrupted Outlook profile. You can try to create a new profile to resolve the issue.

## Symptoms

When you try to send or to receive email in Outlook 2010, you may receive one of these error messages:

> 0x8004010F: Outlook data file cannot be accessed.

or

> 0x8004010F: The operation failed. An object could not be found.

## Resolution

To resolve error **0x8004010F**, identify the current location of your default Outlook data file, and then create a new Outlook profile. To do this follow these steps:

### Step 1 - Locate the default Outlook data file

1. Select **Start**, and then select **Control Panel**.
2. In Control Panel, select **Mail**.
3. In the **Mail Setup - Outlook** dialog box, select **Show Profiles**.

   :::image type="content" source="media/error-0x8004010f-when-sending-or-receiving-emails/show-profiles.jpg" alt-text="In the Mail Setup - Outlook dialog box, select Show Profiles" border="false":::

4. Select your current Outlook profile, and then select **Properties**.

   :::image type="content" source="media/error-0x8004010f-when-sending-or-receiving-emails/properties.jpg" alt-text="Select your current Outlook profile, and then select Properties" border="false":::

5. In the **Mail Setup - Outlook** dialog box, select **Data Files**.

   :::image type="content" source="media/error-0x8004010f-when-sending-or-receiving-emails/data-files.jpg" alt-text="In the Mail Setup - Outlook dialog box, select Data Files" border="false":::

6. Select the **Data Files** tab in the **Account Settings** dialog box, and then note the name and location of the default data file for your profile (a check mark will denote the default data file).

   :::image type="content" source="media/error-0x8004010f-when-sending-or-receiving-emails/data-files-tab-on-account-settings.jpg" alt-text="Select the Data Files tab in the Account Settings dialog box" border="false":::

7. Select **Close**.

### Step 2 - Create a new Outlook profile

> [!VIDEO https://videoplayercdn.osi.office.net/embed/7ef2bbef-531d-4165-809f-7b928486d318]

#### Method 1 - Use auto account setup to create an IMAP or POP3 email account

>
> [!IMPORTANT]
> If your email server supports both IMAP and POP3, auto account setup will create an IMAP account by default. You will need to follow the manual steps in order to create a POP3 account. However, if your email server supports ONLY a POP3, auto account setup will create a POP3 account.

1. Select **Start**, and then select **Control Panel**.
2. In the **Mail Setup - Outlook** dialog box, select **Show Profiles**.

   :::image type="content" source="media/error-0x8004010f-when-sending-or-receiving-emails/show-profiles.jpg" alt-text="In the Mail Setup - Outlook dialog box, select Show Profiles" border="false":::

3. On the **General** tab in the **Mail** dialog box, select **Add**.

   :::image type="content" source="media/error-0x8004010f-when-sending-or-receiving-emails/add.jpg" alt-text="select Add in the Mail dialog box" border="false":::

4. In the **New Profile** dialog box, type a new profile name, and then select **OK**.
5. In the **Add New Account** dialog box, type your email account information, and then select **Next**.

   :::image type="content" source="media/error-0x8004010f-when-sending-or-receiving-emails/add.jpg" alt-text="In the Add New Account dialog box, type your email account information" border="false":::

6. After your account is successfully configured, select **Finish**.

#### Method 2 - Manually create an IMAP or POP3 email account

1. Select **Start**, and then select **Control Panel**.
2. In the **Mail Setup - Outlook** dialog box, select **Show Profiles**.

   :::image type="content" source="media/error-0x8004010f-when-sending-or-receiving-emails/show-profiles.jpg" alt-text="In the Mail Setup - Outlook dialog box, select Show Profiles" border="false":::

3. On the **General** tab in the **Mail** dialog box, select **Add**.

   :::image type="content" source="media/error-0x8004010f-when-sending-or-receiving-emails/add.jpg" alt-text="select Add in the Mail dialog box" border="false":::

4. In the **New Profile** dialog box, type a new profile name, and then select **OK**.
5. In the **Add New Account** dialog box, select **Manually configure server settings or additional server types**, and then select **Next**.

   :::image type="content" source="media/error-0x8004010f-when-sending-or-receiving-emails/manually-configure-server-settings-or-additional-server-types.jpg" alt-text="select Manually configure server settings or additional server types" border="false":::

6. In the **Choose Service** dialog box, select **Internet E-mail**, and then select **Next**.

   :::image type="content" source="media/error-0x8004010f-when-sending-or-receiving-emails/the-internet-e-mail-option.jpg" alt-text="In the Choose Service dialog box, select Internet E-mail" border="false":::

7. In the **Internet E-mail Settings** dialog box, type your account details.
8. Select **Test Account Settings** to test your account.

    > [!NOTE]
    > Contact your Internet service provider if you are unsure of the correct account details.

9. Select **Existing Outlook Data File**, and then select **Browse**.

   :::image type="content" source="media/error-0x8004010f-when-sending-or-receiving-emails/existing-outlook-data-file.jpg" alt-text="Select Existing Outlook Data File, and then select Browse" border="false":::

10. In the **Open Outlook Data File** dialog box, browse to and then select the Outlook data file you previously located. Select **OK**.
11. Select **Next**.
12. In the **Test Account Settings** dialog box, select **Close**.
13. Select **Finish**.

### Step 3 - Configure your new Outlook profile as the default profile

If you want to set the new Outlook profile as the default profile, follow these steps:

1. On the **General** tab of the **Mail** dialog box, select **Always use this profile**.
2. Select the drop-down under **Always use this profile**, and then select the new profile.
3. Select **OK** to close the **Mail** dialog box.

## More information

If you have several non default .pst files and need to include them in your Outlook profile, follow these steps:

1. Start Outlook.
2. On the **File** tab, select **Open**.
3. Select **Open Outlook Data File**.
4. Browse to the folder location that contains your other .pst file, select it, and then select **OK**.

The newly added .pst file will appear in the **Navigation** pane.
