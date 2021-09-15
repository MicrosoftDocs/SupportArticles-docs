---
title: Azure AD Hybrid Sync Agent Installation Issues - No privileges to install MSI
description: This troubleshooting guide focuses on the situation where you have no privileges to install MSI, which may block you from successfully installing the Azure AD Connect Provisioning Agent.
ms.date: 09/15/2021
---

# Azure AD Hybrid Sync Agent Installation Issues - No privileges to install MSI

This troubleshooting guide focuses on the situation where you have no privileges to install MSI, which may block you from successfully installing the Azure AD Connect Provisioning Agent.

## Prerequisites

To install *Cloud Provisioning Agent*, the following prerequisites are required:

- Domain or Enterprise Administrator credentials to execute the installer.
- A Global Administrator Account at the Azure AD Tenant.
- The server for the provisioning agent must be Windows Server 2016 or later, domain-joined, and following directives for Tier 0 based on the Active directory administrative model.
- At least one domain controller running Windows Server 2016, and both a domain functional level and a forest functional level of at least 2012 R2.
- [Network prerequisites](/azure/active-directory/cloud-sync/how-to-prerequisites#in-your-on-premises-environment)

## No privileges to install MSI

While installing Cloud Provisioning Agent, you may encounter the following error:

> Service 'Microsoft Azure AD Connect Provisioning Agent' (AADConnectProvisioningAgent) could not be installed. Verify that you have sufficient privileges to install system services.

:::image type="content" source="media/azure-ad-hybrid-synch-no-privileges-install-msi/1-provisioning-agent-failed-start.png" alt-text="Screenshot of an error window when attempting to install the Microsoft Azure AD Connect Provisioning Agent. The error includes the message Service Microsoft Azure AD Connect Provisioning Agent failed to start. Verify that you have sufficient privileges to install system services." border="true":::

To verify that you have sufficient privileges:

1. Certify that the user context credentials are set to either Domain Administrator or Enterprise Administrator.

1. Check the Local Security Policy (secpol.msc) through **Open local policies** > **User Rights Assignment** > **Log on as a service**

   :::image type="content" source="media/azure-ad-hybrid-synch-no-privileges-install-msi/2-log-on-service-policy.png" alt-text="Screenshot of the Local Security Policy window, highlighting the Log on as a service policy." border="true":::

1. Verify that NT SERVICE\ALL SERVICES is listed as a **Local Security Setting**.

   :::image type="content" source="media/azure-ad-hybrid-synch-no-privileges-install-msi/3-log-on-service-properties.png" alt-text="Screenshot of the Local Security Setting tab in the Log on as a service Properties window." border="true":::

During Package installation the service **AADConnectProvisioningAgent** is created, and log on credentials are temporarily set to **NT Service\AADConnectProvisioningAgent**.

If **Log on as a service** doesn't have ALL SERVICES listed, the installation will fail to start with the previously-listed error message.

To resolve this issue, provide ALL SERVICES user rights to **Log on as a service**.

The wizard will now complete successfully.