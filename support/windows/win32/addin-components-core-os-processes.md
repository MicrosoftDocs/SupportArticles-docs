---
title: Add-in component guidelines for core OS processes
description: Avoid using high-level languages, libraries, or frameworks when building add-in components loaded by system processes.
ms.date: 02/14/2022
ms.custom: sap:System Services Development
ms.reviewer: davean, v-jayaramanp
ms.topic: troubleshooting
ms.technology: windows-dev-apps-system-services-dev
---
# Add-in component guidelines for core OS processes

_Applies to:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 841927

> [!IMPORTANT]
> We recommend that you use only C or C++ languages and Win32 APIs for any add-in components that are loaded by core OS processes such as *lsass.exe*, *winlogon.exe*, and *logout.exe*.

The behavior of any high-level language, framework, or runtime in the components that are loaded by core operating system processes is undefined. For example, Microsoft .NET Framework and the common language runtime weren't designed to run in the context of core operating system processes.

Here is a partial list of high-level languages, frameworks, and runtimes for which behavior is undefined in the context of core OS processes:

- .NET and .NET Framework
- .NET and .NET Framework languages
    - C#
    - Visual Basic
    - Managed Extensions for C++
- Java
- Microsoft Component Object Model (COM)
- Microsoft COM+
- Microsoft Distributed Component Object Model (DCOM)
- Microsoft Foundation Classes (MFC)
- Microsoft Active Template Library (ATL) framework

## More information

For more information about add-in components that are loaded by core OS processes, see the following articles:

- [Winlogon and Credential providers](/windows/win32/secauthn/winlogon-and-credential-providers)
- [Winlogon and GINA](/windows/win32/secauthn/winlogon-and-gina)
- [Winlogon Notification Packages](/windows/win32/secauthn/winlogon-notification-packages)
- [Password Filters](/windows/win32/secmgmt/password-filters)
- [Security Support Providers (SSPs)](/windows/win32/rpc/security-support-providers-ssps-)
- [Authentication Packages](/windows/win32/secauthn/authentication-packages)
- [Subauthentication Packages](/windows/win32/secauthn/subauthentication-packages)
- [Cryptographic Service Providers](/windows/win32/seccrypto/cryptographic-service-providers)
