---
title: Troubleshoot Logic App Standard connectivity to storage private endpoints
description: Learn how to troubleshoot connectivity issues between Logic App Standard and storage account private endpoints.
ms.date: 09/17/2026
ms.topic: troubleshooting
ms.reviewer: xuehongg
ms.service: azure-logic-apps
#customer intent: As an Azure Logic Apps administrator, I want to troubleshoot connectivity between my Logic App Standard and its storage private endpoints so that I can restore my logic app to a healthy running state.
---

# Troubleshoot Logic App Standard connectivity to storage private endpoints

## Summary

This article helps you troubleshoot connectivity issues between Logic App Standard and storage account private endpoints. Logic App Standard requires an Azure storage account to host runtime content, application files, and execution state. Many customers enable private endpoints on that storage account to keep traffic inside Microsoft's global network backbone. When this connectivity breaks, the logic app becomes completely unavailable, and the **Overview** blade shows "**Error**" in the "**Runtime version**" field along with a connectivity error banner. Following this troubleshooting checklist helps restore the logic app to a healthy running state quickly and minimizes downtime.

:::image type="content" source="media/troubleshoot-logic-app-standard-connectivity/logic-app-storage-connectivity-error-banner.png" alt-text="Screenshot of the Logic App Standard Overview blade showing an error state in the Runtime version field with a connectivity error banner.":::

Use this article if your logic app is down and you suspect the issue is related to connectivity between the logic app and a storage account that uses private endpoints.

## Troubleshooting checklist

Use the following steps to diagnose the cause of the connectivity problem.

### Verify VNET integration configuration

Verify the logic app has VNET Integration enabled and set the environment variable **WEBSITE_CONTENTOVERVNET** to 1.

### Verify private endpoints exist for all required services

Create a private endpoint for each of the following services: blob, table, queue, and file.

### Verify network connectivity

Make sure there's connectivity between the subnet for the VNET Integration and the subnet for the storage private endpoints. This check includes firewall rules, NSG rules, and route table rules. Ensure port 443 and port 445 are open on the storage account.

### Test with public access temporarily enabled

Temporarily enable public access on the storage account to test whether the logic app works. If it fails, the issue could be a storage account configuration problem, such as the file share security setting, key access setting, or SAS expiry setting. A successful test confirms the storage account configuration itself is sound.

### Verify private DNS zone integration

Check whether you selected the "**Integration with private DNS zone**" option when creating the private endpoints. Use this option, though some users might choose to use a custom DNS server instead.

### Verify custom DNS configuration

If you use custom DNS and create the private endpoints with the "**Integration with private DNS zone**" option, you can create a conditional forwarder to the Azure DNS server 168.63.129.16. To isolate whether the issue is related to your custom DNS, you can temporarily set the environment variable **WEBSITE_DNS_SERVER** to 168.63.129.16 to see whether it resolves the issue.

### Verify DNS resolution for manually created records

If you use custom DNS and manually create A records for private endpoints, use the **nslookup** tool to verify whether DNS resolution is working as expected. Run **nslookup** on a virtual machine in the logic app subnet to mimic the logic app runtime. The private IP address should be returned. If it resolves to the public IP address of the storage account instead, DNS isn't set up correctly.

## Advanced troubleshooting and data collection

Open the **Diagnose and solve problems** pane and search for the **Logic App Down or Reporting Errors** tool. This tool can help diagnose common problems and suggest actions to fix them.

## Related content

* [Deploy Standard logic apps to Azure storage that use private endpoints](/azure/logic-apps/deploy-single-tenant-logic-apps-private-storage-account)