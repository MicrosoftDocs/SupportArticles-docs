---
title: Error 0xC004E015 (SL_E_EUL_CONSUMPTION_FAILED) when activating Windows
description: Provides a solution to an error 0xC004E015 (SL_E_EUL_CONSUMPTION_FAILED) when you try to activate Windows.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-naqviadil, v-lianna, cwhitley
ms.custom:
- sap:windows activation\windows activation issues
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Error 0xC004E015 (SL_E_EUL_CONSUMPTION_FAILED) when you activate Windows

This article helps fix the error 0xC004E015 that occurs when you activate Windows.

You receive the following error when you activate Windows:

> Error: 0xC004E015 On a computer running Microsoft Windows non-core edition, run 'slui.exe 0x2a 0xC004E015' to display the error text.

This error occurs because the *C:\\Windows\\System32\\spp\\store\\2.0\\tokens.dat* file is corrupted.

To resolve the issue, [rebuild the tokens.dat file](../licensing-and-activation/rebuild-tokens-dotdat-file.md) and activate Windows again.

[!INCLUDE [virtual-machines-windows-activation-troubleshoot-tools](~/includes/azure/virtual-machines-windows-activation-troubleshoot-tools.md)]

## More information

Normally, Windows can create a *tokens.dat* file. If you get an "Error: Product not found" error, run the following commands to reapply the Key Management Services (KMS) client key:

```console
cscript c:\windows\system32\slmgr.vbs /ipk <KMS Client Key>
cscript c:\windows\system32\slmgr.vbs /ato
```

> [!NOTE]
> You can get the \<KMS Client Key\> in [Key Management Services (KMS) client activation and product keys](/windows-server/get-started/kms-client-activation-keys) depending on your Windows version.
