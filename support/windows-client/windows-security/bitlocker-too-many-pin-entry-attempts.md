---
title: Error after you enter BitLocker PIN at startup
description: Helps fix an error (Too many PIN entry attempts) that occurs after you enter a BitLocker PIN at Windows startup.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:bitlocker, csstroubleshoot
---
# Error after you enter a BitLocker PIN at Windows startup: Too many PIN entry attempts

This article helps fix an error (Too many PIN entry attempts) that occurs after you enter a BitLocker PIN at Windows startup.

_Applies to:_ &nbsp; Windows 10 version 1809 and later versions, Windows Server 2012 R2, Windows 7 Service Pack 1, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 4009797

## Symptoms

After you enter a BitLocker PIN at Windows startup on a new computer that is running an OEM version of Windows, you receive the following error message:

> Too many PIN entry attempts

## Cause

This issue occurs because the OEM doesn't reset the lockout count before shipping the device.

## Workaround

To work around this issue, try the following methods, in no particular order:

- Input the BitLocker recovery key.
- Wait until the unlock period expires, and then enter the correct PIN.
- Reinstall the operating system, and then reset the TPM chip.
- Unlock the drive or turn off BitLocker. To do it, follow these steps:

  1. At the BitLocker entry screen, press ESC to access other recovery options.
  2. Select the command prompt option.
  3. Enter **`Manage-bde`** to either unlock the system drive or turn off BitLocker. To do it, enter the appropriate command, and then press Enter:

     Unlock the system drive:

    ```console
    manage-bde -unlock <DriveLetter>: -recoverypassword <Password>
    manage-bde -unlock <DriveLetter>: -recoverykey <RecoveryKey>
    ```

    Turn off BitLocker:

    ```console
    manage-bde -off <DriveLetter>:
    ```

    For more information, see the following articles:

  - [`Manage-bde: unlock`](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/ff829854(v=ws.11))
  - [`Manage-bde: off`](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/ff829857(v=ws.11))

- Contact the OEM for support.

## More information

For more information about how to reset the TPM chip, see [Reset the TPM Lockout](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851452(v=ws.11)).
