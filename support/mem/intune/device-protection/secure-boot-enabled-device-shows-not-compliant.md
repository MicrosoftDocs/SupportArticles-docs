---
title: Secure boot enabled Windows 10 device shows Not Compliant in Intune
description: Describes a behavior that a Windows 10 device that has secure boot enabled is displayed as Not Compliant in Intune.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Create Windows policy
ms.reviewer: kaushika
---
# Windows 10 device with secure boot enabled shows as Not Compliant in Intune

This article expains a scenario where a Windows 10 device with secure boot enabled is shown as **Not Compliant** in Microsoft Intune.

## Symptom

You create a compliance policy for Windows 10 devices in Intune. You set the **Require Secure Boot to be enabled on the device** setting to **Require**.

:::image type="content" source="media/secure-boot-enabled-device-shows-not-compliant/require-secure-boot.png" alt-text="Screenshot of the Require Secure Boot to be enabled on the device setting.":::

In this scenario, a Windows 10 device that meets the requirement is marked as **Not Compliant**.

:::image type="content" source="media/secure-boot-enabled-device-shows-not-compliant/not-compliant.png" alt-text="Screenshot shows Require Secure Boot to be enabled on the device Not compliant.":::

## Cause

The **Require Secure Boot to be enabled on the device** setting is supported on some TPM 1.2 and 2.0 devices. For devices that don't support TPM 2.0 or later, the policy status in Intune shows as **Not Compliant**. TPM 2.0 requires UEFI firmware. A computer with legacy BIOS and TPM 2.0 won't work as expected.

For more information about supported versions, see [Supported versions for device health attestation](/windows/security/information-protection/tpm/trusted-platform-module-overview#supported-versions-for-device-health-attestation).

For more information about how mobile device management (MDM) solutions use the Health Attestation Service, see [Protect, control, and report on the security status of Windows 10-based devices](/windows/security/threat-protection/protect-high-value-assets-by-controlling-the-health-of-windows-10-based-devices#protect-control-and-report-on-the-security-status-of-windows-10-based-devices).

## More information

Use these steps to check whether your device meets the hardware requirements for the health attestation feature.

1. Check the TPM version.

    Type `tpm.msc` in the **Run** box, and then check the value in **Specification Version**.

    :::image type="content" source="media/secure-boot-enabled-device-shows-not-compliant/tpm-info.png" alt-text="Screenshot of TPM Management on Local Computer window, where the Specification Version is highlighted.":::

    > [!NOTE]
    > If the TPM version is 1.2 and your device supports TPM 2.0, contact your device manufacturer to update to TPM 2.0.

2. Open an elevated command prompt, and run the `msinfo32` command.

3. In **System Summary**, verify that **BIOS Mode** is **UEFI**, and **PCR7 Configuration** is **Bound**.

    :::image type="content" source="media/secure-boot-enabled-device-shows-not-compliant/system-information.png" alt-text="Screenshot of System Summary, where BIOS Mode is UEFI, and PCR7 Configuration is Bound.":::

4. Open an elevated PowerShell command prompt, and run the following command:

    ```powershell
    Confirm-SecureBootUEFI
    ```

    Verify that it returns the value of **True**.

5. Run the following PowerShell command:

    ```powershell
    manage-bde -protectors -get $env:systemdrive
    ```

    Verify that the drive is protected by PCR 7.

    :::image type="content" source="media/secure-boot-enabled-device-shows-not-compliant/pcr-validation-profile.png" alt-text="Screenshot of the PCR validation profile." border="false":::
