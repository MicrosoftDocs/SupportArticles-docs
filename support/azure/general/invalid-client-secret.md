---
title: Client secret key is expired error
description: Provides a solution for a "Client secret key is expired" error that occurs when you deploy or terminate virtual machines.
ms.date: 09/15/2022
ms.service: azure-common-issues-support
ms.author: v-weizhu
author: AmandaAZ
ms.reviewer: hclvteam
---
# Client secret key is expired error when deploying or terminating virtual machines

This article provides a solution for a "Client secret key is expired" error that occurs when you deploy or terminate virtual machines (VMs).

## Symptoms

When deploying or terminating VMs, you may encounter an error like the following:

> Azure.Cell.CreateLoadBalancerCreating load balancer (AADSTS7000222: **The provided client secret keys are expired. Visit the Azure Portal to create new keys for your app, or consider using certificate credentials for added security**: `https://docs.microsoft.com/azure/active-directory/develop/active-directory-certificate-credentials` Trace ID: b7ec8707-eb15-42b8-a565-dd39ba303200 Correlation ID: \<Correlation ID> Timestamp: 2020-10-26 10:44:49Z

When you validate the credential in the CycleCloud portal, you see the following error message:

> Invalid Azure credentials provided: AADSTS7000215: Invalid client secret is provided. Trace ID 6c8dbfc3-51c9-4a9a-b667-9b827e3c0200 Correlation ID: \<Correlation ID> Timestamp: 2020-10-27 22:39:49Z

:::image type="content" source="media/invalid-client-secret/validate-client-secret.png" alt-text="Screenshot that shows the error message when validation fails.":::

## Resolution

To resolve this issue, reset the client secret keys in the Azure portal.

1. Sign in the Azure portal and navigate to the Azure Active Directory service.
2. Select the application name under the **App Registrations**.

   :::image type="content" source="media/invalid-client-secret/select-application-name.png" alt-text="Screenshot of an application name.":::

3. Select **Certificates & Secrets** > **New client secret** to renew it. After a client secret key is added, the new secret key value will be shown under the **Key** column. Save it locally.

   :::image type="content" source="media/invalid-client-secret/new-client-secret.png" alt-text="Screenshot that shows the 'New client secret' button.":::

4. Go to the CycleCloud portal, select **Configure** and select the account in **Cloud Provider Accounts**, select **Credentials** > **Edit**. In the **Edit Credential** dialog, fill the password in **Application Secret** and then select **Validate**. If the validation succeeds, select **Save**.

## More information

- [Microsoft identity platform application authentication certificate credentials](/azure/active-directory/develop/active-directory-certificate-credentials)

- [Using Service Principal](/azure/cyclecloud/how-to/service-principals)
