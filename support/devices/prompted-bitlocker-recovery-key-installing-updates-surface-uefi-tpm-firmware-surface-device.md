---
title: Prompted for BitLocker recovery key after installing updates to Surface UEFI or TPM firmware
description: Provides workarounds to the issue in which you're prompted for BitLocker recovery key after installing updates to Surface UEFI or TPM firmware on Surface device.
ms.date: 05/31/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: surface
localization_priority: medium
ms.reviewer: jarrettr, v-lianna
ms.custom: csstroubleshoot
ms.subservice: windows
---
# Prompted for BitLocker recovery key after installing updates to Surface UEFI or TPM firmware on Surface device

This article provides workarounds to the issue in which you're prompted for BitLocker recovery key after installing updates to Surface UEFI or TPM firmware on Surface device.

_Applies to:_ &nbsp; Surface Studio 1, Surface Pro 4, Surface Pro 3, Surface Book, Surface Laptop (1st Gen), Surface Pro (5th Gen), Surface Book 2 - 13 inch, Surface Pro with LTE Advanced, Surface Book 2 - 15 inch  
_Original KB number:_ &nbsp; 4057282

> [!IMPORTANT]
> This article contains information that shows you how to help lower security settings or how to turn off security features on a computer. You can make these changes to work around a specific problem. Before you make these changes, we recommend that you evaluate the risks that are associated with implementing this workaround in your particular environment. If you implement this workaround, take any appropriate additional steps to help protect the computer.

## Symptoms

You encounter one or more of the following symptoms on your Surface device:

- At startup, you're prompted for your BitLocker recovery key, and you enter the correct recovery key, but Windows doesn't start up.
- You boot directly into the Surface Unified Extensible Firmware Interface (UEFI) settings.
- Your Surface device appears to be in an infinite reboot loop.

## Cause

This behavior can occur in the following scenario:

- BitLocker is enabled and configured to use Platform Configuration Register (PCR) values other than the default values of PCR 7 and PCR 11, for example when:

  - Secure Boot is turned off.
  - PCR values have been explicitly defined, such as by Group Policy.

- You install a firmware update that updates the firmware of the device TPM or changes the signature of the system firmware. For example, you install the Surface dTPM (IFX) update.

> [!NOTE]
> You can verify the PCR values that are in use on a device by running the following command from an elevated command prompt:
>
> ```console
> manage-bde.exe -protectors -get <OSDriveLetter>:
> ```
>
> PCR 7 is a requirement for devices that support Connected Standby (also known as InstantGO or Always On, Always Connected PCs), including Surface devices. On such systems, if the TPM with PCR 7 and Secure Boot are correctly configured, BitLocker binds to PCR 7 and PCR 11 by default. For more information, see "About the Platform Configuration Register (PCR)" at [BitLocker group policy settings](/windows/security/information-protection/bitlocker/bitlocker-group-policy-settings).

## Workaround

> [!WARNING]
> BitLocker Drive Encryption helps you protect your organization's sensitive information by encrypting the data. This workaround to temporarily disable BitLocker may put the data at risk. We do not recommend this workaround but are providing this information so that you can implement this workaround at your own discretion. Use this workaround at your own risk.

### Method 1: Suspend BitLocker during TPM or UEFI firmware updates

You can avoid this scenario when installing updates to system firmware or TPM firmware by temporarily suspending BitLocker before applying updates to TPM or UEFI firmware by using [Suspend-BitLocker](/powershell/module/bitlocker/suspend-bitlocker).

> [!NOTE]
> TPM and UEFI firmware updates may require multiple reboots during installation. So suspending BitLocker must be done through the [Suspend-BitLocker](/powershell/module/bitlocker/suspend-bitlocker) cmdlet and using the `RebootCount` parameter to specify a number of reboots greater than 2 to keep BitLocker suspended during the firmware update process. A Reboot Count of 0 will suspend BitLocker indefinitely, until BitLocker is resumed through the PowerShell cmdlet [Resume-BitLocker](/powershell/module/bitlocker/resume-bitlocker) or another mechanism.

To suspend BitLocker for installation of TPM or UEFI firmware updates:

1. Open an administrative PowerShell session.
2. Enter the following cmdlet and press <kbd>Enter</kbd>:

    ```PowerShell
    Suspend-BitLocker -MountPoint "C:" -RebootCount 0
    ```

    where C: is the drive assigned to your disk.
3. Install Surface device driver and firmware updates.
4. Following successful installation of the firmware updates, resume BitLocker by using the [Resume-BitLocker](/powershell/module/bitlocker/resume-bitlocker) cmdlet as follows:

    ```PowerShell
    Resume-BitLocker -MountPoint "C:"
    ```

### Method 2: Enable Secure Boot and restore default PCR values

