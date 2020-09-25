---
title: Verify NDES configuration to use SCEP certificates
description: Describes how to verify NDES configuration on-premises for Simple Certificate Enrollment Protocol (SCEP) certificates in Microsoft Intune.
ms.date: 05/18/2020
ms.prod-support-area-path: Device protection
ms.reviewer: saurkosh, cajenk, intunecic
---
# Verify NDES configuration on-premises for SCEP certificates in Intune

This article helps determine whether you have configured correctly your infrastructure to use Simple Certificate Enrollment Protocol (SCEP) certificates in Microsoft Intune.

This article can also be used to troubleshoot SCEP certificate deployment issues if your on-premises configuration has changed or is broken and needs validation.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4490130

## Verify NDES configuration on-premises for SCEP certificates

1. Open the [Validate-NDESConfiguration.ps1](https://github.com/microsoftgraph/powershell-intune-samples/blob/master/CertificationAuthority/Validate-NDESConfiguration.ps1) script and copy it to your NDES server.

   :::image type="content" source="./media/verify-ndes-configuration/open-script.png" alt-text="Screenshot of opening the Validate-NDESConfiguration.ps1 script.":::

2. On the NDES server, run PowerShell as administrator. You may have to change PowerShell [ExecutionPolicy](/powershell/module/microsoft.powershell.security/get-executionpolicy) to **Unrestricted** to run the script.

   > [!NOTE]
   > Do not forget to change it back to the original setting once done .

3. Values for the following parameters are required:

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

     :::image type="content" source="./media/verify-ndes-configuration/ndes-encryption-properties.png" alt-text="Screenshot of NDES Encryption properties.":::

4. The following screenshot occurs when the Validate-NDESConfiguration.ps1 script is run.

   :::image type="content" source="./media/verify-ndes-configuration/running-script.png" alt-text="Screenshot of running script.":::

5. Type **Y** to continue.
6. The Validate-NDESConfiguration.ps1 script continues and finishes all required checks.

   :::image type="content" source="./media/verify-ndes-configuration/script-finish.png" alt-text="Screenshot of script finishes.":::

7. When the Validate-NDESConfiguration.ps1 script is finished, you are prompted to generate a report.

   :::image type="content" source="./media/verify-ndes-configuration/report.png" alt-text="You're prompted to generate a report.":::

8. Type **Y** or **N** to review the reports.

## References

- [Configure infrastructure to support SCEP with Intune](/mem/intune/protect/certificates-scep-configure)
- [Troubleshooting NDES configuration for use with Microsoft Intune certificate profile](https://support.microsoft.com/help/4459540/troubleshoot-ndes-configuration-for-use-with-intune)
