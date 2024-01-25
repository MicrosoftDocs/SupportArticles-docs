---
title: WCF Service uses wrong impersonation context
description: This article provides resolutions for the problem that WCF Service operations invoked asynchronously via shared client proxies using impersonation may use the wrong impersonation context.
ms.date: 08/24/2020
---
# WCF Service operations invoked asynchronously via shared client proxies using impersonation may use the wrong impersonation context

This article helps you resolve the problem that Windows Communication Foundation (WCF) Service operations invoked asynchronously via shared client proxies using impersonation may use the wrong impersonation context.

_Original product version:_ &nbsp; Windows Communication Foundation  
_Original KB number:_ &nbsp; 2856654

## Symptoms

Consider the following scenario:

- Your client is using WCF proxies to invoke service operations.

- Your client relies on the client proxies to **auto-open**.

- Your client uses impersonation.

- Your client invokes the operations asynchronously.

- You reuse the same client proxy instance for multiple uses.

In this scenario, you may encounter situations where the service operation does not run under the intended impersonation context.

No exception is thrown or error logged due to the loss of impersonation context. Whether the operation succeeds or fails depends on what the service operation attempts to do. Likely failures observed will be authorization errors attempting to execute customer code inside the service operation.

One way to diagnose this issue has occurred is to check the contents of `ServiceSecurityContext.Current.WindowsIdentity` within the service operation. If the identity is intermittently different than you expect, you may be encountering this issue.

## Cause

Before a client proxy can invoke an operation, it must be opened. It can be opened explicitly from your own code or you can rely on WCF to **auto-open** for you.

The problem occurs because the **auto-open** required for asynchronous operations is itself done asynchronously. And when the same proxy is used for multiple asynchronous operations, all but the first must wait for the initial asynchronous operation to succeed. Depending on the threads that invoke these operations and timing, it is possible for the impersonation context present for the first **auto-open** to be lost.

## Resolution

The solution to this issue is straightforward: Do not rely on **auto-open** but instead explicitly open the client proxy yourself.

By opening the client proxy yourself, you assure the underlying connections are completely open in the correct impersonation context before the first operation is invoked.

Here is an example showing the explicit `client.Open()` recommended.

```csharp
public static void Main(string[] args)
{
    NetTcpBinding binding = new NetTcpBinding(SecurityMode.Transport);
    binding.Security.Transport.ClientCredentialType = TcpClientCredentialType.Windows;
    binding.Security.Transport.ProtectionLevel = ProtectionLevel.None;

    string address = "net.tcp://localhost:8887/EchoService/svc";
    Service1Client client = new Service1Client(binding, new EndpointAddress(address));

    // Explicit open is required when using async client operations with impersonation
    using (Impersonation p = new Impersonation("myDomain", "myUser", "myPassword"))
    {
        client.Open();
    }

    for (int i = 0; i < 10; ++i)
    {
        ThreadPool.QueueUserWorkItem((state) =>
        {
            using (Impersonation p = new Impersonation("myDomain", "myUser", "myPassword"))
            {
                client.BeginGetData(new GetDataRequest((int) state), (ar) =>
                {
                    GetDataResponse response = client.EndGetData(ar);
                    Console.WriteLine("Response was: '{0}'", response.GetDataResult);
                }, null);
            }
        }, i);
    }

    Console.WriteLine("Press ENTER...");
    Console.ReadLine();
    Environment.Exit(0);
}
```

## More information

Explicitly opening client proxies when they are shared and used asynchronously is considered a best practice for several reasons. You can learn more at [Best Practice: Always open WCF client proxy explicitly when it is shared](/archive/blogs/wenlong/best-practice-always-open-wcf-client-proxy-explicitly-when-it-is-shared).
