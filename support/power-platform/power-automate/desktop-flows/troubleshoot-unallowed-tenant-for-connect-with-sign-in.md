---
title: Desktop flow unallowed tenant for connect with sign-in
description: Resolves the UnallowedTenantForConnectWithSignIn error that occurs when you run a desktop flow using a connect with sign-in from an tenant that is not allow-listed by the target AD-joined machine..
ms.reviewer: padib，aartigoyle, johndund, quseleba
ms.date: 08/20/2024
---
# Desktop Desktop flow unallowed tenant for connect with sign-in error

This article provides a resolution for the `UnallowedTenantForConnectWithSignIn` error code that occurs when you run a desktop flow using a [connect with sign-in](/power-automate/desktop-flows/desktop-flow-connections#connect-with-sign-in-for-attended-runs) connection on an AD-joined machine.

## Symptoms

Your desktop flow fails with the following error:
```json
{
    "error":{
        "code": "UnallowedTenantForConnectWithSignIn",
        "message": "Tenant <tenantId> needs to be explicitly allow-listed to authorize 'connect with sign-in' runs on the machine."
    }    
}
```

## Cause

This error happens when:

- You are using a [connect with sign-in](/power-automate/desktop-flows/desktop-flow-connections#connect-with-sign-in-for-attended-runs) connection to perform an attended run.
- The target machine is domain-joined, and it is not Entra ID-joined.
- The tenant of your Power Automate envrironment was not added the the AllowedRegistrationTenants allow-list in the machine registry.

This allow-listing is required as part of a security patch to avoid allowing unknown tenants from targeting your machines to run desktop flow scripts, learn more [here](connect-with-sign-in-security-update.md).

## Resolution

You will require admin privileges on the target machine to remediate the issue.

> [!IMPORTANT]
> These steps explain how to allow-list your tenant on a single machine. Consult your domain admins to create a GPO that sets the appropriate allow-list on all of your machines and centrally defines which tenants are trusted to use Power Automate Desktop on your machines.

1. Get your tenant id. It should be included in the `UnallowedTenantForConnectWithSignIn` error meesage. You can also get it from the Power Automate portal: Press Ctrl + Alt + A, and look for the value of the `tenantId` property

2. Open the registry editor and navigate to this key `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Power Automate Desktop\Registration`

3. If the `AllowedRegistrationTenants` registry value doesn't already exist, create it with right click > New > string value, and name it `AllowedRegistrationTenants`.

4. Right click the `AllowedRegistrationTenants` registry value and select `Modify`. Edit the value to add your tenant id. The expected value is a comma separted list of tenant ids such as "00000000-0000-0000-0000-000000000000" or "00000000-0000-0000-0000-000000000000,00000000-0000-0000-0000-000000000001".
