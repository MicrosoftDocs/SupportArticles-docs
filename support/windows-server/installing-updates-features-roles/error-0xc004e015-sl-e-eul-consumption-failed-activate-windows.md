---
title: Error 0xC004E015 (SL_E_EUL_CONSUMPTION_FAILED) when activating Windows
description: Provides a solution to an error 0xC004E015 (SL_E_EUL_CONSUMPTION_FAILED) when you try to activate Windows.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-naqviadil, v-lianna
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# Error 0xC004E015 (SL_E_EUL_CONSUMPTION_FAILED) when you activate Windows

This article helps fix the error 0xC004E015 that occurs when you activate Windows.

You receive the following error when you activate Windows:

> Error: 0xC004E015 On a computer running Microsoft Windows non-core edition, run 'slui.exe 0x2a 0xC004E015' to display the error text.

This error occurs because the *C:\\Windows\\System32\\spp\\store\\2.0\\tokens.dat* file is corrupted.

To resolve the issue, [rebuild the tokens.dat file](https://learn.microsoft.com/troubleshoot/windows-server/licensing-and-activation/rebuild-tokens-dotdat-file)

## More information

Normally, Windows can create a *tokens.dat* file. If you get an "Error: Product not found" error, run the following commands to reapply the Key Management Services (KMS) client key:

```console
cscript c:\windows\system32\slmgr.vbs /ipk <KMS Client Key>
cscript c:\windows\system32\slmgr.vbs /ato
```

> [!NOTE]
> You can get the \<KMS Client Key\> in [Key Management Services (KMS) client activation and product keys](/windows-server/get-started/kms-client-activation-keys) depending on your Windows version.
