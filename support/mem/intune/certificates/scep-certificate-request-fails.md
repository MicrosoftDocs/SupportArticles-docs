---
title: SCEP certificate request fails during verification
description: Fixes an issue in which the SCEP certificate request fails during the verification phase on the certificate registration point.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Configure certificates
ms.reviewer: kaushika, joelste, intunecic, kolldhee
---
# SCEP certificate request fails during the verification phase on the CRP

This article gives two methods to help resolve when a Simple Certificate Enrollment Protocol (SCEP) certificate request fails during verification.

## Symptoms

The SCEP certificate request fails during the verification phase on the certificate registration point (CRP). Therefore, Android and iOS devices do not receive SCEP certificates even though NDES is configured.

Additionally, you see error entries in CRP logs.

> [!NOTE]
> The default log file location is:
>  
> `C:\Program Files\Microsoft Intune\NDESConnectorSvc\Logs\Logs\CertificateRegistrationPoint_xx_xx.svclog`

Three log entries specify a Cryptography Exception error, as shown in the following image.

:::image type="content" source="media/scep-certificate-request-fails/three-instances-of-error.png" alt-text="Screenshot of the three instances of the error.":::

### First error entry

> \<Source Name="CertificateRegistrationPoint" />  
> Cryptography Exception: System.Security.Cryptography.CryptographicException: m_safeCertContext is an invalid handle.  
>&nbsp;at System.Security.Cryptography.X509Certificates.X509Certificate.ThrowIfContextInvalid()  
>&nbsp;at System.Security.Cryptography.X509Certificates.X509Certificate.SetThumbprint()  
>&nbsp;at System.Security.Cryptography.X509Certificates.X509Certificate.GetCertHashString()  
>&nbsp;at Microsoft.ConfigurationManager.CertRegPoint.Helper.ValidateChallenge(String base64Encodedtoken, X509Certificate2Collection encryptedCerts, X509Certificate2 SigningCert, String&amp; decodedChallengePassword)

### Second error entry

> Cryptography Exception: System.Security.Cryptography.CryptographicException: m_safeCertContext is an invalid handle.  
>&nbsp;at System.Security.Cryptography.X509Certificates.X509Certificate.ThrowIfContextInvalid()  
>&nbsp;at System.Security.Cryptography.X509Certificates.X509Certificate.SetThumbprint()  
>&nbsp;at System.Security.Cryptography.X509Certificates.X509Certificate.GetCertHashString()  
>&nbsp;at Microsoft.ConfigurationManager.CertRegPoint.Helper.ValidateChallenge(String base64Encodedtoken, X509Certificate2Collection encryptedCerts, X509Certificate2 SigningCert, String&amp; decodedChallengePassword)  
>&nbsp;at Microsoft.ConfigurationManager.CertRegPoint.ChallengeValidation.ValidationPhase1(VerifyChallengeParams value, String&amp; decodedChallenge, PKCSDecodedObject&amp; pkcsObj)</ApplicationData></E2ETraceEvent>

### Third error entry

> Cryptography Exception: System.Security.Cryptography.CryptographicException: m_safeCertContext is an invalid handle.  
>&nbsp;at System.Security.Cryptography.X509Certificates.X509Certificate.ThrowIfContextInvalid()  
>&nbsp;at System.Security.Cryptography.X509Certificates.X509Certificate.SetThumbprint()  
>&nbsp;at System.Security.Cryptography.X509Certificates.X509Certificate.GetCertHashString()  
>&nbsp;at Microsoft.ConfigurationManager.CertRegPoint.Helper.ValidateChallenge(String base64Encodedtoken, X509Certificate2Collection encryptedCerts, X509Certificate2 SigningCert, String&amp; decodedChallengePassword)  
>&nbsp;at Microsoft.ConfigurationManager.CertRegPoint.ChallengeValidation.ValidationPhase1(VerifyChallengeParams value, String&amp; decodedChallenge, PKCSDecodedObject&amp; pkcsObj)  
>&nbsp;at Microsoft.ConfigurationManager.CertRegPoint.Controllers.CertificateController.VerifyRequest(VerifyChallengeParams value)  

## Cause

This issue occurs because the registry keys that are responsible for verification of the certificate request are missing in NDES connector registry settings.

:::image type="content" source="media/scep-certificate-request-fails/ndes-connector-registry.png" alt-text="Screenshot of NDES connector registry settings.":::

## Solution 1

Complete these steps to restart the Intune Connector Service:

1. On the connector-installed server, open the **Services** snap-in. To do this, open the **Start** menu, enter `services.msc`, and then select **Services** from the results list.
2. In the **Services** snap-in, restart the Intune Connector Service.
3. Check the `HKLM\Software\Microsoft\MicrosoftIntune\NDESConnector` registry subkey to verify that the registry keys were created according to the following screenshot.

    :::image type="content" source="media/scep-certificate-request-fails/ndes-connector-subkey.png" alt-text="Screenshot of the required NDESConnector registry subkey settings.":::

If restarting the service or computer does not fix the issue, continue to Solution 2.

## Solution 2

Complete these steps to clear and reset the template name:

1. On the NDES computer, open the registry, and locate the following subkey:  
    `HKEY_LOCAL_Machine\Software\Microsoft\Cryptography\MSCEP`

2. Change the template values to the default (**IPSECIntermediateOffline**), and restart the server.

3. After the server restarts, check the `HKEY_LOCAL_Machine\Software\Microsoft\MicrosoftIntune\NDESConnector` subkey. You should now see the signing certificates.

4. After the keys are created, change the template name under `HKEY_LOCAL_Machine\Software\Microsoft\Cryptography\MSCEP` to the custom template name that was created for SCEP and NDES.
