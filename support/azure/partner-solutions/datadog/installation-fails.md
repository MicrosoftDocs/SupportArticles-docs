---
title: Troubleshoot Datadog agent installation failures in Azure
description: "Step-by-step troubleshooting to resolve Datadog agent installation failures caused by a missing Default API key or misconfiguration."
author: v-albemi
ms.author: v-albemi
ms.service: Datadog integration
ms.topic: troubleshooting-general
ms.date: 09/22/2025

customer intent: As a {role}, I want {what} so that {why}.

---

# Troubleshoot Datadog agent installation failures

This article helps you troubleshoot Datadog agent installation failures on Azure virtual machines and App Services when the installation fails because the Datadog API key is not configured as the Default Key or the agent configuration is incorrect.

Use this article when Datadog agent installation fails or the agent is installed but does not report metrics or logs.

## Prerequisites

- Access to the Datadog account that manages API keys (API key admin or owner).
- Access to the Azure portal with permissions to view or configure the Datadog integration and to restart VMs or App Services if required.
- Basic familiarity with the Datadog agent configuration and how to view agent logs on the target OS.

## Potential quick workarounds

1. In the Datadog API Keys screen, select an API key as the Default Key and retry the installation.
2. Manually configure the Datadog agent on the VM or App Service with a valid API key and restart the agent.
3. If the installation was attempted from the portal, try using a different browser or an incognito/private window to rule out UI caching issues.

## Troubleshooting checklist

Follow these steps in order. After each change, retry the installation or restart the agent and verify telemetry.

### 1) Verify Default Key in Datadog

- In the Datadog portal, open API Keys (or the Datadog integration configuration in Azure, if applicable).
- Confirm one API key is marked as the Default Key. The Default Key is used when installing the Datadog agent from the integration screen.
- If no Default Key is selected, select an existing valid API key as the Default Key or create a new key and mark it as default.

### 2) Re-run the installation from the integration

- After selecting a Default Key, retry the Datadog agent installation from the Azure Datadog integration screen.
- Wait for the installation to complete and check the installation status or operation logs in the portal.

### 3) Manually validate agent configuration on the VM/App Service

- On Linux VMs, check /etc/datadog-agent/datadog.yaml and confirm api_key is present and matches the expected key.
- On Windows VMs, check C:\ProgramData\Datadog\datadog.yaml for the api_key setting.
- For App Services, verify application settings or extension configuration include the correct Datadog API key.

### 4) Inspect installation and agent logs

- Review installation logs from the Azure integration or extension operation to see error messages related to missing API key.
- Check Datadog agent logs on the VM for errors about authentication or failed connections to Datadog endpoints.

### 5) Verify network connectivity

- Ensure outbound HTTPS (TCP 443) to Datadog ingestion endpoints is allowed by NSGs, firewalls, and proxies.
- Test connectivity from the VM or a jump host (example):

  ```bash
  curl -v <api.datadoghq.com>
  ```

- If a proxy is required, ensure the agent is configured to use the proxy.

### 6) Retry installation with explicit API key

- If the portal installation continues to fail, install or configure the agent manually and supply the API key explicitly in the agent configuration file, then start the agent.

## Causes and solutions

### Cause: No Default API key selected in Datadog

Solution:

1. In the Datadog portal, select an API key as the Default Key in API Keys settings.
2. Retry installation from the Azure integration.

### Cause: Incorrect API key configured on the resource

Solution:

1. Verify the api_key value in the agent configuration file on the VM or App Service.
2. Update the file with the correct key and restart the agent service.

### Cause: Network or proxy blocking agent outbound traffic

Solution:

1. Allow outbound HTTPS to Datadog ingestion endpoints in NSGs, firewalls, or proxy rules.
2. Configure the agent to use the corporate proxy if required.

### Cause: Installation UI/cache or permission issues

Solution:

1. Try the installation from a private browser session or clear browser cache.
2. Confirm the account performing the installation has permissions to use the selected API key and to deploy extensions on the target VM/App Service.

## Advanced troubleshooting and data collection

If you need to escalate to Datadog or Azure support, collect the following information:

- Resource names and IDs for affected VMs or App Services
- Datadog API key ID (do not share the secret key in support requests unless explicitly requested)
- Timestamps (UTC) when installation was attempted
- Installation or extension operation logs from the Azure portal
- Datadog agent logs from the affected resource
- Network test results (curl, Test-NetConnection) showing connectivity to Datadog endpoints

When opening a support request, provide a concise description of the steps you already performed and include the items above.

## Related content

- [Datadog agent installation docs](https://docs.datadoghq.com/agent/)
- [Datadog Azure integration documentation](https://docs.datadoghq.com/integrations/azure/)
- [Manage extensions on Azure virtual machines](https://learn.microsoft.com/azure/virtual-machines/extensions)