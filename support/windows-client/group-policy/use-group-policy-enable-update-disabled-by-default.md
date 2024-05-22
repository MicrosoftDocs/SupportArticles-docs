---
title: Use Group Policy to enable a disabled by default update
description: Describes how to configure Group Policy to enable an update that's disabled by default.
ms.date: 05/22/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-lianna, v-tanjoh
ms.custom: sap:Group Policy\Problems applying Group Policy, csstroubleshoot
---
# How to use Group Policy to enable an update that's disabled by default

This article describes how to configure Group Policy to use a feature preview policy definition that activates a preview update on managed devices.

_Applies to:_ &nbsp; Windows Server 2019 (version 1809) and later versions, Windows 10, version 1809 and later versions

## Summary

Certain updates are shipped in a disabled state with the intent to enable them in a later update. While in a disabled state, enterprises can enable these updates via Group Policy to preview the change and confirm that it works as expected. This preview is temporary. After a new update is released to enable the change by default, the preview is no longer necessary.

> [!Important]
> This preview only applies to non-security updates. Security updates aren't available for preview.

Microsoft manages the deployment process for non-enterprise devices. For enterprise devices, Microsoft provides policy definition MSI files. Enterprises can then use Group Policy to deploy in hybrid Microsoft Entra ID or Active Directory Domain Services (AD DS) domains.

> [!Note]
> You must restart the affected computers for the Group Policy change to take effect.

## Apply a preview to a single device using Group Policy

To use Group Policy to apply a preview to a single device, follow these steps:

1. Download the policy definition MSI file to the device as instructed by Microsoft Support.

    > [!Important]
    > Make sure that the operating system (OS) that is listed in the `.msi` file name matches the OS of the device that you want to update.

2. Run the `.msi` file on the device. This action installs the policy definition in the Administrative Template.
3. Open the Local Group Policy Editor. To do this, select **Start**, and then enter *gpedit.msc*.
4. Select **Local Computer Policy** > **Computer Configuration** > **Administrative Templates** > **KB <#######> Feature Preview** > **Windows 10/11, version \<YYMM\>**.

    > [!Note]
    > In this step, \<#######\> is the KB article number of the update where the change is shipped, and \<YYMM\> is the Windows 10 or Windows 11 version number.

5. Right-click the policy, and then select **Edit** > **Enabled** > **OK**.
6. Restart the device.

For more information about how to use the Local Group Policy Editor, see [Working with the Administrative Template policy settings using the Local Group Policy Editor](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn789184(v=ws.11)).

## Apply a preview to devices in a hybrid Microsoft Entra ID or AD DS domain using Group Policy

To apply a velocity policy definition to devices that belong to a hybrid Microsoft Entra ID or AD DS domain, follow these steps:

