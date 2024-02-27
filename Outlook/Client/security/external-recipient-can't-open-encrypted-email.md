---
title: External recipient can't open encrypted email that uses Microsoft Purview Message Encryption
description: Provides solutions for an issue in which an external recipient can't open an encrypted email message that uses Microsoft Purview Message Encryption.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: michael.green, gbratton, meerak, v-trisshores
appliesto: 
  - Outlook for Microsoft 365
  - Outlook for Mac for Microsoft 365
  - Outlook 2021 for Mac
  - Outlook 2019 for Mac
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
  - Microsoft Purview
search.appverid: MET150
ms.date: 01/30/2024
---

# External recipient can't open encrypted email that uses Microsoft Purview Message Encryption

## Symptoms

A user in your Microsoft Exchange organization sends an encrypted email message to an external recipient who tries to open it in their Microsoft Outlook desktop client. However, the recipient either:

- Can't open the encrypted message (for example, the message body is blank)

- Receives a message that has a "Read the message" link in the message body (the link directs the recipient to the Microsoft Purview message encryption portal)

This issue occurs for email messages that use [Microsoft Purview Message Encryption](/microsoft-365/compliance/ome#get-started-with-the-microsoft-purview-message-encryption).

## Cause

The symptoms can occur for either of the following reasons:

- To decrypt an email message that uses Microsoft Purview Message Encryption, the recipient's Outlook desktop client must connect to the Microsoft Azure Information Protection (AIP) endpoint for your Exchange Online tenant. However, the Outlook desktop client might not connect to the AIP endpoint if either of the following conditions are true:

- An external-facing conditional access (CA) policy in the tenant that's used by the sender blocks access to the endpoint.

- A multifactor authentication (MFA) policy in the tenant that's used by the sender adds an extra layer of security that blocks access to the endpoint.

- The sender applied a sensitivity label to encrypt content, but the label also restricts access in other ways. For example, the label scopes access to internal recipients only.

## Solution

Use one of the following resolutions or workarounds, depending on the cause.

> [!IMPORTANT]
> We recommend that you work with your organization's IT or security team to implement the appropriate resolution or workaround based on your specific environment and security requirements.

### Resolutions

- If an external-facing CA policy in the tenant that's used by the sender blocks access to the AIP endpoint, then exclude AIP from the list of cloud apps that the policy blocks. For information about how to configure AIP, see [CA policies for AIP](https://techcommunity.microsoft.com/t5/security-compliance-and-identity/conditional-access-policies-for-azure-information-protection/ba-p/250357) and [AIP is listed as a cloud app for CA](/azure/information-protection/faqs#i-see-azure-information-protection-is-listed-as-an-available-cloud-app-for-conditional-accesshow-does-this-work).

- If the sender used a sensitivity label to encrypt content, the sender should check the label for any other access restrictions. For more information, see [Restrict access to content by using sensitivity labels to apply encryption](/microsoft-365/compliance/encryption-sensitivity-labels).

### Workarounds

- If an external-facing CA policy in the tenant that's used by the sender blocks external users but allows [guest users](/microsoft-365/admin/add-users/about-guest-users) to access the AIP endpoint, then add the external recipient as a guest user.

- If an MFA policy in the tenant that's used by the sender adds an extra layer of security that blocks access to the AIP endpoint, the external recipient must either:

  - Open the encrypted message in Outlook on the web, Outlook for Android, or Outlook for iOS. Those applications handle decryption in the service and don't require access to the AIP endpoint.

  - Exclude the recipient (and possibly all guest and external users) from your organization's MFA policy. MFA can be configured in Microsoft Entra [Identity Protection](/azure/active-directory/identity-protection/howto-identity-protection-configure-mfa-policy) and in CA policies.
