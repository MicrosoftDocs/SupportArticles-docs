---
title: Error C0190003 after you install updates in Windows Server 2012 R2
description: Describes an issue that triggers an error when you restart a Windows Server 2012 R2-based computer after you install updates. A workaround is provided.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# Error C0190003 after you install updates in Windows Server 2012 R2

This article provides a workaround for an issue that triggers an error when you restart a Windows Server 2012 R2-based computer after you install updates.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3074603

## Symptoms

Consider the following scenario:

- You try to install many updates from Windows Update. This includes update 3000850.
- You're using a native 4K sector disk as a system drive.

However, after the update installation process finishes and the computer is restarted, you may receive one of the following error messages:

> Error C0190003 applying update operation 21417 of 247778 (wow64_microsoft-window

> Fatal error C0190003 applying update operation 19505 of 247778 (amd64_microsoft

> [!NOTE]
> The number of operations and file names may vary.

In this situation, the computer doesn't restart successfully.

## Cause

During the installation process, all the file operations (copy, move, and delete, for example) must be transactional. However, if there are lots of files to process, the transaction log may become full. In this situation, transactions are reverted, and the error message is displayed.

## Workaround

If you haven't installed the updates yet, you can work around this issue by increasing the transaction log size. To do this, open cmd.exe as an administrator, and then run the following command:

```console
fsutil resource setlog maxextents 100 C:\
```

> [!NOTE]
> This command increases the maximum number of containers for the boot drive (drive C) to 100. (The default value is 20.) If you set the value to 100 and still experience the same error, you may want to try a higher number.

If you've already experienced the issue that's described in the [Symptoms](#symptoms) section, you can recover from the issue by following these steps:

1. While the error message is displayed, press the power button to turn off the computer.
2. Press the power button and then immediately press the F8 key. This displays the **Advanced Boot Options** menu.
3. Select **Repair Your Computer**, and then press Enter.
4. On the **Choose an option** menu, select **Troubleshoot**.
5. On the **Advanced options** menu, select **Command Prompt**.
6. Select the administrator account, and then enter the password.
7. At a command prompt (cmd.exe), run the following command:

    ```console
    Dism /image:C:\ /cleanup-image /revertpendingactions
    ```

8. Close the command prompt.
9. On the **Choose an option** menu, select **Continue**.

## Status

Microsoft has confirmed that this is a problem in Windows Server 2012 R2.

## References

[Microsoft support policy for 4K sector hard drives in Windows](../backup-and-storage/support-policy-4k-sector-hard-drives.md)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
