---
title: Troubleshoot the invalid viewstate issues
description: This article describes techniques for debugging and resolving problems with viewstate. Viewstate is a feature of ASP.NET that allows pages to automatically preserve state without relying on server state.
ms.date: 04/17/2025
ms.reviewer: johnhart, weyao, v-jayaramanp
ms.topic: troubleshooting
ms.custom: sap:Performance
---

# Troubleshoot invalid viewstate issues

This article introduces techniques for debugging and for resolving problems with viewstate in Microsoft ASP.NET applications.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 829743

## Introduction

Viewstate is a feature in ASP.NET that allows pages to automatically preserve state without relying on server state (for example, session state). However, issues related to viewstate can be difficult to debug. In most cases, when problems with viewstate occur, you receive the following error message in the web browser, with little indication of what might be causing the issue:

> The viewstate is invalid for this page and might be corrupted.

This article describes some techniques that can be used for debugging and for resolving problems with viewstate.

## Set the validationKey attribute if you're running in a Web farm

In a Web farm, each client request can go to a different machine on every postback. Because of this behavior, you can't leave the `validationKey` attribute set to `AutoGenerate` in the *Machine.config* file. Instead, you must set the value of the `validationKey` attribute to a fixed string that is shared by all the machines on the Web farm.

## Do not store dynamically generated types in viewstate in a Web farm

When ASP.NET compiles files dynamically, the files are built into assemblies with random names (for example, a file name might be *jp395dun.dll*). If you're running a Web farm, the same files are compiled into assemblies with different random names. Normally, this isn't a problem because no one makes assumptions on those assembly names. But if you ever put a dynamically compiled type into viewstate by using binary serialization, the name of the assembly are included as part of the viewstate data. When that viewstate is later sent to a different server in the Web farm, the viewstate can't be deserialized because it uses different assembly names.

The best resolution is to avoid using binary serialization. Binary serialization uses many resources even when you don't run into this problem. Instead, limit what you put in viewstate to a combination of arrays, pairs, triplets, and simple types (for example, strings, int, and other types). `System.Web.UI.Pair` and `System.Web.UI.Triplet` are simple wrapper types that the viewstate engine can efficiently process.

An alternative fix to avoid this problem is to move the types that you're storing in viewstate into a precompiled assembly, either in your `Bin` folder or in the `Global Assembly` cache. This fix doesn't address performance, but it guarantees that the assembly has the same name on all computers.

> [!NOTE]
> If you store complex data types in viewstate and experience this issue, the call stack information will contain stacks that are similar to the following:

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

## Determine whether the problem is related to the viewstate MAC feature

The purpose of the viewstate machine authentication code (MAC) feature is to make it impossible for clients to send a request that contains a malicious viewstate. By default, this feature is enabled in the following flag in the *Machine.config* file.

```xml
enableViewStateMac="true"
```

The simplest way to determine whether the issue you're dealing with is related to the MAC feature is to turn off the feature. To do this, change the flag in the *Machine.config* file to the following code.

```xml
enableViewStateMac="false"
```

If you no longer get viewstate errors, the problem is related to the MAC feature.

> [!IMPORTANT]
> Only turn off the viewstate MAC feature to help diagnose the problem. You shouldn't keep the viewstate MAC turned off to work around the issue. If you do, you could introduce security holes. For more information, see [Building Secure ASP.NET Applications: Authentication, Authorization, and Secure Communication](/previous-versions/msp-n-p/ff649337(v=pandp.10)).

If you turn off the viewstate MAC feature, and then use viewstate for controls that don't HTML encode (for example, a Label control), attackers can tamper with the viewstate data and can put arbitrary data in viewstate. This arbitrary data is decoded and then used by controls when they render the posted page. As a result, attackers can inject script into the application unless you work to prevent the attack. For example, an attacker could decode the data, inject script into the data where a Label control is, and then link to it from a website. Anyone who clicks on the link would be the victim of a script injection attack that could potentially steal their authentication cookies or session ID. The script could also let an attacker alter state data for controls that use viewstate and application specific attacks could occur as a result.

In general, Microsoft recommends that you don't turn off the viewstate MAC feature unless you're confident that you have either disabled viewstate for all controls that don't encode their output (for example, DataGrid controls, DataList controls, Label controls, and other controls) as HTML or that you're always explicitly setting their values on each request to something known to be safe.

## Determine exactly what exception occurs when you receive the error message

Unfortunately, the invalid viewstate error message that's mentioned in the [Introduction](#introduction) section of this article isn't informative. The error message is caused by some exception being generated when the viewstate is being processed. The problem is that the exception is being consumed, and its details are lost in the error message.

By using a debugger, you can determine the original exception. To do this, you must attach a debugger to the ASP.NET process (*Aspnet_wp.exe* or *W3wp.exe*), and then set it to catch all exceptions. The debugger will probably stop at a few exceptions that aren't relevant, but eventually it will hit the viewstate exception and provide useful information for troubleshooting.

The following steps are an example that uses the Runtime Debugger (*Cordbg.exe*).

1. At the command prompt, run the `iisreset` command to make sure you're provided with a good starting point, and then browse to a page on your site.
1. Run `cordbg.exe`.
1. Type `<pro>`, and then press **ENTER**. A list of managed processes will appear. You should see either the *Aspnet_wp.exe* or the *W3wp.exe* process. Note its PID.
1. Type a `<PID>`.

    > [!NOTE]
    > Replace **PID** with the PID that was noted in step 3.

1. Type **ca e** to instruct *Cordbg.exe* to break on all exceptions, and then type `<gto>` run the process.
1. Whenever you get an exception, type `<w>` to see the stack. If the stack is a viewstate exception (look for `LoadPageStateFromPersistenceMedium` on the stack), copy all the exceptions and the stack information from the command window, and then save the information. This information can help you understand the problem. If the exception is unrelated, type `<g>`.

## Try storing the viewstate in the session

By default, the viewstate is round-tripped with an `<input type=hidden>` field that is sent to the browser. The browser then sends the field back to the server on the next request. In some cases, this viewstate can get large and be a potential source of problems. Some browsers can't handle such a large hidden field (and the resulting large request), and the browsers may truncate the viewstate. Truncating the viewstate causes a "viewstate corrupted" error message. This behavior is most likely to occur in simpler browsers. For example, this behavior may occur in a browser on a PDA.

To determine whether you may be running into such an issue, try storing the viewstate in the session. The following example demonstrates how to do this.

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

## Determine whether the problem is caused by worker process recycling

Consider the following scenario.

- You are running ASP.NET under Microsoft Internet Information Services (IIS) 6.0.
- The application pool is running under an identity other than the Local System account, the Network Service account, or an administrative-level account.
- The `validationKey` attribute of the `<machineKey>` element is set to `AutoGenerate` in the configuration file.

In this scenario, the following procedure causes a viewstate error to occur:

1. A user browses a page.
1. The worker process that hosts the ASP.NET application recycles.
1. The user posts back the page.

As a workaround for this scenario, use an explicit `validationKey` attribute in the configuration file.

## References

- [Building Secure ASP.NET Applications: Authentication, Authorization, and Secure Communication](/previous-versions/msp-n-p/ff649337(v=pandp.10))

- [.NET](https://dotnet.microsoft.com/)
