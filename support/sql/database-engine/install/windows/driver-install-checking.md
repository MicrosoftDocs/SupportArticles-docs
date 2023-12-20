---
title: Driver Install Checking
description: This article provides steps users can take to troubleshoot common driver installation issues on Windows.
ms.date: 12/20/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: mastewa, jopilov , prmadhes, v-sidong
---
# Driver install checking

Drivers play a crucial role in facilitating communication between hardware and software on a computer system. When encountering driver installation issues, it's essential to follow specific steps to identify and potentially resolve these problems. While the responsibility primarily lies with the vendor, there are steps users can take to troubleshoot common driver installation issues on Windows.

## Driver installation verification

Drivers are physically represented as [DLLs](/troubleshoot/windows-client/deployment/dynamic-link-library) on the hard drive. Applications need to know how to find the appropriate DLL and load it into the process space. Both ODBC and OLE DB use the registry to locate the Driver or Provider to load into memory. The process of loading drivers into memory varies depending on the type of drivers and the operating system being used.

- In Windows, drivers are loaded into memory via the [Load Library Win32 API](/windows/win32/api/libloaderapi/nf-libloaderapi-loadlibrarya). Once the driver has loaded into memory, the ODBC Driver Manager proxies the calls between the application and the driver. This proxy functionality is what allows for the tracing functionality. However, for performance and other reasons, this trace isn't recommended.

- In the case of OLE DB, it's loaded via COM APIs, such as [CoCreateInstance](/windows/win32/api/combaseapi/nf-combaseapi-cocreateinstance) (C++) or [CreateObject](/office/vba/language/reference/user-interface-help/createobject-function) (VBA/VBScript).

- For .NET Providers, the DLLs are loaded from the [Global Assembly Cache](/dotnet/framework/app-domains/gac) (typical) or application directory, according to .NET search rules. The registry isn't used.

- There are also .NET Providers for ODBC Drivers and OLE DB Providers, and once the .NET Provider DLLs are loaded, they follow the ODBC or OLE DB rules for loading the actual driver or Provider DLLs.

[PROCMON](/sysinternals/downloads/procmon) can be used to trace the install or load and may indicate if any DLL or registry keys are missing or have permissions issues.

> [!NOTE]
> When tracing 32-bit applications, references to *c:\windows\system32* are automatically redirected to *c:\windows\syswow64*. Similar for registry access.

3rd-party drivers manufacturers may also install a test application, for example, SQL*PLUS for Oracle. If that can't connect to the server, the driver should be reinstalled and/or the vendor should be engaged.

> [!NOTE]
> Most of the time driver installation issues are generally the responsibility of the vendor.

Ensuring the proper installation of drivers is paramount for seamless connectivity and functionality within various software ecosystems. The trio of ODBC, OLE DB, and .NET drivers form the backbone of data access and interaction across diverse applications and platforms. Verifying the installation status of these drivers guarantees robust connectivity and optimal performance, enabling smooth data operations and enhanced functionality.

Let's delve into the methods to efficiently check the installation status of these drivers to ensure their readiness for data handling and exchange.

- ODBC Driver Install Checking
- OLE DB Driver Install Checking
- .NET Driver Install Checking

## Installation support for various drivers and providers

When it comes to navigating the vast landscape of drivers and providers, understanding their support structures is crucial for seamless operations and troubleshooting. Here's an overview of the support mechanisms for different third-party drivers and providers:

- 3rd-party drivers and Providers are ultimately supported by the vendor.
- For drivers and Providers that come preinstalled with Windows: SQL Server, FoxPro, Microsoft ODBC for Oracle, and Access (and its IISAM drivers, Text, Paradox, dBase, Excel, etc.), generally you must repair or reinstall Windows. The [Microsoft Windows support team](https://support.microsoft.com/en-us/contactus#!) can assist. These drivers shouldn't be used for new application development.
- For the ACE Provider and the ODBC drivers that derive from it, such as the Excel ODBC driver, the [Access or Office teams](https://support.microsoft.com/en-us/contactus#!) would support this.
- For the Microsoft DB/2 drivers and Providers, the Host Integration Services team supports this.
- For the Active Directory Provider, the Active Directory team supports this.
- For the Exchange Provider, the Exchange team supports this.
- For the installable Microsoft SQL Server drivers and Providers, the SQL Networking team supports them.
- For sample connection strings for testing, see [The Connection Strings Reference](https://www.connectionstrings.com/). (This is a non-Microsoft site.)

## More information

- ODBC Driver Install Checking
- OLE DB Driver Install Checking
- .NET Driver Install Checking

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]
