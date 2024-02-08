---
title: How to turn off e-mail matching for certificates
description: This article provides steps about how to turn off e-mail matching for certificates in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: sercast
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
search.appverid: MET150
ms.date: 02/07/2024
---
# How to turn off e-mail matching for certificates in Outlook

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Description of the Microsoft Windows registry](https://support.microsoft.com/help/256986).

## Summary

When you send a secure message in Outlook, you may need to use a certificate that doesn't match your e-mail address. This article describes how to turn off e-mail matching for certificates.

## Resolution

You can turn off e-mail address matching for certificates by editing your registry. To do so, follow these steps, as appropriate for the version of Outlook that you are running.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

### Outlook for Microsoft 365, Outlook 2019, and Outlook 2016

1. Select **Start** > **Run**, type *regedit* in the **Open** box, and then select **OK**.
1. Locate the registry key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Outlook\Security`.
1. If a Security registry key doesn't exist, follow these steps to create a new key:
    1. Select the registry key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Outlook`.
    1. On the **Edit** menu, point to **New**, and then select **Key**.
    1. Type *Security*, and then press Enter.
1. Right-click the **Security** key, select **New**, and then select **DWORD Value**.
1. Type *SupressNameChecks*, and then press Enter.
1. On the **Edit** menu, select **Modify**.
1. Type *1*, and then select **OK**.
1. On the **Registry** menu, select **Exit**.

### Outlook 2013

1. Select **Start** > **Run**, type *regedit* in the **Open** box, and then select **OK**.
1. Locate the registry key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\15.0\Outlook\Security`.
1. If a Security registry key doesn't exist, follow these steps to create a new key:
    1. Select the registry key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\15.0\Outlook`.
    1. On the **Edit** menu, point to **New**, and then select **Key**.
    1. Type *Security*, and then press Enter.
1. Right-click the **Security** key, select **New**, and then select **DWORD Value**.
1. Type *SupressNameChecks*, and then press Enter.
1. On the **Edit** menu, select **Modify**.
1. Type *1*, and then select **OK**.
1. On the **Registry** menu, select **Exit**.

### Outlook 2010

1. Select **Start**, select **Run**, type regedit in the **Open** box, and then select **OK**.
1. Locate the following registry key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\14.0\Outlook\Security`.
1. If a Security registry key doesn't exist, follow these steps to create a new key:
    1. Select the registry key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\14.0\Outlook`.
    1. On the **Edit** menu, point to **New**, and then select **Key**.
    1. Type *Security*, and then press ENTER.
1. Right-click the **Security** key, select **New**, and then select **DWORD Value**.
1. Type *SupressNameChecks*, and then press Enter.
1. On the **Edit** menu, select **Modify**.
1. Type *1*, and then select **OK**.
1. On the **Registry** menu, select **Exit**.

## More information

When you send an encrypted email message to a recipient, Outlook uses the recipient's certificate to secure the message. If the email address of the contact or recipient is different from the email address that is specified in the recipient's certificate, you receive the following warning:

> Encryption Problems
>
> Microsoft Outlook had problems encrypting this message because the following recipients had missing or invalid certificates, or conflicting or unsupported encryption capabilities:
>
> recipient name
>
> Continue will encrypt and send the message but the listed recipients may not be able to read it.
>
> Send UnencryptedContinueCancel

To prevent Outlook from displaying this warning message, apply the registry change described in the [Resolution](#resolution) section and restart Outlook.
