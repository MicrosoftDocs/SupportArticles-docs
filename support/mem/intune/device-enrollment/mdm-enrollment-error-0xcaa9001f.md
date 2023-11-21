---
title: MDM enrollment error 0xcaa9001f for co-managed Windows devices
description: Describes an issue in which MDM enrollment fails and generates error 0xcaa9001f for co-managed Windows devices that are Microsoft Entra hybrid joined and managed by using Configuration Manager.
ms.date: 10/06/2021
search.appverid: MET150
ms.custom: sap:Windows enrollment
ms.reviewer: kaushika, luche
---
# MDM enrollment fails with error 0xcaa9001f for co-managed Windows devices

This article fixes an issue in which MDM enrollment fails and generates error 0xcaa9001f for co-managed Windows devices that are Microsoft Entra hybrid joined and managed by using Configuration Manager.

## Symptoms

MDM enrollment fails for co-managed Windows devices that are Microsoft Entra hybrid joined and managed by using Microsoft System Center Configuration Manager. The following error messages are logged:

- In `%WinDir%\CCM\logs\CoManagementHandler.log`:

  > **MDM enrollment failed with error code 0xcaa9001f** 'Integrated Windows authentication supported only in federation flow.'. Will retry in 15 minutes...

- In logs under **Applications and Services Logs** > **Microsoft** > **Windows** > **DeviceManagement-Enterprise-Diagnostic-Provider** > **Admin** in the Event Viewer:

  > System Migration Task Started.  
  > Impersonation result. Result: (An attempt was made to reference a token that does not exist.).  
  > **Auto MDM Enroll: Failed (Unknown Win32 Error code: 0xcaa9001f)**

- In logs under **Applications and Services Logs** > **Microsoft** > **Windows** > **Microsoft Entra ID** > **Operational** in the Event Viewer:

  > Http request status: 400. Method: POST Endpoint Uri: https://login.microsoftonline.com/\<AADTenantID\>/oauth2/token Correlation ID: \<ID\>  
  > OAuth response error: invalid_grant  
  > Error description: **AADSTS70002: Error validating credentials. AADSTS50155: Device is not authenticated.**

> [!NOTE]
> [Bring your own device (BYOD)](/mem/intune/user-help/enroll-windows-10-device) enrollment or [auto-enrollment by using Group Policy](/windows/client-management/mdm/enroll-a-windows-10-device-automatically-using-group-policy) works successfully.

## Cause

This issue occurs when integrated Windows authentication is tried by the Configuration Manager client against Microsoft Entra ID while the verified domain isn't federated.

This issue occurs in one of the following situations:

- The Cloud Management Azure service isn't configured in Configuration Manager.
- Either [AD User Discovery](/mem/configmgr/core/servers/deploy/configure/configure-discovery-methods#BKMK_ConfigADDiscGeneral) or [Microsoft Entra user Discovery](/mem/configmgr/core/servers/deploy/configure/configure-discovery-methods#azureaadisc) isn't enabled for the affected users. Both discovery methods must be enabled.

## Solution

To fix the issue, [configure Azure Services for Cloud Management](/mem/configmgr/core/servers/deploy/configure/azure-services-wizard), and make sure that both [AD User Discovery](/mem/configmgr/core/servers/deploy/configure/configure-discovery-methods#BKMK_ConfigADDiscGeneral) and [Microsoft Entra user Discovery](/mem/configmgr/core/servers/deploy/configure/configure-discovery-methods#azureaadisc) are enabled for the users.
