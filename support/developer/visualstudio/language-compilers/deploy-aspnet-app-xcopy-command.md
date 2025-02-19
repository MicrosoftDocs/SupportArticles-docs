---
title: Deploy ASP.NET applications by using Xcopy
description: Describes how to use the MS-DOS Xcopy command to deploy a Microsoft ASP.NET Web application.
ms.date: 04/22/2020
ms.custom: sap:Language or Compilers\Other
ms.topic: how-to
---
# Deploy an ASP.NET web application by using Xcopy deployment  

This article describes how to use the MS-DOS `Xcopy` command to deploy a Microsoft ASP.NET Web application.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 326355

## Summary

Xcopy style deployment isn't suited for all situations. For large Web sites and for line-of-business applications, we recommend the site is temporarily taken offline. You want to do it while the new content and the application assemblies are deployed. You can do this maintenance at a convenient, scheduled time. To minimize the scheduled downtime, follow these steps:

1. Create a new physical directory for the application that you want to update. Copy all new content to the new physical directory.
2. Reconfigure the virtual directory for the application to point to the new physical directory with the new content.

    > [!NOTE]
    > When you deploy new content to an ASP.NET Web application, the application may restart. If you have large applications and complex applications that have significant memory requirements, memory consumption may be increased. When you restart the application, supportability issues may occur. This includes loss of the user session state.

## What is Xcopy deployment

Xcopy deployment describes deployment in ASP.NET where you use the drag-and-drop feature in Microsoft Windows Explorer, File Transfer Protocol (FTP), or the DOS `Xcopy` command to copy files from one location to another. The ASP.NET application requires no modifications to the registry and has no special installation requirements for the host company on hosted sites.

## The advantages of Xcopy deployment

An Xcopy-style file transfer simplifies the deployment and the maintenance of ASP.NET sites because you make no registry entries and because you register no components. The Microsoft .NET applications are self-describing, typically with no dependencies. With assembly versioning, you can even copy a new copy of a dynamic link library (DLL) that the application uses without stopping the Web server.

## The differences between Xcopy deployment and Copy Project in Visual Studio .NET

Xcopy deployment doesn't require that you install any special software on the development computer or on the Web server. The Visual Studio .NET Copy Project method requires that you install Microsoft FrontPage Server Extensions (FPSE) on the remote server. Xcopy also permits you to replace only the most recently edited files. You can either select the files manually to replace them, or you can use the `/d` switch on the `Xcopy` command to specify the date, as follows:

```cmd
xcopy source [destination] /D:m-d-y
```

## Set the virtual directory as an IIS application

If you have not already set up the destination directory, you must set it up as an application in Microsoft Internet Information Services (IIS) before you transfer the files. To set up the virtual directory, follow these steps:

1. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Internet Services Manager**.
2. In the left pane, right-click the name of your virtual directory, and then click **Properties**.
3. Make sure that the Web site name or the name of the virtual directory is listed in the **Application Name** box under **Application Settings**. If it isn't, click **Create**.

## Troubleshooting

In some cases, you can't complete the deployment of the ASP.NET Web application through the Xcopy file transfer alone. These cases include the following ones:

- Assemblies that require you to install in the Global Assembly Cache (GAC). If you must share any of the assemblies that ASP.NET uses across multiple application domains, you must use the Gacutil.exe utility to register those assemblies into the GAC. You must unregister, replace, and then re-register assemblies each time that you deploy the application.

- Component Object Model (COM) Interop. If the ASP.NET application uses any COM components through COM interop, you must register those COM components with COM+ Services.

- Serviced components. Microsoft recommends you use the Regsvcs.exe utility to register any classes that use COM+ services (which are derived from the `System.EnterpriseServices.ServicedComponent` class).

## References

- [Determining When to Use Windows Installer Versus Xcopy](/previous-versions/dotnet/articles/aa302347(v=msdn.10))

- [Global Assembly Cache Tool (Gacutil.exe)](/previous-versions/dotnet/netframework-2.0/ex0ss12c(v=vs.80))

- [Understanding Enterprise Services (COM+) in .NET](/previous-versions/dotnet/articles/ms973847(v=msdn.10))
