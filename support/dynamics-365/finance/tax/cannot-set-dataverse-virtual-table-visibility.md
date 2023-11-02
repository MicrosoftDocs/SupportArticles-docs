---
title: Error 400 or 401 when you set Dataverse virtual table visibility
description: This article provides information about the error codes (400 and 401) that can occur when you set Microsoft Dataverse virtual table visibility for Tax calculation service in a Regulatory Configuration Service (RCS) enviromnment.
author: hshi-ms
ms.date: 07/26/2022
ms.topic: troubleshooting
ms.search.form: ERSolutionTable_RCSSetVirtualTableVisibility
audience: Application User
ms.reviewer: kfend
ms.search.region: Global
ms.author: hshi
ms.search.validFrom: 2022-07-26
ms.dyn365.ops.version: 10.0.30
---

# Error 400 or 401 when you set Dataverse virtual table visibility

Error code: SYS81183

This article describes the error codes (400 and 401) that can occur when you set Microsoft Dataverse virtual table visibility for Tax calculation service in a Regulatory Configuration Service (RCS) environment. It also explains what causes the issues and how to fix them.

## Error 400 with "InternalServerError"

### Symptoms

When you set virtual table visibility or do master data lookup in the tax feature setup, you receive the following error message:

> Connection to Microsoft Dataverse failed. Details: The remote server returned an error: (400) Bad Request. 0x80048d0b: A token was obtained to call Finance and Operations, but Finance and Operations returned an error of type InternalServerError.

### Cause

This issue occurs if the finance and operations service is down, or if the finance and operations target URL is incorrectly set.

### Resolution

1. Confirm that you can sign in to finance and operations apps by using the same account that you use to sign in to Dataverse.
2. Go to **Dataverse** \> **Advanced settings** \> **Administration** \> **Virtual Entity Data Sources**, and select the data source that is named **finance and operations**.
3. Confirm that the target URL can be opened directly in the browser. For more information, see [Configure the virtual entity data source](/dynamics365/fin-ops-core/dev-itpro/power-platform/admin-reference#configure-the-virtual-entity-data-source).

## Error 400 with "The remote name could not be resolved"

### Symptoms

When you set virtual table visibility or do master data lookup in the tax feature setup, you receive the following error message:

> Connection to Microsoft Dataverse failed. Details: The remote server returned an error: (400) Bad Request. 0x80040224: TokenProvider.AcquireTokenAsync(Clientld '\{ApplicationId\}', Authority '{IncorrectURL}', Resource '00000015-0000-0000-c000-000000000000'): unhandled exception: Microsoft.IdentityModel.Clients.ActiveDirectory.AdalServiceException: Service returned error. Check InnerException for more details ---\> System.Net.WebException: The remote name could not be resolved:...

### Cause

This issue occurs if the Open Authorization (OAuth) URL or tenant ID is incorrect. For more information, see [Configure the virtual entity data source](/dynamics365/fin-ops-core/dev-itpro/power-platform/admin-reference#configure-the-virtual-entity-data-source).

### Resolution

1. Go to **Dataverse** \> **Advanced settings** \> **Administration** \> **Virtual Entity Data Sources**, and select the data source that is named **finance and operations**.
2. Confirm that the OAuth URL and tenant ID are correct. For more information, see [Configure the virtual entity data source](/dynamics365/fin-ops-core/dev-itpro/power-platform/admin-reference#configure-the-virtual-entity-data-source).

    - The OAuth URL is a hard-coded value: `https://login.windows.net/`.
    - To find the correct tenant ID, sign in to the [Azure portal](https://portal.azure.com) by using the same account that you use to sign in to Dataverse and RCS. Select **Microsoft Entra ID**, and then select your instance of Microsoft Entra ID. The tenant ID or primary domain appears in the **Tenant** field.

## Error 400 with "Application with identifier {ApplicationId} not found"

### Symptoms

When you set virtual table visibility or do master data lookup in the tax feature setup, you receive the following error message:

> Connection to Microsoft Dataverse failed. Details: The remote server returned an error: (400) Bad
Request. 0x80040224: TokenProvider.AcquireTokenAsync(Clientid '\{IncorrectApplicationId\}', Authority '\<`https://login.windows.net/microsoft.com`\>', Resource '00000015-0000-0000-c000-000000000000'): unhandled exception: Microsoft.IdentityModel.Clients.ActiveDirectory.AdalServiceException: AADSTS700016: Application with identifier '\{IncorrectApplicationId\}' was not found in the directory 'Microsoft'. This can happen if the application has not been installed by the administrator of the tenant or consented to by any user in the tenant. You may have sent your authentication request to the wrong tenant.

### Cause

This issue occurs if the application ID is incorrect. For more information, see [Configure the virtual entity data source](/dynamics365/fin-ops-core/dev-itpro/power-platform/admin-reference#configure-the-virtual-entity-data-source).

### Resolution

1. Go to **Dataverse** \> **Advanced settings** \> **Administration** \> **Virtual Entity Data Sources**, and select the data source that is named **finance and operations**.
2. Confirm that the application ID is correct. For more information, see [Configure the virtual entity data source](/dynamics365/fin-ops-core/dev-itpro/power-platform/admin-reference#configure-the-virtual-entity-data-source).

You should get the application ID during the [Register the app in the Azure portal](/dynamics365/fin-ops-core/dev-itpro/power-platform/admin-reference#grant-app-permissions-in-finance-and-operations-apps) step. Make sure that you entered the correct application ID.

## Error 401

### Symptoms

When you set virtual table visibility, do master data lookup in the tax feature setup, or do model mapping validation, you receive one of the following error messages:

> Connection to Microsoft Dataverse failed. Details: The remote server returned an error: (401) Unauthorized.

> Filtered warehouse entity Warehouse entity Connection to Microsoft Dataverse failed. Details: The remote server returned an error: (401) Unauthorized.

### Cause

The 401 "Unauthorized" error occurs if the "Check connection" process for connected applications in RCS is unsuccessful, or if the "Check connection" process isn't run after changes are made to the settings of connected applications in RCS.

> [!NOTE]
> The account that is used to sign in to RCS should also be able to sign in to the Dataverse instance.

### Resolution

1. In the RCS environment, go to **Electronic reporting** \> **Connected applications** \> **Dataverse application record**.
2. The **Application** field shows the URL of the database instance. Confirm that you can sign in to that Dataverse instance by using the same account that you use to sign in to the RCS environment.
3. Confirm that the **Tenant** field is set to your account's tenant ID (for example, **d335a570-a05b-4bc5-8eb3-c42c65f9560d**) or tenant URL (for example, `taxserviceint.onmicrosoft.com`).
3. Select **Check connection**. The process should be successful.

> [!IMPORTANT]
> If the "Check connection" process isn't successful, the Dataverse setup isn't correct. See [Enable master data lookup for tax calculation configuration](/dynamics365/finance/localizations/tax-service-set-up-environment-master-data-lookup), and make sure that steps 1, 2, and 3 are all done correctly.
