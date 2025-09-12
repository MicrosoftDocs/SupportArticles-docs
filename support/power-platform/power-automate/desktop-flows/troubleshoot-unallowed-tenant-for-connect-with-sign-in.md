---
title: UnallowedTenantForConnectWithSignIn
description: Resolves errors that occur when you run a desktop flow or create or test a connection by using connect with sign-in.
ms.reviewer: padib，aartigoyle, johndund, quseleba
ms.date: 09/11/2024
ms.custom: sap:Desktop flows\Unattended flow runtime errors
---
# "UnallowedTenantForConnectWithSignIn" or connection errors when using "connect with sign-in"

This article provides a resolution for errors that might occur when you run a desktop flow or create or test a connection by using [connect with sign-in](/power-automate/desktop-flows/desktop-flow-connections#connect-with-sign-in-for-attended-runs) on an Active Directory (AD) domain-joined machine.

## Symptoms

- Your desktop flow fails with the following error when you run a desktop flow by using a [connect with sign-in](/power-automate/desktop-flows/desktop-flow-connections#connect-with-sign-in-for-attended-runs) connection on an AD domain-joined machine.

  ```json
  {
      "error":{
          "code": "UnallowedTenantForConnectWithSignIn",
          "message": "Tenant <tenantId> needs to be explicitly allowlisted to authorize 'connect with sign-in' runs on the machine."  
      }    
  }
  ```

- You receive one of the following errors when you try to create or test a "connect with sign-in" connection on an AD domain-joined machine:

  - > Unable to connect. The credentials for the machine are incorrect.
  - > Tenant \<tenantID> needs to be explicitly allow-listed to authorize 'connect with sign-in' runs on the machine.

## Cause

This error occurs when all of the following apply:

- You use a [connect with sign-in](/power-automate/desktop-flows/desktop-flow-connections#connect-with-sign-in-for-attended-runs) connection to perform an attended run.
- The target machine is AD domain-joined but not Microsoft Entra-joined.
- The tenant of your Power Automate environment isn't added to the `AllowedRegistrationTenants` allowlist in the machine registry.

Adding the tenant to the allowlist is required as part of a security patch to prevent unknown tenants from targeting your machine to run desktop flow scripts. For more information, see [Security update for "connect with sign-in" connections on AD domain-joined machines in Power Automate for desktop](connect-with-sign-in-security-update.md).

## Resolution

> [!NOTE]
> You need administrator privileges on the target machine to fix the issue.

### Step 1: Find your Power Automate tenant ID

The tenant ID should be included in the `UnallowedTenantForConnectWithSignIn` error message. If you don't know your tenant ID, follow these steps:

1. Sign in to [Power Automate](https://make.powerautomate.com/).
1. Select <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>A</kbd>.
1. Locate the tenant ID in the `tenantId` property.

### Step 2: Add the tenant ID to the allowlist on your machine

> [!IMPORTANT]
> The following steps can be used to add your tenant to the allowlist on a single machine. However, we recommend consulting with your domain administrators to create a Group Policy Object (GPO) that applies the appropriate allowlist across all your machines. Creating such a GPO can centrally specify which tenants are trusted to use Power Automate for desktop on the machines in your tenant.

1. Open the Registry Editor and navigate to the `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Power Automate Desktop\Registration` key.

1. If the `AllowedRegistrationTenants` registry value doesn't exist, create it by right-clicking and selecting **New** > **String Value**, and then naming it `AllowedRegistrationTenants`.

   :::image type="content" source="media/troubleshoot-unallowed-tenant-for-connect-with-sign-in/registry-value-creation.png" alt-text="Screenshot of the creation of a string value in the Power Automate Desktop Registration registry key.":::

1. Right-click the `AllowedRegistrationTenants` registry value and select **Modify**. Edit the value to add your tenant ID. The expected value is a comma-separated list of tenant IDs, such as "aaaabbbb-0000-cccc-1111-dddd2222eeee" or "aaaabbbb-0000-cccc-1111-dddd2222eeee,bbbbcccc-1111-dddd-2222-eeee3333ffff".
