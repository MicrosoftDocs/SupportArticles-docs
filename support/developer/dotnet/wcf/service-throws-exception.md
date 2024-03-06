---
title: .NET 4.5 WCF service throws exception
description: This article provides resolutions for the exception AddressAlreadyInUseException that occurs when .NET 4.0 Windows Communication Foundation service is moved to .NET 4.5.
ms.date: 08/24/2020
ms.reviewer: piyushjo
---
# .NET 4.0 WCF service throws AddressAlreadyInUseException when moved to .NET 4.5

This article helps you resolve the exception AddressAlreadyInUseException that occurs when .NET 4.0 Windows Communication Foundation (WCF) service is moved to .NET 4.5.

_Original product version:_ &nbsp; Windows Communication Foundation  
_Original KB number:_ &nbsp; 2773443

## Symptoms

Consider the following scenario:

You have a .NET 4.0 WCF service configured with a `NetTcpBinding` and an endpoint sharing a single port and explicitly configuring `listenBacklog` or `maxConnections` on the `netTcpBinding` to the default values of **10**. An example of this configuration is as follows:

```xml
<system.serviceModel>
   <services>
      <service name="MyAssembly.MyNamespace.MyService" behaviorConfiguration="MEX">
         <endpoint address="net.tcp://localhost:56543/MyService"
            binding="netTcpBinding" contract="MyAssembly.MyNamespace.MyServiceInterface"
            bindingConfiguration="NetTcpBindingConfiguration" />
         <endpoint address="net.tcp://localhost:56543/MEX" 
            binding="mexTcpBinding" contract="IMetadataExchange" />
      </service>
   </services>
   <bindings>
      <netTcpBinding>
         <binding name="NetTcpBindingConfiguration" listenBacklog="10" maxConnections="10" >
         </binding>
      </netTcpBinding>
   </bindings>
   <behaviors>
      <serviceBehaviors>
         <behavior name="MEX">
            <serviceMetadata/>
         </behavior>
      </serviceBehaviors>
   </behaviors>
</system.serviceModel>
```

In this scenario, you may receive an `AddressAlreadyInUseException` when the application is moved to .NET 4.5. The exception is similar to the following:

> System.ServiceModel.AddressAlreadyInUseException: There is already a listener on IP endpoint 0.0.0.0:xxxx.
This could happen if there is another application already listening on this endpoint or if you have multiple service endpoints in your service host with the same IP endpoint but with incompatible binding configurations.
---> System.Net.Sockets.SocketException: Only one usage of each socket address (protocol/network address/port) is normally permitted
at System.Net.Sockets.Socket.DoBind(EndPoint endPointSnapshot, SocketAddress socketAddress)
at System.Net.Sockets.Socket.Bind(EndPoint localEP)
at System.ServiceModel.Channels.SocketConnectionListener.Listen()
--- End of inner exception stack trace ---
at System.ServiceModel.Channels.SocketConnectionListener.Listen()
at System.ServiceModel.Channels.BufferedConnectionListener.Listen()
at System.ServiceModel.Channels.ExclusiveTcpTransportManager.OnOpen()
at System.ServiceModel.Channels.TransportManager.Open(TransportChannelListener channelListener)
at System.ServiceModel.Channels.TransportManagerContainer.Open(SelectTransportManagersCallback selectTransportManagerCallback)
at System.ServiceModel.Channels.TransportChannelListener.OnOpen(TimeSpan timeout)
at System.ServiceModel.Channels.ConnectionOrientedTransportChannelListener.OnOpen(TimeSpan timeout)
at System.ServiceModel.Channels.TcpChannelListener`2.OnOpen(TimeSpan timeout)
at System.ServiceModel.Channels.CommunicationObject.Open(TimeSpan timeout)
at System.ServiceModel.Dispatcher.ChannelDispatcher.OnOpen(TimeSpan timeout)
at System.ServiceModel.Channels.CommunicationObject.Open(TimeSpan timeout)
at System.ServiceModel.ServiceHostBase.OnOpen(TimeSpan timeout)
at System.ServiceModel.Channels.CommunicationObject.Open(TimeSpan timeout)

## Cause

WCF does not support service endpoint with `NetTcpBinding` and mex endpoint with `mexTcpBinding` be on the same port yet having differently configured `listenBacklog` and `maxConnections`. If you configured your 4.0 service to have the `listenBacklog` and/or `maxConnections` to be **10**, it worked because these defaults were the same for both NetTcp and `mexTcpBinding`. However in 4.5 to simplify the quotas, these were increased to be a multiple of the processor count (12 * processor count) unless explicitly configured. Therefore when this 4.0 service is moved to 4.5 framework, the defaults change implicitly to the new values for the endpoint where they were not explicitly configured leading to a mismatch with these values for the endpoint where they are explicitly configured causing the `AddressAlreadyInUseException`.

## Resolution

To resolve this issue, apply one of the updates that are described in the following Knowledge Base (KB) articles:

- [An update is available for the .NET Framework 4.5 in Windows 7 SP1, Windows Server 2008 R2 SP1, Windows Server 2008 SP2, and Windows Vista SP2: May 2013](https://support.microsoft.com/help/2805226)

- [An update is available for the .NET Framework 4.5 in Windows 8, Windows RT, and Windows Server 2012: May 2013](https://support.microsoft.com/help/2805227)

> [!NOTE]
> For more information about this issue, see Issue 2 in the [WCF](https://support.microsoft.com/help/2805227) section.

## Workaround

To work around this issue, choose one of the following options:

1. Remove the explicit configuration for `listenBacklog` and `maxConnections` and restart the service.

2. Host the service endpoint with `netTcpBinding` and mex endpoint with `mexTcpBinding` on different ports.

## More information

For more information on hosting the service endpoint with `netTcpBinding` and mex endpoint with `mexTcpBinding` on different ports, see [WCF Troubleshooting Quickstart](/dotnet/framework/wcf/wcf-troubleshooting-quickstart).
