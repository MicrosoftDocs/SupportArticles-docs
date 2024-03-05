---
title: Troubleshoot reporting for SCEP certificate deployment to devices with Microsoft Intune
description: Troubleshoot the reporting by NDES and the Intune Certificate Connector about a successful deployment of certificates that were provisioned with SCEP certificate profiles. 
ms.date: 12/05/2023
ms.reviewer: kaushika, lacranda
search.appverid: MET150
---
# Troubleshooting NDES reporting of certificate deployments in Intune

When using SCEP certificate profiles to provision certificates to Windows devices, the last phase is that the Intune Certificate Connector reports the deployment to Intune. This article explains how to confirm that NDES and the Intune Certificate Connector are successfully reporting on certificate delivery to devices.

This article applies to the Step 6 of the [SCEP communication workflow](troubleshoot-scep-certificate-profiles.md).

> [!IMPORTANT]  
> The details in this article apply only to the **PFX Certificate Connector for Microsoft Intune** and **Microsoft Intune Connector**. Support for both connectors ends in July 2021, when they are both replaced by the **Certificate Connector for Microsoft Intune**.
>
> If you use the new connector, see [Certificate Connector for Microsoft Intune](/mem/intune/protect/certificate-connector-overview) for more information about capabilities, connector status, and log details including a list of Log Event IDs for the newer connector.

## Find reporting log entries

If reporting was successful, you'll find entries that resemble the following examples on the NDES server:

- **IIS log**:

  `fe80::f53d:89b8:c3e8:5fec%13 POST /CertificateRegistrationSvc/Certificate/Notify - 443 - fe80::f53d:89b8:c3e8:5fec%13 NDES_Plugin - 204 0 0 277 62`

- **NDESPlugin.log**:

  ```output
  Calling Notifyrequest ...
  Sending request to certificate registration point.
  Exiting Notify with 0x0
  ```

- **CertificateRegistrationPoint.svclog**:

  :::image type="content" source="media/troubleshoot-scep-certificate-reporting/certificate-registration-point-log.png" alt-text="Screenshot of entries in the Certificate Registration Point log.":::

- **NDESConnector.svclog**:

  :::image type="content" source="media/troubleshoot-scep-certificate-reporting/ndesconnector-log.png" alt-text="Screenshot of entries in the Intune Certificate Connector log.":::

- **CertificateRequestStatus**:

  Go to the *%ProgramFiles%\Microsoft Intune\CertificateRequestStatus* folder. You'll see the Failed, Processing, and Succeed folders that contain certificate request status files.

  If the certificate request is successfully processed, you'll see new files in the Succeed folder. You can use *Notepad.exe* to open the files and view the data that's uploaded to the Intune Service by the Intune Certificate Connector. Data that uploaded includes details like **CertificateSerialNumber**, **UserID**, **DeviceID**, and **Thumbprint**.

## Troubleshoot stuck files

If you don't see any new files being created in the %ProgramFiles%\Microsoft Intune\CertificateRequestStatus\Succeed folder, check whether there are any files stuck in the Processing folder.

Verify that the Intune Connector Service is started on the NDES server. And there are no errors in Ndesconnector.svclog.
