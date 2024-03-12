---
title: Microsoft Entra Hybrid Sync Agent Installation Issues - No privileges to install MSI
description: This troubleshooting guide focuses on when you have no privileges to install MSI. It helps unblock you to install the Microsoft Entra Connect Provisioning Agent.
ms.date: 10/13/2021
ms.service: active-directory
ms.subservice: hybrid
---

# Microsoft Entra Hybrid Sync Agent Installation Issues - No privileges to install MSI

This troubleshooting guide focuses on when you don't have privileges to install MSI. Without these privileges, you may be unable to successfully install the Microsoft Entra Connect Provisioning Agent.

## Prerequisites

To install *Cloud Provisioning Agent*, the following prerequisites are required: [Prerequisites for Microsoft Entra Connect cloud sync](/azure/active-directory/cloud-sync/how-to-prerequisites).

## No privileges to install MSI

While installing Cloud Provisioning Agent, you may get the following error:

> Service 'Microsoft Entra Connect Provisioning Agent' (AADConnectProvisioningAgent) failed to start. Verify that you have sufficient privileges to start system services.

:::image type="content" source="media/azure-ad-hybrid-sync-no-privileges-install-msi/1-provisioning-agent-failed-start.png" alt-text="Screenshot of error when installing Microsoft Entra Connect Provisioning Agent, about how the Connect Provisioning Agent service failed to start." border="true":::

To verify that you have sufficient privileges:

1. Make sure the user context credentials are set to either Domain Administrator or Enterprise Administrator.

1. Open the Local Security Policy snap-in (*secpol.msc*). In the **Security Settings** pane, select **Local policies** > **User Rights Assignment**. Then select the **Log on as a service** policy.

   :::image type="content" source="media/azure-ad-hybrid-sync-no-privileges-install-msi/2-log-on-service-policy.png" alt-text="Screenshot of the Local Security Policy window, highlighting the 'Log on as a service' policy." border="true":::

1. Select **Action** > **Properties**. Then in **Local Security Setting**, make sure the `NT SERVICE\ALL SERVICES` group appears.

   :::image type="content" source="media/azure-ad-hybrid-sync-no-privileges-install-msi/3-log-on-service-properties.png" alt-text="Screenshot of the Local Security Setting tab in the 'Log on as a service Properties' window. The 'NT SERVICE\ALL SERVICES' group should be present." border="true":::

During package installation, the service **AADConnectProvisioningAgent** is created, and logon credentials are temporarily set to **NT Service\AADConnectProvisioningAgent**.

If **Log on as a service** doesn't have *ALL SERVICES* listed, the installation fails to start, and it shows the previously listed error message.

To resolve this issue, provide *ALL SERVICES* user rights to **Log on as a service**.

The wizard now completes successfully.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
