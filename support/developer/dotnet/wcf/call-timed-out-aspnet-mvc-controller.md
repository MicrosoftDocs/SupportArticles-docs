---
title: WCF calls timed out in ASP.NET MVC controller
description: This article provides resolutions for the WCF problem where calls timed out if you create the WCF service host inside ASP.NET MVC controller.
ms.date: 08/24/2020
ms.reviewer: wzhao, amitap
---
# The WCF calls timed out if you create the WCF service host inside ASP.NET MVC controller

This article helps you resolve the Windows Communication Foundation (WCF) problem where calls timed out if you create the WCF service host inside ASP.NET Model View Controller (MVC) controller.

_Original product version:_ &nbsp; Windows Communication Foundation 4.0, Microsoft .NET Framework 4.0  
_Original KB number:_ &nbsp; 2621732

## Symptoms

The WCF call timed out if the service host was created inside ASP.NET MVC controller.

## Cause

This is a deadlock scenario, which the WCF client call originates from ASP.NET MVC controller. And, the WCF service host was created in the ASP.NET MVC controller as well.

Here is a sample code, which can reproduce this issue. Let we say, the application was hosted at `https://localhost/wcfselfhostinmvc`. Then the requests to `https://mywebsite/wcfselfhostinmvc/home/index` always timed out.

```aspx-csharp
public class HomeController : Controller  
{  
    private static ServiceHost SvcHost = null;  
    public ActionResult Index()  
    {  
        //Create the service host  
        if (null == SvcHost)  
        {  
        SvcHost = new ServiceHost(typeof(HelloWorld));  
        SvcHost.Open();  
    }  

    //Create the Client  
    EndpointAddress address = new EndpointAddress("net.pipe://localhost/WCFSelfHostInMVC/HelloWorld");  
    NetNamedPipeBinding binding = new NetNamedPipeBinding();  
    binding.Security.Mode = NetNamedPipeSecurityMode.None;  
    ChannelFactory<IHelloWorld> factory = new  
    ChannelFactory<IHelloWorld>(binding, address);  
    IHelloWorld channel = factory.CreateChannel();  
    //This call always timed out  
    ViewBag.Message = channel.DoWork();  
    return View();  
}  
```

This was due to a deadlock related to `AspNetSynchronizationContext` object. The WCF client thread (MVC thread) was holding the lock of `AspNetSynchronizationContext` as it is an ASP.NET request and it was waiting the response of WCF service call. However, the WCF service thread requires lock for the `AspNetSynchronizationContext` in order to process the WCF request.

The reasons WCF uses the `AspNetSynchronizationContext` are:

1. The `ServiceBehaviorAttribute UseSynchronizationContext` is set to **true** (by default).
2. The WCF service host is created under ASP.NET context (As the code demoed, it was created inside the MCV controller.).

## Resolution

There are several workarounds available:

- Setting `ServiceBehaviorAttribute UseSynchronizationContext` to **false**.

- Creating the service host in the **Application_Start**.

- Using .SVC file to create/activate the service host.

## More information

- [ASP.NET MVC Pattern](https://dotnet.microsoft.com/apps/aspnet/mvc).

- [ServiceBehaviorAttribute.UseSynchronizationContext Property](/dotnet/api/system.servicemodel.servicebehaviorattribute.usesynchronizationcontext).

- [Default Service Behavior](/dotnet/framework/wcf/samples/default-service-behavior).
