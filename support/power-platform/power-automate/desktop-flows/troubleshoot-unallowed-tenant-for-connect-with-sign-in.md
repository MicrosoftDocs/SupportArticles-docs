---
title: Desktop flow unallowed tenant for connect with sign-in
description: Resolves the UnallowedTenantForConnectWithSignIn error that occurs when you run a desktop flow using a connect with sign-in from a tenant that isn't allowlisted by the target Active Directory (AD) domain-joined machine.
ms.reviewer: padib，aartigoyle, johndund, quseleba
ms.date: 08/23/2024
ms.custom: sap:Desktop flows\Unattended flow runtime errors
---
# Desktop flow unallowed tenant for connect with sign-in error

This article provides a resolution for the `UnallowedTenantForConnectWithSignIn` error code that occurs when you run a desktop flow using a [connect with sign-in](/power-automate/desktop-flows/desktop-flow-connections#connect-with-sign-in-for-attended-runs) connection on an Active Directory (AD) domain-joined machine.

## Symptoms

Your desktop flow fails with the following error:

```json
{
    "error":{
        "code": "UnallowedTenantForConnectWithSignIn",
        "message": "Tenant <tenantId> needs to be explicitly allowlisted to authorize 'connect with sign-in' runs on the machine."  
    }    
}
```

## Cause

This error occurs when:

- You use a [connect with sign-in](/power-automate/desktop-flows/desktop-flow-connections#connect-with-sign-in-for-attended-runs) connection to perform an attended run.
- The target machine is AD domain-joined but not Microsoft Entra joined.
- The tenant of your Power Automate envrironment isn't added to the `AllowedRegistrationTenants` allowlist in the machine registry.

  This allowlisting is required as part of a security patch to avoid allowing unknown tenants from targeting your machines to run desktop flow scripts. For more information, see [Power Automate for desktop security update for "connect with sign-in" connections on Active Directory domain-joined machines](connect-with-sign-in-security-update.md).

## Resolution

> [!NOTE]
> You require administrator privileges on the target machine to fix the issue.

### How to find your Power Automate tenant ID

The tenant ID should be included in the `UnallowedTenantForConnectWithSignIn` error message. Use the following steps if you don't know your tenant ID:

1. Sign in to [Power Automate](https://make.powerautomate.com/).
1. Select <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd>.
1. Locate the tenant ID in the `tenantId` property.

### How to allowlist a tenant ID on your machine

> [!IMPORTANT]
> The following steps can be used to allowlist your tenant on a single machine. However, we recommend consulting with your domain administrators to create a Group Policy Object (GPO) that applies the appropriate allowlist across all your machines. Creating a GPO like this can centrally specify which tenants are trusted to use Power Automate for desktop on the machines in your tenant.

1. Open the registry editor and navigate to the `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Power Automate Desktop\Registration` key.

1. If the `AllowedRegistrationTenants` registry value doesn't exist, create it by right-clicking and selecting **New** > **string value**. Name it `AllowedRegistrationTenants`.

1. Right-click the `AllowedRegistrationTenants` registry value and select **Modify**. Edit the value to add your tenant ID. The expected value is a comma-separated list of tenant IDs such as "00000000-0000-0000-0000-000000000000" or "00000000-0000-0000-0000-000000000000,00000000-0000-0000-0000-000000000001".
