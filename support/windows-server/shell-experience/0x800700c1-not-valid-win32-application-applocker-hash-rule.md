---
title: 0x800700C1 not a valid Win32 application error when you create an AppLocker hash rule for a file in Windows
description: Describes an issue in which you can't create an AppLocker hash rule for a file in Windows.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: danesc, kaushika
ms.custom: sap:1st-party-applications, csstroubleshoot
---
# Error when you create an AppLocker hash rule for a file in Windows: 0x800700C1: not a valid Win32 application

This article describes an issue in which you can't create an AppLocker hash rule for a file in Windows.

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2749690

## Symptoms

Assume that you try to create an AppLocker hash rule for a file on a Windows computer. However, you can't create the rule, and you receive the following error message:
> 0x800700C1: not a valid Win32 application

## Cause

This issue occurs because the Windows Authenticode Signature Verification function now verifies portable executable (PE) files. PE files are considered unsigned if one of the following conditions is true:  

- Windows can identify content that doesn't comply with the Authenticode specification in the file. This condition applies to some third-party installers.
- Additional content was added to the file after the signature was applied.

AppLocker hash rules for PE files are based on the SHA2 Authenticode hash of the file. If a PE file meets either of the two conditions that were mentioned earlier, the Authenticode hash of the file isn't trusted. AppLocker can't process the Authenticode hash of such files. Therefore, you can't create Publisher or Hash rules for such files.

## Resolution

Files that have contents that don't comply with Windows Authenticode specifications or files that were changed after the signature was applied can be harmful for your computer. Therefore, we recommend that you replace such files by using the files that comply with the Windows security requirements. To do this, you may have to work with the original software author to publish a new file that complies with the requirements.

If you decide to continue working with such files, you can create AppLocker path-based rules to control these files.

## More information

On Windows 8 and Windows Server 2012-based computers, or on Windows 7 and Windows Server 2008 R2-based computers that have security update MS12-024 installed, you can't create a hash or a publisher rule for unsigned files. You can only create path-based rules for such files. Additionally, if your AppLocker policy contains a hash or publisher rule that is based on such a file, that rule no longer works for that file. The following AppLocker policy is an example of this behavior:

```xml
<AppLockerPolicy Version="1">  
<RuleCollection Type="Exe" EnforcementMode="Enforced">  
<FileHashRule Action="Allow" UserOrGroupSid="S-1-1-0" Description="" Name="Allow Calculator"   Id="7509591f-7552-4ed0-ac56-7b727cd1f9cf">  
<Conditions>  
<FileHashCondition>  
<FileHash Type="SHA256" SourceFileLength="53344" SourceFileName="calculator.exe"   Data="0x2E8950C38FE3DD02D9F9A012BA9481E7E4704838BB5208E3F7086B6935520A93"/>  
</FileHashCondition>  
              </Conditions>  
</FileHashRule>  
<FilePublisherRule Id="a3ab2d94-c20d-4039-8f2b-6caaff04e816" Name="Deny Contoso"   Description="Deny Games" UserOrGroupSid="S-1-1-0" Action="Deny">  
<Conditions>  
<FilePublisherCondition PublisherName="Contoso" ProductName="Attack of Zombies" BinaryName="*">  
<BinaryVersionRange LowSection="*" HighSection="*" />  
                     </FilePublisherCondition>  
</Conditions>  
        </FilePublisherRule>  
...  
...  
</AppLockerPolicy>  
```

In this example, the AppLocker policy has two rules. The first rule ("Allow Calculator") is a hash rule that allows Calculator.exe to run. The second rule ("Deny Contoso") is a publisher rule that blocks any file that belongs to the Attack of Zombies game that is published by Contoso. As both Calculator.exe and Zombies.exe meet one of the two conditions that were mentioned earlier, Windows Authenticode Signature verification fails. Before you apply MS12-024, Calculator.exe is allowed by the "Allow Calculator" rule, and Zombies.exe is blocked by the "Deny Contoso" rule. However, after you apply MS12-024, AppLocker can't process the SHA2 Authenticode hash for Calculator.exe and considers Zombies.exe as an unsigned file. Therefore, neither of the rules is triggered, and unexpected behavior occurs.

## References

For more information about the Windows Authenticode Portable Executable file signature format, see [General information about the Windows Authenticode Portable Executable file signature format](https://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/Authenticode_PE.docx).
