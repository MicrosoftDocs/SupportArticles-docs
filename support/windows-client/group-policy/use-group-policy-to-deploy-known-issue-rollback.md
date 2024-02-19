---
title: Use Group Policy to deploy a Known Issue Rollback
description: describes how to configure Group Policy to use a Known Issue Rollback (KIR) policy definition that activates a KIR on managed devices.
ms.date: 45286
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
keywords: Windows Update, known issue, kir, group policy, rollback
---

# How to use Group Policy to deploy a Known Issue Rollback

This article describes how to configure Group Policy to use a Known Issue Rollback (KIR) policy definition that activates a KIR on managed devices.

_Applies to:_ &nbsp; Windows Server 2019, version 1809 and later versions; Windows 10, version 1809 and later versions

## Summary

Microsoft has developed a new Windows servicing technology that's named [KIR](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/known-issue-rollback-helping-you-keep-windows-devices-protected/ba-p/2176831) for Windows Server 2019 and Windows 10, versions 1809 and later versions. For the supported versions of Windows, a KIR rolls back a specific change that was applied as part of a nonsecurity Windows Update release. All other changes that were made as a part of that release remain intact. By using this technology, if a Windows update causes a regression or other problem, you don't have to uninstall the entire update and return the system to the last known good configuration. You roll back only the change that caused the problem. This rollback is temporary. After Microsoft releases a new update that fixes the problem, the rollback is no longer necessary.

> [!IMPORTANT]  
> KIRs apply to only nonsecurity updates. This is because rolling back a fix for a nonsecurity update doesn't create a potential security vulnerability.

Microsoft manages the KIR deployment process for non-enterprise devices. For enterprise devices, Microsoft provides KIR policy definition MSI files. Enterprises can then use Group Policy to deploy KIRs in hybrid Microsoft Entra ID or Active Directory Domain Services (AD DS) domains.

> [!NOTE]  
> You have to restart the affected computers in order to apply this Group Policy change.

## The KIR process

If Microsoft determines that a nonsecurity update has a critical regression or similar issue, Microsoft generates a KIR. Microsoft announces the KIR in the Windows Health Dashboard, and adds the information to the following locations:

- The Known Issues section of the applicable Windows Update KB article
- The Known Issues list on the Windows Health Release Dashboard at https://aka.ms/windowsreleasehealth for the affected versions of Windows (for example, [Windows 10, version 20H2 and Windows Server, version 20H2](/windows/release-health/status-windows-10-20h2#known-issues))

For non-enterprise customers, the Windows Update process applies the KIR automatically. No user action is required.

For enterprise customers, Microsoft provides a policy definition MSI file. Enterprise customers can propagate the KIR to managed systems by using the enterprise Group Policy infrastructure.

