---
title: Troubleshooting tips for problems while creating Azure RM  service connection
description: This article explains about the problems that might occur when users try to create an Azure RM service connection.
ms.date: 04/24/2023
author: padmajayaraman
ms.author: v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
---

# Troubleshooting problems while creating Azure RM service connections

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

[!INCLUDE [third-party-disclaimer](../../includes/third-party-disclaimer.md)]
