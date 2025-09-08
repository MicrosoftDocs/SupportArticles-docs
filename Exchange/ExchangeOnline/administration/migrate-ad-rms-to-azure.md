---
title: How to migrate AD RMS to Azure RMS in Exchange Online
description: Support has ended for a specific configuration for users who have Exchange Online mailboxes. This results in users unable to view or create messages protected by AD RMS.
author: cloud-writer
ms.author: meerak
ms.reviwer: samschan
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
manager: dcscontentpm
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 01/24/2024
---

# How to migrate AD RMS to Azure RMS in Exchange Online

On February 28, 2021, Microsoft ended support for a specific configuration for users who have Exchange Online mailboxes. The configuration lets these users see and create content that’s protected by Active Directory Rights Management Services (AD RMS).

## Effect on customers

If you determine that your organization is affected, you must follow the steps that are listed in the “Remediation steps” section. Otherwise, users who have mailboxes in Exchange Online will no longer be able to view or create email messages that are protected by AD RMS through Outlook on the web or Outlook for iOS and Android. Users will still be able to view messages that are protected by AD RMS by using the Microsoft Outlook desktop client on Windows.

Mail flow rules in Exchange Online that are configured to protect messages by using AD RMS will also no longer be in effect.

Other functionality that requires decryption of AD RMS-protected messages in Exchange Online will no longer decrypt such messages. Those messages will be left in encrypted state. Such functionality includes eDiscovery, journaling, inspection by transport rules, and indexing.

## How to determine if you’re affected

If your organization is not using AD RMS, this issue doesn’t affect you, and you can safely ignore the rest of the article. Organizations that are using Azure Rights Management Services (Azure RMS) and Azure Information Protection are not affected.

If your organization is using AD RMS, but you haven’t implemented integration of AD RMS in Exchange Online by importing your AD RMS keys into Exchange Online, you are also not affected by this change.

If any of your users have on-premises Microsoft Exchange Server mailboxes, they will not be affected by this change.

To determine whether you have set up integration between AD RMS and Exchange Online, connect to Exchange Online PowerShell, and then run the following cmdlet:

> **Get-IRMConfiguration**

The output of this cmdlet should resemble the following:

```
InternalLicensingEnabled                      : True

ExternalLicensingEnabled                      : True

AzureRMSLicensingEnabled                      : False

TransportDecryptionSetting                    : Optional

JournalReportDecryptionEnabled                : True

SimplifiedClientAccessEnabled                 : True

ClientAccessServerEnabled                     : True

SearchEnabled                                 : True

EDiscoverySuperUserEnabled                    : True

DecryptAttachmentFromPortal                   : False

DecryptAttachmentForEncryptOnly               : False

SystemCleanupPeriod                           : 0

SimplifiedClientAccessEncryptOnlyDisabled     : False

SimplifiedClientAccessDoNotForwardDisabled    : False

EnablePdfEncryption                           : False

AutomaticServiceUpdateEnabled                 : True

RMSOnlineKeySharingLocation                   :

RMSOnlineVersion                              :

ServiceLocation                               :

PublishingLocation                            :

LicensingLocation                             :
```

If the output shows that **InternalLicensingEnabled** is set to **True** and that **AzureRMSLicensingEnabled** is set to **False**, this means that you are potentially affected by this deprecation. In this case, you must use one of the methods that are provided in the “Remediation steps” section.

> [!NOTE]
> If you have this configuration enabled but you no longer use AD RMS in your organization, you do not have to run these steps. However, we recommend that you still do this because there might be protected content that you’re unaware of that's in use in your organization.

For more information about the AD RMS keys that you imported into Exchange Online, run the **Get-RMSTrustedPublishingDomain** cmdlet. This will identify all the Trusted Publishing Domains (TPDs) that are affected in Exchange Online. TPDs are used to package the AD RMS and Azure RMS keys.

## Remediation steps

If your organization is affected by this change, use one of the following remediation methods, as appropriate.

### Method 1: Do nothing
If your organization doesn't frequently use AD RMS to protect emails message, or if you have only a few users who have mailboxes in Exchange Online, the loss of functionality that is caused by this change should not significantly affect your organization. In this case, you can choose not to take any remediation steps, and accept the following consequences:

- Users who have mailboxes in Exchange Online will no longer be able to use Outlook on the web or Outlook for iOS and Android to view email messages that are protected by AD RMS. Those users will continue to be able to view protected messages in the Outlook desktop client on Windows.

- Users who have mailboxes in Exchange Online will no longer be able to apply protection by using AD RMS templates or by using the Do Not Forward feature in Outlook on the web.

- Mail flow in Exchange Online that are configured to protect email messages by using AD RMS will no longer be in effect.

- Functionality that requires decryption of AD RMS-protected email messages in Exchange Online will no longer be able to decrypt such messages. Those messages will be left in an encrypted state. Such functionality includes eDiscovery, journaling, inspection by transport rules, and indexing.

