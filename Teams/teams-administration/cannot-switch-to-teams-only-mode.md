---
title: Unable to switch a tenant to Teams Only mode
description: Fixes an issue in which you can't switch a tenant to Teams Only mode if the lyncdiscover DNS record doesn't point to Microsoft 365 or isn't present at all.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Admin\
  - CI 145950
  - CSSTroubleshoot
ms.reviewer: v-johrob, nickbear, grtaylo
appliesto: 
  - Microsoft Teams
  - Skype for Business Online
search.appverid: 
  - MET150
ms.date: 10/30/2023
---
# Error when switching a tenant to Teams Only mode

## Symptoms

When you try to switch a tenant to Teams Only mode at the organization level either by using the Microsoft Teams admin center or by running the `Grant-CsTeamsUpgradePolicy` cmdlet, the action does not finish, and you receive an error message that resembles one of the following messages, depending on which UI you're using.

### Microsoft Teams admin center

Please see the unsaved sections highlighted in red below.

:::image type="content" source="media/cannot-switch-to-teams-only-mode/teams-only-error.png" alt-text="Screenshot that shows the unsaved section when switching o Teams Only mode.":::

**Note:** If you encounter this error in the Microsoft Teams admin center, we recommend that you run the `Grant-CsTeamsUpgradePolicy` cmdlet which will display the following detailed error message.

### Teams PowerShell

> WARNING: \*All* users in this tenant are now full Teams-only users, except for any users that have an explicit policy assignment of TeamsUpgradePolicy. Teams-only users cannot use Skype for Business clients, except to join Skype for Business meetings. For details, see [http://aka.ms/UpgradeToTeams](/MicrosoftTeams/teams-only-mode-considerations). This organization cannot be upgraded to TeamsOnly mode. One or more M365 domains have a public DNS record that points to an on-premises Skype for Business Server deployment. The domain records at fault are {[lyncdiscover.\<domain_name>.\<IP_address>];}. To upgrade this tenant to TeamsOnly, first complete the migration of all users from on-premises Skype for Business Server to the cloud (using `Move-CsUser`), and then disable Skype for Business hybrid configuration for this tenant and update the DNS records to point to M365. After these steps are complete, you can execute this command, after which all users and any subsequently created new users will be TeamsOnly.

:::image type="content" source="media/cannot-switch-to-teams-only-mode/teams-only-powershell-error.png" alt-text="Screenshot that shows the PowerShell error when switching to Teams Only mode.":::

**Note:** The actual error message specifies the name and IP address of each domain that has incorrect domain records. This example uses placeholder text for one affected domain name and IP address.

## Cause

When you initiate the process to switch your tenant to Teams Only mode, the lyncdiscover DNS record for each SIP-enabled domain in the tenant is checked. If the lyncdiscover DNS record for any domain is present but does not point to Microsoft 365, any attempt to switch to Teams Only mode fails.

## Resolution

At a minimum, the following conditions must be met to enable Teams Only mode at the organization level:

- For all SIP-enabled domains in a tenant, the lyncdiscover DNS record must point to Microsoft 365.
- For all SIP-enabled [domains that will be used for Skype for Business Online and Teams](/microsoft-365/enterprise/external-domain-name-system-records#external-dns-records-required-for-skype-for-business-online), all DNS records must be present.

To fix this error, do the following:

1. Determine the SIP status of all domains in the tenant that are enabled or disabled for SIP:

    1. Connect to [Teams PowerShell](/microsoft-365/enterprise/manage-skype-for-business-online-with-microsoft-365-powershell).
    2. Run the [Get-CsOnlineSipDomain](/powershell/module/skype/get-csonlinesipdomain) cmdlet to get a list of all online SIP domains and their status as enabled or disabled.

2. For each domain whose status is **Enabled**, determine whether it's in use. To do this, run the following cmdlet in Teams PowerShell:

   ```powershell
   Get-CsOnlineUser -ResultSize Unlimited | select userprincipalname,sipaddress | Export-Csv C:\<Path>\allteamsusersexport.csv
   ```

   **Note:** In this cmdlet, replace \<Path> with the folder location where you want to save the output. The output will be exported to the *Allteamsusersexport.csv* file that will be saved in the path you specify. It will list all users together with their User Principal Names (UPNs) and SIP addresses. You can filter the .csv file by SIP domains to determine which SIP-enabled domains are being used. You can also determine the SIP-enabled domain that's assigned to each user.

3. For each SIP-enabled domain that is being used, check the existing DNS records:

    1. Sign in to the Microsoft 365 admin center.
    2. Navigate to **Settings** > **Domains**.
    3. For each domain on the **Domains** page, select **DNS settings**, and then check the DNS records that are listed for **Skype for Business**. Add any DNS records that are missing. For information about how to verify and add DNS records, see step 6 in [Add a domain to Microsoft 365](/microsoft-365/admin/setup/add-domain).

    **Note:** The default SIP-enabled `onmicrosoft.com` domains in your tenant are either owned or managed by Microsoft. You don't have to check their DNS records because that information is updated automatically by Microsoft.

4. Identify the unused SIP-enabled domains by comparing the list of all SIP-enabled domains from step 1b with the list of currently used domains in the *Allteamsusersexport.csv* file from step 2. The domains that are in the "1b" list but not in the .csv file will be those that are not in use.

5. For each unused SIP enabled domain, use either Method 1 or Method 2:

   - **Method 1:** Make sure that the lyncdiscover DNS record exists and points to Microsoft 365.
   - **Method 2:** Disable the domain for SIP by running the following [Disable-CsOnlineSipDomain](/powershell/module/skype/disable-csonlinesipdomain) cmdlet:

     ```powershell
     Disable-CsOnlineSipDomain -Domain <domain_name>
     ```

     > [!WARNING]
     > Do not run this cmdlet on domains that contain users who are hosted on Skype for Business Online or Teams. If you disable an online SIP domain, all Skype for Business Online accounts that are provisioned in that domain will be deleted. Although Teams doesn't use the SIP functionality in the same manner as Skype for Business Online, it has dependencies that are built on the SIP functionality and on the Skype for Business Online accounts that are provisioned in the SIP domain.

6. Try to enable Teams Only mode for your tenant again.
