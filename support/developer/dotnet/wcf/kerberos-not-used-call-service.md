---
title: Kerberos not used when you call a WCF service
description: This article provides resolutions for the issue where you are authenticated through NTLM instead of Kerberos and cannot delegate when you call a WCF service that uses net.tcp binding with transport security, windows transport credentials, and has protection level set to none.
ms.date: 08/24/2020
ms.reviewer: rviana, jasonpa
---
# Kerberos not used when you call a WCF service

This article helps you resolve the issue where you are authenticated through NTLM instead of Kerberos and cannot delegate when you call a WCF service that uses net.tcp binding with transport security, windows transport credentials, and has protection level set to **none**.

_Original product version:_ &nbsp; Windows Communication Foundation  
_Original KB number:_ &nbsp; 2970779

## Symptoms

Consider the following scenario:

- You have a WCF service that uses net.tcp binding with transport security, windows transport credentials, and has protection level set to **none** such as the following sample:

    ```xml
     <netTcpBinding>
       <binding name="NetTcpBindingConfig">
          <security mode="Transport">
             <transport clientCredentialType="Windows" protectionLevel="None" />
          </security>
       </binding>
    </netTcpBinding>
    ```

- You configure your endpoint and provide a valid identity by using the binding as follows:

    ```xml
     <endpoint
       address="net.tcp://srv1/Service/Service1.svc"
       binding="netTcpBinding"
       bindingConfiguration="NetTcpBindingConfig"
       contract="Contoso.IService1" behaviorConfiguration="NoNTLM"
       name="NetTcpContosoService">
       <identity>
          <servicePrincipalName value="WCFService/ContosoService" />
       </identity>
    </endpoint>
    (...)
    <behaviors>
       <endpointBehaviors>
          <behavior name="NoNTLM">
             <clientCredentials>
                <windows allowNtlm="false"/>
             </clientCredentials>
          </behavior>
       </endpointBehaviors>
    </behaviors>
    ```

- You create a proxy and call this WCF service.

In this scenario, you are authenticated through NTLM instead of Kerberos and cannot delegate. The portion calling the service resembles the following:

```csharp
Service1Client client = null;
try
{
    client = new Service1Client("NetTcpBindingConfig");
    string returnStr = client.GetData(5);
    Console.WriteLine(returnStr);
    client.Close();
}
catch(Exception ex)
{
    Console.WriteLine(ex.Message);
}
finally
{
    if(client != null)
    {
        client.Abort();
    }
}
```

If `System.Net` traces are enabled, it displays NTLM was used before trying to use Kerberos:

