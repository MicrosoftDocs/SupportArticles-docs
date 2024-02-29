---
title: TGS requests for krbtgt account fail
description: Describes an issue that causes S4U Kerberos authentication to fail for a user in a trusted forest. Occurs when selective authentication is enabled on the forest trust and when an application calls LsalogonUser by using a Kerberos S4U client request.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, ntuttle
ms.custom: sap:kerberos-authentication, csstroubleshoot
---
# A TGS request for the krbtgt account fails with KDC_ERR_POLICY and an extended status of STATUS_AUTHENTICATION_FIREWALL_FAILED (0xC0000413)

This article provides help to fix an issue that causes S4U Kerberos authentication to fail for a user in a trusted forest.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2959395

## Symptoms

S4U Kerberos authentication fails for a user in a trusted forest when selective authentication is enabled on the forest trust.

Specifically, an application that calls the LsalogonUser API by using a Kerberos S4U client request to authenticate a user in a trusted forest may fail when the following conditions are true:

- The ClientUPN value that's provided to LsalogonUser represents a user in a trusted forest where selective authentication is enabled.
- The ClientRealm value that's provided to LsalogonUser is in the form of a NetBIOS name (flat name), not a fully qualified domain name (FQDN).

In this situation, a network trace shows that a TGS request for the krbtgt account fails with a "STATUS_AUTHENTICATION_FIREWALL_FAILED (0xC0000413)" error.

## Cause

This issue occurs when, as part of processing the LsalogonUser  request, the Kerberos client must obtain an authentication ticket for the user from a domain controller in the user's trusted forest.

If the ClientRealm value was passed in a flat name format, the Kerberos client does not use the referral ticket it received as part of the referral process. Therefore, the client must request a service ticket for the Krbtgt account in the user domain.

When selective authentication is enabled, the domain controller in the user's domain checks the "Allowed to Authenticate" permission on the Krbtgt account to see whether the identity of the caller that's making the ticket request has access.

> [!NOTE]
> The caller that makes the service ticket request has the identity that the thread that calls LsalogonUser was impersonating at the time.

If the "Allowed to Authenticate" permission is not present, the domain controller in the user's domain generates a KDC_ERR_POLICY error and an extended error of STATUS_AUTHENTICATION_FIREWALL_FAILED (0xC0000413).

## Resolution

To resolve this issue, use one of the following methods.

### Method 1: Remove selective authentication from the trust

The domain controller in the target resources domain will ignore the "Allowed to authenticate" permission on the account. This behavior may not be desirable in a secure environment.

### Method 2: Add the caller's identity to the "Allowed to Authenticate" permission on the Krbtgt account in the target user's domain

Because the Krbtgt account is a protected account, you must add the "Allowed to Authenticate" permission for the caller's identity to the AdminSdHolder account object. To do this, follow these steps:

1. Open a command prompt on a domain controller in the target user's domain.
2. Run the following command to add the "Allowed to Authenticate" permission to the AdminSdholder object:

    ```console
    dsacls "CN=AdminSDHolder,CN=System,DC=ForestB,DC=com" /G DomainA\callers-identity:CA;"Allowed to Authenticate"  
    ```

    > [!NOTE]
    >
    > - *DC=ForestB,DC=com* is the distinguished name of the user's target forest.
    > - *DomainA* is the name of the domain where the identity of the account that's calling LsaLogonUser is located.
    > - *Callers-identity* is the account name of the identity under which the LsaLogonUser call is being made.

3. Run the following command to verify the "Allowed to Authenticate" permission on the target account:

    ```console
    dsacls "CN=AdminSDHolder,CN=System,DC=ForestB,DC=com"
    ```

4. Run dsa.msc on the user's target domain, and then locate the Krbtgt account.
5. Select the properties of the target account, and then click the **Security** tab.
6. Add the "Allowed to Authenticate" permission to the account under which the LsaLogonUser call is being made.
