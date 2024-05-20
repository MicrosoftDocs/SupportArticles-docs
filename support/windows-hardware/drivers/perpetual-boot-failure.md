---
title: Perpetual Boot failure with a prompt
description: This article provides resolutions for the problem where a prompt at boot time stating that Windows did not boot properly.
ms.date: 09/01/2020
ms.custom: sap:Windows Embedded POSReady 7
ms.reviewer: jtanner
ms.subservice: general
---
# Perpetual Boot failure with 'Boot Windows Normally' prompt

This article helps you resolve the problem where a prompt at boot time stating that Windows did not boot properly.

_Original product version:_ &nbsp; Windows Embedded POSReady 7, Windows Embedded Standard 7, Windows Embedded Standard 7 Service Pack 1  
_Original KB number:_ &nbsp; 2689822

## Symptoms

OEMs and their customers encounter a prompt at boot time stating that Windows did not boot properly requesting whether to 'boot Windows normally'.

## Cause

Embedded systems are frequently shut down unceremoniously and may be shut down with Enhanced Write Filter (EWF) enabled. Either scenario will not allow Windows to shut down normally.

## Resolution

For systems where either cause can occur frequently, the bcdedit utility build into the operating system can be used to prevent the prompt. Follow this procedure:

1. Power up the machine and log in as local Administrator.

1. Disable EWF, reboot, and log in again.

1. Run this command from a command prompt with administrator privileges:

    ```console
    bcdedit /set {current} bootstatuspolicy ignoreallfailures
    ```

1. Reboot the machine, and log in again.

1. Enable EWF, reboot, log in again.

1. Shut down the machine normally (do not power off).

1. Power up the machine and log in.

1. If you now power of the machine and reboot the message should not occur.

## More information

To disable or enable EWF on a drive, within a command prompt, which has administrator privileges you would use a command like:

```console
ewfmgr c: -disable
```

or

```console
ewfmgr c: -enable
```

Additional commands, see [EWF Manager Commands](/previous-versions/windows/embedded/ms940853(v=winembedded.5)).
