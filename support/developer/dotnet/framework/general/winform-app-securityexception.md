---
title: Windows Forms app throws SecurityException
description: You have a Windows Forms application that uses the System.Net.HttpWebRequest class to send HTTP requests to a server (even calling a WebService). You experience that the application will intermittently throw a System.Security.SecurityException.
ms.date: 05/08/2020
ms.reviewer: pphadke, chrross
---
# A System.Security.SecurityException is thrown when using the System.Net.HttpWebRequest class from a Windows Forms application based on .NET Framework 2.0 or 3.5 SP1

This article helps you resolve the `System.Security.SecurityException` that's thrown when you use the `System.Net.HttpWebRequest` class from a Windows Forms application based on Microsoft .NET Framework 3.5 SP1.

_Original product version:_ &nbsp; Microsoft .NET Framework 3.5 Service Pack 1  
_Original KB number:_ &nbsp; 2512713

## Symptoms

You're using the `System.Net.HttpWebRequest` class from a Windows Forms application based on Microsoft .NET Framework 3.5 Service Pack 1 in a synchronous way. Specifically, this code is running on the main or UI thread. Your Windows Forms application throws an intermittent exception of type `System.Security.SecurityException` that has a message similar to the following:

> Request for the permission of type 'System.Security.Permissions.UIPermission, mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089' failed.

The exception will show a faulting callstack similar to the following:

```console
0:000> !clrstack
ESP EIP
<<ESP>> <<EIP>> System.Threading.WaitHandle.WaitOneNative(Microsoft.Win32.SafeHandles.SafeWaitHandle, UInt32, Boolean, Boolean)
<<ESP>> <<EIP>> System.Threading.WaitHandle.WaitOne(Int64, Boolean)
<<ESP>> <<EIP>> System.Threading.WaitHandle.WaitOne(Int32, Boolean)
<<ESP>> <<EIP>> System.Net.NetworkAddressChangePolled.CheckAndReset()
<<ESP>> <<EIP>> System.Net.NclUtilities.get_LocalAddresses()
<<ESP>> <<EIP>> System.Net.WebProxyScriptHelper.myIpAddress()
.........
.........
<<ESP>> <<EIP>> System.Net.WebProxyScriptHelper+MyMethodInfo.Invoke(System.Object, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo)
<<ESP>> <<EIP>> Microsoft.JScript.LateBinding.CallOneOfTheMembers(System.Reflection.MemberInfo[], System.Object[], Boolean, System.Object, System.Reflection.Binder, System.Globalization.CultureInfo, System.String[], Microsoft.JScript.Vsa.VsaEngine, Boolean ByRef)
<<ESP>> <<EIP>> Microsoft.JScript.LateBinding.Call(System.Reflection.Binder, System.Object[], System.Reflection.ParameterModifier[], System.Globalization.CultureInfo, System.String[], Boolean, Boolean, Microsoft.JScript.Vsa.VsaEngine)
<<ESP>> <<EIP>> Microsoft.JScript.LateBinding.Call(System.Object[], Boolean, Boolean, Microsoft.JScript.Vsa.VsaEngine).........
.........
<<ESP>> <<EIP>> Microsoft.JScript.JSMethodInfo.Invoke(System.Object, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo)
<<ESP>> <<EIP>> Microsoft.JScript.FunctionObject.Call(System.Object[], System.Object, Microsoft.JScript.ScriptObject, Microsoft.JScript.Closure, System.Reflection.Binder, System.Globalization.CultureInfo)
<<ESP>> <<EIP>> Microsoft.JScript.Closure.Call(System.Object[], System.Object, System.Reflection.Binder, System.Globalization.CultureInfo)
<<ESP>> <<EIP>> Microsoft.JScript.LateBinding.CallValue(System.Object, System.Object[], Boolean, Boolean, Microsoft.JScript.Vsa.VsaEngine, System.Object, System.Reflection.Binder, System.Globalization.CultureInfo, System.String[])
<<ESP>> <<EIP>> Microsoft.JScript.LateBinding.CallValue(System.Object, System.Object, System.Object[], Boolean, Boolean, Microsoft.JScript.Vsa.VsaEngine)
.........
.........
<<ESP>> <<EIP>> System.Reflection.MethodBase.Invoke(System.Object, System.Object[])
<<ESP>> <<EIP>> System.Net.VsaWebProxyScript.CallMethod(System.Object, System.String, System.Object[])
<<ESP>> <<EIP>> System.Net.VsaWebProxyScript.Run(System.String, System.String)
.........
.........
<<ESP>> <<EIP>> System.Net.IWebProxyScript.Run(System.String, System.String)
<<ESP>> <<EIP>> System.Net.AutoWebProxyScriptEngine.GetProxies(System.Uri, Boolean, System.Net.AutoWebProxyState ByRef, Int32 ByRef)
<<ESP>> <<EIP>> System.Net.WebProxy.GetProxiesAuto(System.Uri, System.Net.AutoWebProxyState ByRef, Int32 ByRef)
<<ESP>> <<EIP>> System.Net.ProxyScriptChain.GetNextProxy(System.Uri ByRef)
<<ESP>> <<EIP>> System.Net.ProxyChain+ProxyEnumerator.MoveNext()
<<ESP>> <<EIP>> System.Net.ServicePointManager.FindServicePoint(System.Uri, System.Net.IWebProxy, System.Net.ProxyChain ByRef, System.Net.HttpAbortDelegate ByRef, Int32 ByRef)
<<ESP>> <<EIP>> System.Net.HttpWebRequest.FindServicePoint(Boolean)
<<ESP>> <<EIP>> System.Net.HttpWebRequest.GetRequestStream(System.Net.TransportContext ByRef)
<<ESP>> <<EIP>> System.Net.HttpWebRequest.GetRequestStream().........
.........
<<ESP>> <<EIP>> YourApplicationFunction.....
.........
.........
```

