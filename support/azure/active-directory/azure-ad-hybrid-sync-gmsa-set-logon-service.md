---
title: Azure AD Hybrid Sync Agent Installation Issues - The gMSA is set to log on as Service
description: This troubleshooting guide focuses on the situation where the gMSA is set to log on as Service, which may block you from successfully installing the Azure AD Connect Provisioning Agent.
ms.date: 09/15/2021
---

# Azure AD Hybrid Sync Agent Installation Issues - The gMSA is set to log on as Service

This troubleshooting guide focuses on the situation where the gMSA is set to log on as Service, which may block you from successfully installing the Azure AD Connect Provisioning Agent.

## Prerequisites

To install *Cloud Provisioning Agent*, the following prerequisites are required:

- Domain or Enterprise Administrator credentials to execute the installer.
- A Global Administrator Account at the Azure AD Tenant.
- The server for the provisioning agent must be Windows Server 2016 or later, domain-joined, and following directives for Tier 0 based on the Active directory administrative model.
- At least one domain controller running Windows Server 2016, and both a domain functional level and a forest functional level of at least 2012 R2.
- [Network prerequisites](/azure/active-directory/cloud-sync/how-to-prerequisites#in-your-on-premises-environment)

## The gMSA is set to log on as Service

While installing Cloud Provisioning Agent, you may encounter the following error:

> Failed changing Windows service credentials to gMSA.

To resolve this issue, check the System event logs for **EventID 7038**. The following error will be displayed:

> The user name or password is incorrect.

:::image type="content" source="media/azure-ad-hybrid-sync-gmsa-set-logon-service/1-user-name-password-incorrect.png" alt-text="Screenshot of an error window when attempting to install the Microsoft Azure AD Connect Provisioning Agent. The error includes the message The user name or password is incorrect." border="true":::

When you open the **Microsoft Azure AD Connect Provisioning Agent** properties, and select the **Log On** tab, you will find that the settings aren’t grey out, as is expected for a managed account service.

:::image type="content" source="media/azure-ad-hybrid-sync-gmsa-set-logon-service/2-provisioning-agent-properties.png" alt-text="Screenshot of the Log On tab of the Microsoft Azure AD Connect Provisioning Agent window, including the account and password entries." border="true":::

To verify whether the account is managed, open a command prompt and type the following command: 

```console
Sc.exe qmanagedaccount aadconnectprovisioningagent
```

The account managed status will show as **False**.

:::image type="content" source="media/azure-ad-hybrid-sync-gmsa-set-logon-service/3-account-managed-false.png" alt-text="Screenshot of the output for the command, showing the False attribute." border="true":::

To set the status to **True** and resolve this issue, type the following command:

```console
Sc.exe managedaccount aadconnectprovisioningagent true
```

The wizard will now complete successfully.