---
title: Initial debugging for issues related to Azure Web App and services
description: This article describes some initial debugging of issues related to Azure Web App service deployments from Azure DevOps Services.
ms.date: 04/27/2023
ms.custom: sap:Pipelines
ms.reviewer: 
ms.service: azure-devops
ms.subservice: ts-pipelines
---
# Initial debugging for issues related to Azure Web App and services

You can use this article as a reference for the initial debugging of issues related to Azure Web App service deployments from Azure DevOps Services. Many of these issues also apply to deploying other Azure services, especially those related to networking configuration.

> [!NOTE]
> Check [Status history](https://status.dev.azure.com/_history) to see if you may be impacted due to an outage in Azure DevOps Services.

## Common issues and solutions

- "I am seeing the error: "No package found with specified pattern in the task.""

  Verify that the package mentioned in the task is published as an artifact in the build or a previous stage and downloaded in the current job.  

- "My task fails with the error: "Publish using zip deploy option is not supported for MSBuild package type.""

  Web packages created using the MSBuild task (with default arguments) have a nested folder structure that can only be deployed correctly by Web Deploy. The publish-to-zip deployment option can't be used to deploy those packages. To convert the packaging structure, follow [these steps](/azure/devops/pipelines/tasks/deploy/azure-rm-web-app-deployment#error-publish-using-zip-deploy-option-is-not-supported-for-msbuild-package-type).  

- The task fails with a 5xx error code.

  - Check the [status of your Azure service](https://status.azure.com/status).

  - Also check the [Azure DevOps status page](https://status.dev.azure.com/_history) to see if any ongoing outage is related to your issue.

- A release hangs for a long time and then fails, a "503 service unavailable" error occurs, or the deployment history in the deployment logs fails to update.  

  These issues may occur when there's insufficient capacity on your App Service Plan. To resolve these issues, you can scale up the App Service instance to increase available CPU, RAM, and disk space or try with a different App Service plan. Also, check the Kudo logs from the Azure Web Apps side.

- Receiving errors related to the network not being reachable during deployment, for example, "Could not connect to the remote computer ('XXXXX.scm.azurewebsites.net')."  

  Review the following articles for firewall, proxy, and permissions (applicable for all platforms). These articles provide references for Microsoft-hosted and self-hosted agent scenarios.

  - [Communication with Azure Pipelines](/azure/devops/pipelines/agents/agents#communication-with-azure-pipelines)

  - [Agent Authentication and Authorization](https://github.com/Microsoft/azure-pipelines-agent/blob/master/docs/design/auth.md)

  - [Run a self-hosted agent behind a web proxy](/azure/devops/pipelines/agents/proxy)

  - [IPs and URLs that need to be unblocked in the firewall](/azure/devops/pipelines/agents/v2-windows#im-running-a-firewall-and-my-code-is-in-azure-repos-what-urls-does-the-agent-need-to-communicate-with)

  - [Permissions required for agent configuration](/azure/devops/pipelines/agents/v2-windows#permissions)  

- The task fails with the error: "Could not fetch access token for Azure. Verify if the Service Principal used is valid and not expired."

  > [!NOTE]
  > There might also be other scenarios when issues with the Azure service connection impact the deployment.

  - Verify the validity of the service principal used and that it's present in the app registration. For more information, see [Use Role-Based Access Control to manage access to your Azure subscription resources](/azure/role-based-access-control/role-assignments-portal).

  - Refer to the [troubleshooting doc for Azure RM service principal](/azure/devops/pipelines/release/azure-rm-endpoint).  

- "I am seeing an SSL error in the App Service or Web App deploy task."  

  To use a certificate in App Service, it must be signed by a trusted certificate authority. See [SSL errors](/azure/devops/pipelines/tasks/deploy/azure-rm-web-app-deployment#ssl-error) to resolve this error.  

- "I am seeing a Web Deploy Error in the App Service deploy task."  

  If you're using Web Deploy to deploy your app, in some error scenarios, Web Deploy will show an error code in the log. To troubleshoot a Web Deploy error, see [Web Deploy error codes](/iis/publish/troubleshooting-web-deploy/web-deploy-error-codes).  

- "I am seeing the error: "ERROR_FILE_IN_USE" while trying to deploy .NET apps to Web App on Windows."

  To resolve this error, ensure the **Rename locked files** and **Take App offline** options are enabled in the task. For zero downtime, use slot swap.  

- Web App deployment on Windows is successful, but the app is not working.  

  This might be because the *web.config* file isn't present in your app. To add a *web.config* file, follow [these steps](/azure/devops/pipelines/tasks/deploy/azure-rm-web-app#web-app-deployment-on-windows-is-successful-but-the-app-is-not-working).  

- Web App deployment on App Service Environment (ASE) is not working.  

  [Follow these steps](/azure/devops/pipelines/tasks/deploy/azure-rm-web-app#web-app-deployment-on-app-service-environment-ase-is-not-working) to ensure you're deploying correctly.  

- "I'm failing to deploy a Function App using the AzureRmWebAppDeployment task."

  Consider using the [Azure Functions v1 task](/azure/devops/pipelines/tasks/reference/azure-function-app-v1).

- "I need guidance on deploying an app to Azure Web App."  

  See the following tutorials about deploying apps of various languages to Azure Web App:  

  - [Python to Web App](/azure/devops/pipelines/ecosystems/python-webapp)  
  - [PHP to Web App](/azure/devops/pipelines/ecosystems/php-webapp)  
  - [Java to Web App](/azure/devops/pipelines/ecosystems/java-webapp)  
  - [JavaScript and Node.js to Web App](/azure/devops/pipelines/ecosystems/javascript)  

## Recommended documents

- [App Service Deploy task Troubleshooting](/azure/devops/pipelines/tasks/deploy/azure-rm-web-app-deployment#troubleshooting)  
- [Azure Web App task Troubleshooting](/azure/devops/pipelines/tasks/deploy/azure-rm-web-app#troubleshooting)  
- [Azure Web Apps for Container task Troubleshooting](/azure/devops/pipelines/tasks/deploy/azure-rm-web-app-containers#troubleshooting)  
- [Deploy to Linux Web App](/azure/devops/pipelines/targets/webapp-linux)  
- [Deploy to Windows Web App](/azure/devops/pipelines/targets/webapp)  
- [Deploy to Web App for Containers](/azure/devops/pipelines/targets/webapp-on-container-linux)  
- For service-impacting issues, see [Azure DevOps Services Status](https://status.dev.azure.com/)

## See related

- [Capture logs for further debugging with the tasks](logs-capture-further-debugging-tasks.md)
- [Failure scenarios related to Azure web app tasks](failure-scenarios-related-azure-web-app-tasks.md)
- [Issues with the service connection in the task](issues-service-connection-task.md)
- [Resource doesn't exist error with services deployment](resource-not-exist-error-services-deployment.md)
