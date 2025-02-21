---
title: Errors occur when you use Web Deploy
description: This article provides resolutions for the unexpected error that occurs when you perform Web Deploy operations remotely through IIS Manager and use WMSVC.
ms.date: 12/16/2024
ms.custom: sap:Deployment and Migration\Windows Management Service (WMSVC)
ms.reviewer: zixie
---
# Errors when you use the Web Deployment tool as a delegated user over a remote IIS manager connection

This article helps you resolve an unexpected error that occurs when you use the Web Deployment Tool (Web Deploy) as a delegated user over a remote Microsoft Internet Information Services (IIS) manager connection via the Web Management Service (WMSVC).

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2023855

## Symptoms

When you perform Web Deploy operations remotely through IIS Manager and use the Web Management Service (WMSVC), you might receive the following error message:

> An error occurred when the request was processed on the remote computer.  
> Attempted to perform an unauthorized operation.

## Cause

The problem occurs because the user hasn't been granted permissions to perform the action for the specified provider. The server administrator has to determine the provider and user that are affected, the permissions that are necessary (for example, Read or Write), and the path that is being used.  

## Resolution

The resolution varies depending on the message returned and the provider specified. Consult the following resources for instrumentation to help diagnose the problem:

- [Configuring Web Management Service Logging and Tracing](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee461173(v=ws.10))
- [Process Monitor](/sysinternals/downloads/procmon) can assist with File System access issues.

The following common issues might be met in this scenario:  

## 401 unauthorized when connecting to a Web site

**Possible causes**: This error comes from WMSVC and is usually an error with a username or password, or because the user doesn't have access to the web site.

**Resolution**: Verify the username and password and that the user has access to the web site.

## Server error when importing or exporting an application

**Possible causes**: This error comes from the Web Deployment Handler and is usually a problem with the deployment rules. Since the user has connected successfully, it isn't an issue with WMSVC. A deployment rule has a typo, the user perform deployment might not be authorized, or the RunAs identity might not have required access permissions.

**Resolution**: [Configuring Web Management Service Logging and Tracing](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee461173(v=ws.10)) and review the logs to identify the failure.

- Look for entries in the logs that contain failures such as:

    > Details: No rule was found that could authorize user server1\siteowner, provider appPoolConfig, operation Read, path DefaultAppPool. In this case, the provider appPoolConfig isn't authorized and the user tried to use a provider for which the user didn't have permissions.
- Another common error is if the RunAs user that is being used to create applications doesn't have proper access to configuration. In this case, Process Monitor is a useful tool for determining where an access denied error might be coming from.

## References

- [Web Deployment Tool](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd568996(v=ws.10))
- [Configure the Web Deployment Handler](/iis/publish/using-web-deploy/configure-the-web-deployment-handler)
- [Taking Web Applications Offline with Web Deploy](/aspnet/web-forms/overview/deployment/advanced-enterprise-web-deployment/taking-web-applications-offline-with-web-deploy)
