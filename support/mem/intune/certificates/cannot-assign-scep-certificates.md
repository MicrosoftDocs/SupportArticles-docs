---
title: You can't assign SCEP certificates to devices in Intune
description: Fixes an issue in which you can't assign SCEP certificates to devices in Microsoft Intune after you renew an expired certificate.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Configure Devices - Windows\SCEP Certificates
ms.reviewer: kaushika, joelste, shhodge
---
# You can't assign SCEP certificates to devices in Intune after a certificate renewal

This article fixes an issue in which you can't assign Simple Certificate Enrollment Protocol (SCEP) certificates to devices in Microsoft Intune after you renew an expired certificate.

> [!IMPORTANT]  
> The details in this article apply only to the **Microsoft Intune Connector**. Support for this connector ends in July 2021, when it's replaced by the **Certificate Connector for Microsoft Intune**.
>
> If you use the new connector, see [Certificate Connector for Microsoft Intune](/mem/intune/protect/certificate-connector-overview) for more information about capabilities, connector status, and log details including a list of Log Event IDs for the newer connector.

## Symptoms

You use Microsoft Intune to assign SCEP certificates to devices that you manage. After you renew an expired certificate, new certificates can't be assigned to the devices. When you open the NDESPlugin.log file, the log stops at **Sending request to certificate registration point**.

Additionally, if you [enable CAPI2 logging](/archive/blogs/benjaminperkins/enable-capi2-event-logging-to-troubleshoot-pki-and-ssl-certificate-issues) on the Network Device Enrollment Service (NDES) server, you receive the following error message:

> A required certificate is not within its validity period when verifying against the current system clock or the timestamp in the signed file.

## Cause

This problem occurs because the NDES policy module still uses the thumbprint from an expired client authentication certificate. That certificate was selected when the NDES policy module or Intune Certificate Connector was first installed.

## Solution

To fix this problem, set the NDES policy module to use the new certificate. To do this, complete these steps on the NDES server:

1. Use `certlm.msc` to open the local computer certificate store, expand **Personal**, and then select **Certificates**.
1. In the list of certificates, find an expired certificate that satisfies the following conditions:

   - The value of **Intended Purposes** is **Client Authentication**.
   - The value of **Issued To** or **Common Name** matches the NDES server name.

   > [!NOTE]
   > The Client Authentication extended key usage (EKU) is required. Without this EKU, CertificateRegistrationSvc will return an HTTP 403 response to NDESPlugin requests. This response will be logged in the IIS logs.
1. Double-click the certificate. In the **Certificate** dialog box, select the **Details** tab, locate the **Thumbprint** field, and then verify the value matches the value of the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\MSCEP\Modules\NDESPolicy\NDESCertThumbprint` registry subkey.
1. Select **OK** to close the **Certificate** dialog box.
1. Right-click the certificate, select **All Tasks**, then select **Request Certificate with New Key** or **Renew Certificate with New Key**.
1. In the **Certificate Enrollment** page, select **Next**, select the correct SSL template, and then select **More information is required to enroll for this certificate. Click here to configure settings**.
1. In the **Certificate Properties** dialog box, select the **Subject** tab, and then complete the following steps:
      1. Under **Subject name**, in the **Type** drop-down box, select **Common Name**. In the **Value** box, enter the fully qualified domain name (FQDN) of the NDES server. Then select **Add**.
      1. Under **Alternative name**, in the **Type** drop-down box, select **DNS**. In the **Value** box, enter the FQDN of the NDES server. Then select **Add**.
      1. Select **OK** to close the **Certificate Properties** dialog box.
1. Select **Enroll**, wait until the enrollment finishes successfully, and then select **Finish**.
1. Reinstall the Intune Certificate Connector to link it to the newly created certificate. For more information, see [Install the Certificate Connector for Microsoft Intune](/mem/intune/protect/certificate-connector-install).
1. After you close the Certificate Connector UI, restart the Intune Connector Service and the World Wide Web Publishing Service.
