---
title: Error 25310 when creating a cluster
description: Fixes an issue in which you can't create a cluster with the recently created hosts and receive error 25310.
ms.date: 04/09/2024
ms.reviewer: wenca
---
# Creating a cluster in System Center 2012 Virtual Machine Manager fails with error 25310

This article helps you fix an issue in which you can't create a cluster with the recently created hosts and receive error 25310.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2680262

## Symptoms

After doing a bare metal deployment using System Center 2012 Virtual Machine Manager, you are unable to create a cluster with the recently created hosts. Attempting to do so fails with the following error message:

> Error (25310)  
> Unable to connect to the user host process.

## Cause

This occurs because the host is running out of resources to process the request. The event log will point to resource pools not available to process the request.

## Resolution

To resolve this issue, reboot the host prior to creating the cluster.

## More Information

A carmine trace will show something similar to:

> 1294 11:22:18.509 12-13-2011 HostHelper.cs(231) VMM service could not connect to the user host process. retrying after sleep. {00000000-0000-0000-0000-000000000000}  
> 1295 11:22:22.512 12-13-2011 HostHelper.cs(220) error while connecting to host. retying... {00000000-0000-0000-0000-000000000000}  
> 1296 11:22:22.512 12-13-2011 HostHelper.cs(220) System.ServiceModel.EndpointNotFoundException: There was no endpoint listening at net.pipe://localhost/pipe/A221BCB199BC4B74B6E5DBB176470CE5 that could accept the message. This is often caused by an incorrect address or SOAP action. See InnerException; if present; for more details. ---> System.IO.PipeException: The pipe endpoint 'net.pipe://localhost/pipe/A221BCB199BC4B74B6E5DBB176470CE5' could not be found on your local machine.  
> --- End of inner exception stack trace ---  
> Server stack trace:  
> at System.ServiceModel.Channels.PipeConnectionInitiator.GetPipeName(Uri uri)  
> at System.ServiceModel.Channels.NamedPipeConnectionPoolRegistry.NamedPipeConnectionPool.GetPoolKey(EndpointAddress address; Uri via)  
> at System.ServiceModel.Channels.CommunicationPool\`2.TakeConnection(EndpointAddress address; Uri via; TimeSpan timeout; TKey& key)  
> at System.ServiceModel.Channels.ConnectionPoolHelper.EstablishConnection(TimeSpan timeout)  
> at System.ServiceModel.Channels.ClientFramingDuplexSessionChannel.OnOpen(TimeSpan timeout)  
> at System.ServiceModel.Channels.CommunicationObject.Open(TimeSpan timeout)
> at System.ServiceModel.Channels.ServiceChannel.OnOpen(TimeSpan timeout)  
> at System.ServiceModel.Channels.CommunicationObject.Open(TimeSpan timeout)  
> at System.ServiceModel.Channels.ServiceChannel.CallOnceManager.CallOnce(TimeSpan timeout; CallOnceManager cascade)  
> at System.ServiceModel.Channels.ServiceChannel.EnsureOpened(TimeSpan timeout)  
> at System.ServiceModel.Channels.ServiceChannel.Call(String action; Boolean oneway; ProxyOperationRuntime operation; Object[] ins; Object[] outs; TimeSpan timeout)  
> at System.ServiceModel.Channels.ServiceChannelProxy.InvokeService(IMethodCallMessage methodCall; ProxyOperationRuntime operation)  
> at System.ServiceModel.Channels.ServiceChannelProxy.Invoke(IMessage message)Exception rethrown at [0]:  
> at System.Runtime.Remoting.Proxies.RealProxy.HandleReturnMessage(IMessage reqMsg; IMessage retMsg)  
> at System.Runtime.Remoting.Proxies.RealProxy.PrivateInvoke(MessageData& msgData; Int32 type)  
> at Microsoft.VirtualManager.VmmHelperHost.IHelperRemotedInterface.Connect()  
> at Microsoft.VirtualManager.VmmHelperHost.HostDuplexHelper\`3.CreateChannel(NetNamedPipeBinding namedPipeBinding; EndpointAddress endPointAddress; TimeSpan timeout)  
> at Microsoft.VirtualManager.VmmHelperHost.HostHelper\`2.ConnectToProcess(TimeSpan& timeout; String namedPipeName) {00000000-0000-0000-0000-000000000000}  
> 1297 11:22:22.512 12-13-2011 HostHelper.cs(231) VMM service could not connect to the user host process. retrying after sleep. {00000000-0000-0000-0000-000000000000}  
> 1298 11:22:22.826 12-13-2011 Host.cs(70) Starting VMM helper host with namedpipe net.pipe://localhost/pipe/A221BCB199BC4B74B6E5DBB176470CE5 for user CONTOSO\username {00000000-0000-0000-0000-000000000000}  
> 1299 11:22:22.867 12-13-2011 Host.cs(79) VMM helper host hosting class Microsoft.VirtualManager.Engine.Adhc.TestClusterService and exposing interface Microsoft.VirtualManager.Engine.Adhc.ITestCluster {00000000-0000-0000-0000-000000000000}  
> 1300 11:22:22.940 12-13-2011 Host.cs(105) VMM helper host starting WCF service {00000000-0000-0000-0000-000000000000}  
> 1301 11:22:22.959 12-13-2011 Host.cs(107) VMM helper host started WCF service {00000000-0000-0000-0000-000000000000}  
> 1302 11:22:27.513 12-13-2011 HostHelper.cs(347) Terminating the unresponsive process {00000000-0000-0000-0000-000000000000}  
> 1303 11:22:27.514 12-13-2011 HostHelper.cs(351) Terminating the unresponsive process : Success {00000000-0000-0000-0000-000000000000}  
> 1304 11:22:27.515 12-13-2011 RunningTaskDbWriter.cs(771) UpdateRunningStepDescription --> SubtaskID: 5b8a04f5-7807-4935-be51-60034520872e; Description Validate nodes for clustering {85cc103d-149c-4adb-bf16-219866fb082c}  
> 1305 11:22:27.515 12-13-2011 InstallClusterSubtask.cs(392) The cluster operation failed before cluster creation. cleaning up cluster in DB {00000000-0000-0000-0000-000000000000}  
> 1306 11:22:27.519 12-13-2011 InstallClusterSubtask.cs(392) Microsoft.VirtualManager.Utils.CarmineException: Unable to connect to the user host process.  
> retry the operation.  
> at Microsoft.VirtualManager.VmmHelperHost.HostHelper\`2.ConnectToProcess(TimeSpan& timeout; String namedPipeName)  
> at Microsoft.VirtualManager.VmmHelperHost.HostHelper\`2.CreateProcess(TimeSpan timeout)  
> at Microsoft.VirtualManager.VmmHelperHost.HostHelper\`2.CreateProcess()  
> at Microsoft.VirtualManager.Engine.Adhc.TestClusterSubtask.RunSubtask()  
> at Microsoft.VirtualManager.Engine.TaskRepository.SubtaskBase.Run()  
> at Microsoft.VirtualManager.Engine.Adhc.InstallClusterSubtask.RunClusterValidationOnHosts()  
> at Microsoft.VirtualManager.Engine.Adhc.InstallClusterSubtask.RunSubtask()*** Carmine error was: UserHostConnectFailed (25310) {00000000-0000-0000-0000-000000000000}  
> 1307 11:22:27.520 12-13-2011 UpdateServer.cs(212) ==>GetRootUpdateServer {00000000-0000-0000-0000-000000000000}
