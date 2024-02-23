---
title: 401 Access denied when running Test-OAuthConnectivity
description: Describes an issue that occurs when you run the Test-OAuthConnectivity cmdlet to test OAuth authentication for a user.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom:
  - Exchange Online
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# 401 Access denied error when you run the Test-OAuthConnectivity cmdlet

_Original KB number:_ &nbsp; 3090197

## Symptoms

When you run the `Test-OAuthConnectivity` cmdlet to test OAuth authentication for a user, the operation fails, and you receive a message that resembles the following:

> 401 Access denied

## Cause

This issue can occur if one of the following conditions is true:

- The service principal name (SPN) that's required for OAuth authentication is missing.
- You're testing an account that's not synchronized between the on-premises environment and Microsoft Exchange Online.

## Resolution

To fix this issue, take one of the following actions, as appropriate for your situation.

### Scenario 1 - The SPN is missing

1. Open the Exchange Management Shell.
2. Run the following command:

    ```powershell
    Get-IntraOrganizationConfiguration
    ```

    Notice the values that are returned for `OnPremisesDiscoveryEndPoint` and `OnPremisesWebServiceEndPoint`.

3. Run the following command:

    ```powershell
    (Get-MsolServicePrincipal -ServicePrincipalName "00000002-0000-0ff1-ce00-000000000000").ServicePrincipalNames
    ```

    Check whether the domain names that are listed for the endpoints are returned.

4. If the domains names aren't returned, use the `Set-MsolServicePrincipal` cmdlet to add them.

    For example, the following command adds the `mail.contoso.com` domain.

    ```powershell
    $AppId = (Get-MsolServicePrincipal -ServicePrincipalName "00000002-0000-0ff1-ce00-000000000000").AppPrincipalId
    Set-MsolServicePrincipal -AppPrincipalId $AppId -ServicePrincipalNames @("mail.contoso.com")
    ```

### Scenario 2 - You're using an account that isn't synchronized between the on-premises environment and Exchange Online

When you run the `Test-OAuthConnectivity` cmdlet, make sure that you use an account that's synchronized between the on-premises environment and Exchange Online. For example, you'll encounter this issue if you use an on-premises administrator account.

In the following example, *Fred* is a user account that's synchronized between the on-premises environment and Exchange Online.

```powershell
Test-OAuthConnectivity -Service EWS -TargetUri https://cas.contoso.com/ews/ -Mailbox "Fred"
```

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
