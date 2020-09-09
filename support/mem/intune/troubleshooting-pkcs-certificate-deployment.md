---
title: Troubleshoot PKCS certificate deployment
description: Helps you understand and solve some common issues that may occur when you deploy PKCS certificates in Microsoft Intune.
ms.date: 06/23/2020
ms.prod-support-area-path: Configure certificates
---
# Troubleshoot PKCS certificate deployment in Microsoft Intune

This article helps you understand and troubleshoot some of the most common issues that may be encountered when you deploy Public Key Cryptography Standards (PKCS) certificates in Microsoft Intune.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4515438

> [!NOTE]
> This article doesn't cover the process of setting up the PKCS infrastructure, including the following:
>
> - Configuring certificate templates on the certification authority
> - Installing and configuring the Intune Certificate Connector
> - Creating and deploying a Trusted Root CA certificate profile and a PKCS #12 (.PFX) profile

For more information about how to set up the PKCS infrastructure, see [Support Tip: Configuring and Troubleshooting PFX/PKCS Certificates in Microsoft Intune](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-configuring-and-troubleshooting-pfx-pkcs/ba-p/516450).

## Collect initial data

Before you begin troubleshooting, it's important to collect some basic information about the issue. Such information can help you to both better understand the problem, and reduce the time to find a resolution.

The following is the most important information to collect:

- The NDESConnector log files (NDESConnector_\<date>_\<time stamp>.svclog) under this folder:

  `%programfiles%\Microsoft Intune\NDESConnectorSvc\Logs\Logs`

- The PFX requests (PFR) files under this folder:

  `%programfiles%\Microsoft Intune\PfxRequest`

- Any errors in the NDESConnector log file.
- Any errors in the Intune admin console.
- Any errors in the **Failed Requests** folder on the issuing certificate authority (CA).

Now let's start troubleshooting based on the answers to these questions.

## Error: The RPC server is unavailable. 0x800706ba

When you try to deploy a PFX certificate to a device that's enrolled in Intune, the trusted root certificate appears on the device. However, the PFX certificate doesn't appear on the device. The following error messages are logged in the NDESConnector log file:

> IssuePfx - COMException: System.Runtime.InteropServices.COMException (0x800706BA): CCertRequest::Submit: **The RPC server is unavailable. 0x800706ba** (WIN32: 1722 RPC_S_SERVER_UNAVAILABLE)  
> IssuePfx -Generic Exception: System.ArgumentException: CCertRequest::Submit: The parameter is incorrect. 0x80070057 (WIN32: 87 ERROR_INVALID_PARAMETER)  
> IssuePfx - COMException: System.Runtime.InteropServices.COMException (0x80094800): The requested certificate template is not supported by this CA. (Exception from HRESULT: 0x80094800)

This issue typically occurs when the following properties of the PKCS certificate profile are populated incorrectly in Intune:

- Certification authority
- Certification authority name

To fix the issue, make sure the following:

1. The **Certification authority** property displays the internal fully qualified domain name (FQDN) of your CA server and is spelled correctly.
2. The **Certification authority name** property displays the name of your CA and is spelled correctly.

If the issue persists, check whether event ID 128 that resembles the following is logged in the application event log:

> Log Name: Application:  
> Source: Microsoft-Windows-CertificationAuthority  
> Event ID: 128  
> Level: Warning  
> Details:  
> An Authority Key Identifier was passed as part of the certificate request 2268. This feature has not been enabled. To enable specifying a CA key for certificate signing, run: "certutil -setreg ca\UseDefinedCACertInRequest 1" and then restart the service.

If event ID 128 is logged, the reason is that the CA certificate is renewed but the CA isn't configured to support certificate requests signed by the previous CA certificate. When the CA certificate is renewed, the OCSP Response Signing certificate used for validation of existing certificates must still be signed by the CA certificate that was used to issue the existing certificates and the new CA certificate. However, this isn't enabled by default.

To fix this issue:

1. Open an elevated Command Prompt on the CA server, and then run this command:

    ```console
    certutil -setreg ca\UseDefinedCACertInRequest 1
    ```