1. [Download and install the MSI files](#1-download-and-install-the-msi-files).
2. [Create a Group Policy Object (GPO)](#2-create-a-gpo).
3. [Configure the GPO](#3-configure-the-gpo).
4. [Monitor the GPO results](#4-monitor-the-gpo-results).

### 1. Download and install the MSI files

1. Obtain the `.msi` file from your Microsoft Customer Service and Support (CSS) counterpart as instructed by Microsoft Support when applicable.
2. Download the velocity policy definition `.msi` files that you require to update to the computer that you use to manage Group Policy for your domain.
3. Run the `.msi` files. This action installs the velocity policy definition in the Administrative Template.

    > [!Note]
    > Policy definitions are installed in the *C:\\Windows\\PolicyDefinitions* folder. If you have implemented the Group Policy [Central Store](create-and-manage-central-store.md#the-central-store), you must copy the `.admx` and `.adml` files to the Central Store.

### 2. Create a GPO

1. Open Group Policy Management Console, and then select **Forest: \<DomainName\>** > **Domains**.
2. Right-click your domain name, and then select **Create a GPO in this domain, and link it here**. Alternatively, you can create and apply it to the preferred container in the domain based on the location of the target computer accounts.
3. Enter the name of the new GPO (for example, *Preview \<######\>*), and then select **OK**.

For more information about how to create GPOs, see [Create a Group Policy Object](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj717274(v=ws.11)).

### 3. Configure the GPO

To edit your GPO:

1. Right-click the GPO that you created previously, and then select **Edit**.
2. In the Group Policy Editor, select **\<GPOName\>** > **Computer Configuration** > **Administrative Templates** > **KB ####### Issue XXX Feature Preview** > **Windows 10, version \<YYMM\>**.
3. Right-click the policy, and then select **Edit** > **Enabled** > **OK**.

For more information about how to edit GPOs, see [Edit a Group Policy object from GPMC](/previous-versions/windows/it-pro/windows-server-2003/cc759123(v=ws.10)).

### 4. Monitor the GPO results

In the default configuration of Group Policy, managed devices should apply the new policy within 90 to 120 minutes. To speed up this process, you can run `gpupdate` on affected devices to manually check for updated policies.

Make sure that each affected device restarts after it applies the policy.

> [!Important]
> The feature preview will be enabled after the device applies the policy and then restarts.

## Deploy a preview using Microsoft Intune ADMX policy ingestion to the managed devices

> [!Note]
> To use the solutions in this section, you must install the cumulative update that was released on [July 26, 2022](https://support.microsoft.com/topic/july-26-2022-kb5015878-os-builds-19042-1865-19043-1865-and-19044-1865-preview-549f5551-fcc5-4fee-8811-c5df12e04d40) or a later one on the computer.

Group policies and GPOs aren't compatible with mobile device management (MDM) based solutions, such as Microsoft Intune. These instructions will guide you through how to use [Intune custom settings](/mem/intune/configuration/custom-settings-windows-10) for [ADMX ingestion](/windows/client-management/win32-and-centennial-app-policy-configuration) and configure [ADMX backed MDM policies](/windows/client-management/understanding-admx-backed-policies) to enable a preview without requiring a GPO.

To enable a preview on Intune-managed devices, follow these steps:

1. [Download and install the MSI file to get ADMX files](#1-download-and-install-the-msi-files).
2. [Create a custom configuration profile in Microsoft Intune](#2-create-a-custom-configuration-profile-in-microsoft-intune).
3. [Monitor preview enablement](#3-monitoring-the-preview).

### 1. Download and install the preview MSI file to get ADMX files

1. Download the required velocity policy definition `.msi` files on the machine you use to sign in to Microsoft Intune.

    > [!Note]
    > You need access to the contents of an ADMX file.

2. Run the `.msi` files. This action installs the velocity policy definition in the Administrative Template.

    > [!Note]
    > Policy definitions are installed in the *C:\\Windows\\PolicyDefinitions* folder.
    >
    > If you want to extract the ADMX files to another location, use the `msiexec` command with the [TARGETDIR](/windows/win32/msi/targetdir) property. For example: `msiexec /i c:\admx_file.msi /qb TARGETDIR=c:\temp\admx`.

### 2. Create a custom configuration profile in Microsoft Intune

To configure devices to perform activation, you need to create a custom configuration profile for each OS of your managed devices. To create a custom profile, follow these steps:

1. [Select properties and add basic information of the profile](#a-select-properties-and-add-basic-information-about-the-profile).
2. [Add custom configuration settings to ingest ADMX files](#b-add-custom-configuration-settings-to-ingest-admx-files).
3. [Add custom configuration settings to set the new policy](#c-add-custom-configuration-settings-to-set-the-new-velocity-policy).
4. [Assign devices to the custom configuration profile](#d-assign-devices-to-the-preview-activation-custom-configuration-profile).
5. [Review and create the custom configuration profile](#e-review-and-create-the-preview-activation-custom-configuration-profile).

#### A. Select properties and add basic information about the profile

1. Sign in to the [Microsoft Intune admin center](https://intune.microsoft.com/#home).
2. Select **Devices** > **Configuration profiles** > **Create profile**.
3. Select the following properties:

    - **Platform: Windows 10 and later**
    - **Profile: Templates > Custom**

4. Select **Create**.
5. In **Basics**, enter the following properties:

    - **Name**: Enter a descriptive name for the policy. Name your policies so you can identify them later. For example, a possible policy name is "Preview \<######\> – Windows 10 21H2."
    - **Description**: Enter a description for the policy. This setting is optional but recommended.

    > [!Note]
    > Platform and Profile type should already have values selected.

6. Select **Next**.

> [!Note]
> For more information about creating custom configuration profiles and configuration settings, see [Use custom device settings in Microsoft Intune](/mem/intune/configuration/custom-settings-configure).

Before proceeding to the next two steps, open the ADMX file in a text editor (for example, Notepad) where the file was extracted. The ADMX file should be in the path *C:\\Windows\\PolicyDefinitions* if you installed it as an MSI file.

Here's an example of the ADMX file:

```xml
  <policies>  
    <policy name=" KB5034129_240124_0305_3_FeaturePreview" … >  
      <parentCategory ref=" KnownIssueRollback_Server_2022" />  
      <supportedOn ref=" SUPPORTED_Windows_10_0_Server_2022_Only" />  
      <enabledList…> … </enabledList>  
      <disabledList…>…</disabledList>  
    </policy>  
  </policies>
```

Record the values for `policy name` and `parentCategory`. This information is in the `policies` node at the end of the file.

#### B. Add custom configuration settings to ingest ADMX files

This configuration setting is used to install the policy on target devices. Follow these steps to add the ADMX ingestion settings:

1. In **Configuration settings**, select **Add**.
2. Enter the following properties:

    - **Name**: Enter a descriptive name for the configuration setting. Name your settings so you can identify them later. For example, "ADMX Ingestion: 04/30 Preview – Windows 10 21H2."
    - **Description**: Enter a description for the setting. This setting is optional but recommended.
    - **OMA-URI**: Enter the string *./Device/Vendor/MSFT/Policy/ConfigOperations/ADMXInstall/KIR/Policy/\<ADMX Policy Name\>*.

        > [!Note]
        > Replace \<ADMX Policy Name\> with the value of the recorded policy name from the ADMX file. For example, " KB5034129_240124_0305_3_FeaturePreview ".

    - **Data type**: Select **String**.
    - **Value**: Open the ADMX file with a text editor (for example, Notepad). Copy and paste the entire contents of the ADMX file you intend to ingest into this field.

3. Select **Save**.

#### C. Add custom configuration settings to set the new velocity policy

This configuration setting is used to configure the preview policy, which is defined in the previous step.

Follow these steps to add the activation configuration settings:

1. In **Configuration settings**, select **Add**.
2. Enter the following properties:

    - **Name**: Enter a descriptive name for the configuration setting. Name your settings so you can identify them later. For example, "Velocity Preview: 04/30 Preview ###### – Windows 10 21H2."
    - **Description**: Enter a description for the setting. This setting is optional but recommended.
    - **OMA-URI**: Enter the string *./Device/Vendor/MSFT/Policy/Config/KIR~Policy~KnownIssueRollback~\<Parent Category\>/\<ADMX Policy Name\>*.

        > [!Note]
        > Replace \<Parent Category\> with the parent category string recorded in the previous step. For example, "KnownIssueRollback_Win_11". Replace \<ADMX Policy Name\> with the same policy name used in the previous step.

    - **Data type**: Select **String**.
    - **Value**: Enter *\<enabled/\>*.

3. Select **Save**.
4. Select **Next**.

#### D. Assign devices to the preview activation custom configuration profile

After you've defined what the custom configuration profile does, follow these steps to identify which devices you'll configure:

1. In **Assignments**, select **Add all devices**.
2. Select **Next**.

#### E. Review and create the preview activation custom configuration profile

Review the settings of your custom configuration profile and select **Create**.

### 3. Monitoring the preview

Follow these steps to monitor the configuration profile progress:

1. Go to **Devices** > **Configuration profiles**, and select an existing profile. For example, select a macOS profile.
2. Select the **Overview** tab. In this view, the **Profile assignment status** includes the following statuses:

- **Succeeded**: Policy is applied successfully.
- **Error**: The policy failed to apply. The message typically displays an error code that links to an explanation.
- **Conflict**: Two settings are applied to the same device, and Intune can't sort out the conflict. An administrator should review the conflict.
- **Pending**: The device hasn't checked in with Intune to receive the policy yet.
- **Not applicable**: The device can't receive the policy. For example, the policy updates a setting specific to Windows Server 2022, but the device is using Windows 11, version 23H2.

For more information, see [Monitor device configuration profiles in Microsoft Intune](/mem/intune/configuration/device-profile-monitor).
