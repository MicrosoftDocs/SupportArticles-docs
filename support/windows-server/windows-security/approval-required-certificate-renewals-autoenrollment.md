---
title: Recommended values of validity period and renewal period in certificate templates
description: Describes an issue in which certificate renewals require approvals when certificate autoenrollment is configured. Recommend values of the validity period and renewal period in certificate templates.
ms.date: 11/22/2021
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, jories, milanmil, v-lianna
ms.custom: sap:certificates-and-public-key-infrastructure-pki, csstroubleshoot
ms.technology: windows-server-security
---
# Approval required for certificate renewals when certificate autoenrollment configured

Assume that you're configuring a certificate autoenrollment that has the **CA certificate manager approval** and **Valid existing certificate** options enabled. When setting a validity period and renewal period for the autoenrollment, the Certificate Authority (CA) certificate manager approval is required only for the initial certificate autoenrollment. However, in this scenario, the consequent certificate renewals also require CA certificate manager approval.

> [!NOTE]
> To identify the validity period and renewal period, use the `certutil -dstemplate <CertificateTemplateName>` cmdlet, and search for `pKIExpirationPeriod` (the validity period) and `pKIOverlapPeriod` (the renewal period).

:::image type="content" source="media/approval-required-certificate-renewals-autoenrollment/certificate-autoenrollment-configuration.png" alt-text="Configuration example for certificate autoenrollment.":::

Certificate autoenrollment runs every eight hours. When unsupported values of validity and renewal period are configured in a certificate template, the certificate renewal is skipped and the client triggers new enrollment requests instead of renewals, then prompting CA certificate manager approval.

## Recommended values of validity period and renewal period

To be renewed, a certificate should have completed 80% of its validity period and be within the renewal period. For example, a certificate valid for one year reaches the 80% mark at around 41.5 weeks. If the certificate has a renewal period of six weeks, it will be renewed during the 46th week period.

For normal renewal behaviors, set the renewal period to more than 8 hours and less than 20% of the validity period.

> [!NOTE]
> The execution of the certificate renewal will be skipped during the first 80% of the certificate validity period and triggered in the last 20%.

This issue might occur with any type of certificate renewals.