## Cause

When the `System.Net.HttpWebRequest` class is run from the main thread, which is also the User Interface (UI) thread, it may need to run the WPAD (Web Proxy Automatic Detection) protocol to detect whether a proxy is required for reaching the destination URL. During this process, `System.Net` downloads and compiles the PAC (Proxy Auto-Configuration) script in memory and tries to execute the `FindProxyForURL` function as per the PAC specification.

When doing so, `System.Net` creates an internal application domain inside the application that runs with minimal permissions and most importantly, it doesn't grant the UI permission to this new application domain. The evaluation of a proxy and running the `FindProxyForURL` JavaScript function happens in the context of this new application domain and during this process `System.Net` may need to run several helper functions as per the PAC specification such as `isInNet`, `dnsResolve`, `myIpAddress` to compute the proxy.

For example, when running the `myIpAddress` function `System.Net` will try to evaluate the current IP Address of the current machine and at some point it may have to use the `System.Threading.WaitHandle.WaitOne()` function call. When this `System.Threading.WaitHandle.WaitOne()` function is called from the main or UI thread, this call will keep processing window messages while it's waiting.

If the window message gets processed during the `WaitOne()` call, the .NET framework Common Language Runtime (CLR) will make a full stack check and demand the UI permission. If it finds any mismatch in the permissions, a `System.Security.SecurityException` is thrown.

## Resolution

This behavior is by design.

To work around this issue, you can either switch to using the `System.Net.HttpWebRequest` class asynchronously or you can still use the synchronous approach, but run it from a background thread or a non-UI thread. That way the window process will have free reign of the UI thread without having to interrupt wait calls in a different application domain.

Another approach that you can use is to keep the same code as before, but instead of having `System.Net` run the automatic proxy detection on the main thread, you can create a new thread and try running the `System.Net.WebProxy.GetProxy` function on this background thread and let the background thread perform the automatic Proxy detection. Once the background thread retrieves the address of a proxy server, you can set the `Proxy` property of the `HttpWebRequest` object, and set it to a fixed proxy. This will prevent the automatic proxy detection on the main thread and will not throw the exception.

If your environment has a fixed proxy configured, you can turn off the automatic proxy detection completely, by adding the following configuration settings in your application configuration file:

```xml
<system.net>
    <defaultProxy>
        <proxy autoDetect="False" usesystemdefault="False" proxyaddress="http://yourProxy:yourProxyPort"/>
    </defaultProxy>
</system.net>
```

> [!NOTE]  
> Although running synchronous HTTP requests using the `System.Net.HttpWebRequest` class should work fine in most scenarios, we don't recommend running synchronous network operations such as sending HTTP requests from the main or UI thread due to possible delays encountered during network operations (such as IP Address or DNS resolution, Proxy detection etc). It is best to run such synchronous requests from a background thread or run the requests asynchronously.

## More information

- [HttpWebRequest.BeginGetResponse(AsyncCallback, Object) Method](/dotnet/api/system.net.httpwebrequest.begingetresponse?&view=netcore-3.1&preserve-view=true)
- [WebProxy.GetProxy(Uri) Method](/dotnet/api/system.net.webproxy.getproxy?&view=netcore-3.1&preserve-view=true)
- [\<proxy> Element (Network Settings)](/dotnet/framework/configure-apps/file-schema/network/proxy-element-network-settings)
