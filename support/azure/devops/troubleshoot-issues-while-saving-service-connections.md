---
title: Troubleshooting tips for problems while saving Azure RM  service connection
description: This article explains about the problems that might occur when users try to save the Azure RM service connection.
ms.date: 04/24/2023
author: padmajayaraman
ms.author: v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
---

# Troubleshooting problems while saving Azure RM service connections

## Troubleshoot the "Failed to get Azure DevOps Service access token" error

### Symptoms

When users try to verify the automatic Azure RM service connection, they receive the following error message:

> Failed to get Azure DevOps Service access token, cache value is invalid.

:::image type="content" source="media/troubleshoot-azure-rm-failed-access-token/edit-service-connection-azurerm.png" alt-text="Screenshot that shows verification of the automatic Azure RM connection.":::

### Debugging steps

Capture an F12/Fiddler trace while you reproduce the issue.

You will see following response for the POST call in the trace:

`{"authorization":{"parameters":{"tenantid":"xxxxxx49-XXXXcexxxxxx","serviceprincipalid":"xxxxxx7e-XXXX-027xxxxxxxxx","authenticationType":"spnKey","serviceprincipalkey":null,"accesstoken":null},"scheme":"ServicePrincipal"},"created}`

### Cause

When you run a service connection update call from the UI, the body of the `PUT` request contains an `accesstoken = null` entry. If we compare the `PUT` payload against the working service connections at either end of the operation, we don't see this entry. If the `AccessToken` property is present in the service connection UI object, it should have valid value (such as a GUID). It shouldn't be empty or null.

### Resolution

1. Go to the **Service Connection** page, and then select the affected service connection.
1. Select **Edit**.
1. Press **F12**, and then open the network trace window. If possible, select the **disable cache** option in the panel.
1. Update the description.
1. Select the **Save** button.
1. If you are prompted for authorization, enter the required credentials.
1. In network trace, you can now see the PUT call to update the service connection that failed.
1. Open the PUT call details, and copy the request body by selecting **Payload > View source > Copy the content**.
1. In the request body, remove the **accesstoken: null** (or **accesstoken:''**) property under the authorization header.
1. Copy the request body, and make a service connection update `PATCH REST` call by using Postman (or any other `REST` tool) by running the following command.

`PUT https://dev.azure.com/{organization}/_apis/serviceendpoint/endpoints/{endpointId}?api-version=6.0-preview.4`

For more information, see [Endpoints - Update Service Endpoint](/rest/api/azure/devops/serviceendpoint/endpoints/update-service-endpoint?view=azure-devops-rest-6.0&tabs=HTTP&preserve-view=true).

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