To see an example of a KIR MSI file, download [Windows 10 (2004 & 20H2) Known Issue Rollback 031321 01.msi](https://download.microsoft.com/download/b/8/9/b89221d0-d5db-40a7-bf25-cecbee25f713/Windows%2010%20(2004%20&%2020H2)%20Known%20Issue%20Rollback%20031321%2001.msi).

A KIR policy definition has a limited lifespan (a few months, at most). After Microsoft publishes an amended update to address the original issue, the KIR is no longer necessary. The policy definition can then be removed from the Group Policy infrastructure.

## Apply KIR to a single device using Group Policy

To use Group Policy to apply a KIR to a single device, follow these steps:

1. Download the KIR policy definition MSI file to the device.  
   > [!IMPORTANT]  
   > Make sure that the operating system that is listed in the .msi file name matches the operating system of the device that you want to update.
1. Run the .msi file on the device. This action installs the KIR policy definition in the Administrative Template.  
1. Open the Local Group Policy Editor. To do this, select **Start**, and then enter *gpedit.msc*.
1. Select **Local Computer Policy** > **Computer Configuration** > **Administrative Templates** > **KB *#######* Issue *XXX* Rollback** > **Windows 10, version *YYMM***.
   > [!NOTE]  
   > In this step, *#######* is the KB article number of the update that caused the problem. *XXX* is the issue number, and *YYMM* is the Windows 10 version number.
1. Right-click the policy, and then select **Edit** > **Disabled** > **OK**.
1. Restart the device.

For more information about how to use the Local Group Policy Editor, see [Working with the Administrative Template policy settings using the Local Group Policy Editor](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn789184(v=ws.11)).

<a name='apply-a-kir-to-devices-in-a-hybrid-azure-ad-or-ad-ds-domain-using-group-policy'></a>

## Apply a KIR to devices in a hybrid Microsoft Entra ID or AD DS domain using Group Policy

To apply a KIR policy definition to devices that belong to a hybrid Microsoft Entra ID or AD DS domain, follow these steps:

1. [Download and install the KIR MSI files](#install)
1. [Create a Group Policy Object (GPO)](#gpo).
1. [Create and configure a WMI filter that applies the GPO](#wmi).
1. [Link the GPO and the WMI filter](#link).
1. [Configure the GPO](#configure).
1. [Monitor the GPO results](#monitor).

### <a id="install"></a>1. Download and install the KIR MSI files

1. Check the KIR release information or the known issues lists to identify which operating system versions you have to update.  
1. Download the KIR policy definition .msi files that you require to update to the computer that you use to manage Group Policy for your domain.
1. Run the .msi files. This action installs the KIR policy definition in the Administrative Template.  
   > [!NOTE]  
   > Policy definitions are installed in the *C:\Windows\PolicyDefinitions* folder. If you have implemented the Group Policy [Central Store](create-and-manage-central-store.md#the-central-store), you must copy the .admx and .adml files to the Central Store.

### <a id="gpo"></a>2. Create a GPO

1. Open Group Policy Management Console, and then select **Forest: *DomainName*** > **Domains**.
1. Right-click your domain name, and then select **Create a GPO in this domain, and link it here**.
1. Enter the name of the new GPO (for example, **KIR Issue *XXX***), and then select **OK**.  

For more information about how to create GPOs, see [Create a Group Policy Object](/windows/security/threat-protection/windows-firewall/create-a-group-policy-object).

### <a id="wmi"></a>3. Create and configure a WMI filter that applies the GPO

1. Right-click **WMI Filters**, and then select **New**.
1. Enter a name for your new WMI filter.
1. Enter a description of your WMI filter, such as **Filter to all Windows 10, version 2004 devices**.
1. Select **Add**.
1. In **Query**, enter the following query string:

   ```sql
   SELECT version, producttype from Win32_OperatingSystem WHERE Version = <VersionNumber>
   ```

   > [!IMPORTANT]  
   > In this string, \<VersionNumber> represents the Windows version that you want the GPO to apply to. The version number must use the following format (exclude the brackets when you use the number in the string):
   >  
   > > 10.0.*xxxxx*  
   >  
   > where *xxxxx* is a five digit number. Currently, KIRs support the following versions:
   >  
   > |Version |Build number |
   > | --- | --- |
   > |Windows 10, version 20H2 |10.0.19042 |
   > |Windows 10, version 2004 |10.0.19041 |
   > |Windows 10, version 1909 |10.0.18363 |
   > |Windows 10, version 1903 |10.0.18362 |
   > |Windows 10, version 1809 |10.0.17763 |
   >  

   For an up-to-date list of Windows releases and build numbers, see [Windows 10 - release information](/windows/release-health/release-information).  

   > [!IMPORTANT]  
   > The build numbers that are listed on the Windows 10 release information page don't include the **10.0** prefix. To use a build number in the query, you must add the **10.0** prefix.

For more information about how to create WMI filters, see [Create WMI Filters for the GPO](/windows/security/threat-protection/windows-firewall/create-wmi-filters-for-the-gpo).

### <a id="link"></a>4. Link the GPO and the WMI filter

1. Select the GPO that you created [previously](#gpo), open the **WMI Filtering** menu, and then select the WMI filter that you just created.
1. Select **Yes** to accept the filter.

### <a id="configure"></a> 5. Configure the GPO

Edit your GPO to use the KIR activation policy:

1. Right-click the GPO that you created [previously](#gpo), and then select **Edit**.
1. In the Group Policy Editor, select ***GPOName*** > **Computer Configuration** > **Administrative Templates** > **KB&nbsp;*#######* Issue *XXX* Rollback** > **Windows 10, version *YYMM***.  
1. Right-click the policy, and then select **Edit** > **Disabled** > **OK**.

For more information about how to edit GPOs, see [Edit a Group Policy object from GPMC](/previous-versions/windows/it-pro/windows-server-2003/cc759123(v=ws.10)).

### <a id="monitor"></a>6. Monitor the GPO results

In the default configuration of Group Policy, managed devices should apply the new policy within 90 to 120 minutes. To speed up this process, you can run `gpupdate` on affected devices to manually check for updated policies.

Make sure that each affected device restarts after it applies the policy.

> [!IMPORTANT]  
> The fix that introduced the issue is disabled after the device applies the policy and then restarts.

## Deploy a KIR activation using Microsoft Intune ADMX policy ingestion to the managed devices

> [!NOTE]
> To use the solutions in this section, you must install the cumulative update that is released on [July 26, 2022](https://support.microsoft.com/topic/july-26-2022-kb5015878-os-builds-19042-1865-19043-1865-and-19044-1865-preview-549f5551-fcc5-4fee-8811-c5df12e04d40) or a later one on the computer.

Group Policies and GPOs aren't compatible with mobile device management (MDM) based solutions, such as Microsoft Intune. These instructions will guide you through how to use [Intune custom settings](/mem/intune/configuration/custom-settings-windows-10) for [ADMX ingestion](/windows/client-management/mdm/win32-and-centennial-app-policy-configuration) and configure [ADMX backed MDM policies](/windows/client-management/mdm/understanding-admx-backed-policies) to perform a KIR activation without requiring a GPO.

To perform a KIR activation on Intune managed devices, follow these steps:  

1. [Download and install the KIR MSI file to get ADMX files](#1-download-and-install-the-kir-msi-file-to-get-admx-files).  
2. [Create a custom configuration profile in Microsoft Intune](#2-create-a-custom-configuration-profile-in-microsoft-intune).
3. [Monitor KIR activation](#3-monitor-kir-activation).  
  
### 1. Download and install the KIR MSI file to get ADMX files

1. Check the KIR release information or the known issues lists to identify which operating system (OS) versions you must update.  
2. Download the required KIR policy definition .msi files on the machine you use to sign in to Microsoft Intune.  

    > [!NOTE]
    > You will need access to the contents of a KIR activation ADMX file.  

3. Run the `.msi` files. This action installs the KIR policy definition in the Administrative Template.  

    > [!NOTE]
    > Policy definitions are installed in the *C:\Windows\PolicyDefinitions* folder.
    >
    > If you want to extract the ADMX files to another location, use the `msiexec` command with the [TARGETDIR](/windows/win32/msi/targetdir) property. For example:  
    >
    > ```console
    > msiexec /i c:\admx_file.msi /qb TARGETDIR=c:\temp\admx
    > ```

### 2. Create a custom configuration profile in Microsoft Intune  

To configure devices to perform a KIR activation, you need to create a custom configuration profile for each OS of your managed devices. To create a custom profile, follow these steps:

1. [Select properties and add basic information of the profile](#a-select-properties-and-add-basic-information-about-the-profile).
2. [Add custom configuration setting to ingest ADMX files for KIR activation](#b-add-custom-configuration-setting-to-ingest-admx-files-for-kir-activation).
3. [Add custom configuration setting to set new KIR activation policy](#c-add-custom-configuration-setting-to-set-new-kir-activation-policy).
4. [Assign devices to the KIR activation custom configuration profile](#d-assign-devices-to-the-kir-activation-custom-configuration-profile).
5. [Use applicability rules to target devices to receive KIR custom configuration settings by OS](#e-use-applicability-rules-to-target-devices-to-receive-kir-custom-configuration-settings-by-os).
6. [Review and create KIR activation custom configuration profile](#f-review-and-create-kir-activation-custom-configuration-profile).

#### A. Select properties and add basic information about the profile

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431).  
2. Select **Devices** > **Configuration profiles** > **Create profile**.  
3. Select the following properties:  

    - **Platform**: **Windows 10 and later**  
    - **Profile**: **Templates** > **Custom**  

4. Select **Create**.
5. In **Basics**, enter the following properties:

    - **Name**: Enter a descriptive name for the policy. Name your policies so you can easily identify them later. For example, a good policy name is "04/30 KIR Activation – Windows 10 21H2".  
    - **Description**: Enter a description for the policy. This setting is optional but recommended.

    > [!NOTE]
    > **Platform** and **Profile type** should already have values selected.

6. Select **Next**.  

> [!NOTE]  
> For more information about creating custom configuration profiles and configuration settings, see [Use custom device settings in Microsoft Intune](/mem/intune/configuration/custom-settings-configure).

Before proceeding to the next two steps, open the ADMX file in a text editor (for example, Notepad) where the file was extracted. The ADMX file should be in the path *C:\Windows\PolicyDefinitions* if you installed it as an MSI file.

Here's an example of the ADMX file:

```xml
  <policies>  
    <policy name="KB5011563_220428_2000_1_KnownIssueRollback" … >  
      <parentCategory ref="KnownIssueRollback_Win_11" />  
      <supportedOn ref="SUPPORTED_Windows_11_0_Only" />  
      <enabledList…> … </enabledList>  
      <disabledList…>…</disabledList>  
    </policy>  
  </policies>
```

Record the values for `policy name` and `parentCategory`. This information is in the "policies" node at the end of the file.

#### B. Add custom configuration setting to ingest ADMX files for KIR activation

This configuration setting is used to install the KIR activation policy on target devices. Follow these steps to add the ADMX ingestion settings:

1. In **Configuration settings**, select **Add**.  
2. Enter the following properties:  

    - **Name**: Enter a descriptive name for the configuration setting. Name your settings so you can easily identify them later. For example, a good setting name is "ADMX Ingestion: 04/30 KIR Activation – Windows 10 21H2".  
    - **Description**: Enter a description for the setting. This setting is optional but recommended.  
    - **OMA-URI**: Enter the string *./Device/Vendor/MSFT/Policy/ConfigOperations/ADMXInstall/KIR/Policy/\<ADMX Policy Name\>*.

        > [!NOTE]
        > Replace \<ADMX Policy Name\> with the value of the recorded policy name from the ADMX file. For example, "KB5011563_220428_2000_1_KnownIssueRollback".  
    - **Data type**: Select **String**.  
    - **Value**: Open the ADMX file with a text editor (for example, Notepad). Copy and paste the entire contents of the ADMX file you intend to ingest into this field.  

3. Select **Save**.  

#### C. Add custom configuration setting to set new KIR activation policy  

This configuration setting is used to configure the KIR activation policy, which is defined in the previous step.

Follow these steps to add the KIR activation configuration settings:

1. In **Configuration settings**, select **Add**.  
2. Enter the following properties:  

    - **Name**: Enter a descriptive name for the configuration setting. Name your settings so you can easily identify them later. For example, a good setting name is "KIR Activation: 04/30 KIR Activation – Windows 10 21H2".  
    - **Description**: Enter a description for the setting. This setting is optional but recommended.  
    - **OMA-URI**: Enter the string *./Device/Vendor/MSFT/Policy/Config/KIR~Policy~KnownIssueRollback~\<Parent Category\>/\<ADMX Policy Name\>*.  
        > [!NOTE]
        > Replace \<Parent Category\> with the parent category string recorded in the previous step. For example, "KnownIssueRollback_Win_11". Replace \<ADMX Policy Name\> with the same policy name used in the previous step.

    - **Data type**: Select **String**.  
    - **Value**: Enter *\<disabled/\>*.
3. Select **Save**.  
4. Select **Next**.  

#### D. Assign devices to the KIR activation custom configuration profile  

After you've defined what the custom configuration profile does, follow these steps to identify which devices you'll configure:

1. In **Assignments**, select **Add all devices**.  
2. Select **Next**.  

#### E. Use applicability rules to target devices to receive KIR custom configuration settings by OS  

To target the devices by OS that are applicable to the GP, add an applicability rule to check the device OS Version (Build) before applying this configuration. You can look up the build numbers for the supported OS on the following pages:

- [Windows 11 release information](/windows/release-health/windows11-release-information)  
- [Windows 10 release information](/windows/release-health/release-information)  
- [Windows Server release information](/windows/release-health/windows-server-release-info)

The build numbers shown in the pages are formatted as MMMMM.mmmm (M= major version and m= minor version). The OS Version properties use the major version digits. The OS Version values entered into the Applicability Rules should be formatted as "10.0.MMMMM". For example, "10.0.22000".  

Follow these instructions to set the correct Applicability Rules for your KIR activation:

1. In **Applicability Rules**, create an applicability rule by entering the following properties on the blank rule already on the page:  

    - **Rule**: Select **Assign profile if** from the dropdown list.  
    - **Property**: Select **OS Version** from the dropdown list.  
    - **Value**: Enter the Min and the Max OS version numbers formatted as "10.0.MMMMM".

2. Select **Next**.

> [!NOTE]
> The OS version of a device can be found by running the `winver` command from the Start menu. It will show a two-part version number separated by a ".". For example, "22000.613". You can append the left number to "10.0." for the Min OS version. Obtain the Max OS version number by adding 1 to the last digit of the Min OS version number. For this example, you can use these values:  
> Min OS version: "10.0.22000"  
> Max OS version: "10.0.22001"  

#### F. Review and create KIR activation custom configuration profile

Review your settings of the custom configuration profile and select **Create**.

### 3. Monitor KIR activation  

Your KIR activation should be in progress now. Follow these steps to monitor the configuration profile progress:

1. Go to **Devices** > **Configuration profiles**, and select an existing profile. For example, select a macOS profile.  
2. Select the **Overview** tab. In this view, the **Profile assignment status** includes the following statuses:  

    - **Succeeded**: Policy is applied successfully.  
    - **Error**: The policy failed to apply. The message typically displays an error code that links to an explanation.  
    - **Conflict**: Two settings are applied to the same device, and Intune can't sort out the conflict. An administrator should review the conflict.  
    - **Pending**: The device hasn't checked in with Intune to receive the policy yet.  
    - **Not applicable**: The device can't receive the policy. For example, the policy updates a setting specific to iOS 11.1, but the device is using iOS 10.  

For more information, see [Monitor device configuration profiles in Microsoft Intune](/mem/intune/configuration/device-profile-monitor).  

## More information

- [Local Group Policy Editor](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn265982(v=ws.11))
- [Working with the Administrative Template policy settings using the Local Group Policy Editor](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn789184(v=ws.11))
- [Group Policy Overview](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831791(v=ws.11))
- [GPMC How To](/previous-versions/windows/it-pro/windows-server-2003/cc783034(v=ws.10))
- [Create WMI Filters for the GPO (Windows 10) - Windows security](/windows/security/threat-protection/windows-firewall/create-wmi-filters-for-the-gpo)
- [Edit a Group Policy object from GPMC](/previous-versions/windows/it-pro/windows-server-2003/cc759123(v=ws.10))
- [Create and manage group policy in Microsoft Entra Domain Services](/azure/active-directory-domain-services/manage-group-policy)
- [Use Windows 10/11 templates to configure group policy settings in Microsoft Intune](/mem/intune/configuration/administrative-templates-windows)
