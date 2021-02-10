---
title: Error 0x80090014 installing NDES certificate
description: Describes an issue that causes the installation of the NDES connector for Intune to fail to install the NDES certificate. Provides a resolution.
ms.date: 05/11/2020
ms.prod-support-area-path: Device protection
ms.reviewer: jchornbe, joelste, anziob, luche
---
# Installing NDES connector for Intune fails to install NDES certificate

This article fixes an issue in which you can't install the Network Device Enrollment Service (NDES) connector for Intune because the NDES certificate is not installed.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4018130

## Symptoms

When you try to install the Network Device Enrollment Service (NDES) connector for Intune, the NDES certificate is not installed. Additionally, the following error is logged in the SetupMSI.log file (`C:\NDESConnectorSetup\SetupMSI.log`):

> SI (s) (64:4C) [*time*]: Invoking remote custom action. DLL: C:\Windows\Installer\MSID8CB.tmp, Entrypoint: AddNDESToCertPrivKey  
> AddNDESToCertPrivKey: Giving read access to the accountAccountNameon the private key of the cert with thumbprint:ThumbPrint  
> AddNDESToCertPrivKey: Error 0x80090014: CryptAcquireContext failed. Error hr = 80090014lx  
> CustomAction AddNDESToCertPrivKey returned actual error code 1603

## Resolution

To resolve this issue, the NDES certificate must be created as a v2 certificate.

:::image type="content" source="./media/error-0x80090014-installing-ndes-certificate/certificate.png" alt-text="Screenshot of a V2 template.":::

> [!NOTE]
> The webserver template is a good example of this situation, although it should have **Client Authentication** added as an **Enhanced Key Usage** value.

## References

[Use certificates for authentication in Microsoft Intune](/mem/intune/protect/certificates-configure)
