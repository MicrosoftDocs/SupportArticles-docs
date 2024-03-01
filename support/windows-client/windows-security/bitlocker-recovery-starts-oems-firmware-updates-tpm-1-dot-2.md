---
title: BitLocker Recovery starts when OEMs perform firmware updates for TPM 1.2
description: Provides a workaround for the issue where BitLocker Recovery starts when OEMs perform firmware updates for TPM 1.2.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:bitlocker, csstroubleshoot
---
# BitLocker Recovery starts when OEMs perform firmware updates for TPM 1.2

This article provides a workaround for the issue where BitLocker Recovery starts when OEMs perform firmware updates for TPM 1.2.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3184518

## Symptoms

For Trusted Platform Module (TPM) 1.2, Windows does not know if the system is going through a firmware update. In this situation, the computer reboots into BitLocker Recovery.
  
[`Manage-bde`: protectors](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/ff829848(v=ws.11))

To suspend protection, run the following command line:

```console
manage-bde -protectors -disable c:
```

To resume protection, run the following command line:

```console
manage-bde -protectors -enable c: 
```

## Workaround

For IT managers who are performing firmware updates for TPM 1.2 through Windows Update, make sure that you suspend BitLocker before you run the updates. This prevents BitLocker Recovery from starting.

## More Information

Use TPM 2.0, as PCR 7 performs all these measurements automatically.
