---
title: Pre-compiled WCF service activation fails
description: A pre-compiled workflow service wrapped with a .svc file may fail activation when the service path contains non-English characters. This article provides a resolution.
ms.date: 03/24/2020
---
# Service activation may fail when a pre-compiled WCF workflow service that is wrapped together with a .svc file is hosted

This article helps you resolve the problem where the service activation may fail when a pre-compiled Windows Communication Foundation (WCF) workflow service that is wrapped together with a .svc file is hosted.

_Original product version:_ &nbsp; Windows Workflow Foundation 4.0  
_Original KB number:_ &nbsp; 2286155

## Symptoms

When a pre-compiled WCF workflow service that is wrapped together with a .svc file is hosted, the service activation may fail with an exception error.

## Cause

This problem may occur when the service path contains non-English characters. For example, the following service path may cause this problem:  
application_name+directory_name+file_name

## Workaround

To work around this problem, use configuration-based activation.

For example, consider that you have an application and a pre-compiled WCF workflow service such as `CalculatorService` that is wrapped together in the *Service.svc* file in the following way:

```xml
<% @ServiceHost
language=c#
Factory="System.ServiceModel.Activities.Activation.WorkflowServiceHostFactory,Service="CalculatorService"%>
```

When `CalculatorService` is hosted, the service activation may fail with an exception error.

To work around this problem, add a part that resembles the following example to the application to root *Web.config* file:

```xml
<System.serviceModel>
    <serviceHostingEnvironment>
        <serviceActivations>
            <add relativeAddress="~/service.svc" service="CalculatorService"
              factory="System.ServiceModel.Activities.Activation.WorkflowServiceHostFactory"/>
        </serviceActivations>
    </serviceHostingEnvironment>
</system.serviceModel>
```

## More information

- [Configuration-Based Activation](/previous-versions/dotnet/netframework-4.0/dd807499(v=vs.100))

- [Configuration-Based Activation in IIS and WAS](/dotnet/framework/wcf/feature-details/configuration-based-activation-in-iis-and-was)
