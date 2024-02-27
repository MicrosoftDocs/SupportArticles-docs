---
title: Tenant attach components fail to connect to backend cloud service
description: Provides a solution to an issue where Configuration Manager components for tenant attach fail to connect to the backend cloud service.
ms.date: 12/05/2023
ms.reviewer: kaushika, brianhun, umaikhan, v-weizhu
---

# Mismatch certificate subject name error when running client action for Configuration Manager device

This article provides a solution to an issue where Configuration Manager components for tenant attach fail to connect to the backend cloud service.

_Applies to:_ &nbsp; Configuration Manager (current branch)

## Symptoms

When you run a client action from the Microsoft Intune admin center, Configuration Manager components for tenant attach fail to connect to the backend cloud service with the following error:

> Failed to check and load service signing certificate. System.ArgumentException: Mismatch certificate subject name

This issue occurs in versions earlier than the [Configuration Manager version 2203 hotfix rollup](/mem/configmgr/hotfix/2203/14244456) after a change in public certificates on July 27, 2022.

Here are some example entries in the *CMGatewayNotificationWorker.log* file in the top-level site in the hierarchy:

```output
Error occured when process notification with notification Id <notification Id>. Ignore the notification. SMS_SERVICE_CONNECTOR_CMGatewayNotificationWorker
Exception details: SMS_SERVICE_CONNECTOR_CMGatewayNotificationWorker
[Warning][CMGatewayNotificationWorker][0][System.IO.InvalidDataException][0x80131501]
Failed to check and load service signing certificate. System.ArgumentException: Mismatch certificate subject name
at Microsoft.ConfigurationManager.ManagedBase.CertificateUtility.ServiceCertificateUtility.VerifyCertificate(X509Certificate2 certificate, Boolean crlCheck, X509Chain& certificateChain, X509Certificate2Collection extraStore)
at Microsoft.ConfigurationManager.ManagedBase.CertificateUtility.ServiceCertificateUtility.Reload()
at Microsoft.ConfigurationManager.ManagedBase.CertificateUtility.ServiceCertificateUtility.Exists(String thumbprint)
at Microsoft.ConfigurationManager.ServiceConnector.AccountOnboardingWorker.\<RefreshServiceSigningCertificateIfNotExistsAsync>d__19.MoveNext()
```

## Cause

After the change in public certificates on July 27, 2022, **OU=Microsoft Corporation** is removed from the public certificate subject name, but the configuration manager database still has the old subject name, which causes the load check failure.

## Resolution

To fix this issue, use one of the following methods:

- If you are running Configuration Manager version 2203, install the [Configuration Manager version 2203 hotfix rollup](/mem/configmgr/hotfix/2203/14244456).

- If you are running a previously supported version of Configuration Manager, upgrade to Configuration Manager version 2203 and install the [Configuration Manager version 2203 hotfix rollup](/mem/configmgr/hotfix/2203/14244456).

If there isn't a suitable option above, open a support ticket with the Configuration Manager support team to mitigate the issue in the supported version of Configuration Manager in your environment.
