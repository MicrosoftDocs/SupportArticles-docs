---
title: Can't connect to Exchange message occurs when using Microsoft Dynamics 365 App for Outlook
description: When you use Microsoft Dynamics 365 App for Outlook, you receive a Can't connect to Exchange message.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# Can't connect to Exchange message appears when using Microsoft Dynamics 365 App for Outlook

This article provides resolutions for the issue that you receive a **Can't connect to Exchange** message when using Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Dynamics 365 App for Outlook  
_Original KB number:_ &nbsp; 4534356

## Symptoms

When using Microsoft Dynamics 365 App for Outlook, you see the following message:

> "Can't connect to Exchange".

The rest of the app may load successfully but the ability to track items and use Set Regarding may be missing.

## Cause

This typically occurs when using a Microsoft Exchange on-premises mailbox and may be caused by one of the following reasons:

**Cause 1:** OAuth authentication is not enabled in Exchange.  
**Cause 2:** There is an issue with the authentication certificate used by Exchange.

## Resolution 1: Verify OAuth authentication is enabled in Exchange

1. On the Exchange server, open the **Exchange Management Shell**.
2. Run the following command:

    ```powershell
    Get-WebServicesVirtualDirectory | FL server,*auth
    ```

3. Verify the results returned show that **OAuthAuthentication** is set to **True**.
4. If `OAuthAuthentication` is set to **False**, a command such as the following needs to be run:

    ```powershell
    Set-WebServicesVirtualDirectory -Identity "EWS (Default Web Site)" -OAuthAuthentication $true
    ```

    The identify value is the name of the virtual directory that can be found in the Exchange Admin Center by selecting **servers** and then selecting **virtual directories** or by running the following command and reviewing the Name value returned:

    ```powershell
    Get-WebServicesVirtualDirectory | FL
    ```

    More information about this command can be found in [Set-WebServicesVirtualDirectory](/powershell/module/exchange/set-webservicesvirtualdirectory?view=exchange-ps&preserve-view=true).

    For more details on authentication requirements for allowing an Outlook Add-in to make asynchronous Exchange Web Service (EWS) requests, see [Authentication and permission considerations for makeEwsRequestAsync](/office/dev/add-ins/outlook/web-services#authentication-and-permission-considerations-for-makeewsrequestasync).

5. Run the following command:

    ```powershell
    Get-OrganizationConfig | FL OAuth2ClientProfileEnabled
    ```

    If the value returned is False, run the following command:

    ```powershell
    Set-OrganizationConfig -OAuth2ClientProfileEnabled:$True
    ```

6. Also verify your version of Exchange has the update mentioned in [Can't access EWS from Outlook/OWA add-ins via makeEwsRequestAsync in Exchange Server 2016 and Exchange Server 2013](https://support.microsoft.com/help/4056329).

## Resolution 2: Verify Exchange Certificate

1. On the Exchange server, open the **Exchange Management Shell**.
2. Run the following command:

   `Get-AuthConfig | FL`
3. Verify the results show **IsValid** as **True**.
4. Copy the value returned for CurrentCertificateThumbprint and use it in the following command:

    ```powershell
    Get-ExchangeCertificate -Thumbprint <CurrentCertificateThumbprint Value>| FL
    ```

5. Verify the results show the following:

    Status = Valid

    The current date is within the NotAfter and NotBefore dates indicating the certificate is not expired.

    If the prior command does not successfully retrieve the certificate, this indicates an issue with the certificate configuration that may require you to create and configure a new certificate. The following are some resources with steps for creating and configuring a new certificate:

    - [Exchange OAuth authentication couldn't find the authorization certificate with thumbprint error when running Hybrid Configuration](/exchange/troubleshoot/administration/exchange-oauth-authentication-could-not-find-the-authorization)
    - [Create a new Exchange Server self-signed certificate](/Exchange/architecture/client-access/create-self-signed-certificates?view=exchserver-2019&preserve-view=true)
    - [Set-AuthConfig](/powershell/module/exchange/set-authconfig?view=exchange-ps&preserve-view=true)

If any changes were required after following the steps above, close and reopen Outlook to see if the issue has been resolved. If the issue persists and your Microsoft Exchange administrator has verified OAuth is enabled and the certificate is valid, it may be necessary to contact Microsoft Support.
