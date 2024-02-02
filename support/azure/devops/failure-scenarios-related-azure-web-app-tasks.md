---
title: Failure scenarios related to Azure Web App tasks
description: Provides resolutions for some errors related to Azure Web App tasks.
ms.date: 05/10/2023
ms.custom: sap:Pipelines
ms.reviewer: dmittal, cathmill, v-sidong
ms.service: azure-devops
ms.subservice: ts-pipelines
---
# Failure scenarios related to Azure Web App tasks

> [!NOTE]
> The best way to start debugging errors related to Azure Web App tasks is to gather [debug logs](troubleshoot-azure-web-apps-tasks-deployments.md#debug-logs-and-tips-for-further-debugging) for pipelines and collect the logs by using [Kudu service](/azure/app-service/resources-kudu) and the [**Diagnose and solve problems**](/azure/app-service/overview-diagnostics) feature.

## Errors and resolutions

#### Error 1: "FATAL ERROR: Ineffective mark-compacts near heap limit Allocation failed - JavaScript heap out of memory"

**Resolution**:

This error may occur due to a failure to unzip and zip a large package for the deployment, as Microsoft-hosted agents have limited resources. In the logs, you see the steps where it's failing. Preferably, use the [Azure Web App V1 task](https://github.com/microsoft/azure-pipelines-tasks/tree/master/Tasks/AzureWebAppV1) for App Services deployment. For more complicated scenarios like XML transformation, see [Azure RM Web Deployment V4 task](https://github.com/microsoft/azure-pipelines-tasks/tree/master/Tasks/AzureRmWebAppDeploymentV4).

#### Error 2: "Encountered a retriable error:ECONNRESET. Message: read ECONNRESET"

**Resolution**:

- If you're using the Microsoft-hosted agent and App Services in an ASE environment, make sure you have opened the [IP addresses](https://www.microsoft.com/download/details.aspx?id=56519) for the Microsoft-hosted agent geography. See [Allowed IP addresses and domain URLs](/azure/devops/organizations/security/allow-list-ip-url) for IP address ranges of incoming connections.

- If you're using a self-hosted agent, apart from unblocking the IP range for the self-hosted agent, the problem could be due to a flaky network issue. Consider creating a support ticket with the Azure Web App or Azure Networking team for troubleshooting in this area.

#### Error 3: "Failed to deploy web package to App Service"

The task calls a zipDeploy Kudu API for deployment. The following error generally comes in response to some operations performed by the API.

```output
[error]Failed to deploy web package to App Service.
[debug]Processed: ##vso[task.issue type=error;]Failed to deploy web package to App Service.
[debug]Deployment Failed with Error: Error: Package deployment using ZIP Deploy failed. 
Refer logs for more details.
[debug]task result: Failed
```

**Resolution**:
  
Try setting the **WEBSITE_RUN_FROM_PACKAGE** app setting to **1** on the App Services side.

#### Error 4: "EMFILE: too many open files" or "Error: Package deployment using ZIP Deploy failed"
  
**Possible workarounds**:

- Use the [Azure Web App V1 task](https://github.com/microsoft/azure-pipelines-tasks/tree/master/Tasks/AzureWebAppV1).

- Use the following Extract Files task to extract the zip file into a folder path, and then provide the folder path into the App Service Deploy task. This step prevents the App Service task from unzipping the package, preventing EMFILE errors.

  ```yml
  steps:
  - task: ExtractFiles@1
    displayName: 'Extract files'
    inputs:
    archiveFilePatterns: '$(InputPackageZipPath)'
    destinationFolder: '$(OutputUnzippedPath)'
    
  - task: AzureRmWebAppDeployment@4
    displayName: 'Azure App Service Deploy'
    inputs:
    azureSubscription: 'Subscription'
    WebAppName: 'app-name'
    package: '$(OutputUnzippedPath)'
    enableXmlTransform: true
  ```

## See related

- [Troubleshoot Azure Web app tasks and deployment issues](troubleshoot-azure-web-apps-tasks-deployments.md)
- [Azure Web App and services related issues](azure-web-app-services-related-issues.md)
- [Issues with the service connection in the task](issues-service-connection-task.md)
- [Resource doesn't exist error with services deployment](resource-not-exist-error-services-deployment.md)