2. Restart the Certificate Services service.

After the Certificate Services service is restarted, devices can receive certificates.

## Error: An enrollment policy server cannot be located. (0x80094015)

PKCS certificates aren't deployed, and the following error is logged in the NDESConnector log file:

> IssuePfx - COMException: System.Runtime.InteropServices.COMException (0x80094015): **An enrollment policy server cannot be located.** (Exception from HRESULT: **0x80094015**)

This issue occurs if the computer that hosts the Intune NDES Connector can't locate a certificate enrollment policy server.

To fix the issue, manually configure the name of the certificate enrollment policy server on the computer that hosts the NDES connector by using the [Add-CertificateEnrollmentPolicyServer](/powershell/module/pkiclient/add-certificateenrollmentpolicyserver) cmdlet.

## Error: The submission is pending

After you deploy a PKCS certificate profile to issue certificates to mobile devices, the certificates aren't acquired, and the following errors are logged in the NDESConnector log file:

> IssuePfx - **The submission is pending:** Taken Under Submission  
> IssuePfx -Generic Exception: System.InvalidOperationException: IssuePfx - The submission is pending

You can see the PFX request in the **Pending Requests** folder on the certificate authority.

:::image type="content" source="media/troubleshooting-pkcs-certificate-deployment/pending-request-folder.png" alt-text="screenshot of the Pending request folder":::

This issue occurs if the **Set the request status to pending. The administrator must explicitly issue the certificate** option is selected in the certificate authority **Properties** > **Policy Module** > **Properties** dialog box. Here is the screenshot:

:::image type="content" source="media/troubleshooting-pkcs-certificate-deployment/properties.png" alt-text="screenshot of the Properties window" border="false":::

To fix the issue, select the **Follow the settings in the certificate template, if applicable. Otherwise, automatically issue the certificate** option in the **Properties** dialog box.

## Error: The parameter is incorrect. 0x80070057

The Intune Certificate Connector is successfully installed and configured, and seems to work correctly. However, the devices don't receive PKCS certificates. The following error message is logged in the NDESConnector log file:

> CCertRequest::Submit: **The parameter is incorrect. 0x80070057** (WIN32: 87 ERROR_INVALID_PARAMETER)

This issue occurs if the PKCS profile in Intune is misconfigured. For example, you receive this error in one of the following scenarios:

- You use a wrong name for the CA.
- The subject alternative name (SAN) is configured for email address, but the targeted user doesn't have a valid email address yet. This results in a null value for the SAN, which is invalid.

To fix the issue, verify that the PKCS profile in Intune is both configured correctly and assigned to the correct user group, and that the user is in the user group. The devices can receive certificates after the policy is refreshed. For more information, see [Configure and use PKCS certificates with Intune](/mem/intune/protect/certficates-pfx-configure).

## Error: The submission failed: Denied by Policy Module

When you try to deploy a PFX certificate to a device that's enrolled in Intune, the trusted root certificate appears on the device. However, the PFX certificate doesn't appear on the device. The following error messages are logged in the NDESConnector log file:

> IssuePfx - **The submission failed: Denied by Policy Module**  
> IssuePfx -Generic Exception: System.InvalidOperationException: IssuePfx - The submission failed  
> at Microsoft.Management.Services.NdesConnector.MicrosoftCA.GetCertificate(PfxRequestDataStorage pfxRequestData, String containerName, String& certificate, String& password)  
> Issuing Pfx certificate for Device ID \<Device ID> failed :

This issue usually occurs if the Computer Account of the server that hosts the Intune Certificate Connector doesn't have permissions to the certificate template.

To fix the issue:

1. Sign in to your Enterprise CA with an account that has administrative privileges.

1. Open the **Certification Authority** console, right-click **Certificate Templates**, and select **Manage**.

1. Find the certificate template that you create, and open the **Properties** dialog box of the template.

1. Select the **Security** tab, and add the Computer Account for the server where you install the Microsoft Intune Certificate Connector. Grant this account **Read** and **Enroll** permissions.

