---
title: Test agent configuration fails
description: This article provides resolutions for the error that occurs when you try to configure the test agent to talk to the controller service.
ms.date: 08/17/2020
ms.custom: sap:Test Plans
ms.reviewer: georgea
ms.service: azure-devops-server
ms.subservice: ts-test-plans
---
# Test agent configuration fails when you try to configure the test agent

This article helps you resolve the error that occurs when you try to configure the test agent to talk to the controller service.

_Original product version:_ &nbsp; Visual Studio Test Professional 2012, Visual Studio Test Professional 2010  
_Original KB number:_ &nbsp; 2823477

## Symptoms

Consider the following scenario:

- The Test Controller runs on a domain joined machine with a DNS suffix for the machine being `contoso.com`. The Test Agent runs on a workgroup machine and the DNS suffix for the workgroup machine is `fabrikaam.com`.

- The two machines are able to ping each other by using the full qualified domain names.

- Firewall exceptions are in place for required ports for the controller and agent services.

In the above scenario, the test agent configuration tool fails while trying to configure the agent to talk to the controller service. The test agent configuration logs as described in [How to enable test agent logs](/archive/blogs/aseemb/how-to-enable-test-agent-logs) show the following error:

```console
I, 2013/02/08, 11:18:22.791, CreateControllerObject: attempt 0, System.Net.Sockets.SocketException (0x80004005): No such host is known

Server stack trace:
at System.Net.Dns.GetAddrInfo(String name)
at System.Net.Dns.InternalGetHostByName(String hostName, Boolean includeIPv6)
at System.Net.Dns.GetHostAddresses(String hostNameOrAddress)
at System.Runtime.Remoting.Channels.RemoteConnection.CreateNewSocket()
at System.Runtime.Remoting.Channels.RemoteConnection.GetSocket()
at System.Runtime.Remoting.Channels.SocketCache.GetSocket(String machinePortAndSid, Boolean openNew)
at System.Runtime.Remoting.Channels.Tcp.TcpClientTransportSink.SendRequestWithRetry(IMessage msg, ITransportHeaders requestHeaders, Stream requestStream)
at System.Runtime.Remoting.Channels.Tcp.TcpClientTransportSink.ProcessMessage(IMessage msg, ITransportHeaders requestHeaders, Stream requestStream, ITransportHeaders& responseHeaders, Stream& responseStream)
at System.Runtime.Remoting.Channels.BinaryClientFormatterSink.SyncProcessMessage(IMessage msg)

Exception rethrown at [0]:
at System.Runtime.Remoting.Proxies.RealProxy.HandleReturnMessage(IMessage reqMsg, IMessage retMsg)
at System.Runtime.Remoting.Proxies.RealProxy.PrivateInvoke(MessageData& msgData, Int32 type)
at Microsoft.VisualStudio.TestTools.Controller.ControllerObject.Hello()
at Microsoft.VisualStudio.TestTools.ConfigCore.TestControllerHelper.CreateControllerObject(String controllerUri)
I, 2013/02/08, 11:18:22.918, CreateControllerObject: attempt 1, System.Net.Sockets.SocketException (0x80004005): No such host is known
```

## Cause

This issue can happen if:

1. We are providing fully qualified domain names for the test controller machine in the test controller URI on the test agent configuration tool.

2. The Test Agent and the Test Controller machines cannot communicate with each other by just using the machine host names, so something like foo instead of `foo.contoso.com`. A good test would be to just do ping the test agent machine host name from the test controller machine and vice-versa.

## Resolution

To resolve the issue, we need to append the DNS suffix of the domain for the controller machine to the TCP\IP settings for the NIC on the test agent machine and vice versa.

Steps(on the test agent machine):

1. Open the NIC\Lan card properties on the agent machine.

2. Select **Internet Protocol Version 4** (TCP/IP v4) and select **properties**.

3. In the **Internet Protocol Version 4** (TCP/IP v4) dialog box, on the **General** tab, click **Advanced**.

4. In the **Advanced TCP/IP Settings** dialog box, select the option **Append these DNS suffixes (in order)**.

5. Click **Add** and in the **TCP/IP Domain Suffix** dialog box, provide the DNS suffix for the test controller's domain and click **Add**.

6. Click **Ok** in the **Advanced TCP/IP Settings** dialog box.

7. Click **OK** in the **Internet Protocol Version 4** (TCP/IP v4) dialog box.

Repeat the same steps on the test controller machine.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
