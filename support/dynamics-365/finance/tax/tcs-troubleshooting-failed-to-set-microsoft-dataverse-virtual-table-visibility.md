---
title: Failed to set Microsoft Dataverse virtual table visibility
description: This article provides information for Application users who failed to set dataverse table visibility.
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

# Errors codes for 'failed to set microsoft dataverse virtual table visibility'

This article describes error codes for setting virtual table visibility

## Error 400

### Symptom 
#### Symptom 1 - InternalServerError
When "Set virtual table visibility" or doing master data lookup in tax feature setup. See error message : 
`Connection to Microsoft Dataverse failed. Details: The remote server returned an error: (400) Bad Request. 0x80048d0b: A token was obtained to call Finance and Operations, but Finance and Operations returned an error of type InternalServerError.` 

#### Symptom 2 - The remote name could not be resolved
When "Set virtual table visibility" or doing master data lookup in tax feature setup. See error message : 
`Connection to Microsoft Dataverse failed. Details: The remote server returned an error: (400) Bad Request. 0x80040224: TokenProvider.AcquireTokenAsync(Clientld '{ApplicationId}', Authority ‘{IncorrectURL}', Resource '00000015-0000-0000-c000- 
000000000000’): unhandled exception: 
Microsoft.IdentityModel.Clients.ActiveDirectory.AdalServiceException: 
Service returned error. Check 
InnerException for more details ---> 
System.Net.WebException: The remote name could not be resolved:...`

#### Symptom 3 - Application with identifier {ApplicationId} not found
When "Set virtual table visibility" or doing master data lookup in tax feature setup. See error message : 
`Connection to Microsoft Dataverse failed. Details: The remote server returned an error: (400) Bad 
Request. 0x80040224: TokenProvider.AcquireTokenAsync(Clientid '{IncorrectApplicationId}', Authority ‘https://login.windows.net/microsoft.com', Resource '00000015-0000-0000-c000- 
000000000000’): unhandled exception: 
Microsoft.IdentityModel.Clients.ActiveDirectory.AdalServiceException: AADSTS700016: Application with 
identifier '{IncorrectApplicationId}' was not found in the directory ‘Microsoft’. This can 
happen if the application has not been installed by the administrator of the tenant or consented to by any user in the tenant. You may have sent your authentication request to the wrong tenant. `

