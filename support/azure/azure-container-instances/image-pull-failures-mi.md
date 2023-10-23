---
title: Image pull fails with managed identity authentication
description: Troubleshoot why image pull fails with managed identity authentication
ms.date: 10/17/2023
ms.service: container-instances
ms.subservice: common-issues
keywords:
#Customer intent:
---
# Image Pull fails with Managed Identity Authentication 

This article discusses how to troubleshoot image pull failures when using Managed Identitiy on Azure Container Instances. 

## Symptoms 

User is attempting to deploy a container group and pull images from the Container Registry behind a private endpoint using Managed Identity authentication. 

## Cause 

There are a few factors in play that could be the cause of these problems.  

From the ACI side, 
- The credential format provided could be invalid based on the API version used when creating the container group.  
- The container group could be violating ACI limitations for this feature. The container group definition could be malformed. 

From the ACR side,  
- The user could be using an older API version.  
- The user could be using a private DNS zone for the registry.  
- The user could be using a private endpoint for the registry.

## Solution 

### ACI Checks 
Walk through the following checks on the ACI side. 
Check to see if you’re using ACI API version 07-01-2021 or newer.  
```
$ az deployment group create —g macolsorg --template—file conntainergroup_trusted.json 
Deployment failed. Correlation ID: fb67d8a7-f827-4947-b917-6524b42d93b6. { 
  "error": { 
    "code": "InvalidImageRegistryCredentialType", 
    "message": "Identity in 'imageRegistryCredentials' of container group 'acrtestcontainergroup' is not supported." 
  } 
} 
```
Check to see if you’re not violating any ACI limitations for this feature. Limitations include: Virtual Network injected container groups; Windows Server 2016 container groups; attempting to resolve ACR's private DNS zone 
Check that the container group definition is well formed. User must provide the ImageRegistryCredential property  (server, identity) as well as the ContainerGroupIdentity  (type, userAssignedIdentity). 
```
Deployment failed. Correlation ID: dbd29fb6—SbDS-4882-8c31-9b74839f728d. { 
  "error": { 
    "code": "AmbiguousImageResitryCredentialType", 
    "message": "The registry credential type in the 'imageRegistryCredentials' of container group 'acrtestcontainergroup' cannot be detected. Please set exactly one of username or identity" 
   } 
} 
```
```
Deployment failed. Correlation ID: cae466d4-f32b-4ee6-824d-a448749d80e5. { 
  "error": { 
    "code": "InvalidImageRegistryIdentity", 
    "message": "The identity in the 'imageRegistryCredentials' of container group 'acrtestcontainergroup' not found in container group identity list." 
  } 
} 
```
```
Deployment failed. Correlation ID: 6Saa5ceB-cc79-4a62-8b45-Sfd15265e92b. { 
  "error": { 
    "code": "InvalidRequestContent", 
    "message": "The request content was invalid and could not be deserialized: 'Required property 'server' not found in JSON. Path 'properties.imageRegistryCredentials[0]', line 1, position 586.'." 
   } 
}
```
### ACR Checks 
Check if user has given their Managed Identity instance ACR pull access. Step 3 of this tutorial  demonstrates how to do this. 
```
Deployment failed. Correlation ID: e78e754f-1d49-4206-8386-7cafb1733ddd. { 
  "error": { 
    "code": "InaccessibleImage", 
    "message": "The image 'kenzieacr.azurecr.io/pythonworker:v1' in container group 'acrtestcontainergroup' is not accessible. Please check the image and registry credential." 
  } 
} 
```
Check ACR has [Trusted Services](https://learn.microsoft.com/en-us/azure/container-registry/allow-access-trusted-services) enabled. 
## Next Steps 
If the previous checks did not resolve the incident, please submit a [support request](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest) 
Azure Container Registry ResourceURI 
Container Group ARM template (or other reference used to deetermine the ACI configuration deployed). 
