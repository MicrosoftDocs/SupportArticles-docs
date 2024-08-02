---
title: Resolve Microsoft Purview Message Encryption issues
description: Describes how to troubleshoot common issues when you use Microsoft Purview Message Encryption.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI172717
ms.reviewer: lindabr, sathyana
search.appverid: MET150
ms.date: 06/24/2024
---

# Resolve Microsoft Purview Message Encryption issues

## Symptoms

Users in your organization experience one or more of the following issues:

- They can't open encrypted email messages in Microsoft Outlook or Outlook on the web.
- They can't send encrypted email messages.
- The **Encrypt** button is missing in both Outlook and Outlook on the web.

## Cause

These issues can occur for several reasons, such as:

- Your organization's Microsoft 365 subscription doesn't support Microsoft Purview Message Encryption.
- The tenant that's used by your organization is misconfigured.
- The account that's used by the affected users to sign in to Outlook or Outlook on the web isn't assigned a valid license to use the Microsoft Purview Message Encryption feature.

## Resolution

To resolve the issues, follow these steps in the given order. After you complete each step, check whether the issue persists. If it does, go to the next step.

### Step 1: Verify the Microsoft 365 subscription 

To use Microsoft Purview Message Encryption, your organization must have a subscription that supports this feature. For information about the subscription requirements, see [What subscriptions do I need to use Microsoft Purview Message Encryption](/microsoft-365/compliance/ome-faq?view=o365-worldwide#what-subscriptions-do-i-need-to-use-microsoft-purview-message-encryption-&preserve-view=true).

### Step 2: Verify the tenant configuration

1. Use Exchange Online PowerShell to verify that your tenant is [configured correctly for Microsoft Purview Message Encryption](/microsoft-365/compliance/set-up-new-message-encryption-capabilities?view=o365-worldwide#verify-microsoft-purview-message-encryption-configuration-in-exchange-online-powershell&preserve-view=true).
1. Run the following cmdlet to check whether Information Rights Management (IRM) features are enabled in Outlook on the web:

   ```powershell
   Get-OwaMailboxPolicy | fl *IRMEnabled*
   ```

   If **IRMEnabled** is **False**, run the following cmdlet:

   ```powershell
   Set-OwaMailboxPolicy -Identity OwaMailboxPolicy-Default -IRMEnabled $true
   ```

1. If the **Encrypt** button is missing in Outlook on the web, run the following cmdlet:

   ```powershell
   Set-IRMConfiguration -SimplifiedClientAccessEnabled $true
   ```

### Step 3: Verify the affected users' account licenses

The affected users have to make sure that the account that they use to sign in to Outlook or Outlook on the web is assigned the appropriate license to use the Microsoft Purview Message Encryption feature. If they can't determine this, users should follow these steps on their device:

1. Sign out of Office.
1. Remove cached credentials from Windows Credential Manager:

   1. Open **Control Panel** > **User Accounts** > **Credential Manager**.
   1. Select **Windows Credentials**.
   1. Remove all Outlook or Office credentials by expanding each credential and then selecting **Remove**.
1. If the device isn't Microsoft Entra joined, remove the unlicensed account from the device:

   1. Select **Start** > **Settings** > **Accounts** > **Access work or school**.
   1. Select the account to be removed, and then select **Disconnect**.
1. Sign in to Office by using a user account that's licensed to use the Microsoft Purview Message Encryption feature.

### Step 4: Verify connection to the Azure Rights Management service

To determine whether the affected user's mail client can connect to the Azure Rights Management service, run the following PowerShell commands:

```powershell
$request = [System.Net.HttpWebRequest]::Create("https://admin.na.aadrm.com/admin/admin.svc")
$request.GetResponse()
$request.ServicePoint.Certificate.Issuer
```

The output should show that the issuing Certificate Authority (CA) is a Microsoft CA. For example:

> CN=Microsoft Secure Server CA 2011, O=Microsoft Corporation, L=Redmond, S=Washington, C=US.

If you see a CA that isn't from Microsoft, your secure client-to-service connection was probably terminated and has to be reconfigured on your firewall. For more information, see [Firewalls and network infrastructure](/azure/information-protection/requirements#firewalls-and-network-infrastructure).

### Step 5: Check for sensitivity labels

If sensitivity labels are applied to email messages, permissions must be assigned correctly so that recipients can access the messages. For more information, see [Restrict access to content by using sensitivity labels](/microsoft-365/compliance/encryption-sensitivity-labels?view=o365-worldwide&preserve-view=true).

If the issue persists after you complete all these steps, [contact Microsoft Support](https://support.microsoft.com/contactus/) for further troubleshooting.

## More information

- If users in your organization experience issues when they send encrypted messages to or receive encypted messages from people outside your organization, check the Conditional Access policies and guest account configuration in both organizations. For more information, see [Microsoft Entra configuration for encrypted content](/microsoft-365/compliance/encryption-azure-ad-configuration?view=o365-worldwide&preserve-view=true) and [Conditional Access policies for Azure Information Protection](https://techcommunity.microsoft.com/t5/security-compliance-and-identity/conditional-access-policies-for-azure-information-protection/ba-p/250357).
- Users can open encrypted email messages that are sent to a shared mailbox. If the message is sent from the same organization, users can open it when they're signed in to a supported Outlook client. If the message is sent from an external organization, users must use Outlook on the web. For more information, see [Message encryption FAQ](/microsoft-365/compliance/ome-faq?view=o365-worldwide#can-i-open-encrypted-messages-sent-to-a-shared-mailbox-&preserve-view=true).
