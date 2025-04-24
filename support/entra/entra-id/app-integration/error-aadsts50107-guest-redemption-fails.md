---
# Required metadata
# For more information, see https://learn.microsoft.com/en-us/help/platform/learn-editor-add-metadata
# For valid values of ms.service, ms.prod, and ms.topic, see https://learn.microsoft.com/en-us/help/platform/metadata-taxonomies

title: 'error AADSTS50107 invitation redemption fails '
description: Error AADSTS50107  When Guest User Attempts to Redeem Invitation via SAML External Trust
author:      Laks1 # GitHub alias
ms.author:   laks # Microsoft alias
ms.service: entra-id
ms.topic: troubleshooting-problem-resolution
ms.date:     04/24/2025
ms.subservice: authentication
---
# Error AADSTS50107 Guest Invitation Redemption fails via SAML external Trust

This article provides a solution to the Microsoft Entra authentication error AADSTS50107, which occurs when a guest user attempts to redeem an invitation from an Entra tenant using SAML external trust, the invitation redemption fails with the following error message:
Error: AADSTS50107: The requested federation realm object 'https://abc.contoso.com' does not exist.

#### Symptoms

- You have a SAML external Trust configured between Entra tenant to External IDP.
- A user is invited from an external identity provider (IDP) to an Entra tenant as a guest.
- When the external guest user attempts to redeem the invitation, the redemption fails, and the error AADSTS50107 is displayed.

#### Cause

This issue occurs when the Issuer URL value in the SAML response does not match the Issuer URL configured in Microsoft Entra ID. The Issuer URL in the SAML response corresponds to the URL mentioned in the error message.


#### Resolution

To resolve this issue, follow these steps:
	1. Ensure that the Issuer URL value in the external IDP matches the Issuer URL value configured in Microsoft Entra ID.
	2. Verify or update the Issuer URL in Microsoft Entra ID to align with the Issuer URL in the SAML response.
To verify the Issuer URL in Microsoft Entra ID:
		1. Sign in to the Entra portal as an administrator.
		2. Select External Identities.
		3. Choose All Identity Providers.
		4. Under Custom Identity Providers, select the desired SAML trust (e.g., Contoso.com).
		5. Click Edit Configuration for Contoso.com.
		6. Check that the Issuer URI value configured in Entra ID matches the saml:Issuer value in the SAML response sent by the external IDP.
Following these steps should resolve the AADSTS50107 error and allow successful invitation redemption.