---
title: Can't Access the Storage Account Services from Azure Logic Apps
description: Describes the common error that may happen when you deploy such logic apps to protected private storage accounts.
ms.services: azure-logic-apps
ms.reviewer: estfan, azla, shrahman, xuehongg
ms.custom: sap:Connectors
ms.date: 05/19/2025
# Customer intent: As a developer, I want to deploy Standard logic apps to Azure storage accounts that use private endpoints.
---

# Troubleshooting private storage account errors in Azure Logic Apps

When you create a single-tenant Standard logic app resource, you're required to have a storage account for storing logic app artifacts. You can restrict access to this storage account so that only the resources inside a virtual network can connect to your logic app workflow. Azure Storage supports adding private endpoints to your storage account.

This article describes the common error that may happen when you deploy such logic apps to protected private storage accounts.

## Troubleshoot common errors

The following errors commonly happen with a private storage account that's behind a firewall and indicate that the logic app can't access the storage account services.

| Problem | Error |
|---------|-------|
| Access to the `host.json` file is denied | `"System.Private.CoreLib: Access to the path 'C:\home\site\wwwroot\host.json' is denied."` |
| Unable to connect to file share | `"System.Private.CoreLib: The network path was not found: 'C:\home\data\Functions\secrets\Sentinels'."` |
| Unable to authenticate to file share | `"System.Private.CoreLib: The user name or password is incorrect: 'C:\home\data\Functions\secrets\Sentinels'."` |
| Error building configuration in an external startup class | `"System.Private.CoreLib: Could not find a part of the path 'C:\home\site\wwwroot'."` |
| Can't load workflows in the logic app resource | `"Encountered an error (ServiceUnavailable) from host runtime."` |

To help you troubleshoot these problems and find the root cause, follow these steps:

1. In the Azure portal, make sure that the storage account and file share still exist.

1. On the logic app resource menu, under **Settings**, select **Environment variables**.

   1. On the **App settings** tab, find the settings named **WEBSITE_CONTENTAZUREFILECONNECTIONSTRING** and **WEBSITE_CONTENTSHARE**.

   1. Check that these settings specify the correct storage account and file share, respectively. Make sure no spelling errors exist.

1. On the logic app resource menu, select **Diagnose and solve problems**. Find and run the following detectors: **Logic App Down or Reporting Errors** and **Network Troubleshooter**

   These detectors provide insights and suggestions for fixing the problem.

The following list includes more troubleshooting actions that you can take to find the cause:

> [!NOTE]
>
> Your logic app resource and workflows aren't running when these errors occur, 
> so you can't use the Kudu console debugging capability in Azure for troubleshooting.


- Create an Azure virtual machine (VM) inside a different subnet within the same virtual network that's integrated with your logic app. Try to connect from the VM to the storage account.

- Check access to the storage account services by using the [Storage Explorer tool](https://azure.microsoft.com/features/storage-explorer/#overview).

  If you find any connectivity issues using this tool, continue with the following steps:

  1. From the command prompt, run `nslookup` to check whether the storage services resolve to the private IP addresses for the virtual network:

     `C:\>nslookup {storage-account-host-name} [optional-DNS-server]`

  1. Check all the storage services:

     `C:\nslookup {storage-account-host-name}.blob.core.windows.net`

     `C:\nslookup {storage-account-host-name}.file.core.windows.net`

     `C:\nslookup {storage-account-host-name}.queue.core.windows.net`

     `C:\nslookup {storage-account-host-name}.table.core.windows.net`

  1. If these DNS queries resolve, run `psping` or `tcpping` to check traffic to the storage account over port 443:

     `C:\psping {storage-account-host-name} {port} [optional-DNS-server]`

  1. Check all the storage services:

     `C:\psping {storage-account-host-name}.blob.core.windows.net:443`

     `C:\psping {storage-account-host-name}.queue.core.windows.net:443`

     `C:\psping {storage-account-host-name}.table.core.windows.net:443`

     `C:\psping {storage-account-host-name}.file.core.windows.net:445`

  1. If the queries resolve from the VM, continue with the following steps:

     1. In the VM, find the DNS server that's used for resolution.

     1. In your logic app, [find and set the `WEBSITE_DNS_SERVER` app setting](/azure/logic-apps/edit-app-settings-host-settings?tabs=azure-portal#manage-app-settings---localsettingsjson) to the same DNS server value that you found in the previous step.

     1. Check that the virtual network integration is set up correctly with the appropriate virtual network and subnet in your logic app.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
