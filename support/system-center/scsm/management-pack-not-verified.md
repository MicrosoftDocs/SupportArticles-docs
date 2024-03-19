---
title: The management pack could not be verified 
description: Fixes an issue where The management pack could not be verified error occurs when adding a custom property to a UNIX class extension.
ms.date: 03/14/2024
ms.reviewer: khusmeno
---
# The management pack could not be verified error when adding a custom property to a UNIX class extension

This article helps you fix an issue where **The management pack could not be verified** error occurs when you add a custom property to a UNIX class extension.

_Original product version:_ &nbsp; System Center 2012 Service Manager  
_Original KB number:_ &nbsp; 2834765

## Symptoms

You use the Authoring console in System Center 2012 Service Manager to extend the class from a UNIX management pack to an unsealed management pack. When you try to add a new property, you get the following error message:

> The management pack could not be verified due to this error:  
> Service Manager Authoring Tool  
> The management pack could not be verified due to this error:  
> Verification failed with 1 errors:  
> Error 1:  
> Found error in
1|RHI.UNIXComputer.CI.ClassExtension|1.0.0.0|RHI.UNIXComputer.CI.ClassExtension.Category|| with message:  
> The Target attribute value is not valid. Element RHI.UNIXCOMPUTER.CI.ClassExtension.Category reference a Target element that cannot be found

## Cause

This issue can occur if a management pack public key token is specified for an unsealed management pack. For example, you will find an entry similar to the following in the XML file for the management pack:

> Category ID="RHI.UNIXComputer.CI.ClassExtension.Category" Value=\<"Console!Microsoft.EnterpriseManagement.ServiceManager.ManagementPack"> \<ManagementPackName>RHI.UNIXComputer.CI.ClassExtension\</ManagementPackName> \<ManagementPackVersion>1.0.0.0\</ManagementPackVersion> **\<ManagementPackPublicKeyToken>2abcXyz2d6760a2b\</ManagementPackPublicKeyToken>**

When the authoring tool tries to validate the management pack XML file, the process fails because the management pack is not sealed, so we cannot add a new property successfully.

## Resolution

To resolve this issue, remove the `<ManagementPackPublicKeyToken>2abcXyz2d6760a2b</ManagementPackPublicKeyToken>` entry from the XML file.

## More Information

The line `<ManagementPackPublicKeyToken>2abcXyz2d6760a2b</ManagementPackPublicKeyToken>` should be included only when you are going to seal the management pack. The public key token must match the .snk file that the management pack file will be sealed with.
