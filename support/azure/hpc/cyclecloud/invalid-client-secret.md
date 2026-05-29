---
title: Client secret key is expired error
description: "Fix the client secret key expired error in Azure CycleCloud that occurs when deploying or terminating VMs. Learn how to reset your client secret keys in the Azure portal."
ms.date: 05/22/2025
ms.service: azure-cyclecloud
ms.reviewer: hclvteam, v-weizhu
ms.custom: sap:Azure CycleCloud
---
# Client secret key is expired error occurs when deploying or terminating virtual machines

## Summary

This article provides a solution for a "Client secret key is expired" error that occurs when you deploy or terminate virtual machines (VMs).

[!INCLUDE [Feedback](../../../includes/feedback.md)]

## Symptoms

When you deploy or terminate VMs, you might encounter an error such as the following error message:

> Azure.Cell.CreateLoadBalancerCreating load balancer (AADSTS7000222: **The provided client secret keys are expired. Visit the Azure Portal to create new keys for your app, or consider using certificate credentials for added security**: `https://docs.microsoft.com/azure/active-directory/develop/active-directory-certificate-credentials` Trace ID: \<Trace ID> Correlation ID: \<Correlation ID> Timestamp: \<Date Time>

When you validate the credential in the CycleCloud portal, you see the following error message:

> Invalid Azure credentials provided: AADSTS7000215: Invalid client secret is provided. Trace ID \<Trace ID> Correlation ID: \<Correlation ID> Timestamp: \<Date Time>

:::image type="content" source="media/invalid-client-secret/validate-client-secret.png" alt-text="Screenshot of the CycleCloud portal showing an invalid client secret validation error message." lightbox="media/invalid-client-secret/validate-client-secret.png":::

## Resolution

To resolve this issue, reset the client secret keys in the Azure portal.

1. Sign in to the Azure portal and navigate to the Microsoft Entra service.
1. Select the application name under **App Registrations**.

   :::image type="content" source="media/invalid-client-secret/select-application-name.png" alt-text="Screenshot of the App Registrations page in Microsoft Entra showing an application name selected." lightbox="media/invalid-client-secret/select-application-name.png":::

1. Select **Certificates & Secrets** > **New client secret** to renew it.

   :::image type="content" source="media/invalid-client-secret/new-client-secret.png" alt-text="Screenshot of the Certificates and Secrets page showing the New client secret button in the Azure portal." lightbox="media/invalid-client-secret/new-client-secret.png":::

   After you add a client secret key, the new secret key value appears under the **Key** column.

1. Go to the CycleCloud portal and select **Configure**. Select the account in **Cloud Provider Accounts**, and then select **Credentials** > **Edit**. In the **Edit Credential** dialog, enter the password in **Application Secret**, and then select **Validate**. If the validation succeeds, select **Save**.

## More information

- [Microsoft identity platform application authentication certificate credentials](/azure/active-directory/develop/active-directory-certificate-credentials)

- [Using Service Principal](/azure/cyclecloud/how-to/service-principals)

 
