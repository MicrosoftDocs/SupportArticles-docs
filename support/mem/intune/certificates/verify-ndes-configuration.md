---
title: Verify NDES configuration to use SCEP certificates
description: Gives a troubleshooting procedure to help you verify your on-premises NDES configuration for Simple Certificate Enrollment Protocol (SCEP) certificates in Microsoft Intune.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Device protection
ms.reviewer: kaushika, saurkosh, cajenk, intunecic
---
# Verify on-premises NDES configuration for SCEP certificates in Intune

This article gives troubleshooting steps to help determine whether you have correctly configured your on-premises infrastructure to use Simple Certificate Enrollment Protocol (SCEP) certificates in Microsoft Intune.

Complete these steps to validate your on-premises Network Device Enrollment Service (NDES) configuration.

1. Open the [Validate-NDESConfiguration.ps1](https://github.com/microsoftgraph/powershell-intune-samples/blob/master/CertificationAuthority/Validate-NDESConfiguration.ps1) script and copy it to your NDES server.

   :::image type="content" source="media/verify-ndes-configuration/open-script.png" alt-text="Screenshot of opening the Validate-NDESConfiguration.ps1 script.":::

1. On the NDES server, run PowerShell as administrator. You may have to change PowerShell [ExecutionPolicy](/powershell/module/microsoft.powershell.security/get-executionpolicy) to **Unrestricted** to run the script.

   > [!NOTE]
   > Do not forget to change it back to the original setting once done .

1. Values for the following parameters are required:

   - `NDESServiceAccount`

     This is the account that you created in the [Accounts](/mem/intune/protect/certificates-scep-configure#accounts) section of the [Configure infrastructure to support SCEP with Intune](/mem/intune/protect/certificates-scep-configure).

     The following format is used: Domain\\\<username>. For example: *contoso\ndes*.

     > [!NOTE]
     > Do not specify the root domain part of the account such as *contoso.lab\ndes* as this does not work.

   - `IssuingCAServerFQDN`

     This is the fully qualified domain name (FQDN) of your issuing certification authority (CA) server such as dc2.consoto.lab.

   - `SCEPUserCertTemplate`

     This is the template name that is specified in the [Configure the certification authority](/mem/intune/protect/certificates-scep-configure#configure-the-certification-authority) section of the [Configure infrastructure to support SCEP with Intune](/mem/intune/protect/certificates-scep-configure).

     For example:

     :::image type="content" source="media/verify-ndes-configuration/ndes-encryption-properties.png" alt-text="Screenshot of NDES Encryption properties, showing the template name.":::

1. The following screenshot occurs when the Validate-NDESConfiguration.ps1 script is run.

   :::image type="content" source="media/verify-ndes-configuration/run-script.png" alt-text="Screenshot of running script in PowerShell." border="false":::

1. Type **Y** to continue.
1. The Validate-NDESConfiguration.ps1 script continues and finishes all required checks.

   :::image type="content" source="media/verify-ndes-configuration/script-finish.png" alt-text="Screenshot shows script finished all required checks." border="false":::

1. When the Validate-NDESConfiguration.ps1 script is finished, you are prompted to generate a report.

   :::image type="content" source="media/verify-ndes-configuration/report.png" alt-text="You're prompted to generate a report.":::

1. Type **Y** or **N** to review the reports.
