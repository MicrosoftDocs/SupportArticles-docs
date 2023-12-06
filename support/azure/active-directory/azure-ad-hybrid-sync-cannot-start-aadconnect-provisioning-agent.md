---
title: Microsoft Entra Hybrid Sync Agent Installation Issues - Cannot start service AADConnectProvisioningAgent
description: This troubleshooting guide focuses on when you can't start service AADConnectProvisioningAgent. It unblocks you to install Microsoft Entra Connect Provisioning Agent.
ms.date: 10/13/2021
ms.service: active-directory
ms.subservice: hybrid
---

# Microsoft Entra Hybrid Sync Agent Installation Issues - Cannot start service AADConnectProvisioningAgent

This troubleshooting guide focuses on when you can't start the AADConnectProvisioningAgent service. This problem may block you from installing the Microsoft Entra Connect Provisioning Agent successfully.

## Prerequisites

To install *Cloud Provisioning Agent*, the following prerequisites are required: [Prerequisites for Microsoft Entra Connect cloud sync](/azure/active-directory/cloud-sync/how-to-prerequisites).

## Cannot start service AADConnectProvisioningAgent

While installing Cloud Provisioning Agent, you may get the following error:

> Service 'Microsoft Entra Connect Provisioning Agent' (AADConnectProvisioningAgent) failed to start. Verify that you have sufficient privileges to start system services.

:::image type="content" source="media/azure-ad-hybrid-sync-cannot-start-aadconnect-provisioning-agent/1-aad-connect-provision-agent-failed.png" alt-text="Screenshot of error when installing Microsoft Entra Connect Provisioning Agent, about how the Connect Provisioning Agent service failed to start." border="true":::

Assign domain administrator credentials to the **AADConnectProvisioningAgent** service, as shown in [How to troubleshoot agent failed to start](/azure/active-directory/cloud-sync/how-to-troubleshoot#agent-failed-to-start).

:::image type="content" source="media/azure-ad-hybrid-sync-cannot-start-aadconnect-provisioning-agent/2-provisioning-agent-properties.png" alt-text="Screenshot of the 'Log On' tab of the Microsoft Entra Connect Provisioning Agent Properties window, including the account and password entries." border="true":::

After assigning credentials to the service, you may still be unable to complete the installation wizard, and receive the following error message:

> Failed changing Windows service credentials to gMSA. Please check the logs for more detailed information. If that doesn't help resolve this issue, please contact support.

:::image type="content" source="media/azure-ad-hybrid-sync-cannot-start-aadconnect-provisioning-agent/3-failed-changing-service-credentials.png" alt-text="Screenshot of the agent configuration window. It shows an error about how it couldn't change the Windows service credentials to g M S A." border="true":::

If you select the confirm button again, following message will be displayed:

> Unable to create gMSA because KDS may not be running on domain controller. Please create/run KDS manually.

:::image type="content" source="media/azure-ad-hybrid-sync-cannot-start-aadconnect-provisioning-agent/4-unable-create-gmsa.png" alt-text="Screenshot of the agent configuration window. It shows an error about how it can't create g M S A, and to create or run K D S manually first." border="true":::

To resolve this issue, check the System event logs for **eventID 7041**. The event details describe how to assign a **Log on as a service** user right at the Local Security Policy snap-in (*secpol.msc*).

:::image type="content" source="media/azure-ad-hybrid-sync-cannot-start-aadconnect-provisioning-agent/5-event-7041.png" alt-text="Screenshot of the Event 7041, Service Control Manager window. It notes that the service account doesn't have the required user right." border="true":::

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
