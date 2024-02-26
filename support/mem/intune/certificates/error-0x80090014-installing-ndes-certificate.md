---
title: Error 0x80090014 installing NDES certificate
description: Gives the resolution for an issue where the NDES connector for Microsoft Intune fails to install because the NDES certificate isn't installed.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Device protection
ms.reviewer: kaushika, jchornbe, joelste, anziob, luche
---
# Installing NDES connector for Intune fails to install NDES certificate

This article fixes an issue in which you can't install the Network Device Enrollment Service (NDES) connector for Intune because the NDES certificate is not installed.

## Symptoms

When you try to install the Network Device Enrollment Service (NDES) connector for Intune, the NDES certificate is not installed. Additionally, the following error is logged in the *SetupMSI.log* file (`C:\NDESConnectorSetup\SetupMSI.log`):

> SI (s) (64:4C) [*time*]: Invoking remote custom action. DLL: C:\Windows\Installer\MSID8CB.tmp, Entrypoint: AddNDESToCertPrivKey  
> AddNDESToCertPrivKey: Giving read access to the accountAccountNameon the private key of the cert with thumbprint:ThumbPrint  
> AddNDESToCertPrivKey: Error 0x80090014: CryptAcquireContext failed. Error hr = 80090014lx  
> CustomAction AddNDESToCertPrivKey returned actual error code 1603

## Solution

To resolve this issue, the NDES certificate must be created as a v2 certificate.

:::image type="content" source="media/error-0x80090014-installing-ndes-certificate/certificate.png" alt-text="Screenshot of V2 templates for Windows 2008 R2 and Windows 2012 R2.":::

> [!NOTE]
> The webserver template is a good example of this situation, although it should have **Client Authentication** added as an **Enhanced Key Usage** value.
