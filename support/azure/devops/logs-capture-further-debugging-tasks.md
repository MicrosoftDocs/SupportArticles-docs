---
title: Capture logs for further debugging with the tasks
description: This article describes steps to capture debug logs for deeper investigation with the tasks.
ms.date: 04/24/2023
ms.custom: sap:Pipelines
ms.reviewer: 
ms.service: azure-devops
ms.subservice: ts-pipelines
---
# Capture logs for further debugging with the tasks

To capture debug logs for deeper investigation with the tasks, follow these steps:

1. Enable debug logs by setting [system.debug](/azure/devops/pipelines/build/variables#systemdebug) to **True** in the pipeline.

1. If possible, enable verbose logging from the Azure service side.

1. Review Azure services related details like networking to see if it's restricted for public network access, if IPs are open for public network access, or if other network configurations may impact the issue. Also verify the resource group name and region of the service.

1. If you noticed that the issue started happening suddenly, review the success and failure logs to check if there were any changes to the task version or agent version.

1. If you're using the Microsoft hosted agent, check the [runner-images](https://github.com/actions/runner-images) documentation for any recent updates related to the Azure module that might have broken the pipeline.

1. Check the [Azure DevOps status history](https://status.dev.azure.com/_history) and the [Azure status history](https://status.azure.com/status/history/) to find out whether there are any outages.

## See related

- [Failure scenarios related to Azure web app tasks](failure-scenarios-related-azure-web-app-tasks.md)
- [Initial debugging for Azure Web App and services related issues](initial-debugging-azure-web-app-services.md)
- [Issues with the service connection in the task](issues-service-connection-task.md)
- [Resource doesn't exist error with services deployment](resource-not-exist-error-services-deployment.md)
