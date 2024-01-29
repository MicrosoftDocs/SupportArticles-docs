---
title: Change or set multiple locations for MSI package
description: Describes how to change the MSI file location in the Software Deployment GPO and set the multiple UNC paths for the same MSI package.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, anshg
ms.custom: sap:deploying-software-through-group-policy, csstroubleshoot
ms.subservice: group-policy
---
# How to change the MSI file location in the Software Deployment GPO (Multiple UNC paths for same package)

This article describes how to change the MSI file location in the Software Deployment GPO and set the multiple UNC paths for the same MSI package.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2395088

## Summary

Scenario: 1

You create a GPO for deploying an MSI Package, and need to change the location of the MSI package (UNC path). You need to create a new GPO for the package and this new GPO would be applied to all the machines in the OU, which will further end up redeploying the same package on the machines already having the software (installed from the previous GPO).

Scenario: 2

You want to provide multiple paths for the same installation package and push it through via GPO, but the GUI only gives you one option to select the package location.

## More information

You can work around this using the following methods:

1. Open the GPO the Package Object it is defined in and right-click the Package Object and select Properties.

2. Click the Deployment tab, then click the Advanced button. Note the Script Name location. You will need the CLSID (long alphanumeric number) directly after the \Policies notation.

3. Open the ADSI editor, connect to your domain and navigate to the System\Policies tree on the left side of the window. Locate the CLSID you noted above.

4. Expand this CLSID tree and then expand the following trees to get to the actual defined Package Object: CN=Machine \ CN=Class Store \ CN=Packages.  

5. Right click on the Package Object and select Properties. Navigate to the Optional property ' msiFileList '. This property contains the UNC path of the location of the MSI Installer file. Edit this value to represent the new UNC path.

    > [!NOTE]
    > It is possible to have multiple UNC paths defined for a Package Object, starting with 0:, then 1: and so on. If you are changing the UNC path, type in the new UNC path, prefixed with 0: and click the Add button. Select the old UNC path and click the Remove button.

6. The UNC path for the Package Object has now been updated to reflect the new UNC path.
