---
title: No buttons to sign or encrypt emails
description: Describes how to configure Outlook to automatically show the Sign button and the Encrypt button in an email message after Outlook 2007 or 2010 has been configured for S/MIME.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, sbradley, gregmans
appliesto: 
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 01/30/2024
---
# After you obtain an S/MIME certificate, no buttons are available to sign or encrypt email messages in Outlook 2007 and in Outlook 2010

_Original KB number:_ &nbsp; 2482059

## Summary

Microsoft Office Outlook 2007 and Outlook 2010 can configure S/MIME automatically if a valid S/MIME certificate that matches your email address is available in Windows. However, this process must be manually initiated by accessing the **E-mail Security** option in the **Trust Center** in Microsoft Outlook.

This article describes how you or an administrator can use a registry setting to force Outlook to show the **Sign** and **Encrypt** buttons on the Ribbon, even though S/MIME has not yet been fully configured. After the registry setting is enabled, and the **Sign** and **Encrypt** buttons are displayed, the first time either button is select, the automatic configuration of S/MIME is initiated and completed. From that point forward, you can choose to sign or encrypt any email message.

## More information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To force Outlook 2007 or Outlook 2010 to show the **Sign** and **Encrypt** buttons, add the `SecurityAlwaysShowButtons` value to the registry. To do this, follow these steps:

1. Exit Outlook.
2. Start Registry Editor.

    In Windows Vista or in Windows 7: Select **Start**, type *regedit* in the **Start Search** box, and then press Enter.

    If you are prompted for an administrator password or for confirmation, type the password, or select **Continue**.

    In Windows XP: Select **Start**, select **Run**, type *regedit*, and then select **OK**.

3. Locate and then right-click the following registry subkey, as appropriate for the version of Outlook that you are running:

   - In Outlook 2007

     `HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Outlook\Preferences`

   - In Outlook 2010

     `HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Outlook\Preferences`

4. In the **Edit** menu, point to **New**, and then select **DWORD Value**.
5. Type SecurityAlwaysShowButtons , and then press Enter.
6. Right-click **SecurityAlwaysShowButtons**, and then select **Modify**.
7. In the **Value data** box, type *1*, and then select **OK**.
8. Exit Registry Editor.

Typically, before the **Sign** and **Encrypt** Ribbon controls are available, you must specify which certificates are to be used for signing and for encrypting. In a deployment scenario, it would be better to specify the S/MIME settings automatically instead of requiring users to manually specify the settings in the **Trust Center** dialog box. There is no deployment mechanism for S/MIME settings. However, the `SecurityAlwaysShowButtons` registry value provides an alternative method.

If the S/MIME certificates are deployed to the client computers, Outlook automatically configures the settings if you specify that you want a message to be signed or encrypted. If the Ribbon controls are not displayed by configuring the `SecurityAlwaysShowButtons` registry value, it is difficult to specify that you want the message to be signed or encrypted. After you enable the registry setting, the Ribbon controls are always available.

## Troubleshooting

> [!NOTE]
> If a valid S/MIME certificate is not present, and you try to sign or encrypt a message, the signing or encryption operation fails. Additionally, you receive the following error message:
>
> Microsoft Office Outlook could not sign or encrypt this message because you have no certificates which can be used to send from the e-mail address 'e-mail address'. You can do either of the following:
>
> Get a new digital ID to use with this account. On the Tools menu, click Options, click the Security tab, and then click Get a Digital ID.
>
> Use the Accounts button to send the message using an account that you have certificates for.

There must be a valid S/MIME certificate on the computer that Outlook can find and use for S/MIME purposes.

If you use the **Sign** or **Encrypt** buttons, and an error occurs, you can troubleshoot the manual S/MIME configuration in Outlook. To do this, follow these steps, as appropriate for the version of Outlook that you are running.

### Outlook 2010

1. In Outlook, select the **File** tab on the Ribbon, and then select **Options**.
2. In the **Outlook Options** dialog box, select **Trust Center** in the navigation pane on the left side.
3. Select the **Trust Center Settings** button in the details pane on the right side.
4. In the **Trust Center** dialog box, select **E-mail Security** in the navigation pane on the left side.
5. Select the **Settings** button in the details pane on the right side.

If the **Signing Certificate** and **Encryption Certificate** text boxes are blank, these blank boxes indicate that Outlook cannot automatically associate an S/MIME certificate with the email address that is specified in your email account. To try to configure the certificate(s) manually, select the **Choose** buttons.

### Outlook 2007

1. In Outlook, select the **Tools** menu, and then select **Trust Center**.
2. In the **Trust Center** dialog box, select **E-mail Security** in the navigation pane on the left side.
3. Select the **Settings** button in the details pane on the right side.

If the Welcome to E-mail Security Wizard starts, it indicates that Outlook cannot automatically associate an S/MIME certificate with the email address that is specified in your email account.

### View installed certificates

To determine which S/MIME certificates are installed in Windows, follow these steps:

1. Start Registry Editor.

    In Windows Vista or in Windows 7: Select **Start**, type *certmgr.msc* in the **Start Search** box, and then press Enter.

    If you are prompted for an administrator password or for confirmation, type the password, or select **Continue**.

    In Windows XP: select **Start**, select **Run**, type *certmgr.msc*, and then select **OK**.

2. Expand the **Personal** node, and below this node, expand the **Certificates** node.