### Cause
#### Symptom 1 - InternalServerError
This symptom always could be encountered when F&O service is down or the F&O Target URL is configured incorrectly.
#### Symptom 2 - The remote name could not be resolved
This symptom always could be encountered when [Configure the virtual entity data source](https://docs.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/power-platform/admin-reference#configure-the-virtual-entity-data-source) OAuth URL / Tenant Id is incorrect.
#### Symptom 3 - Application with identifier {ApplicationId} not found
This symptom always could be encountered when [Configure the virtual entity data source](https://docs.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/power-platform/admin-reference#configure-the-virtual-entity-data-source) Application Id is incorrect.


### Troubleshooting 
#### Symptom 1 - InternalServerError
  1. Check the F&O internally, whether it could be login with the account same with which login to Dataverse. 
  2. Go to Dataverse > Advanced Settings > Administration > Virtual Entity Data Sources > "Finance and Operations". ([Configure the virtual entity data source](https://docs.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/power-platform/admin-reference#configure-the-virtual-entity-data-source)), check the Target URL could be directly open in the browser.
  3. For Engineer Dev Env, please use the SQL query below to see if your account has the 'SysAdmin' security role. 
`select * from SecurityUserRole join SecurityRole on SecurityUserRole.Securityrole = SecurityRole.recid where SecurityUserRole.User_ = '{yourailas}' `
If no result, please refer [Setup FinOps env for supporting Dataverse - Detailed Steps - Step 2](https://msazure.visualstudio.com/FINOPS/_wiki/wikis/FINOPS.wiki/318230/Setup-FinOps-env-for-supporting-Dataverse?anchor=detailed-steps) to redo the role assignment.
  4. For Customer Env, please refer [Grant app permissions in Finance and Operations apps](https://msdyneng.visualstudio.com/FinOps/_workitems/edit/694034/) to see the correct role has been assigned. 
#### Symptom 2 - The remote name could not be resolved
  1. Double check the OAuth URL and Tenant Id that filled in Dataverse > Advanced Settings > Administration > Virtual Entity Data Sources > "Finance and Operations". ([Configure the virtual entity data source](https://docs.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/power-platform/admin-reference#configure-the-virtual-entity-data-source)) The correct Tenant Id could be found at the Azure Portal (login with your account the same as Dataverse and RCS) - Azure Active Directory - Your AAD instance. Both the Tenant Id or Primary Domain could be filled into the field "Tenant". And OAuth URL till June/2022 is hard code "https://login.windows.net/".
![image.png](/.attachments/image-22ee3610-27c1-45d0-983b-7fca8276f9ac.png)
#### Symptom 3 - Application with identifier {ApplicationId} not found
  1. For the Customer Env, double check the Application Id that filled in Dataverse > Advanced Settings > Administration > Virtual Entity Data Sources > "Finance and Operations". ([Configure the virtual entity data source](https://docs.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/power-platform/admin-reference#configure-the-virtual-entity-data-source)). The Application Id should be grabbed from the step [Register the app in the Azure portal](https://docs.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/power-platform/admin-reference#grant-app-permissions-in-finance-and-operations-apps)). Make sure you filled in the correct application id.
  2. For the Engineer Dev Env, follow the [Setup FinOps env for supporting Dataverse - Detailed Steps - Step 4](https://msazure.visualstudio.com/FINOPS/_wiki/wikis/FINOPS.wiki/318230/Setup-FinOps-env-for-supporting-Dataverse?anchor=detailed-steps), redo the SignalRepeaterClient and try again.


## Error 401

### Symptom 
When "Set virtual table visibility", doing master data lookup in tax feature setup, or do the Model Mapping "validate" behavior. See error message : `Connection to Microsoft Dataverse failed. Details: The remote server returned an error: (401) Unauthorized.` or `Filtered warehouse entity Warehouse entity Connection to Microsoft Dataverse failed. Details: The remote server returned an error: (401) Unauthorized.`

### Cause
The 401 Unauthorized issue could always be encountered when RCS - Connected Application setting "checking connection" failed, or after modifying the RCS - Connected Application setting and without "checking connection". **Please be aware that your account that login to RCS, should also has the ability to login the Dataverse instance.**

### Troubleshooting 
- RCS Env - Go to Electronic Reporting -> Connected Applications -> Dataverse application record
- Check Dataverse instance URL filled in "Application", should be able to login with your account that same as RCS env. And the "Tenant" should fill in your account "Tenant Id", such as `d335a570-a05b-4bc5-8eb3-c42c65f9560d` or "Tenant URL", such as `taxserviceint.onmicrosoft.com`.
- Click "Check connection", the process should be successful.

### Mitigation
If the "Check connection" process is not successful, it means the Dataverse setup is not correct. Please review [How to trouble shooting the environments for Dataverse from beginning](/Home/Services/Tax-Calculation-Service/Tax-Calculation-Service-DRI-Handbook/Dataverse-DRI-Handbook/How-to-trouble-shooting-the-environments-for-Dataverse-from-beginning) to do the specific trouble shooting.
- For Engineer Dev Env, please doublecheck the doc: [Setup Dataverse instance for development](/Home/Services/Tax-Calculation-Service/Development/Dataverse-development/Setup-Dataverse-instance-for-development) and [Setup RCS env supported by Dataverse](/Home/Services/Tax-Calculation-Service/Development/Dataverse-development/Setup-RCS-env-supported-by-Dataverse) have all been done. 
- For Customer Env, please refer [Enable master data lookup for tax calculation configuration](https://docs.microsoft.com/en-us/dynamics365/finance/localizations/tax-service-set-up-environment-master-data-lookup?toc=%2Fdynamics365%2Ffinance%2Ftoc.json) step 1, 2 and 3. And make sure every step has been done correctly.
