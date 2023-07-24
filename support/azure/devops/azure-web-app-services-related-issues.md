---
title: Troubleshoot common issues related to Azure Web App service deployments
description: This article lists some common issues related to Azure Web App service deployments from Azure DevOps Services and provides steps to resolve or debug these issues.
ms.date: 05/10/2023
ms.custom: sap:Pipelines
ms.reviewer: dmittal, cathmill, v-sidong
ms.service: azure-devops
ms.subservice: ts-pipelines
---
# Azure Web App service deployments related issues

This article lists some common issues related to Azure Web App service deployments from Azure DevOps Services and provides steps to resolve or debug these issues.

> [!NOTE]
> Check [Status history](https://status.dev.azure.com/_history) to see if you may be impacted due to an outage in Azure DevOps Services.

## Common issues and solutions

#### Error: "No package found with specified pattern in the task"

Verify that the package mentioned in the task is published as an artifact in the build or a previous stage and downloaded in the current job.  

#### Error: "Publish using zip deploy option is not supported for MSBuild package type"

Web packages created using the MSBuild task (with default arguments) have a nested folder structure that can only be deployed correctly by Web Deploy. The publish-to-zip deployment option can't be used to deploy those packages. To convert the packaging structure, follow [these steps](/azure/devops/pipelines/tasks/deploy/azure-rm-web-app-deployment#error-publish-using-zip-deploy-option-is-not-supported-for-msbuild-package-type).  

#### The task fails with a 5xx error code

- Check the [status of your Azure service](https://status.azure.com/status).

- Also check the [Azure DevOps status page](https://status.dev.azure.com/_history) to see if any ongoing outage is related to your issue.

#### A release hangs for a long time and then fails, a "503 service unavailable" error occurs, or the deployment history in the deployment logs fails to update

These issues may occur when there's insufficient capacity on your App Service Plan. To resolve these issues, you can scale up the App Service instance to increase available CPU, RAM, and disk space or try with a different App Service plan. Also, check the [Kudu logs](/azure/app-service/resources-kudu) from the Azure Web Apps side.

#### Errors related to the network not being reachable during deployment, for example, "Could not connect to the remote computer ('\<AppName\>.scm.azurewebsites.net')"

Review the following articles for firewall, proxy, and permissions (applicable for all platforms). These articles provide references for Microsoft-hosted and self-hosted agent scenarios.

- [Communication with Azure Pipelines](/azure/devops/pipelines/agents/agents#communication-with-azure-pipelines)

- [Agent Authentication and Authorization](https://github.com/Microsoft/azure-pipelines-agent/blob/master/docs/design/auth.md)

- [Run a self-hosted agent behind a web proxy](/azure/devops/pipelines/agents/proxy)

- [IPs and URLs that need to be unblocked in the firewall](/azure/devops/pipelines/agents/v2-windows#im-running-a-firewall-and-my-code-is-in-azure-repos-what-urls-does-the-agent-need-to-communicate-with)

- [Permissions required for agent configuration](/azure/devops/pipelines/agents/v2-windows#permissions)  

#### The task fails with the error: "Could not fetch access token for Azure. Verify if the Service Principal used is valid and not expired"

> [!NOTE]
> There might also be other scenarios when issues with the Azure service connection impact the deployment.

- Verify the validity of the service principal used and that it's present in the app registration. For more information, see [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal).

- See [Troubleshoot ARM service connections](/azure/devops/pipelines/release/azure-rm-endpoint).  

#### SSL error in the App Service or Web App deploy task

To use a certificate in App Service, it must be signed by a trusted certificate authority. See [SSL error](/azure/devops/pipelines/tasks/deploy/azure-rm-web-app-deployment#ssl-error) to resolve this error.  

#### Web Deploy error in the App Service deploy task

If you're using Web Deploy to deploy your app, in some error scenarios, Web Deploy will show an error code in the log. To troubleshoot a Web Deploy error, see [Web Deploy error codes](/iis/publish/troubleshooting-web-deploy/web-deploy-error-codes).  

#### Error "ERROR_FILE_IN_USE" while trying to deploy .NET apps to Web App on Windows

To resolve this error, ensure the **Rename locked files** and **Take App offline** options are enabled in the task. For zero downtime, use [slot swap](/azure/app-service/deploy-staging-slots#add-a-slot).  

#### Web App deployment on Windows is successful, but the app isn't working

This issue may occur because the *web.config* file isn't present in your app. To add a *web.config* file, follow [these steps](/azure/devops/pipelines/tasks/deploy/azure-rm-web-app#web-app-deployment-on-windows-is-successful-but-the-app-is-not-working).  

#### Web App deployment on App Service Environment (ASE) isn't working

[Follow these steps](/azure/devops/pipelines/tasks/deploy/azure-rm-web-app#web-app-deployment-on-app-service-environment-ase-is-not-working) to ensure you're deploying correctly.  

#### Failed to deploy a Function App using the AzureRmWebAppDeployment task

Consider using the [AzureFunctionApp@1 - Azure Functions v1 task](/azure/devops/pipelines/tasks/reference/azure-function-app-v1).

#### Guidance on deploying an app to Azure Web App

See the following tutorials about deploying apps of various languages to Azure Web App:  

- [Use CI/CD to deploy a Python web app to Azure App Service on Linux](/azure/devops/pipelines/ecosystems/python-webapp)  
- [Build and test PHP apps](/azure/devops/pipelines/ecosystems/php)
- [Build & deploy to Java web app](/azure/devops/pipelines/ecosystems/java-webapp)  
- [Quickstart - Use Azure Pipelines to build and publish a Node.js package](/azure/devops/pipelines/ecosystems/javascript)  

## Recommended documents

- [App Service Deploy task Troubleshooting](/azure/devops/pipelines/tasks/deploy/azure-rm-web-app-deployment#troubleshooting)  
- [AzureWebApp@1 - Azure Web App v1 task](/azure/devops/pipelines/tasks/reference/azure-web-app-v1#troubleshooting)  
- [AzureWebAppContainer@1 - Azure Web App for Containers v1 task](/azure/devops/pipelines/tasks/reference/azure-web-app-container-v1#troubleshooting)  
- [Deploy to App Service using Azure Pipelines](/azure/app-service/deploy-azure-pipelines)  
- [Deploy to Azure Web App for Containers](/azure/devops/pipelines/targets/webapp-on-container-linux)

## See related

- [Troubleshoot Azure Web App tasks and deployment issues](troubleshoot-azure-web-apps-tasks-deployments.md)
- [Issues with the service connection in the task](issues-service-connection-task.md)
- [Resource doesn't exist error with services deployment](resource-not-exist-error-services-deployment.md)
- [Failure scenarios related to Azure Web App tasks](failure-scenarios-related-azure-web-app-tasks.md)
