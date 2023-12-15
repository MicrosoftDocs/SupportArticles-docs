---
title: Client secret key is expired error
description: Provides a solution for a Client secret key is expired error that occurs when you deploy or terminate virtual machines.
ms.date: 09/15/2022
ms.service: cyclecloud
ms.reviewer: hclvteam, v-weizhu
---
# Client secret key is expired error occurs when deploying or terminating virtual machines

This article provides a solution for a "Client secret key is expired" error that occurs when you deploy or terminate virtual machines (VMs).

[!INCLUDE [Feedback](../../includes/feedback.md)]

## Symptoms

When you deploy or terminating VMs, you may encounter an error such as the following:

> Azure.Cell.CreateLoadBalancerCreating load balancer (AADSTS7000222: **The provided client secret keys are expired. Visit the Azure Portal to create new keys for your app, or consider using certificate credentials for added security**: `https://docs.microsoft.com/azure/active-directory/develop/active-directory-certificate-credentials` Trace ID: \<Trace ID> Correlation ID: \<Correlation ID> Timestamp: \<Date Time>

When you validate the credential in the CycleCloud portal, you see the following error message:

> Invalid Azure credentials provided: AADSTS7000215: Invalid client secret is provided. Trace ID \<Trace ID> Correlation ID: \<Correlation ID> Timestamp: \<Date Time>

:::image type="content" source="media/invalid-client-secret/validate-client-secret.png" alt-text="Screenshot that shows the error message when validation fails."lightbox="media/invalid-client-secret/validate-client-secret.png":::

## Resolution

To resolve this issue, reset the client secret keys in the Azure portal.

1. Sign in to the Azure portal and navigate to the Microsoft Entra service.
2. Select the application name under the **App Registrations**.

   :::image type="content" source="media/invalid-client-secret/select-application-name.png" alt-text="Screenshot of an application name." lightbox="media/invalid-client-secret/select-application-name.png":::

3. Select **Certificates & Secrets** > **New client secret** to renew it.

   :::image type="content" source="media/invalid-client-secret/new-client-secret.png" alt-text="Screenshot that shows the 'New client secret' button." lightbox="media/invalid-client-secret/new-client-secret.png":::

   After a client secret key is added, the new secret key value will be shown under the **Key** column.

4. Go to the CycleCloud portal and select **Configure**. Select the account in **Cloud Provider Accounts**, and then select **Credentials** > **Edit**. In the **Edit Credential** dialog, enter the password in **Application Secret**, and then select **Validate**. If the validation succeeds, select **Save**.

## More information

- [Microsoft identity platform application authentication certificate credentials](/azure/active-directory/develop/active-directory-certificate-credentials)

- [Using Service Principal](/azure/cyclecloud/how-to/service-principals)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