### Method 2: Use your AD RMS key

Import your AD RMS key into Azure RMS, and configure Exchange Online to use that key to handle protected content. If you're affected by this change, then you have already imported your key from AD RMS to Exchange Online. The process to import your AD RMS key into Azure RMS is similar except that it involves importing your key to a different location.

Although these remediation steps are a subset of the steps that are used to migrate from AD RMS to Azure RMS, they don't require that you complete a full migration from AD RMS to Azure RMS. These steps also don't change the client environment or the keys and policies that are used in the environment. Users will not see the changes that are made by these steps, nor will they need any additional training or awareness because of them. After you run these steps, your users will still use AD RMS to protect content.

Do the following:

1. Export your AD RMS TPD to Azure RMS. The steps to do this are documented in [Migration phase 2 - server-side configuration for AD RMS](/azure/information-protection/migrate-from-ad-rms-phase2).

1. Configure Azure RMS in read-only mode by setting up an onboarding control policy that excludes all users.

   This step involves creating an empty Microsoft Entra group, and assigning it to the onboarding control policy by running the following PowerShell script:
   ```
   Set-AipServiceOnboardingControlPolicy -UseRmsUserLicense $False -SecurityGroupObjectId "{Group’s GUID}"
   ```
   For more information, see the [“Step 2. Prepare for client migration” section of Migration phase 1 – preparation](/azure/information-protection/migrate-from-ad-rms-phase1#step-2-prepare-for-client-migration).

1. Configure Exchange Online to use the key that’s stored in Azure RMS for protection instead of using the copy of the key that was originally imported into the Exchange Online service. To do this, run the following command: 
   ```
   $irmConfig = Get-IRMConfiguration

   $list = $irmConfig.LicensingLocation

   $list += "<Your Azure RMS URL>/_wmcs/licensing"

   Set-IRMConfiguration Set-IRMConfiguration -AzureRMSLicensing $True -LicensingLocation $list**
   ```

   To determine the Azure RMS URL, connect to Azure Information Protection PowerShell, and run the following cmdlet:
   ```
   Get-AipServiceConfiguration
   ```

1. Configure the relevant DNS SRV records that point to Exchange Online. The relevant records are those for which Azure RMS has the necessary artifacts to enable it to license content that’s protected by AD RMS. The required DNS records are discussed in the [“Step 8. Configure IRM integration for Exchange Online” section of Migration phase 4 - supporting services configuration](/azure/information-protection/migrate-from-ad-rms-phase4#step-8-configure-irm-integration-for-exchange-online).

After you complete these steps, all users who currently use AD RMS can continue to use it. There will be only one change: Content that’s protected by Exchange Online users by using Outlook on the web or an Exchange Online transport rule will be encrypted instead by using Azure RMS together with the same key that’s stored in AD RMS and that now has an Azure RMS URL in its license. This means that users who are consuming this content must make requests to Azure RMS to acquire licenses. Those requests will be handled automatically by Outlook clients without any adverse effects because of the onboarding controls that you configured in step 2 of this method. 

**Notes:**

- If there are on-premises Exchange servers in the environment that are currently integrated with AD RMS, one additional configuration is required to make sure that these servers can decrypt content that's protected by Exchange Online users. This step provides redirections that point the Azure RMS URLs to the AD RMS clusters. Configure the following registry values on each Exchange server:
   ```
   [HKLM\SOFTWARE\Microsoft\ExchangeServer\v15\IRM\LicenseServerRedirection]
   “https://[5241e6fb-b220-4cf6-9b95-8889a5b02b52.rms.na.aadrm.com]/_wmcs/licensing” = “https://[AD RMS Intranet Licensing URL]/_wmcs/licensing”
   ```

   In this registry subkey, replace the values between the brackets with the Azure RMS URL in the organization’s tenant and the AD RMS cluster URL. See step 3 in this method for details about how to determine this URL.

- If any third-party applications are currently in use in the environment that is integrated to consume AD RMS-protected email messages, these applications must be revised after the change is made. This revision is to determine whether any actions are necessary to make sure that the applications can still process messages that are protected by Exchange Online.

### Method 3: Migrate AD RMS to Azure RMS (preferred)

This is the preferred remediation method for customers who can invest the necessary time and effort. While this method requires considerable effort and planning, it maximizes the benefits because it lets the organization continue to use the functionality of Azure Information Protection and Azure RMS. This functionality is significantly more extensive than that available in AD RMS.

For guidance to migrate from AD RMS to Azure RMS, see [Migrating from AD RMS to Azure Information Protection](/azure/information-protection/migrate-from-ad-rms-to-azure-rms).

> [!NOTE]
> If you have run the steps from Method 2, and you choose to run Method 3 later, you can skip those same steps when you do the full migration to Azure RMS. This is because the Method 2 steps are a subset of the steps for the full migration.
