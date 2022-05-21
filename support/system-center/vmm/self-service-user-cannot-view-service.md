---
title: Self-service users can't view a service on App Controller
description: Fixes an issue where a self-service user receives the Retrieved data is incomplete warning when they view a service on System Center 2012 App Controller.
ms.date: 08/18/2020
ms.reviewer: jeffpatt
---
# Retrieved data is incomplete warning when a self-service user views a service on App Controller

This article helps you fix an issue where a self-service user receives the **Retrieved data is incomplete** warning when they view a service on System Center 2012 App Controller.

_Original product version:_ &nbsp; Microsoft System Center 2012 App Controller  
_Original KB number:_ &nbsp; 2709415

## Symptoms

On System Center 2012 App Controller, a self-service user is unable to view a service that includes a computer tier with a load balancer. When the user attempts to view the service in App Controller, they receive a **Retrieved data is incomplete** warning. Viewing the details of the warning displays the following message:

> Category: Warning  
> Message: Retrieved data is incomplete.  
> Details: Category: Critical  
> Message: Microsoft.SystemCenter.CloudManager.Providers.ProviderException  
> Description: An unexpected error from VMM was encountered while processing the request.  
> Details: Category: Critical  
> Message: 11418-ObjectsInaccessible  
> Description: You do not have permission to access one or more of the objects required by this operation.  
> Web error status: UnknownError  
> Web response description: Internal Server Error  
> Web response status code: InternalServerError

## Cause

This is a known issue in System Center 2012 App Controller.

## Resolution

To resolve this issue, install [Update Rollup 2 for System Center 2012](https://support.microsoft.com/help/2706783).

## Workaround

To work around this issue, perform one of the following steps:

- To view the service in App Controller, log on to App Controller using an account that's a member of the Administrators role.
- To view the service as a self-service user, use the Virtual Machine Manager console.
