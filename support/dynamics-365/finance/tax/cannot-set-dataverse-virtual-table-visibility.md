---
title: Error 400 or 401 when setting Microsoft Dataverse virtual table visibility
description: Provides resolutions for the error codes that occur when application users try to set Dataverse virtual table visibility.
author: hshi
ms.date: 07/26/2022
ms.topic: troubleshooting
ms.search.form: ERSolutionTable
audience: Application User
ms.reviewer: kfend
ms.search.region: Global
ms.author: hshi
ms.search.validFrom: 2022-07-26
ms.dyn365.ops.version: 10.0.30
---

# Error codes that occur when you set Microsoft Dataverse virtual table visibility

This article describes the error codes that occur when you set Microsoft Dataverse virtual table visibility.

## Error 400 with "InternalServerError"

When you set virtual table visibility or do master data lookup in tax feature setup, the following error message occurs:

> Connection to Microsoft Dataverse failed. Details: The remote server returned an error: (400) Bad Request. 0x80048d0b: A token was obtained to call Finance and Operations, but Finance and Operations returned an error of type InternalServerError.

### Cause

This issue occurs when finance and operations service is down, or the finance and operations Target URL is set incorrectly.

### Resolution

1. Check the finance and operations internally whether you can sign in with the same account that you use to sign in to Dataverse.

2. Go to **Dataverse** > **Advanced settings** > **Administration** > **Virtual Entity Data Sources** and select the data source named "finance and operations".

3. Double check the Target URL whether can be directly opened in the browser. For more information, see [Configure the virtual entity data source](/dynamics365/fin-ops-core/dev-itpro/power-platform/admin-reference#configure-the-virtual-entity-data-source).

## Error 400 with "The remote name could not be resolved"

When you set virtual table visibility or do master data lookup in tax feature setup, the following error message occurs:

> Connection to Microsoft Dataverse failed. Details: The remote server returned an error: (400) Bad Request. 0x80040224: TokenProvider.AcquireTokenAsync(Clientld '{ApplicationId}', Authority ‘{IncorrectURL}', Resource '00000015-0000-0000-c000-000000000000’): unhandled exception: Microsoft.IdentityModel.Clients.ActiveDirectory.AdalServiceException: Service returned error. Check InnerException for more details ---> System.Net.WebException: The remote name could not be resolved:...

### Cause

This issue occurs when OAuth URL or Tenant ID is incorrect. For more information, see [Configure the virtual entity data source](/dynamics365/fin-ops-core/dev-itpro/power-platform/admin-reference#configure-the-virtual-entity-data-source).

### Resolution

1. Go to **Dataverse** > **Advanced settings** > **Administration** > **Virtual Entity Data Sources** and select the data source named "finance and operations".

2. Double check the OAuth URL and Tenant ID. For more information, see [Configure the virtual entity data source](/dynamics365/fin-ops-core/dev-itpro/power-platform/admin-reference#configure-the-virtual-entity-data-source).

The correct Tenant ID can be found at the [Azure portal](https://portal.azure.com) (sign in with your account the same as Dataverse and Regulatory Configuration Service (RCS)) > **Azure Active Directory** > your Azure Active Directory instance. The Tenant ID or Primary domain could be filled into the field **Tenant**. And the OAuth URL until June 2022 is hard code `https://login.windows.net/`.

## Error 400 with "Application with identifier {ApplicationId} not found"

When you set virtual table visibility or do master data lookup in tax feature setup, the following error message occurs:

> Connection to Microsoft Dataverse failed. Details: The remote server returned an error: (400) Bad
Request. 0x80040224: TokenProvider.AcquireTokenAsync(Clientid '{IncorrectApplicationId}', Authority ‘<`https://login.windows.net/microsoft.com`>', Resource '00000015-0000-0000-c000-000000000000’): unhandled exception: Microsoft.IdentityModel.Clients.ActiveDirectory.AdalServiceException: AADSTS700016: Application with identifier '{IncorrectApplicationId}' was not found in the directory ‘Microsoft’. This can happen if the application has not been installed by the administrator of the tenant or consented to by any user in the tenant. You may have sent your authentication request to the wrong tenant.

### Cause

This issue occurs when Application ID is incorrect. For more information, see [Configure the virtual entity data source](/dynamics365/fin-ops-core/dev-itpro/power-platform/admin-reference#configure-the-virtual-entity-data-source).

### Resolution

1. Go to **Dataverse** > **Advanced settings** > **Administration** > **Virtual Entity Data Sources** and select the data source named "finance and operations".

2. Double check the Application ID. For more information, see [Configure the virtual entity data source](/dynamics365/fin-ops-core/dev-itpro/power-platform/admin-reference#configure-the-virtual-entity-data-source).

The Application ID should be grabbed from the step [Register the app in the Azure portal](/dynamics365/fin-ops-core/dev-itpro/power-platform/admin-reference#grant-app-permissions-in-finance-and-operations-apps). Make sure that you filled in the correct Application ID.

## Error 401

### Symptoms

When you set virtual table visibility, do master data lookup in tax feature setup, or do the Model Mapping "validate" behavior. you receive one of the following error messages:

> Connection to Microsoft Dataverse failed. Details: The remote server returned an error: (401) Unauthorized.

or

> Filtered warehouse entity Warehouse entity Connection to Microsoft Dataverse failed. Details: The remote server returned an error: (401) Unauthorized.

### Cause

The 401 Unauthorized error occurs when RCS - Connected applications setting "Check connection" fails, or after modifying the RCS - Connected applications setting and without "Check connection".

> [!NOTE]
> Be aware that your account that signs in to RCS should also has the ability to sign in to the Dataverse instance.

### Resolution

1. In RCS environment, go to **Electronic reporting** > **Connected applications** > **Dataverse application record**.
2. Check the Dataverse instance URL that is filled in the **Application** field should be able to sign in with your account that same as RCS environment. And the **Tenant** field should be filled in by using your account "Tenant ID", such as `d335a570-a05b-4bc5-8eb3-c42c65f9560d` or "Tenant URL", such as `taxserviceint.onmicrosoft.com`.
3. Select **Check connection**. The process should be successful.

> [!IMPORTANT]
> If the "Check connection" process is not successful, it means the Dataverse setup is not correct. See [Enable master data lookup for tax calculation configuration](/dynamics365/finance/localizations/tax-service-set-up-environment-master-data-lookup) step 1, 2 and 3. And make sure that every step is done correctly.
