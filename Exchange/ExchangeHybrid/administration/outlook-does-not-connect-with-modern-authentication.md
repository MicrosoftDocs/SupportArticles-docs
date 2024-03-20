---
title: Outlook doesn't connect when using Modern authentication
description: Resolves an issue in which the Outlook client can't connect to Exchange Online when Autodiscover points to on-premises Exchange Server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
  - CI 170995
  - has-azure-ad-ps-ref
  - azure-ad-ref-level-one-done
ms.reviewer: haembab, ninob, meerak, v-trisshores
appliesto: 
  - Exchange Online
  - Outlook 2016 Professional MSI
search.appverid: MET150
ms.date: 01/24/2024
---

# Outlook doesn't connect when using Modern authentication

## Symptoms

Consider the following scenario:

- Your organization has a hybrid Microsoft Exchange environment.

- Autodiscover points to on-premises Exchange Server.

- You have a Microsoft Outlook 2016 Professional MSI client.

In this scenario, you encounter the following issues when you try to add your Exchange Online email account to Outlook:

- The Modern authentication prompt window goes blank after you enter your Exchange Online credentials.

- Outlook doesn't add the account to your default Outlook profile.

## Cause

When you enter your credentials, the Outlook client connects to Exchange Online to request an OAuth token for the on-premises Autodiscover resource principle. However, authentication fails because the resource principal is either:

- Missing from the list of service principal names (SPNs) in the Microsoft Entra tenant.

- In an invalid state within the Microsoft Entra tenant.

## Resolution

To add your Exchange Online email account to Outlook, use either of the following resolutions.

## Resolution 1

Use a Click-to-Run version of Outlook. Outlook Click-to-Run versions determine whether a user account exists in Exchange Online, as described in step 4 of [Outlook 2016 implementation of Autodiscover](https://support.microsoft.com/topic/outlook-2016-implementation-of-autodiscover-0d7b2709-958a-7249-1c87-434d257b9087).

## Resolution 2

Add the missing Autodiscover resource principle to the SPN list in the Microsoft Entra tenant. Follow these steps:

1. Determine the resource principal name by using either of the following methods:

   - Search the [Microsoft Entra sign-in logs](/azure/active-directory/reports-monitoring/concept-sign-ins) for the following sign-in failure message:

     ```output
     "status": {
         "errorCode": 500011,
         "failureReason": "The resource principal named <resource principal name> was not found in  
     the tenant named <tenant name>. This can happen if the application has not been installed by 
     the administrator of the tenant or consented to by any user in the tenant. You might have sent 
     your authentication request to the wrong tenant."
     ```

     Get the resource principal name from the failure message.

   - When you enter your credentials to add your Exchange Online email account, use a network protocol analyzer to capture the network traffic. Search the captured network traffic for a POST request that has all the following items:

     - An endpoint URL that contains `oauth2/token HTTP/1.1`
     - An HTTP response status code 400 (Bad Request)
     - An error message in the response body that resembles the following message:

     ```output
     "error":"invalid_resource","error_description":"AADSTS500011: The resource principal named 
     <resource principal name> was not found in the tenant named <tenant name>. This can happen 
     if the application has not been installed by the administrator of the tenant or consented to
     by any user in the tenant. You might have sent your authentication request to the wrong tenant.
     ```

     Get the resource principal name from the error message.

    An example of the resource principal name is `https://autodiscover.contoso.com`.

2. Add the resource principal name to the SPN list in the Microsoft Entra tenant by following the procedure that's described in [Step 5: Register all hostname authorities for your internal and external on-premises Exchange HTTP endpoints](/exchange/configure-oauth-authentication-between-exchange-and-exchange-online-organizations-exchange-2013-help#step-5-register-all-hostname-authorities-for-your-internal-and-external-on-premises-exchange-http-endpoints-with-azure-active-directory).

   > [!NOTE]
   > You can check the list of SPNs in Microsoft Entra ID by running the following command:
   >
   > ```powershell
   > Get-MsolServicePrincipal -AppPrincipalId 00000002-0000-0ff1-ce00-000000000000 | select -ExpandProperty ServicePrincipalNames
   > ```

[!INCLUDE [Azure AD PowerShell deprecation note](~/../Exchange/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

To verify that the on-premises Exchange Server and Exchange Online endpoints can [successfully authenticate requests](/exchange/configure-oauth-authentication-between-exchange-and-exchange-online-organizations-exchange-2013-help#how-do-you-know-this-worked) from each other, use the [Test-OAuthConnectivity](/powershell/module/exchange/Test-OAuthConnectivity) cmdlet.
