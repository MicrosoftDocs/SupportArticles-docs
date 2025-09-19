---
title: Resource Monitoring Stopped Working 
description: Troubleshoot situations in which New Relic stops receiving logs or metrics from Azure resources.
author: ProfessorKendrick
ms.author: kkendrick
ms.service: partner-services
ms.topic: troubleshooting-general
ms.date: 09/19/2025
ai-usage: ai-assisted

#customer intent: As an Azure administrator or user, I want to troubleshoot situations in which New Relic monitoring stops working.

---

# Resource monitoring stopped working 

This article helps you troubleshoot situations in which New Relic stops receiving telemetry (logs, metrics, or events) from Azure resources like virtual machines and app services. It includes likely causes, quick workarounds, and a step‑by‑step troubleshooting checklist to help you identify and resolve your issue.

## Prerequisites

- Access to the New Relic account that owns the ingest API key (API key admin or owner).
- Access to the Azure subscription and resource group that contain the affected resources (Reader to view; Contributor/Owner to remediate or change billing).
- Familiarity with the Azure portal, New Relic portal, and basic CLI (Azure CLI or PowerShell) commands.

## Potential quick workarounds

1. Refresh the New Relic portal and check the timestamp of the latest telemetry to confirm whether the issue is transient.
2. If the ingest API key was recently rotated or revoked, reissue a new ingest API key in New Relic and update the resource configuration.
3. Restart the resource agent or the VM (if possible) to force the agent to re-establish connections and re-send telemetry.

## Troubleshooting checklist

Follow these steps in order. After each major remediation, wait a few minutes and verify whether telemetry resumes in New Relic.

### 1) Verify the New Relic ingest API key

- In the New Relic portal, confirm the ingest API key assigned to the resource exists and is Active.
- If the key is revoked, recreate or rotate the key and update the resource configuration to use the new key.
- If you cannot manage the key or need help, contact New Relic support: https://support.newrelic.com/

### 2) Check Azure subscription and billing state

- In the Azure portal, confirm the subscription that contains the resources is Active.
- If the subscription is Suspended, Disabled, or Deleted for payment reasons, either update the payment method or move resources to a different active subscription.
- [Billing docs](/azure/cost-management-billing/manage/change-credit-card)

### 3) Confirm resource-side agents and extensions

- Virtual Machines:
  - Verify the Azure VM Agent and New Relic extension are installed and healthy.
  - Azure CLI example:

    az vm extension list --resource-group {resource-group} --vm-name {vm-name} --output table

  - PowerShell example (Az module):

    Get-AzVMExtension -ResourceGroupName {resource-group} -VMName {vm-name}

- App Services:
  - Verify the New Relic integration settings (application settings, extension configuration) are present and correctly configured.

### 4) Inspect Activity Log and resource logs

- Check the Azure Activity Log for extension install/uninstall, configuration changes, or permission changes that align with when telemetry stopped.
- Review agent logs on the resource for connectivity or authentication errors.

### 5) Check network connectivity to New Relic endpoints

- From the resource or a bastion host, verify outbound connectivity to New Relic ingestion endpoints. Example (Linux) using curl:

  curl -v https://log-api.newrelic.com

- For Windows, use Test-NetConnection:

  Test-NetConnection -ComputerName log-api.newrelic.com -Port 443

- Ensure NSGs, firewalls, or proxies are not blocking outbound HTTPS to New Relic.

### 6) Check for New Relic service issues

- Verify New Relic status and known incidents on New Relic status pages or support channels. If a New Relic outage is reported, collect timestamps and wait for the service to recover or contact New Relic support.

### 7) Reconfigure or reissue the ingest key and restart agents

- If the ingest key was revoked or rotated, create a new ingest API key in New Relic and update resource configuration.
- Restart the agent or the hosting resource to ensure the new key and configuration are applied.

## Causes and solutions

### Cause: Ingest API key revoked or rotated
Solution:
1. Recreate or rotate the ingest API key in New Relic.
2. Update resource configuration to use the new key.
3. Restart the agent or resource if required.

### Cause: Azure subscription suspended or deleted (billing)
Solution:
1. Update the subscription payment method or move resources to an active subscription.
2. Confirm subscription state in the Azure portal and verify telemetry resumes.

### Cause: Resource agent/extension failure or misconfiguration
Solution:
1. Reinstall or repair the VM agent or New Relic extension.
2. Review agent logs for authentication or connectivity errors and address them.

### Cause: Network connectivity blocking outbound traffic
Solution:
1. Adjust NSG, firewall, or proxy rules to allow outbound HTTPS to New Relic ingestion endpoints.
2. Test connectivity from the resource.

### Cause: New Relic service outage
Solution:
1. Check New Relic status and incidents.
2. If required, open a support ticket with New Relic and provide collected diagnostics.

## Advanced troubleshooting and data collection

If you need to open a support request, collect these items to speed diagnosis:

- Affected resource names and resource IDs
- Resource group and subscription ID
- Exact timestamps (UTC) when telemetry stopped and any observed retries or errors
- Activity Log entries related to extensions, configuration changes, or subscription state
- Agent or extension logs from the affected resource
- Results of connectivity tests (curl, Test-NetConnection, or equivalent)
- New Relic ingest API key ID (do not include the API key secret in support tickets unless requested by support)

When contacting support, provide a concise reproduction path and the results of the steps above.

## Related content

- [Manage extensions on Azure virtual machines](/azure/virtual-machines/extensions)
- [Troubleshoot VM Agent issues](/azure/virtual-machines/troubleshooting-vm-agent)
- [Add, update, or delete a payment method](/azure/cost-management-billing/manage/add-change-payment-method)
- [New Relic support](https://support.newrelic.com/)