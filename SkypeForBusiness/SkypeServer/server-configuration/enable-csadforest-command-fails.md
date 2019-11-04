---
title: Enable-CsAdForest command fails in a multi domain active directory
description: Resolves an issue in which Lync Server Enable-CsAdForest command fails in a multi domain active directory.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: skype-for-business-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: seemarah 
ms.custom: CSSTroubleshoot
appliesto:
- Lync Server 2010 Standard Edition
- Lync Server 2010 Enterprise Edition
- Lync Server 2013
---

# Lync Server Enable-CsAdForest command fails in a multi domain active directory

## Symptoms

The Lync Server Enable-CsAdForest command will fail under the following circumstances and return the error listed below:

- When used as an Lync Server active directory preparation step for a Office Communications Server and Lync Server migration coexistence scenario   
- When run in a active directory domain that does not host the pre-existing Office Communications Server RTC Universal security groups   

```adoc
PS C:\Users\Administrator.SERVER01> Enable-CsAdForest
WARNING: Enable-CsAdForest failed.
WARNING: Detailed results can be found at
"C:\Users\Administrator.CONTOSO\AppData\Local\Temp\2\Enable-CsAdForest-b299482f-b912-441c-a39c-82c2bc86b478.html".
Enable-CsAdForest : Command execution failed: Active Directory operation failed on DC01.contoso.com. The object 
"CN=RTCUniversalReadOnlyAdmins,CN=Users,DC=contoso,DC=com" does not exist. At line:1 char:18 + Enable-CsAdForest <<<< 
 + CategoryInfo : InvalidOperation: (:) [Enable-CsAdForest], ADNoSuchObjectException + FullyQualifiedErrorId : 
ProcessingFailed,Microsoft.Rtc.Management.Deployment.PrepareForestCmdlet
```

## Cause

The Enable-CsAdForest Lync Server command is designed to run from the Active Directory Domain Services forest root domain for security purposes. If the pre-existing RTC Universal security groups do not exist in the Active Directory Domain Services forest root domain the Enable-CsAdForest Lync Server command will fail with an error that is similar to the one listed in the Symptoms section of this article.

## Resolution

The Enable-CsAdForest Lync Server command has to be directed to the Active Directory Domain Services domain that hosts the pre-existing RTC Universal security groups for the forest using the -GroupDomain parameter. As listed below:

**Enable-CsAdForest -GroupDomain domain.contoso.com**

## More Information

The Lync Server Get-CsADForest command will not reveal any information that is related to the Office Communications Server forest preparation. The Office Communications Server command line tool LcsCmd.exe can be used with the following parameters to provide a HTML report that will disclose the Active Directory Domain Services domain that hosts the pre-existing RTC Universal security groups for the forest. As listed below:

**LcsCmd /forest:<forest FQDN> /action:CheckForestPrepState**

The Office Communications Server LcsCmd.exe command listed above will provide a path location for the CheckForestPrepState HTML report that is similar to the one listed below:

"C:\Users\ADMINISTRATOR\AppData\Local\Temp\2\Forest_CheckForestPrepState[YYYY_MM_DD][HH_MM_SS].html" 

For more details on using the Lync Server Enable-CsAdForest PowerShell cmdlet:

[Enable-CsAdForest](https://technet.microsoft.com/library/gg425713.aspx)

For more details on using the Office Communications Server LcsCmd.exe CheckForestPrepState command:

Microsoft Office Communications Server 2007 R2
[Forest Preparation Commands](https://technet.microsoft.com/library/dd573032(office.13).aspx)
