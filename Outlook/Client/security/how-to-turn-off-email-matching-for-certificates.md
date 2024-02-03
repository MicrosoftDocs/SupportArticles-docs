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
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
search.appverid: MET150
ms.date: 03/31/2022
---
# How to turn off e-mail matching for certificates in Outlook

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Description of the Microsoft Windows registry](https://support.microsoft.com/help/256986).

_Original KB number:_ &nbsp; 276597

## Summary

When you send a secure message in Microsoft Outlook for Microsoft 365, Microsoft Outlook 2016, Microsoft Outlook 2013, Microsoft Outlook 2010, Microsoft Office Outlook 2007, Microsoft Office Outlook 2003, Microsoft Outlook 2002, or in Microsoft Outlook 2000, you may need to use a certificate that does not match your e-mail address. This article describes how to turn off e-mail matching for certificates.

## Resolution

You can turn off e-mail address matching for certificates by editing your registry. To do this, follow these steps, as appropriate for the version of Outlook that you are running.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

### Outlook for Microsoft 365 and Outlook 2016

1. Select **Start**, select **Run**, type *regedit* in the **Open** box, and then select **OK**.
2. Locate the registry key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Outlook\Security`.
3. If a Security registry key does not exist, create a new key. To do this, follow these steps:
    1. Select the registry key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Outlook`.
    2. On the **Edit** menu, point to **New**, and then select **Key**.
    3. Type *Security*, and then press Enter.

4. Right-click the **Security** key, select **New**, and then select **DWORD Value**.
5. Type *SupressNameChecks*, and then press Enter.
6. On the **Edit** menu, select **Modify**.
7. Type *1*, and then select **OK**.
8. On the **Registry** menu, select **Exit**.

### Outlook 2013

1. Select **Start**, select **Run**, type *regedit* in the **Open** box, and then select **OK**.
2. Locate the registry key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\15.0\Outlook\Security`.
3. If a Security registry key does not exist, create a new key. To do this, follow these steps:
    1. Select the registry key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\15.0\Outlook`.
    2. On the **Edit** menu, point to **New**, and then select **Key**.
    3. Type *Security*, and then press Enter.

4. Right-click the **Security** key, select **New**, and then select **DWORD Value**.
5. Type *SupressNameChecks*, and then press Enter.
6. On the **Edit** menu, select **Modify**.
7. Type *1*, and then select **OK**.
8. On the **Registry** menu, select **Exit**.

### Outlook 2010

1. Select **Start**, select **Run**, type regedit in the **Open** box, and then select **OK**.
2. Locate the following registry key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\14.0\Outlook\Security`.
3. If a Security registry key does not exist, create a new key. To do this, follow these steps:
    1. Select the registry key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\14.0\Outlook`.
    2. On the **Edit** menu, point to **New**, and then select **Key**.
    3. Type *Security*, and then press ENTER.

4. Right-click the **Security** key, select **New**, and then select **DWORD Value**.
5. Type *SupressNameChecks*, and then press Enter.
6. On the **Edit** menu, select **Modify**.
7. Type *1*, and then select **OK**.
8. On the **Registry** menu, select **Exit**.

### Outlook 2007

1. Select **Start**, select **Run**, type *regedit* in the **Open** box, and then select **OK**.
2. Locate the registry key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\12.0\Outlook\Security`.
3. If a Security registry key does not exist, create a new key. To do this, follow these steps:
    1. Select the registry key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\12.0\Outlook`.
    2. On the **Edit** menu, point to **New**, and then select **Key**.
    3. Type *Security*, and then press Enter.

4. Right-click the **Security** key, select **New**, and then select **DWORD Value**.
5. Type *SupressNameChecks*, and then press Enter.
6. On the **Edit** menu, select **Modify**.
7. Type *1*, and then select **OK**.
8. On the **Registry** menu, select **Exit**.

### Outlook 2003

1. Select **Start**, select **Run**, type *regedit* in the **Open** box, and then select **OK**.
2. Locate the registry key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\11.0\Outlook\Security`.
3. If a Security registry key does not exist, create a new key. To do this, follow these steps:
    1. Select the registry key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\11.0\Outlook`.
    2. On the **Edit** menu, point to **New**, and then select **Key**.
    3. Type *Security*, and then press ENTER.

4. Right-click the **Security** key, select **New**, and then select **DWORD Value**.
5. Type *SupressNameChecks*, and then press Enter.
6. On the **Edit** menu, select **Modify**.
7. Type *1*, and then select **OK**.
8. On the **Registry** menu, select **Exit**.

### Outlook 2002

1. Select **Start**, select **Run**, type *regedit* in the **Open** box, and then select **OK**.
2. Locate the registry key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\10.0\Outlook\Security`.
3. If a Security registry key does not exist, create a new key. To do this, follow these steps:
    1. Select the registry key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\10.0\Outlook`.
    2. On the **Edit** menu, point to **New**, and then select **Key**.
    3. Type *Security*, and then press Enter.

4. Right-click the Security key, select **New**, and then select **DWORD Value**.
5. Type *SupressNameChecks*, and then press Enter.
6. On the **Edit** menu, select **Modify**.
7. Type *1*, and then select **OK**.
8. On the **Registry** menu, select **Exit**.

### Outlook 2000

1. Select **Start**, select **Run**, type *regedit* in the **Open** box, and then select **OK**.
2. Locate the registry key: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\9.0\Outlook\Security`.
3. If a Security registry key does not exist, create a new key. To do this, follow these steps:
    1. Select the registry key: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\9.0\Outlook`.
    2. On the **Edit** menu, point to **New**, and then select **Key**.
    3. Type *Security*, and then press Enter.

4. Right-click the **Security** key, select **New**, and then select **DWORD Value**.
5. Type *SupressNameChecks*, and then press ENTER.
6. On the **Edit** menu, select **Modify**.
7. Type *1*, and then select **OK**.
8. On the **Registry** menu, select **Exit**.

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

To prevent Outlook from displaying this warning message, apply the registry change described in the Resolution section of this article and restart Outlook.
