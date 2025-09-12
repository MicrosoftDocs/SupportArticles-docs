---
title: Can't get a service in Visual Studio SDK
description: Introduces common causes and solutions when you can't get a service in the Visual Studio SDK.
ms.date: 11/04/2016
author: aartig13
ms.author: aartigoyle
ms.reviewer: maiak
ms.custom: sap:Extensibility - Visual Studio SDK (VS SDK)\Extension and add-in development
---
# Can't get a service in Visual Studio SDK

_Applies to:_&nbsp;Visual Studio

This article introduces common causes and solutions when you can't [get a service](/visualstudio/extensibility/how-to-get-a-service) in the Visual Studio SDK.

If the requested service can't be obtained, the call to <xref:Microsoft.VisualStudio.Shell.Package.GetService%2A> returns null. Always test for null after requesting a service:

```csharp
IVsActivityLog log =
    GetService(typeof(SVsActivityLog)) as IVsActivityLog;
if (log == null) return;
```

## The service isn't registered with Visual Studio

Examine the system registry to see whether the service has been correctly registered. For more information, see [How to: Provide a service](/visualstudio/extensibility/how-to-provide-a-service).

The following sample *.reg* file fragment shows how the SVsTextManager service might be registered:

```registry
[HKEY_LOCAL_MACHINE\Software\Microsoft\VisualStudio\<version number>\Services\{F5E7E71D-1401-11d1-883B-0000F87579D2}]
@="{F5E7E720-1401-11d1-883B-0000F87579D2}"
"Name"="SVsTextManager"
```

In this example, version number is the version of Visual Studio, such as 12.0 or 14.0, the key `{F5E7E71D-1401-11d1-883B-0000F87579D2}` is the service identifier (SID) of the service, SVsTextManager, and the default value `{F5E7E720-1401-11d1-883B-0000F87579D2}` is the package GUID of the text manager VSPackage, which provides the service.

## The service is requested by interface type and not by service type

Use the service type and not the interface type when you call `GetService`. When requesting a service from Visual Studio, <xref:Microsoft.VisualStudio.Shell.Package> extracts the GUID from the type. A service won't be found if:

- An interface type is passed to `GetService` instead of the service type.
- No GUID is explicitly assigned to the interface. Therefore, the system creates a default GUID for an object as needed.

## The VSPackage requesting the service hasn't been sited

Be sure the VSPackage requesting the service has been sited. Visual Studio sites a VSPackage after constructing it and before calling <xref:Microsoft.VisualStudio.Shell.Package.Initialize%2A>.

If you have code in a VSPackage constructor that needs a service, move it to the `Initialize` method.

## The wrong service provider is used

Be sure that you're using the correct service provider.

Not all service providers are alike. The service provider that Visual Studio passes to a tool window differs from the one it passes to a VSPackage. The tool window service provider knows about <xref:Microsoft.VisualStudio.Shell.Interop.STrackSelection>, but doesn't know about <xref:Microsoft.VisualStudio.Shell.Interop.SVsRunningDocumentTable>. You can call <xref:Microsoft.VisualStudio.Shell.Package.GetGlobalService%2A> to get a VSPackage service provider from within a tool window.

If a tool window hosts a user control or any other control container, the container will be sited by the Windows component model and won't have access to any Visual Studio services. You can call <xref:Microsoft.VisualStudio.Shell.Package.GetGlobalService%2A> to get a VSPackage service provider from within a control container.

## References

- [List of available services](/visualstudio/extensibility/internals/list-of-available-services)
- [Use and provide services](/visualstudio/extensibility/using-and-providing-services)
- [Service essentials](/visualstudio/extensibility/internals/service-essentials)
- [Visual Studio troubleshooting](../welcome-visual-studio.yml)