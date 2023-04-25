---
title: Troubleshooting scenarios while creating azure RM service connections 
description: This article explains about common problems while creating azure RM service connections.
ms.date: 04/24/2023
author: padmajayaraman
ms.author: v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
---

# Troubleshooting scenarios while creating service connections

This article helps to resolve problems that you might encounter while creating service connections.

## "Failed to set Azure permission" error when trying to save a service connection

### Symptoms

When users create a service connection and try to save it by selecting the **Save** button, they receive the following error message:

```output
Failed to set Azure permission 'RoleAssignmentId: xxxxxx26-xxxx-xxxx-xxxx-8f0xxxxxxx' for the service principal 'xxxxxx06-xxxx-xxxx-xxxx-6fbxxxxxxxxx' on subscription ID 'xxxxxxb6-xxxx-xxxx-xxxx-23xxxxxxxxx': error code: Forbidden, inner error code: AuthorizationFailed, inner error message The client 'kxxxxt@micrxxxxoft.com' with object id 'xxxxxx74-xxxx-xxxx-xxxx-477xxxxxxxxx' does not have authorization to perform action 'Microsoft.Authorization/roleAssignments/write' over scope '/subscriptions/xxxxxxb6-xxxx-xxxx-xxxx-234xxxxxxxxx' or the scope is invalid. If access was recently granted, please refresh your credentials. Ensure that the user has 'Owner' or 'User Access Administrator' permissions on the Subscription.
```

### Debugging steps

