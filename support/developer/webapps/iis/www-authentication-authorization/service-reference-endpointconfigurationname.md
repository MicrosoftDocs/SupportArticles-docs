---
title: EndpointConfigurationName isn't updated
description: This article describes the problem where EndpointConfigurationName properties in the activities that are added to the workflow aren't updated when you use Update Service Reference feature to update the client proxy and the configuration file.
ms.date: 03/24/2020
ms.custom: sap:WWW authentication and authorization
ms.reviewer: weixi, lezha, smason
ms.technology: iis-www-authentication-authorization
---
# An update to a service reference doesn't update the EndpointConfigurationName property setting in the activities in a Windows Workflow Foundation 4.0 application

This article helps you resolve the problem where changes to a service reference don't update the `EndpointConfigurationName` property setting in the activities of in a Windows Workflow Foundation 4.0 application.

_Original product version:_ &nbsp; Windows Workflow Foundation 4.0  
_Original KB number:_ &nbsp; 2015763

## Symptoms

Consider the following scenario in Microsoft Visual Studio 2010:

- You have a Windows Workflow Foundation 4.0 project that uses **Add Service Reference** feature to consume services.
- You dropped some generated activities to add them as part of the workflow application. The endpoint name is changed in the referenced service. When this occurs, you use **Update Service Reference** feature to update the client proxy and the configuration file.

In this scenario, the `EndpointConfigurationName` properties in the activities that are added to the workflow aren't updated. If you try to build the project, the **Build Solution** operation successfully builds the project. However, users receive the following exception at runtime:

> Could not find endpoint element with name 'BindingType_ServiceContractName' and contract 'ServiceContractName' in the ServiceModel client configuration section. This might be because no configuration file was found for your application, or because no endpoint element matching this name could be found in the client element.

## Cause

This issue occurs because the endpoint name is changed by using one of the following two methods:

- You explicitly changed the endpoint name in the service configuration file.
- You didn't specify the endpoint name in the service configuration file.

By default, the `EndpointConfigurationName` that is generated on client side is *BindingType_ServiceContractName*. When you change the binding type or service contract name, the default endpoint name is updated accordingly.

## Resolution

To work around this issue, manually update the `EndpointConfigurationName` property for each existing activity. When you do this, use the same value as the endpoint name in the *App.config* file on the client.

## Best practice

To reduce the chance that you encounter this issue, specify the endpoint name in service configuration file instead of using the default name. If you do this, the endpoint name in client side is specified accordingly and is not changed when a service contract or a binding type is updated.

> [!NOTE]
>
> - This is recommended as best practice.
> - You can implement this practice only if you own the referenced service.