1. Select **Apply** > **OK** to save the certificate template, and close the **Certificate Templates** console.

1. In the **Certification Authority** console, right-click **Certificate Templates** > **New** > **Certificate Template to Issue**.

1. Select the template that you just configured, and select **OK**.

For more information, see [Configure certificate templates on the CA](/mem/intune/protect/certficates-pfx-configure#configure-certificate-templates-on-the-ca).

## The certificate profile gets stuck at Pending state in the admin console

After you deploy a PFX/PKCS certificate profile, the deployment fails, and stops at the **Pending** state. In this scenario, you don't see obvious errors in the NDESConnector log file.

To fix the issue:

- On the computer that hosts the NDES connector, validate the incoming requests under the `%programfiles%\Microsoft Intune\PfxRequest` folder. If you don't find any request in the **Failed**, **Processing** and **Succeed** folders, the most likely cause is the Intune profile.

Otherwise, the issue may occur because of an incorrect certificate associated with the profile, for example, a subordinate certificate associated with the profile.

- A common example is that multiple certificate profiles are deployed but they are deployed with the wrong root certificate.

To fix the issue, make sure that you select and deploy the correct trusted root certificate. After the correct root certificate is installed on the devices, PKCS certificates start being assigned.

## Error: -2146875374 CERTSRV_E_SUBJECT_EMAIL_REQUIRED on the issuing CA

PKCS certificates aren't deployed. And you receive the following error message in the Certificate console on the CA:

> Active Directory Certificate Services denied request abc123 because The Email name is unavailable and cannot be added to the Subject or Subject Alternate name. 0x80094812 (**-2146875374 CERTSRV_E_SUBJECT_EMAIL_REQUIRED**). The request was for CN="Common Name". Additional information: Denied by Policy Module".

This issue occurs if the **Supply in the request** option isn't enabled on the **Subject Name** tab in the certificate template **Properties** dialog box.

:::image type="content" source="media/troubleshooting-pkcs-certificate-deployment/supply-in-the-request.jpg" alt-text="screenshot of the Supply in the request option" border="false":::

To fix the issue:

1. Sign in to your Enterprise CA with an account that has administrative privileges.
2. Open the **Certification Authority** console, right-click **Certificate Templates**, and select **Manage**.
3. Find the certificate template that you create, and open the **Properties** dialog box of the template.
4. Select the **Subject Name** tab, and select **Supply in the request**.
5. Select **OK** to save the certificate template, and close the **Certificate Templates** console.
6. In the **Certification Authority** console, and right-click **Certificate Templates** > **New** > **Certificate Template to Issue**.
7. Select the template that you just configured, and select **OK**.

## More information

If you're still looking for a solution to a related problem, or you're looking for more information about Intune, post a question in our Microsoft Intune forum [here](https://social.technet.microsoft.com/Forums/home?category=microsoftintune&filter=alltypes&sort=lastpostdesc). Many support engineers, MVPs, and members of our development team frequent the forums, so there's a good chance that you can find someone with the information you need.

If you want to open a support request with the Microsoft Intune product support team, see [How to get support for Microsoft Intune](/mem/intune/fundamentals/get-support).

For more information about PKCS certificate deployment, see:

- [Support Tip: Configuring and Troubleshooting PFX/PKCS Certificates in Microsoft Intune](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-configuring-and-troubleshooting-pfx-pkcs/ba-p/516450).
- [Configure and use PKCS certificates with Intune](/mem/intune/protect/certficates-pfx-configure)
- [Use certificates for authentication in Microsoft Intune](/mem/intune/protect/certificates-configure)
- [Remove SCEP and PKCS certificates in Microsoft Intune](/mem/intune/protect/remove-certificates)

For all the latest news, information and tech tips, visit our official blogs:

- [The Microsoft Intune Support Team Blog](https://techcommunity.microsoft.com/t5/intune-customer-success/bg-p/IntuneCustomerSuccess)
- [The Microsoft Enterprise Mobility and Security Blog](https://cloudblogs.microsoft.com/enterprisemobility)
