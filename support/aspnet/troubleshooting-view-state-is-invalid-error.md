---
title: Troubleshoot the View state is invalid error
description: This article describes techniques for debugging and for resolving problems with view state. View state is a feature of ASP.NET that allows pages to automatically preserve state without relying on server state.
ms.date: 12/11/2020
ms.prod-support-area-path: 
---
# Troubleshoot the View state is invalid error with ASP.NET

This article introduces techniques for debugging and for resolving problems with view state in Microsoft ASP.NET applications.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 829743

## Introduction

`View state` is a feature in ASP.NET that allows pages to automatically preserve state without relying on server state (for example, session state). However, issues relating to view state can be difficult to debug. In most cases, when problems with view state occur, you receive the following error message in the Web browser, with little indication of what might be causing the issue:

> The viewstate is invalid for this page and might be corrupted

This article describes some techniques that can be used for debugging and for resolving problems with view state.

## Verify that you are not running into issues that have been fixed

A number of view state issues were fixed with ASP.NET 1.0 hotfixes and service packs, and those fixes are also part of ASP.NET 1.1. Make sure that you have applied the latest fixes before tracking issues that have already been resolved. You can obtain the latest Microsoft .NET Framework updates from here: [Download .NET Framework](https://dotnet.microsoft.com/download/dotnet-framework).

## Set the validationKey attribute if you are running in a Web farm

In a Web farm, each client request can go to a different machine on every postback. Because of this behavior, you cannot leave the `validationKey` attribute set to AutoGenerate in the Machine.config file. Instead, you must set the value of the `validationKey` attribute to a fixed string that is shared by all the machines on the Web farm.

For more information about this issue, see [Troubleshooting Invalid viewstate issues](/iis/troubleshoot/aspnet-issues/troubleshooting-invalid-viewstate-issues).  

## Do not store dynamically generated types in view state in a Web farm

When ASP.NET compiles files dynamically, the files are built into assemblies with random names (for example, a file name might be jp395dun.dll). If you are running a Web farm, the same files will be compiled into assemblies with different random names. Normally, this is not a problem because no one makes assumptions on those assembly names. But if you ever put a dynamically compiled type into view state by using binary serialization, the name of the assembly will be included as part of the view state data. When that view state is later sent to a different server in the Web farm, the view state cannot be deserialized because it uses different assembly names.

The best fix to this problem is to avoid using binary serialization. Binary serialization uses many resources even when you do not run into this problem. Instead, limit what you put in view state to a combination of Arrays, Pairs, Triplets, and simple types (for example, strings, int, and other types). `System.Web.UI.Pair` and `System.Web.UI.Triplet` are simple wrapper types that the view state engine can efficiently process.

An alternative fix to avoid this problem is to move the types that you are storing in view state into a precompiled assembly, either in your Bin folder or in the `Global Assembly` Cache. This fix does not address performance, but it guarantees that the assembly has the same name on all computers.

> [!NOTE]
> If you store complex data types in view state and experience this issue, the call stack information will contain stacks that are similar to the following:

```console
[FileNotFoundException: Could not load file or assembly 'App_Web_fx--sar9, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null' or one of its dependencies. The system cannot find the file specified.]
 System.RuntimeTypeHandle._GetTypeByName(String name, Boolean throwOnError, Boolean ignoreCase, Boolean reflectionOnly, StackCrawlMark& stackMark, Boolean loadTypeFromPartialName) +0
System.RuntimeTypeHandle.GetTypeByName(String name, Boolean throwOnError, Boolean ignoreCase, Boolean reflectionOnly, StackCrawlMark& stackMark) +72
System.RuntimeType.PrivateGetType(String typeName, Boolean throwOnError, Boolean ignoreCase, Boolean reflectionOnly, StackCrawlMark& stackMark) +58
System.Type.GetType(String typeName, Boolean throwOnError) +57
System.Web.UI.ObjectStateFormatter.DeserializeType(SerializerBinaryReader reader) +192 
System.Web.UI.ObjectStateFormatter.DeserializeValue(SerializerBinaryReader reader) +943 
System.Web.UI.ObjectStateFormatter.DeserializeValue(SerializerBinaryReader reader) +384 
System.Web.UI.ObjectStateFormatter.DeserializeValue(SerializerBinaryReader reader) +198 
System.Web.UI.ObjectStateFormatter.DeserializeValue(SerializerBinaryReader reader) +210 
System.Web.UI.ObjectStateFormatter.DeserializeValue(SerializerBinaryReader reader) +198 
System.Web.UI.ObjectStateFormatter.Deserialize(Stream inputStream) +142
```

## Determine whether the problem is related to the view state MAC feature

The purpose of the view state machine authentication code (MAC) feature is to make it impossible for clients to send a request that contains a malicious view state. By default, this feature is enabled in the following flag in the *Machine.config* file.

```xml
enableViewStateMac="true"
```

The simplest way to determine whether the issue you are dealing with is related to the MAC feature is to turn off the feature. To do this, change the flag in the *Machine.config* file to the following code.

```xml
enableViewStateMac="false"
```

If you no longer get view state errors, the problem is related to the MAC feature.

> [!IMPORTANT]
> Only turn off the view state MAC feature to help diagnose the problem. You should not keep the view state MAC turned off to work around the issue. If so, you could introduce security holes. For more information, see [Building Secure ASP.NET Applications: Authentication, Authorization, and Secure Communication](/previous-versions/msp-n-p/ff649337(v=pandp.10)).

If you turn off the view state MAC feature, and then you use view state for controls that do not HTML encode (for example, a Label control), attackers can tamper with the view state data and can put arbitrary data in view state. This arbitrary data is decoded and then used by controls when they render the posted page. As a result, attackers can inject script into the application unless you work to prevent the attack. For example, an attacker could decode the data, inject script into the data where a Label control is, and then link to it from a Web site. Anyone who clicks on the link would be the victim of a script injection attack that could potentially steal their authentication cookies or session id. The script could also let an attacker alter state data for controls that use view state and application specific attacks could occur as a result.

In general, Microsoft recommends that you not turn off the view state MAC feature unless you are confident that you have either disabled view state for all controls that do not HTML encode their output (for example, DataGrid controls, DataList controls, Label controls, and other controls) or that you are always explicitly setting their values on each request to something known to be safe.

## Determine exactly what exception occurs when you receive the error message

Unfortunately, the invalid view state error message that is mentioned in the [Introduction](#introduction) section of this article is not informative. The error message is caused by some exception being thrown when the view state is being processed. The problem is that the exception is being consumed, and its details are lost in the error message.

By using a debugger, you can determine the original exception. To do this, you must attach a debugger to the ASP.NET process (Aspnet_wp.exe or W3wp.exe), and then set it to catch all exceptions. The debugger will probably stop at a few exceptions that are not relevant, but eventually it will hit the view state exception and provide useful information for troubleshooting.

The following steps are an example that uses the Runtime Debugger (Cordbg.exe).

1. At a command prompt, run the `iisreset` command to make sure you are provided with a good starting point, and then browse to a page on your site.
2. At a command prompt, run `cordbg.exe`.
3. At the command prompt, type *pro*, and then press **ENTER**. A list of managed processes will appear. You should see either the Aspnet_wp.exe process or the W3wp.exe process. Note its PID.
4. At the prompt, type a *PID* to attach to the process.

    > [!NOTE]
    > Replace **PID** with the PID that was noted in step 3.

5. At the prompt, type **ca e** to tell Cordbg.exe to break on all exceptions, and then type *gto* let the process run.
6. Whenever you get an exception, type *w* to see the stack. If the stack is a view state exception (look for `LoadPageStateFromPersistenceMedium` on the stack), copy all the exception and the stack information from the command window, and then save the information. This information can help you understand the problem. If the exception is unrelated, type *g*.

## Try storing the view state in the session

By default, the view state is round-tripped by means of an `<input type=hidden>` field that is sent to the browser. The browser then sends the field back to the server on the next request. In some cases, this view state can get large and be a potential source of problems. Some browsers cannot handle such a large hidden field (and the resulting large request), and the browsers may truncate the view state. Truncating the view state causes a **view state corrupted** error message. This behavior is most likely to occur in simpler browsers. For example, this behavior may occur in a browser on a PDA.

To determine whether you may be running into such an issue, try storing the view state in the session. The following example demonstrates how to do this.

```aspx-csharp
<%@ language=c# debug=true %> 

<script runat=server> 
protected override object LoadPageStateFromPersistenceMedium() 
{ 
    return Session["_ViewState"]; 
}

protected override void SavePageStateToPersistenceMedium(object viewState) 
{ 
    Session["_ViewState"] = viewState; 
}

void TextChanged(object o, EventArgs e) 
{ 
    Response.Write("TextChanged"); 
} 
</script> 
<form runat=server> 
<asp:button text=Test runat=server/> 
<asp:textbox ontextchanged=TextChanged runat=server/> 
<input type=hidden name=__VIEWSTATE> 
</form> 
```

The following line of code is only needed in ASP.NET 1.0, to work around a bug. In ASP.NET 1.1, it is not necessary.

```html
<input type=hidden name=__VIEWSTATE>
```

## Determine whether the problem is caused by worker process recycling

Consider the following scenario.

- You are running ASP.NET under Microsoft Internet Information Services (IIS) 6.0.
- The application pool is running under an identity other than the Local System account, the Network Service account, or an administrative-level account.
- The validationKey attribute of the `<machineKey>` element is set to AutoGenerate in the configuration file.

In this scenario, the following procedure will cause a view state error to occur:

1. A user browses a page.
2. The worker process that hosts the ASP.NET application recycles.
3. The user posts back the page.

The workaround for this scenario is to use an explicit validationKey attribute in the configuration file.

## References

- [Building Secure ASP.NET Applications: Authentication, Authorization, and Secure Communication](/previous-versions/msp-n-p/ff649337(v=pandp.10))

- [.NET](https://dotnet.microsoft.com/)
