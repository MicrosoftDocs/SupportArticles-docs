---
title: Ingestion Key Rotation and Log Flow Resolution in Azure Native New Relic Service
description: Resolve log flow issues after an ingestion key rotation in Azure Native New Relic Service. Follow the API steps to refresh the key and restore logs.
author: kaushika-msft
ms.author: kaushika
ms.service: partner-services
ms.subservice: new-relic
ms.custom: sap:Native New Relic Service
ms.topic: troubleshooting-problem-resolution
ms.date: 08/05/2026

#customer intent: As a customer, I want to resolve log flow issues after ingestion key rotation so that my logs can continue flowing from Azure to New Relic without disruptions.
---

# Resolve log flow loss after ingestion key rotation

## Summary

If you rotate your ingestion key in the New Relic partner portal, log flow might stop because the Azure Native New Relic Service still uses the old key. This article explains how to resolve the issue and restore log flow.

## Symptoms

You observe a log flow loss after you rotate the ingestion key on the New Relic partner portal. The log flow status might still be in **Sending** mode on the **Monitored resources** page of the Azure New Relic resource.

## Cause

The issue occurs because Azure isn't notified of the ingestion key rotation. Therefore, the old ingestion key remains stored in the configuration database. The log forwarder service continues to use the expired key to send logs. This situation causes authentication errors and log loss.

### Workaround: Update the ingestion key manually

To work around the issue, manually update the ingestion key by using the following API call:

1. Find the **Resource ID** of the Azure New Relic resource that's associated with the account to which the ingestion key was rotated. If multiple resources are linked to the same account, you can make the API call for any of them. The following is an example of a Resource ID: `/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/myRG/providers/NewRelic.Observability/monitors/MyNewRelicResource`.
  It includes the subscription ID, the resource group name, and the Azure New Relic resource name.

1. Make the API call to update the ingestion key. Use an API client to make a **POST** request to the following endpoint. Replace the placeholders with your actual values:

     ```HTTP
     https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors/{AzureNewRelicResourceName}/refreshIngestionKey
     ```
     In this example, the full API endpoint is:
     ```HTTP
     https://management.azure.com/subscriptions/aaaabbbb-0000-cccc-1111-dddd2222eeee/resourceGroups/myRG/providers/NewRelic.Observability/monitors/MyNewRelicResource/refreshIngestionKey
     ```

     **Query parameter**: `api-version`: `2024-10-01`

     **Body**: Empty raw JSON

     **Authorization**: Use a **Bearer Token** for authentication.
     
     To get the token, use one of the following methods:

     **Use Azure Cloud PowerShell**

     1. Sign in to the [Azure portal](https://portal.azure.com), and then open the Azure Cloud PowerShell. For more information, see [Start Azure Cloud PowerShell](/azure/cloud-shell/get-started/classic?tabs=azurecli#start-cloud-shell).
     1. Switch to Bash, and then run the following command: `az account get-access-token --resource-type arm`.
     1. Copy the value of the access token. 

     **Use browser Developer tools**
   
      1. In the browser, press F12 to open Developer tools.
      1. Select **Network**, and then select **Disable Cache**.
      1. Open the [Azure portal](https://portal.azure.com).
      1. While keeping the **Network tab** open, perform any basic operations, such as opening a resource.
      1. Filter the results by using **Fetch/XHR**. You can find a bearer token in the request headers of the corresponding API call. Use it while it remains active.
      
         :::image type="content" source="media/ingestion-key-rotation-log-flow/get-token.png" alt-text="Screenshot of the browser Developer tools Network tab showing the access token in the request headers." lightbox="media/ingestion-key-rotation-log-flow/get-token.png":::
1. The request returns a **204** status code that indicates that the ingestion key was successfully updated.
   
    > [!NOTE]
    > Because of cache resetting on the Azure side, log flow might take up to 24 hours to resume.

## Get support

If you receive an error response, contact [**New Relic Support**](https://support.newrelic.com/s/). For help, provide the **correlation ID** (`x-ms-correlation-request-id`) from the response headers of your API call.
