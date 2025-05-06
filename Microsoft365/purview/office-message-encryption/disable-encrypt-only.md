---
title: Disabling the Encrypt-Only feature in Outlook
description: Describes how to update the DRM registry key to disable Encrypt-Only on the Encrypt list without also disabling Message Classification.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Encryption
  - CSSTroubleshoot
ms.reviewer: gbratton, nagarajp, mamcfadd
appliesto: 
  - Outlook 2016
search.appverid: MET150
ms.date: 06/24/2024
---

# How to disable the Encrypt-Only feature in Outlook

_Original KB number:_&nbsp;4493792

## Summary

In Microsoft Outlook for Microsoft 365, when you enable Microsoft Purview Message Encryption, **Encrypt-Only**  is added as a new ad-hoc template. **Encrypt-Only**  enables message encryption without rights restrictions. This article describes how to disable the **Encrypt-Only** option in Outlook.

For more information about the feature, see [Encrypt-Only option for emails](/azure/information-protection/configure-usage-rights#encrypt-only-option-for-emails).

## More information

You can disable the **Encrypt-Only** option on the **Encrypt**  list without also disabling Message Classification. To do this, apply the following registry key.

> [!WARNING]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:
>
> [322756](https://support.microsoft.com/help/322756/how-to-back-up-and-restore-the-registry-in-windows) How to back up and restore the registry in Windows

1. In Registry Editor, locate and select the following registry subkey:

   `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\DRM`

1. On the **Edit** menu, point to **New**, and then select **DWORD (32-bit) Value**.
1. Type **DisableEO**, and then press Enter.
1. In the **Detail** pane, right-click **DisableEO**, and then select **Modify**.
1. In the **Value data** box, type **1**, and then select **OK**.
1. On the **Edit** menu, point to **New**, and then select **String Value**.
1. Type **DefaultPermissionTemplateGuid**, and then press Enter.
1. In the **Detail** pane, right-click **DefaultPermissionTemplateGuid**, and then select **Modify**.
1. In the **Value data** box, type **irmdnf**, and then select **OK**.
1. Exit Registry Editor.