We strongly recommend that you restore the default and recommended configuration of Secure Boot and PCR values after BitLocker is suspended to prevent entering BitLocker Recovery when applying future updates to TPM or UEFI firmware.

To enable Secure Boot on a Surface device that has BitLocker enabled:

1. Suspend BitLocker by using the `Suspend-BitLocker` cmdlet as described in Method 1.
2. Boot your Surface device to UEFI by using one of the methods defined in [Using Surface UEFI on Surface Laptop, new Surface Pro, Surface Studio, Surface Book, and Surface Pro 4](https://support.microsoft.com/surface/how-to-use-surface-uefi-df2c8942-dfa0-859d-4394-95f45eb1c3f9).
3. Select the **Security** section.
4. Select **Change Configuration** under **Secure Boot**.
5. Select **Microsoft Only** > **OK**.
6. Select **Exit**, and then **Restart** to reboot the device.
7. Resume BitLocker by using the `Resume-BitLocker` cmdlet as described in Method 1.

To change the PCR values used to validate BitLocker Drive Encryption:

1. Disable any Group Policies that configure PCR, or remove the device from any groups where such policies apply. See "Deployment Options" at [BitLocker Group Policy Reference](/previous-versions/windows/it-pro/windows-7/ee706521(v=ws.10)) for more information.
2. Suspend BitLocker by using the `Suspend-BitLocker` cmdlet as described in Method 1.
3. Resume BitLocker by using the `Resume-BitLocker` cmdlet as described in Method 1.

### Method 3: Remove protectors from the boot drive

If you have installed a TPM or UEFI update and your device is unable to boot, even when the correct BitLocker Recovery Key is entered, you can restore the ability to boot by using the BitLocker recovery key and a Surface recovery image to remove the BitLocker protectors from the boot drive.

To remove the protectors from the boot drive by using your BitLocker recovery key:

1. Obtain your BitLocker recovery key from [Microsoft account](https://go.microsoft.com/fwlink/p/?LinkId=237614), or if BitLocker is managed by other means such as Microsoft BitLocker Administration and Monitoring (MBAM), contact your administrator.
2. From another computer, download the Surface recovery image from [Download a recovery image for your Surface](https://support.microsoft.com/surface-recovery-image) and create a USB recovery drive.
3. Boot from the USB Surface recovery image drive.
4. Select your operating system language when you are prompted.
5. Select your keyboard layout.
6. Select **Troubleshoot** > **Advanced Options** > **Command Prompt**.
7. Run the following commands:

    ```console
    manage-bde -unlock -recoverypassword <password>C:
    manage-bde -protectors -disable C:
    ```

    where C: is the drive assigned to your disk and \<password\> is your BitLocker recovery key as obtained in step 1.

    > [!NOTE]
    > For more information about using this command, see [Manage-bde: unlock](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/ff829854(v=ws.11)).

8. Reboot the computer.
9. When you are prompted, enter your BitLocker recovery key as obtained in step 1.

> [!NOTE]
> After disabling the BitLocker protectors from your boot drive, your device will no longer be protected by BitLocker Drive Encryption. You can re-enable BitLocker by selecting **Start**, typing *Manage BitLocker* and pressing <kbd>Enter</kbd> to launch the BitLocker Drive Encryption Control Panel applet and following the steps to encrypt your drive.

### Method 4: Recover data and reset your device with Surface Bare Metal Recovery (BMR)

To recover data from your Surface device if you are unable to boot into Windows:

1. Obtain your BitLocker recovery key from [Microsoft account](https://go.microsoft.com/fwlink/p/?LinkId=237614), or if BitLocker is managed by other means such as Microsoft BitLocker Administration and Monitoring (MBAM), contact your administrator.
2. From another computer, download the Surface recovery image from [Download a recovery image for your Surface](https://support.microsoft.com/en-us/surface-recovery-image) and create a USB recovery drive.
3. Boot from the USB Surface recovery image drive.
4. Select your operating system language when you are prompted.
5. Select your keyboard layout.
6. Select **Troubleshoot** > **Advanced Options** > **Command Prompt**.
7. Run the following command:

    ```console
    manage-bde -unlock -recoverypassword <password> C:
    ```

    where C: is the drive assigned to your disk and \<password\> is your BitLocker recovery key as obtained in step 1.
8. After the drive is unlocked, use `copy` or `xcopy` commands to copy the user data to another drive.

    > [!NOTE]
    > For more information about the these commands, see the [Windows Command Line Reference](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc771254(v=ws.11)).

To reset your device by using a Surface recovery image, follow the instructions in "How to reset your Surface using your USB recovery drive" at [Creating and using a USB recovery drive](https://support.microsoft.com/surface/creating-and-using-a-usb-recovery-drive-for-surface-677852e2-ed34-45cb-40ef-398fc7d62c07).