---
title: Cannot create a meeting on behalf of delegate in Skype for Business
description: Resolves a problem in which you cannot create a Skype meeting on behalf of delegate and with error in Skype for Business Online.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
---

# Cannot create a Skype meeting on behalf of delegate and with error in Skype for Business Online

## Symptoms 

In Skype for Business Online, you are granted delegate permission for another user. When you try to create a Skype meeting on behalf of this user, the attempt fails. Additionally, you might receive an error message that resembles the following:

> **You do not have permissions to schedule Skype Meetings on behalf of the owner of this account. Please contact the owner of the account to get delegate permissions in Skype for Business.**

## Cause

This issue occurs because the delegate and delegator's data location aren't located in a same region. By default, Office 365 resources for your users are in the same geographical location as your Azure AD tenant.

## Resolution

To fix this issue, define the same location for the affected users by setting the preferredDataLocation attribute. The preferredDataLocation value is managed by Azure Active Directory (Azure AD) and is then replicated to Skype for Business AD.

- If you are in a Skype for Business Online environment, users are hosted in Azure AD. To update the value of preferredDataLocation, run the following cmdlet:

    ```powershell
    Set-MsolUser -UserPrincipalName "davidchew@contoso.com" -PreferredDataLocation "EUR"
    ```

    This cmdlet sets the preferred data location property of a user whose user principal name is davidchew@contoso.com to EUR (European Union).

- If users are hosted on an on-premises server, such as a domain controller (DC) that is running Active Directory Domain Service (AD DS), you must manually update the preferred data location value in on-premises AD, and then sync the updates to Azure AD by using Azure AD Connect. To do this, see the following article:

    [Azure Active Directory Connect sync: Configure preferred data location for Office 365 resources](/azure/active-directory/hybrid/how-to-connect-sync-feature-preferreddatalocation)

    This cmdlet sets the preferred data location property of a user whose user principal name is davidchew@contoso.com to EUR (European Union).

> [!NOTE]
> You have to update the value for both the delegate and delegator.

To verify that the value of the preferredDataLocation attribute was synced to Skype for Business, run the following cmdlet:

```powershell
Get-CsOnlineUser "davidchew@contoso.com" | select registrarpool, sipaddress, enabled, objectid, PreferredDataLocation
```

## More information

When the issue occurs, you may also notice the following Skype for Business client log entry that states, "Delegate operation not allowed as delegate and delegator are in different deployments."

```asciidoc
SIP/2.0 403 Forbidden
ms-user-logon-data: RemoteUser
Authentication-Info: TLS-DSK qop="auth", opaque="884755AC", srand="8ED749F1", snum="84", rspauth="688d337bcfc845a9f8cbe388cafd475000902b5eb64fe03d21a90010ecbb8291d09a89beb3fc0d9a227265c0fd87747d", targetname="BLU2A16FES15.infra.lync.com", realm="SIP Communications Service", version=4
Content-Length: 83
From: <sip:user@domain.com>;tag=66064880da;epid=a4ac5a5f0f
To: <sip:user@domain.com>;tag=E9535CAC88CA8B5A4B84A576EF5AED75
Call-ID: 06aba2f23c6441c0a6b9d910f6fd4a6c
CSeq: 1 SERVICE
Via: SIP/2.0/TLS 146.47.202.216:50136;received=10.5.17.254;ms-received-port=53248;ms-received-cid=FF8800
ms-diagnostics: 4268;reason="Delegate operation not allowed as delegate and delegator are in different deployments.";source="BLU2A16FES08.infra.lync.com"
ms-telemetry-id: 97AEE43F-31E3-59EF-B34D-6B13D38BE439
Content-Type: application/msrtc-fault+xml
Server: RTC/7.0
- <Fault>
<Faultcode>Client.Delegate.Operation.NotAuthorized</Faultcode>
```

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).