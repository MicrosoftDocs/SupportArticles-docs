---
title: Use Group Policy to deploy a Known Issue Rollback
description: describes how to configure Group Policy to use a Known Issue Rollback (KIR) policy definition that activates a KIR on managed devices.
ms.date: 04/26/2021
author: v-tappelgate
ms.author: v-tappelgate
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
ms.technology: windows-client-group-policy
keywords: Windows Update, known issue, kir, group policy, rollback
---

# How to use Group Policy to deploy a Known Issue Rollback

This article describes how to configure Group Policy to use a Known Issue Rollback (KIR) policy definition that activates a KIR on managed devices.

_Applies to:_ &nbsp; Windows Server 2019, version 1809 and later versions; Windows 10, version 1809 and later versions

## Summary

Microsoft has developed a new Windows servicing technology that's named [KIR](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/known-issue-rollback-helping-you-keep-windows-devices-protected/ba-p/2176831) for Windows Server 2019 and Windows 10, versions 1809 and later versions. For the supported versions of Windows, a KIR rolls back a specific change that was applied as part of a nonsecurity Windows Update release. All other changes that were made as a part of that release remain intact. By using this technology, if a Windows update causes a regression or other problem, you don't have to uninstall the entire update and return the system to the last known good configuration. You roll back only the change that caused the problem. This rollback is temporary. After Microsoft releases a new update that fixes the problem, the rollback is no longer necessary.

> [!IMPORTANT]  
> KIRs apply to only nonsecurity updates. This is because rolling back a fix for a nonsecurity update doesn't create a potential security vulnerability.

Microsoft manages the KIR deployment process for non-enterprise devices. For enterprise devices, Microsoft provides KIR policy definition MSI files. Enterprises can then use Group Policy to deploy KIRs in hybrid Azure Active Directory (Azure AD) or Active Directory Domain Services (AD DS) domains.

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

## Using Group Policy to apply a KIR to a single device

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

## Using Group Policy to apply a KIR to devices in a hybrid Azure AD or AD DS domain

To apply a KIR policy definition to devices that belong to a hybrid Azure AD or AD DS domain, follow these steps:

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

Edit your GPO to use the KIR Activation Policy

1. Right-click the GPO that you created [previously](#gpo), and then select **Edit**.
1. In the Group Policy Editor, select ***GPOName*** > **Computer Configuration** > **Administrative Templates** > **KB&nbsp;*#######* Issue *XXX* Rollback** > **Windows 10, version *YYMM***.  
1. Right-click the policy, and then select **Edit** > **Disabled** > **OK**.

For more information about how to edit GPOs, see [Edit a Group Policy object from GPMC](/previous-versions/windows/it-pro/windows-server-2003/cc759123(v=ws.10)).

### <a id="monitor"></a>6. Monitor the GPO results

In the default configuration of Group Policy, managed devices should apply the new policy within 90 to 120 minutes. To speed up this process, you can run `gpupdate` on affected devices to manually check for updated policies.

Make sure that each affected device restarts after it applies the policy.

> [!IMPORTANT]  
> The fix that introduced the issue is disabled after the device applies the policy and then restarts.

## More information

- [Local Group Policy Editor](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn265982(v=ws.11))
- [Working with the Administrative Template policy settings using the Local Group Policy Editor](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn789184(v=ws.11))
- [Group Policy Overview](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831791(v=ws.11))
- [GPMC How To](/previous-versions/windows/it-pro/windows-server-2003/cc783034(v=ws.10))
- [Create WMI Filters for the GPO (Windows 10) - Windows security](/windows/security/threat-protection/windows-firewall/create-wmi-filters-for-the-gpo)
- [Edit a Group Policy object from GPMC](/previous-versions/windows/it-pro/windows-server-2003/cc759123(v=ws.10))
- [Create and manage group policy in Azure AD Domain Services](/azure/active-directory-domain-services/manage-group-policy)
