---
title: Install ActiveX Controls in Internet Explorer
description: This article describes how to prepare and publish an ActiveX control in the Active Directory.
ms.date: 03/02/2020
ms.prod-support-area-path: Internet Explorer
ms.reviewer: JOSHUAL
---
# How to install ActiveX controls in Internet Explorer using the Active Directory

By design in Windows 2000, members of the Users group cannot install ActiveX controls from the Internet without modifying the rights of the group. However, some administrators may want to allow the Users group to install some ActiveX controls. This article describes how to publish a control in the Active Directory to facilitate this functionality.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 280579

## Preparing the Control

The ActiveX control must be packaged as an Installer Package (.msi) file instead of as a standard Internet Explorer cabinet (.cab) file. The .msi file can be created by using Visual Studio Installer. For the ActiveX control to be listed properly in the Active Directory, it must be set up to register through the .msi file instead of registering automatically.

To create the installation package, follow these steps:

1. Add the control to the Visual Installer package. To do this, click **Add Files** on the **Project** menu, and add your compiled control file to the project.

2. Determine the CLSID. To do this, either use the OLE View tool that ships with Microsoft Visual Studio, or look it up in the registry.

3. Open the Target Machine/Associations section of the project.

4. Under COM Object, add the control CLSID.

5. Under Type Libraries, add the control type library ID. If you are using a Microsoft Visual Basic (VB) control, it is the same as the CLSID by default.

6. Continue packaging the control as you normally would (that is, add any additional files and registry entries) by using Visual Installer.

7. Place the .msi file for the control on a public share on the network.

## Publishing the Control

After the MSI has been created, the Active Directory must be made aware of the control. The control must be added as a published control in the user portion of a policy for the appropriate Organizational Unit (OU). After the control has been published properly, you should see it in Add/Remove programs for any of the users in the OU.

After you have prepared the control and confirmed that the control can be seen in Add/Remove programs, you need to set up a registry entry in Windows 2000 that causes Internet Explorer to check the Active Directory for an installation package for the control.

After the registry changes are made, Internet Explorer installs the control from the Active Directory under the permissions of the Administrator who published the control. The control is installed when the user visits a Web page that contains the control. The method that is described works based on the CLSID of the control as referenced on the Web page that hosts the control. This solution works no matter what the codebase refers to. Because most Web pages that use ActiveX controls on the Internet already have a codebase that clearly cannot be modified to point to a local installation location, this method makes controlled installation possible in the environment. No changes are necessary for the Web page itself.

## References

[How to inspect COM components by using the TypeLib Information Object Library (TLI)](https://msdn.microsoft.com/magazine/bb985086.aspx)
