---
title: Ingestion Key Rotation and Log Flow Resolution in Azure Native New Relic Service
description: Learn how to resolve issues that are related to log flow after an ingestion key rotation in New Relic.
author: apoorvasingh130
ms.author: singhapoorva
ms.service: partner-services
ms.subservice: new-relic
ms.topic: troubleshooting-problem-resolution
ms.date: 04/24/2025

#customer intent: As a customer, I want to resolve log flow issues after ingestion key rotation so that my logs can continue flowing from Azure to New Relic without disruptions.
---

# Logs missing after ingestion key rotation

If you rotated your ingestion key in the New Relic partner portal, log flow may stop because the Azure Native New Relic Service is still using the old key. This guide dicusses how to resolve the issue and restore log flow.

## Symptoms

You observe log loss after you rotate the ingestion key on the New Relic partner portal. The log flow status might still be in **Sending** mode on the **Monitored resources** page of the Azure New Relic resource.

## Cause

The issue occurs because Azure isn't notified of the ingestion key rotation. Therefore, the old ingestion key remains stored in the configuration database. The log forwarder service continues to use the expired key to send logs. This causes authentication errors and log loss.

## Workaround: Update the ingestion key manually

To work around the issue, manually update the ingestion key by using the following API call:

1. Find the **resource ID** of the Azure New Relic resource that's associated with the account to which the ingestion key was rotated. If multiple resources are linked to the same account, you can make the API call for any of them.

2. Make the API call to update the ingestion key. Use an API client (such as **Bruno**) to make a **POST** request to the following endpoint:

     ```HTTP
     https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors/{monitorName}/refreshIngestionKey
     ```

     **Query parameter**: `api-version`: `2024-10-01`

     **Body**: Empty raw JSON

     **Authorization**: Use a **Bearer Token** for authentication.
     
     You can obtain the token by using the **Network** tab of your browser's Developer tools:
      
      1. In the browser, press F12 to open Developer tools.
      2. Select **Network**, and then select **Disable Cache**.
      1. Open the [Azure portal](https://portal.azure.com).
      2. While keeping the **Network tab** open, perform any basic operations, such as opening a resource.
      1. Filter the results by using **Fetch/XHR**. You can find a bearer token in the request headers of the corresponding API call. Use it while it remains active.
      
         :::image type="content" source="media/ingestion-key-rotation-log-flow/get-token.png" alt-text="Screenshot showing how to view the access token." lightbox="media/ingestion-key-rotation-log-flow/get-token.png":::
3. The request should return a **204** status code that indicates that the ingestion key was successfully updated.
   
    > [!NOTE]
    > Because of cache resetting on the Azure side, log flow might take up to 24 hours to resume.

## Troubleshooting

If you receive an error response, contact [**New Relic Support**](https://support.newrelic.com/s/) and provide the **correlation ID** (`x-ms-correlation-request-id`) from the response headers of your API call for further assistance.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
