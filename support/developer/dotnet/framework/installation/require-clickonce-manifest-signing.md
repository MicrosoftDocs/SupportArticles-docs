---
title: .NET Framework 4.0 requires ClickOnce Manifest signing
description: .NET Framework 4.0 enforces Manifest Signature Validation for ClickOnce deployed applications.
ms.date: 05/09/2020
ms.custom: sap:Installation
---
# .NET Framework 4.0 requires ClickOnce Manifest signing

This article helps you resolve the problem where ClickOnce deployed applications can't avoid some prompts to accept installation from unknown publishers.

_Original product version:_ &nbsp; Microsoft .NET Framework 4.0 and later versions  
_Original KB number:_ &nbsp; 2651504

## Symptoms

In the past, Visual Studio-developed applications that are deployed by using the ClickOnce technology can avoid some of the prompting to accept installation from unknown publishers.

It's beyond the scope of the article to identify those steps, particularly since it wasn't an intended behavior.

Once .NET Framework 4.0 or a later version has been installed, even those applications that have been developed and target .NET Framework versions less than 4.0 will no longer skip those user dialogs.

## Cause

This change in behavior is an increase in security. It's an expected behavior for computers that have .NET Framework 4.0 or greater installed. It isn't affected by the targeted version of the .NET Framework for which the application was developed. It isn't affected by having lower versions of the .NET Framework installed along with .NET Framework 4.0.

## Resolution

The recommended resolution is to honor the certificates and signing of the manifests, providing the appropriate certificates in the target machine's certificate store.

A non-recommended alternative is to restrict the target machines to exclude the installation of .NET Framework 4.0 or a later version. This might limit the deployment to exclude future Window versions.

## References

- [Signing ClickOnce Manifests](/previous-versions/zfz60ccf(v=vs.90))

- [How to: Sign application and deployment manifests](/visualstudio/ide/how-to-sign-application-and-deployment-manifests)

- [How to: Re-sign application and deployment manifests](/visualstudio/deployment/how-to-re-sign-application-and-deployment-manifests)

- [Caspol.exe (Code Access Security Policy Tool)](/dotnet/framework/tools/caspol-exe-code-access-security-policy-tool)  

- [ClickOnce Manifest Signing and Strong-Name Assembly Signing Using Visual Studio Project Designer's Signing Page](/previous-versions/aa730868(v=vs.80))

- [Configuring ClickOnce Trusted Publishers](/previous-versions/dotnet/articles/ms996418(v=msdn.10))

- [How to: Configure the ClickOnce Trust Prompt](/previous-versions/visualstudio/visual-studio-2008/cc176048(v=vs.90))
