---
title: Troubleshoot Office solution security
description: Learn some tips for solving common problems that you might encounter when you work with securing Microsoft Office solutions.
ms.date: 02/02/2017
dev_langs:
  - VB
  - CSharp
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: johnhart
ms.custom: sap:Tools and Utilities\Microsoft Office dev tools
---
# Troubleshoot Office solution security

_Applies to:_&nbsp;Visual Studio

This article contains tips for solving common problems that you might encounter when you work with [securing Office solutions](/visualstudio/vsto/securing-office-solutions).

The information in this article applies to document-level projects and Visual Studio Tools for Office (VSTO) Add-in projects. See [Features available by Office application and project type](/visualstudio/vsto/features-available-by-office-application-and-project-type).

## Trusted solutions can't be installed from restricted sites

If the website is listed in the Internet Explorer restricted sites zone, users can't install a solution from a web location, even if the solution is signed with a trusted certificate.

The URL of the deployment manifest can be categorized into one of five zones:

- My Computer
- Internet
- Local intranet
- Trusted sites
- Restricted sites

If the location of the deployment manifest has been assigned to the restricted sites zone, Visual Studio Tools for Office runtime doesn't install the solution. If the location is known and can be trusted, the user can remove the location from the restricted sites zone and install the solution. For information about how to manage zones, see [Configuring ClickOnce Trusted Publishers](/previous-versions/dotnet/articles/ms996418(v=msdn.10)).

## Solutions can't be installed from network file shares or web locations when Internet Explorer Enhanced Security Configuration or Internet Explorer 7 is installed

 Internet Explorer Enhanced Security Configuration (IEESC) in Windows Server 2003 and higher, and Internet Explorer 7 and higher, significantly restricts the ability of users to browse the Internet. When users try to install Office solutions from a network file share or web location, they might get the following error message: "Customized functionality in this application will not work because the certificate used to sign the deployment manifest for \<SolutionName> is not trusted. Contact your administrator for further assistance."

 With IEESC and Internet Explorer 7 and higher, if the URL of the deployment manifest is categorized in the Internet zone, the manifest must have a certificate from a trusted publisher or the solution can't be installed. Without IEESC, the default behavior is to prompt the end user to make a trust decision.

 To manage the effect of IEESC and Internet Explorer 7 and higher, identify websites and universal naming convention (UNC) paths that you trust and add them to one of the trusted security zones (Local intranet or Trusted sites).For information about how to manage zones, see [Configure ClickOnce trusted publishers](/previous-versions/dotnet/articles/ms996418(v=msdn.10)).

## References

- [Secure Office solutions](/visualstudio/vsto/securing-office-solutions)
