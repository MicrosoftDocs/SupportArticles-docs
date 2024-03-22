---
title: SCEP deployment to Windows 10 devices fails after CA renewal
description: Describes an issue in which SCEP certificates can't be deployed to Windows 10 devices after you renew the CA certificate.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Configure Devices - Windows\SCEP Certificates
ms.reviewer: kaushika
---
# SCEP deployment to Windows 10 devices fails after you renew the CA certificate

This article provides a solution for when Simple Certificate Enrollment Protocol (SCEP) certificate deployment fails to a Windows 10 device after you renew the certification authority (CA) certificate.

> [!NOTE]
> This issue does not occur when you use Intune to deploy SCEP certificates to Android or iOS devices.

## Symptoms

You use Microsoft Intune to deploy SCEP certificate profiles to Windows 10 devices. After you renew the certificate of your root CA or issuing CA, SCEP certificate deployment fails.

The following is a screenshot of the deployment status in the Intune portal:

:::image type="content" source="media/scep-deployment-to-win10-devices-fails/deployment-error.png" alt-text="Screenshot of Deployment error status.":::

On the Windows 10 device, event 32 and event 307 are logged in Admin logs under **Applications and Services Logs** > **Microsoft** > **Windows** > **DeviceManagement-Enterprise-Diagnostic-Provider** as shown in the following screenshots:

:::image type="content" source="media/scep-deployment-to-win10-devices-fails/event-32.png" alt-text="Screenshot of Event 32.":::

:::image type="content" source="media/scep-deployment-to-win10-devices-fails/event-307.png" alt-text="Screenshot of Event 307.":::

Event 30 is logged in CAPI2 log, as shown in the following screenshot:

:::image type="content" source="media/scep-deployment-to-win10-devices-fails/event-30.png" alt-text="Screenshot of Event 30 and its details.":::

## Cause

The most likely cause is that the registration authority (RA) certificates that are issued by your CA to the Network Device Enrollment Service (NDES) server still refer to the old CA certificate. In this case, the CA certificate is no longer trusted after renewal, and you receive the following error message that's logged in event 30 in CAPI2 log:

> A certificate chain processed, but terminated in a root certificate which is not trusted by the trust provider. 800B0109

Therefore, the devices can no longer receive SCEP certificates.

## Solution

To fix the issue, reinstall both the NDES server role and Microsoft Intune Certificate Connector on the NDES server. During the reinstallation, RA certificates will be reissued to the NDES server.

For more information about how to install the NDES server role and Intune Certificate Connector, see [Support Tip - How to configure NDES for SCEP certificate deployments in Intune](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-how-to-configure-ndes-for-scep-certificate/ba-p/455125).
