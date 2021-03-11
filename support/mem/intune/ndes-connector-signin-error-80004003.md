---
title: Error 0x80004003 signing to NDES Connector UI
description: Describes an issue in which you receive an unexpected error and an 0x80004003 error during the sign-in process to NDES Connector UI when you configure NDES.
ms.date: 05/11/2020
ms.prod-support-area-path: iOS app configuration profiles
ms.reviewer: luche
---
# Unexpected error and error 0x80004003 when you sign in to Intune NDES Connector UI

This article fixes an issue in which you receive an unexpected error during the sign-in process to Network Device Enrollment Service (NDES) Connector UI when you configure NDES.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4024602

## Symptoms

When you configure NDES for Simple Certificate Enrollment Protocol (SCEP) certificate deployment in Microsoft Intune, you receive the following error message during the sign-in process to NDES Connector UI (NDESConnectorUI.exe):

> An unexpected error has occurred

Error entries that resemble the following are logged in the NDES Connector .svclog file:

> NDES Connector certificate could not be found
>
> \<Source Name="NDESConnectorService" />\<Correlation ActivityID="{\<Correlation ActivityID>}" />\<Execution ProcessName="NDESConnector" ProcessID="7364" ThreadID="50" />\<Channel/>\<Computer>Computer_Name\</Computer>\</System>\<ApplicationData>Writing registry SOFTWARE\Microsoft\MicrosoftIntune\NDESConnector\ConnectionStatus - IssueDetails with the value **0x80004003**.

> [!NOTE]
> The NDES Connector .svclog files are located in the following folder on the computer that runs the Microsoft Intune Certificate Connector:
> `%programfiles%\Microsoft Intune\NDESConnectorSvc\Logs\Logs\`.
>
> These files are named in the format: NDESConnector_*YYYY*-*MM*-*DD*_*xxxxxx*.svclog

## Cause

This issue occurs if the account that you use to sign in doesn't have a valid Intune license.

## Resolution

To fix the issue, assign a valid Intune license to the account that you use to sign in.

> [!NOTE]
> The account that you use to sign in must be an Intune Service Administrator or a tenant administrator that has **Global Administrator** permissions.

## More information

For more information about how to configure NDES for SCEP certificate deployment, see [Configure infrastructure to support SCEP with Intune](/mem/intune/protect/certificates-scep-configure).