> System.Net.Sockets Verbose: 0 : [5964] DNS::GetHostEntry(srv1)  
DateTime=2014-05-09T12:57:41.3298728Z  
System.Net.Sockets Verbose: 0 : [5964] DNS::GetHostByName(srv1)  
DateTime=2014-05-09T12:57:41.3298728Z  
System.Net.Sockets Verbose: 0 : [5964] Exiting DNS::GetHostByName() -> IPHostEntry#14993092  
DateTime=2014-05-09T12:57:41.3298728Z  
System.Net.Sockets Verbose: 0 : [5964] Exiting DNS::GetHostEntry() -> IPHostEntry#14993092  
DateTime=2014-05-09T12:57:41.3298728Z
System.Net.Sockets Verbose: 0 : [5964] Socket#720107::Socket(AddressFamily#2)  
DateTime=2014-05-09T12:57:41.3298728Z  
System.Net.Sockets Verbose: 0 : [5964] Exiting Socket#720107::Socket()  
DateTime=2014-05-09T12:57:41.3298728Z  
System.Net.Sockets Verbose: 0 : [5964] Socket#720107::Connect(10.1.0.5:808#403439906)  
DateTime=2014-05-09T12:57:41.3298728Z  
System.Net.Sockets Information: 0 : [5964] Socket#720107 - Created connection from 10.1.0.10:46321 to 10.1.0.5:808.  
DateTime=2014-05-09T12:57:41.3454728Z  
System.Net.Sockets Verbose: 0 : [5964] Exiting Socket#720107::Connect()  
DateTime=2014-05-09T12:57:41.3454728Z  
System.Net.Sockets Verbose: 0 : [5964] Socket#720107::Send()  
DateTime=2014-05-09T12:57:41.3454728Z  
System.Net.Sockets Verbose: 0 : [5964] Data from Socket#720107::Send
DateTime=2014-05-09T12:57:41.3454728Z  
System.Net.Sockets Verbose: 0 : [5964] 00000000 : 00 01 00 01 02 02 31 6E-65 74 2E 74 63 70 3A 2F : ......1net.tcp:/  
DateTime=2014-05-09T12:57:41.3454728Z  
System.Net.Sockets Verbose: 0 : [5964] 00000010 : 2F 73 72 76 31 2F 53 65-72 76 69 63 65 2F 53 65 : /srv1/Service/Se  
DateTime=2014-05-09T12:57:41.3454728Z  
System.Net.Sockets Verbose: 0 : [5964] 00000020 : 72 76 69 63 65 31 2E 73-76 63 03 08 00 00 00 00 : rvice1.svc......  
DateTime=2014-05-09T12:57:41.3454728Z
System.Net.Sockets Verbose: 0 : [5964] Exiting Socket#720107::Send() -> Int32#58  
DateTime=2014-05-09T12:57:41.3454728Z  
System.Net.Sockets Verbose: 0 : [5964] Socket#720107::Send()  
DateTime=2014-05-09T12:57:41.3610728Z  
System.Net.Sockets Verbose: 0 : [5964] Data from Socket#720107::Send  
DateTime=2014-05-09T12:57:41.3610728Z  
System.Net.Sockets Verbose: 0 : [5964] 00000000 : 09 15 61 70 70 6C 69 63-61 74 69 6F 6E 2F 6E 65 : ..application/ne  
DateTime=2014-05-09T12:57:41.3610728Z  
System.Net.Sockets Verbose: 0 : [5964] 00000010 : 67 6F 74 69 61 74 65 : gotiate  
DateTime=2014-05-09T12:57:41.3610728Z  
System.Net.Sockets Verbose: 0 : [5964] Exiting Socket#720107::Send() -> Int32#23  
DateTime=2014-05-09T12:57:41.3610728Z  
System.Net.Sockets Verbose: 0 : [5964] Socket#720107::Receive()  
DateTime=2014-05-09T12:57:41.3610728Z  
System.Net.Sockets Verbose: 0 : [5964] Data from Socket#720107::Receive  
DateTime=2014-05-09T12:57:42.1098728Z  
System.Net.Sockets Verbose: 0 : [5964] 00000000 : 0A : .  
DateTime=2014-05-09T12:57:42.1098728Z  
System.Net.Sockets Verbose: 0 : [5964] Exiting Socket#720107::Receive() -> Int32#1  
DateTime=2014-05-09T12:57:42.1098728Z  
System.Net Information: 0 : [5964] Enumerating security packages:  
DateTime=2014-05-09T12:57:42.1254728Z  
System.Net Information: 0 : [5964] Negotiate  
DateTime=2014-05-09T12:57:42.1254728Z  
System.Net Information: 0 : [5964] NegoExtender  
DateTime=2014-05-09T12:57:42.1254728Z  
System.Net Information: 0 : [5964] Kerberos  
DateTime=2014-05-09T12:57:42.1254728Z  
System.Net Information: 0 : [5964] NTLM  
DateTime=2014-05-09T12:57:42.1254728Z  
System.Net Information: 0 : [5964] Schannel  
DateTime=2014-05-09T12:57:42.1254728Z  
System.Net Information: 0 : [5964] Microsoft Unified Security Protocol Provider  
DateTime=2014-05-09T12:57:42.1254728Z  
System.Net Information: 0 : [5964] WDigest  
DateTime=2014-05-09T12:57:42.1254728Z  
System.Net Information: 0 : [5964] TSSSP  
DateTime=2014-05-09T12:57:42.1254728Z  
System.Net Information: 0 : [5964] pku2u  
DateTime=2014-05-09T12:57:42.1254728Z  
System.Net Information: 0 : [5964] CREDSSP  
DateTime=2014-05-09T12:57:42.1254728Z  
System.Net Information: 0 : [5964] AcquireDefaultCredential(package = NTLM, intent = Outbound)
DateTime=2014-05-09T12:57:42.1254728Z  
System.Net Information: 0 : [5964] InitializeSecurityContext(credential = System.Net.SafeFreeCredential_SECURITY,  
context = (null), targetName = WCFService/ContosoService, inFlags = Connection, AcceptIntegrity)
DateTime=2014-05-09T12:57:42.1254728Z

> [!IMPORTANT]
> Even though identity is necessary in the endpoint alongside the configuration of the Service Principal Name (SPN) to enable Kerberos delegation in net.tcp, this article will not resolve this. It will assume Kerberos configuration has finished correctly.

## Cause

If protection level is set to **None** in the binding, NTLM will be used even if the behavior does not allow NTLM.

## Resolution

To resolve this issue, use protection level Sign or `EncryptAndSign` to enable Kerberos authentication. The following sample is the updated binding configuration:

```xml
<netTcpBinding>
   <binding name="NetTcpBindingConfig">
      <security mode="Transport">
         <transport clientCredentialType="Windows" protectionLevel="EncryptAndSign" />
      </security>
   </binding>
</netTcpBinding>
```

## More information

- [Understanding Protection Level](/dotnet/framework/wcf/understanding-protection-level)

- [Chapter 9: Intranet - Web to Remote WCF Using Transport Security (Original Caller, TCP)](/previous-versions/msp-n-p/ff648998(v=pandp.10))
