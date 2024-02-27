---
title: AutoDiscover fails with error 0x80004005 or 0x8004010F
description: Discusses that Outlook AutoDiscover fails and generates a 0x80004005 error (Outlook 2013) or 0x8004010F error (Outlook 2010). Provides a resolution.
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
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook AutoDiscover fails with error 0x80004005 (Outlook 2013) or 0x8004010F (Outlook 2010)

_Original KB number:_ &nbsp; 2785498

## Symptoms  

Microsoft Outlook does not successfully configure an account automatically. When you use the Test E-mail AutoConfiguration tool, you receive output similar to the following on the Log tab:

- Outlook 2013

Local autodiscover for Contoso.com starting  
Local autodiscover for Contoso.com Failed (0x8004005)

- Outlook 2010

Local autodiscover for Contoso.com starting  
Local autodiscover for Contoso.com Failed (0x8004010F)

## Cause

This issue can occur when the following registry subkey exists and is empty:

`HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Outlook\AutoDiscover\Boot`

> [!NOTE]
> In this subkey, *x.0* is 15.0 for Outlook 2013 and 14.0 for Outlook 2010.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

Follow these steps to delete the \Boot subkey:

1. Exit Outlook if it is running.
2. Select **Start**, and then select **Run**. Copy and paste (or type) the *regedit* command in the **Open** box, and then press Enter.

3. Locate the following registry location:

    `HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Outlook\AutoDiscover\Boot`

    > [!NOTE]
    > In this subkey, *x.0* is 15.0 for Outlook 2013 and 14.0 for Outlook 2010.

    If the registry key exists, follow these steps to delete it:

    1. Select the following registry subkey: `HKEY_CURRENT_USER\Software\Microsoft\Office\c.0\Outlook\AutoDiscover\Boot`

       > [!NOTE]
       > In this subkey, *x.0* is 15.0 for Outlook 2013 and 14.0 for Outlook 2010.

    2. On the **Edit** menu, select **Delete**.
    3. When you are prompted to confirm the deletion, select **Yes**.
    4. Exit Registry Editor.
    5. Start Outlook.

## More information

Use the Test E-mail AutoConfiguration tool to help determine why AutoDiscover failed in Outlook. To do this, follow these steps:

1. Start Outlook.
2. Hold down the Ctrl key, right-click the Outlook icon in the notification area, and then select **Test E-mail AutoConfiguration**.
3. Verify that the correct email address is in the **E-mail Address** box.
4. In the **Test E-mail AutoConfiguration** window, clear the **Use Guessmart** check box and the **Secure Guessmart Authentication** check box.
5. Select the **Use AutoDiscover** check box, and then select **Test**.

> [!NOTE]
> In some cases, customers report that AppSense software re-creates the `\Boot` registry subkey under specific conditions. However, this does not necessarily occur. If AppSense software is used in a virtual environment, and if the administrator believes that the software may cause the `\Boot` registry subkey to be re-created, the administrator should contact AppSense for support.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
