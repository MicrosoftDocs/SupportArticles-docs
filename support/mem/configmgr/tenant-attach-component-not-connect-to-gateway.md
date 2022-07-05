---
title: Tenant attach components fail to connect to cloud management gateway
description: Provides a solution to an issue where Configuration Manager components for tenant attach fail to connect to the cloud management gateway.
ms.date: 07/05/2022
ms.reviewer: brianhun, umaikhan
---

# Error when running client action from Microsoft Endpoint Manager admin center

This article provides a solution to an issue where Configuration Manager components for tenant attach fail to connect to the cloud management gateway.

_Applies to:_ &nbsp; Configuration Manager (current branch)

## Symptoms

After the public certificate is changed on July 27, 2022, if you run a client action from Microsoft Endpoint Manager admin center, Configuration Manager components for tenant attach will fail to connect to the cloud management gateway with a "Mismatch certificate subject name" error.

This issue can occur in all the supported Configuration Manager versions that run versions less than [Configuration Manager version 2203 hotfix rollup](/mem/configmgr/hotfix/2203/14244456).

Here are example entries in the *CMGatewayNotificationWorker.log* file in the top-level site in the hierarchy:

```output
Error occured when process notification with notification Id 5d5ef2b2-fbf6-4245-8b12-9618e98d1054. Ignore the notification. SMS_SERVICE_CONNECTOR_CMGatewayNotificationWorker
Exception details: SMS_SERVICE_CONNECTOR_CMGatewayNotificationWorker
[Warning][CMGatewayNotificationWorker][0][System.IO.InvalidDataException][0x80131501]
Failed to check and load service signing certificate. System.ArgumentException: Mismatch certificate subject name
at Microsoft.ConfigurationManager.ManagedBase.CertificateUtility.ServiceCertificateUtility.VerifyCertificate(X509Certificate2 certificate, Boolean crlCheck, X509Chain& certificateChain, X509Certificate2Collection extraStore)
at Microsoft.ConfigurationManager.ManagedBase.CertificateUtility.ServiceCertificateUtility.Reload()
at Microsoft.ConfigurationManager.ManagedBase.CertificateUtility.ServiceCertificateUtility.Exists(String thumbprint)
at Microsoft.ConfigurationManager.ServiceConnector.AccountOnboardingWorker.\<RefreshServiceSigningCertificateIfNotExistsAsync>d__19.MoveNext()
```

## Cause

After July 27, 2022, **OU=Microsoft Corporation** is removed from the public certificate subject name, but the configuration manager database still has the old subject name, which causes the load check failure.

## Resolution

If you are running Configuration Manager version 2203, install [Configuration Manager version 2203 hotfix rollup](/mem/configmgr/hotfix/2203/14244456) to resolve this issue.

If you are running a previous supported version of Configuration Manager, upgrade to Configuration Manager version 2203 and install [Configuration Manager version 2203 hotfix rollup](/mem/configmgr/hotfix/2203/14244456).

If the solutions above aren't your option, open a support ticket with the Configuration Manager support team to mitigate the issue in the supported version of Configuration Manager in your environment.
