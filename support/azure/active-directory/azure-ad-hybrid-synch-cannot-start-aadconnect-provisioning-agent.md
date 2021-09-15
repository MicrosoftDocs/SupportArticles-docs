---
title: Azure AD Hybrid Sync Agent Installation Issues - Cannot start service AADConnectProvisioningAgent
description: This troubleshooting guide focuses on the situation where you can't start service AADConnectProvisioningAgent, which may block you from successfully installing the Azure AD Connect Provisioing Agent.
ms.date: 09/15/2021
---

# Azure AD Hybrid Sync Agent Installation Issues - Cannot start service AADConnectProvisioningAgent

This troubleshooting guide focuses on the situation where you can't start service AADConnectProvisioningAgent, which may block you from successfully installing the Azure AD Connect Provisioing Agent.

## Prerequisites

To install *Cloud Provisioning Agent*, the following prerequisites are required:

- Domain or Enterprise Administrator credentials to execute the installer.
- A Global Administrator Account at the Azure AD Tenant.
- The server for the provisioning agent must be Windows Server 2016 or later, domain-joined, and following directives for Tier 0 based on the Active directory administrative model.
- At least one domain controller running Windows Server 2016, and both a domain functional level and a forest functional level of at least 2012 R2.
- [Network prerequisites](/azure/active-directory/cloud-sync/how-to-prerequisites#in-your-on-premises-environment)

## Cannot start service AADConnectProvisioningAgent

While installing Cloud Provisioning Agent, you may encounter the following error:

> Service 'Microsoft Azure AD Connect Provisioning Agent' (AADConnectProvisioningAgent) could not be installed. Verify that you have sufficient privilages to install system services.

:::image type="content" source="media/azure-ad-hybrid-synch-cannot-start-aadconnect-provisioning-agent/1-aad-connect-provision-agent-failed.png" alt-text="Screenshot of an error window when attempting to install the Microsoft Azure AD Connect Provisioning Agent. The error includes the message Service Microsoft Azure AD Connect Provisioning Agent could not be installed. Verify that you have sufficient privileges to install system services." border="true":::

Assign domain administrator credentials to the service **AADConnectProvisioningAgent** as shown in [How to troubleshoot agent failed to start](/azure/active-directory/cloud-sync/how-to-troubleshoot#agent-failed-to-start).

:::image type="content" source="media/azure-ad-hybrid-synch-cannot-start-aadconnect-provisioning-agent/2-provisioning-agent-properties.png" alt-text="Screenshot of the Log On tab of the Microsoft Azure AD Connect Provisioning Agent window, including the account and password entries." border="true":::

After assigning credentials to the service, you may still be unable to complete the installation wizard, and receive the following error message:

> Failed changing Windows service credentials to gMSA. Please check the logs for more detailed information. If that doesn't help resolve this issue, please contact support.

:::image type="content" source="media/azure-ad-hybrid-synch-cannot-start-aadconnect-provisioning-agent/3-failed-changing-service-credentials.png" alt-text="Screenshot of the Agent configuration with the error message Failed changing Windows service credentials to gMSA. Please check the logs for more detailed information. If that doesn't help resolve this issue, please contact support." border="true":::

If you select the confirm button again, following message will be displayed:

> Unable to create gMSA because KDS may not be running on domain controller. Please create/run KDS manually.

:::image type="content" source="media/azure-ad-hybrid-synch-cannot-start-aadconnect-provisioning-agent/4-unable-create-gmsa.png" alt-text="Screenshot of the Agent configuration with the error message Unable to create gMSA because KDS may not be running on domain controller. Please create/run KDS manually." border="true":::

To resolve this issue, check the System event logs for **eventID 7041**. The event details will describe how to assign **Log on as a Service** user right at the `secpol.msc` console.

:::image type="content" source="media/azure-ad-hybrid-synch-cannot-start-aadconnect-provisioning-agent/5-event-7041.png" alt-text="Screenshot of Event 7041, Service Control Manager. This includes the error message This service account does not have the required user right." border="true":::
