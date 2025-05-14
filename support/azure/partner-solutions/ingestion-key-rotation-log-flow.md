---
title: Ingestion Key Rotation and Log Flow Resolution
description: Learn how to resolve issues related to log flow after an ingestion key rotation in New Relic.
author: apoorvasingh130
ms.author: singhapoorva
ms.service: partner-services
ms.subservice: new-relic
ms.topic: troubleshooting-problem-resolution
ms.date: 04/24/2025

#customer intent: As a customer, I want to resolve log flow issues after ingestion key rotation so that my logs can continue flowing from Azure to New Relic without disruptions.
---

# Ingestion Key Rotation and Log Flow Issues in New Relic

When the ingestion key is rotated on the New Relic partner portal, log flow of the resources may stop due to the outdated key still being used by the Azure New Relic service. If you are experiencing issues with log flow after rotating your ingestion key, this guide will help you resolve them.


## Symptoms

- You might observe log loss after the ingestion key rotation on the New Relic partner portal. 
- The Log flow status may still be **Sending** on the **Monitored resources** page of the Azure New Relic resource.

## Cause

The issue occurs because Azure isn't notified of the ingestion key rotation. As a result, the old ingestion key remains stored in the configuration database. The log forwarder service continues to use the expired key to send logs. This causes authentication errors and results in log loss.

## Workaround : Update the ingestion key manually

To work around the issue,  manually update the ingestion key by using the following API call:

1. **Gather Resource Information**
   - Find the **resource ID** of the Azure New Relic resource associated with the account where the ingestion key was rotated. If multiple resources are linked to the same account, you can make the API call for any one of them.

2. **Make the API Call to update the ingestion key**
   - Use an API client (like **Postman** or **Bruno**) to make a **POST** request to the following endpoint:

     ```HTTP
     https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors/{monitorName}/refreshIngestionKey
     ```

     - **Query parameter**:
       - `api-version`: `2024-10-01`

     - **Body**: Empty raw JSON
     - **Authorization**: Use a **Bearer Token** for authentication. You can obtain the token using the **Network** tab of your browser's Developer tools:
          1. In the browser, press F12 to open Developer tools. Select **Network**, and then select **Disable Cache**
          1. Open azure portal and while keeping the **Network tab** open, perform any basic operations like opening a resource.
          1. Filter the result by **Fetch/XHR**. You can find a bearer token present in the request headers of the corresponding API call. Use it while it remains active.
    
         :::image type="content" source="media/ingestion-key-rotation-log-flow/get-token.png" alt-text="Screenshot of viewing access token." lightbox="media/ingestion-key-rotation-log-flow/get-token.png":::
3. **Expected Outcome**
   - The request should return a **204** status code, indicating that the ingestion key has been successfully updated.
   - Note that it may take up to **24 hours** for log flow to resume due to cache resetting on our side.

4. **Troubleshooting**
   - If you receive an error response, please contact **Microsoft Support** and provide the **correlation ID** (`x-ms-correlation-request-id`) from the response headers of your API call for further assistance.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]