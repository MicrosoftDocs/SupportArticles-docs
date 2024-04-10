---
title: Error when you use WCF Discovery over UDP
description: This article provides resolutions for the error that occurs when you use Windows Communication Foundation (WCF) support for WS-Discovery over UDP.
ms.date: 08/25/2020
ms.reviewer: rviana, jasonpa
---
# WCF Discovery over UDP causes high CPU utilization and network congestion

This article helps you resolve the error that occurs when you use Windows Communication Foundation (WCF) support for WS-Discovery over UDP.

_Original product version:_ &nbsp; Windows Communication Foundation  
_Original KB number:_ &nbsp; 2777305

## Symptoms

When using WCF support for WS-Discovery over UDP, you may see one or more of the following problems:

- An unexpected increase in CPU utilization on the server.
- Higher than expected multicast traffic.
- An unexpectedly large number of SOAP Fault messages being sent over the network in an environment with .NET 4.5 installed.

The problem may happen even if the service was not compiled to target .NET 4.5 but runs in an environment where .NET 4.5 is installed.

## Cause

These problems can occur for the following reasons:

1. Incorrect handling of unexpected message types on some of WCF Discovery's internal infrastructure endpoints.

2. The WCF service hosts multiple UDP Multicast Services where more than one service shares a given multicast address and port.

## Resolution

To resolve this issue, apply one of the updates that are described in the following Knowledge Base (KB) articles:

- [An update is available for the .NET Framework 4.5 in Windows 7 SP1, Windows Server 2008 R2 SP1, Windows Server 2008 SP2, and Windows Vista SP2: May 2013](https://support.microsoft.com/help/2805226)

- [An update is available for the .NET Framework 4.5 in Windows 8, Windows RT, and Windows Server 2012: May 2013](https://support.microsoft.com/help/2805227)

## Workaround

To work around these issues, please choose one of the following options:

- Workaround 1:

    Programmatically force the transport to use duplex channel, instead of the `IReplyChannel` that was introduced in 4.5. Following is a C# code sample to accomplish this on the service side (on the server). Using the following class, we can have a custom implementation of `CanBuildChannelListener` that returns false for `IReplyChannel`:

    ```csharp
    class DisableIReplyChannelShapeBindingElement : BindingElement
    {
        public override BindingElement Clone()
        {
            return this;
        }
        public override T GetProperty<T>(BindingContext context)
        {
            return null;
        }
        public override bool CanBuildChannelListener<TChannel>(BindingContext context)
        {
            if (typeof(TChannel) == typeof(IReplyChannel))
            {
                return false;
            }
            return context.CanBuildInnerChannelListener<TChannel>();
        }
    }
    ```

    By inserting this into the binding, your application can hide the fact that the UDP transport supports the `IReplyChannel` shape from the `announcementEndpoint`, which will avoid the problem. Following is a helper method that will be used later:

    ```csharp
    public static void DisableIReplyChannelShape(ServiceEndpoint endpoint)
    {
        CustomBinding customBinding = new CustomBinding(endpoint.Binding);
        //only do this if using the UdpTransport.
        if (customBinding.Elements.Find<UdpTransportBindingElement>()!= null)
        {
            customBinding.Elements.Insert(customBinding.Elements.Count - 1, new DisableIReplyChannelShapeBindingElement());
            endpoint.Binding = customBinding;
        }
    }
    ```

    You can stop your server-side code from sending the fault messages that are causing problems by doing the following to your `announcementEndpoint`:

    ```csharp
    UdpAnnouncementEndpoint announcementEndpoint = new UdpAnnouncementEndpoint();
    DisableIReplyChannelShape(announcementEndpoint);
    ```

- Workaround 2:

    If you do not have access to the server-side code, you can add the following on the client-side instead. Add this behavior to your client-side `UdpDiscoveryEndpoint`. This workaround must be applied to all Discovery clients whether they are compiled in .NET 4.5 or in .NET 4.0.

    > [!NOTE]
    > Microsoft strongly suggests Workaround 1 (server-side) as it prevents the issue from occurring on both WCF and non-WCF discovery clients. Workaround 2 is applicable only to WCF clients.

    The client code:

    ```csharp
    UdpDiscoveryEndpoint clientEndpoint = new UdpDiscoveryEndpoint();
    clientEndpoint.Behaviors.Add(new WorkaroundBehavior());
    var discoveryClient = new DiscoveryClient(clientEndpoint);
    ```

    The Class:

    ```csharp
    class WorkaroundBehavior : IEndpointBehavior
    {
        public void AddBindingParameters(ServiceEndpoint endpoint, BindingParameterCollection bindingParameters)
        {
        }
        public void ApplyClientBehavior(ServiceEndpoint endpoint, ClientRuntime clientRuntime)
        {
            if (clientRuntime == null)
            {
                throw new ArgumentNullException("clientRuntime");
            }
            clientRuntime.CallbackDispatchRuntime.UnhandledDispatchOperation.Invoker = new UnhandledActionOperationInvoker();
        }
        public void ApplyDispatchBehavior(ServiceEndpoint endpoint, EndpointDispatcher endpointDispatcher)
        {
        }
        public void Validate(ServiceEndpoint endpoint)
        {
        }
        class UnhandledActionOperationInvoker : IOperationInvoker
        {
            public bool IsSynchronous
            {
                get
                {
                    return true;
                }
            }
            public object[] AllocateInputs()
            {
                return new object[1];
            }
            public object Invoke(object instance, object[] inputs, out object[] outputs)
            {
                outputs = new object[0];
                return Message.CreateMessage(MessageVersion.None, string.Empty);
            }
            public IAsyncResult InvokeBegin(object instance, object[] inputs, AsyncCallback callback, object state)
            {
                throw new NotImplementedException();
            }
            public object InvokeEnd(object instance, out object[] outputs, IAsyncResult result)
            {
                throw new NotImplementedException();
            }
        }
    }
    ```

- Workaround 3:

    Use a unique multicast address and/or port for each service listening on the `SOAP.UDP` protocol.