1. Capture an F12 or Fiddler trace.
1. In a GET call (similar to https://devopsdevil.visualstudio.com/xxxxfa-xxxx-xxxx-xxxx-76dxxxxxxxxx/_apis/serviceendpoint/endpoints/xxxxxxxbb-xxxx-xxxx-xxxx-df4xxxxxxxxx), the following response is returned:

```output
 {"data":{"environment":"AzureCloud","scopeLevel":"Subscription","subscriptionId":"xxxxxxb6-xxxx-xxxx-xxxx-234xxxxxxxxx","subscriptionName":"SIxxxxA","resourceGroupName":"","mlWorkspaceName":"","mlWorkspaceLocation":"","managementGroupId":"","managementGroupName":"","oboAuthorization":"","creationMode":"Automatic","azureSpnRoleAssignmentId":"","azureSpnPermissions":"[{"roleAssignmentId":"xxxxxx26-xxxx-xxxx-xxxx-8f0xxxxxxxxx","resourceProvider":"Microsoft.RoleAssignment","provisioned":false}]","spnObjectId":"xxxxxx06-xxxx-xxxx-xxxx-6fbxxxxxxxxx","appObjectId":"xxxxxx01-xxxx-xxxx-xxxx-36axxxxxxxxx","resourceId":""},"id":"xxxxxxbb-xxxx-xxxx-xxxx-df4xxxxxxxxx","name":"Sixxxxda-subscription","type":"azurerm","url":https://management.azure.com/,"createdBy":{"displayName":<name>,"url":https://spsprodwus21.vssps.visualstudio.com/xxxxxx52-xxxx-xxxx-xxxx-b65xxxxxxxxx/_apis/Identities/xxxxxx71-xxxx-xxxx-xxxx-6b2xxxxxxxxx,"_links":{"avatar":{"href":https://devopsdevil.visualstudio.com/_apis/GraphProfile/MemberAvatars/aad.N2RmZxxxxxxxNi03MWUzLWJlNzItZWYzMTA5YzRjZTA3} },"id":"xxxxxx71-xxxx-xxxx-xxxxx-6b2xxxxxxxxx","uniqueName":kxxt@mixxxxxxft.com,"imageUrl":https://devopsdevil.visualstudio.com/_apis/GraphProfile/MemberAvatars/aad.N2RmZWEyNDctxxxxxi03MWUzLWJxxxxxxxxxMTA5YzRjZTA3,"descriptor":"aad.N2RmxxxxxxxxxxxxMWUzLWJlNzItZWYzMTA5YzRjZTA3" },"description":"","authorization":{"parameters":{"tenantid":"xxxxxxxbf-xxxx-xxxx-xxxx-2d7xxxxxxxxx","serviceprincipalid":"xxxxxx5d-xxxx-xxxx-xxxx-dfaxxxxxxxxx","authenticationType":"spnKey","serviceprincipalkey":null},"scheme":"ServicePrincipal"},"isShared":false,"isReady":false,"operationStatus":{"state":"Failed","statusMessage":" Failed to set Azure permission 'RoleAssignmentId: xxxxxx26-xxxx-xxxx-xxxx-8f0fxxxxxxxxx' for the service principal 'xxxxxx06-xxxx-xxxx-xxxx-6fbxxxxxxxxxx' on subscription ID 'xxxxxxxb6-xxxx-xxxx-xxxx-234xxxxxxxxx': error code: Forbidden, inner error code: AuthorizationFailed, inner error message The client 'kxxxxxt@micxxxxxoft.com' with object id 'xxxxxx74-xxxx-xxxx-xxxx-477xxxxxxxxx' does not have authorization to perform action 'Microsoft.Authorization/roleAssignments/write' over scope '/subscriptions/xxxxxxxb6-xxxx-xxxx-xxxx-234xxxxxxxxx' or the scope is invalid. If access was recently granted, please refresh your credentials. Ensure that the user has 'Owner' or 'User Access Administrator' permissions on the Subscription."},"owner":"Library","serviceEndpointProjectReferences":[{"projectReference":{"id":"xxxxxxfa-xxxx-xxxx-xxxx-76dxxxxxxxxx","name":"IIS"},"name":"Sxxxxxxxda-subscription","description":""}]}
```

### Resolution

Check the user permission on the subscription. Make sure that the user has the Owner or User Access Administrator permission on the Subscription.

## Error when verifying the manual Azure RM service connection

### Symptoms

After users provide the details to create a manual Azure RM service connection, and then they select the **Verify** button, verification fails, and users receive the following error message:

```output
Failed to query service connection API: 'https://management.azure.com/subscriptions/xxxxxx08-xxxx-xxxx-xxxx-eadxxxxxxxxx?api-version=2016-06-01 '. Status Code: 'Forbidden', Response from server: '{"error":{"code":"AuthorizationFailed","message":"The client 'xxxxxxaf-xxxx-xxxx-xxxx-6bexxxxxxxxx' with object id 'xxxxxxaf-xxxx-xxxx-xxxx-6bexxxxxxxxx' does not have authorization to perform action 'Microsoft.Resources/subscriptions/read' over scope '/subscriptions/xxxxxx08-xxxx-48ec-xxxx-eadxxxxxxxxx' or the scope is invalid. If access was recently granted, please refresh your credentials."}}'
```

### Debugging steps

1. Capture F12/Fiddler trace, while reproducing the issue.

You will see the following response for the POST call in the trace:

```output
{"result":[],"statusCode":403,"errorMessage":"Failed to query service connection API: 'https://management.azure.com/subscriptions/xxxxxx08-xxxx-xxxx-xxxx-eadxxxxxxxxx?api-version=2016-06-01 '. Status Code: 'Forbidden', Response from server: '{"error":{"code":"AuthorizationFailed","message":"The client 'xxxxxxaf-xxxx-xxxx-xxxx-6bexxxxxxxxx' with object id 'xxxxxxaf-xxxx-xxxx-xxxx-6bexxxxxxxxx' does not have authorization to perform action 'Microsoft.Resources/subscriptions/read' over scope '/subscriptions/xxxxxx08-xxxx-xxxx-xxxx-eadxxxxxxxxx' or the scope is invalid. If access was recently granted, please refresh your credentials."}}'"}
```

### Resolution

Make sure that the newly created SPN (App) has the Contributor and Reader permissions on the subscription.

1. Check whether the connection is automated or manual.

1. [Get the details for the endpoints by using the REST API](/rest/api/azure/devops/serviceendpoint/endpoints/get?view=azure-devops-rest-6.0&tabs=HTTP).

1. Make sure that you set the `includeFailed=true` parameter so that all service endpoints are captured. This should provide more information and show whether an issue affects the service connection (for example, in the `isReady` field).

1. [Try to delete the connections by using the REST API directly](/rest/api/azure/devops/serviceendpoint/endpoints/delete?view=azure-devops-rest-6.0&tabs=HTTP&preserve-view=true). Although the UI makes similar calls, it's always worth checking whether calling the API directly will create a different result.

1. If you use the API from the previous step by using the default parameters, and this still doesn't work, you can set the `deep` value to `false`. This setting causes the program to skip any checks and attempts that are part of the usual process to delete the underlying SPN.

> [!NOTE]
> The user must manually delete or edit the service principal by using the Active Directory app in the Azure portal.

