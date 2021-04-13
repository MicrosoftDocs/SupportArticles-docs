---
title: Delegates page is not available if setting a delegate
description: Fixes an issue in which you receive an error message when you select the Delegate Access button in Outlook 2010 or when you select the Delegates tab in Outlook 2007. This issue occurs in an Exchange Server 2010 environment.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
- Outlook for Windows
- CSSTroubleshoot
ms.reviewer: gregmans
appliesto:
- Microsoft Outlook 2010
- Microsoft Office Outlook 2007
- Exchange Server 2010 Enterprise
- Exchange Server 2010 Standard
search.appverid: MET150
---
# The delegates page is not available error when setting a delegate in Outlook 2010 or 2007

_Original KB number:_ &nbsp; 2753709

## Symptoms

Assume that you do one of the following:

- You select the **Delegate Access** button on the **Account Settings** menu in Microsoft Outlook 2010.
- You select the **Delegates** tab in the **Options** dialog box in Microsoft Office Outlook 2007.

In this situation, you receive the following error messages:

> The delegates page is not available. Cannot access Outlook folder. The connection to Microsoft Exchange is unavailable. Outlook must be online or connected to complete this action.

> [!NOTE]
> This issue occurs in a Microsoft Exchange Server 2010 environment.

## Cause

This issue occurs because an account attribute in Active Directory Domain Services (AD DS) references the value of a deleted object. For example, the account attribute references CN=Deleted Objects.

## Workaround

To work around this issue, remove the value of the deleted object in the affected account attribute by using the Active Directory Service Interfaces (ADSI) Edit tool.

> [!NOTE]
> To identify which value belongs to the deleted object in the account attribute, follow these steps:
>
> 1. Copy the value of the distinguishedName attribute of the affected account by using the ADSI Edit tool.
> 2. Export an .ldf file. To do this, use the value that you copied to run the following command in an elevated command prompt (cmd.exe):  
> Ldifde -f **drive**:\\**filename**.ldf -d "**distinguishedName value**"  
> 3. Open the .ldf file in an application such Notepad.
> 4. Type CN=Deleted Objects in the Find function.

## More information

For more information about the ADSI Edit tool, see [ADSI Edit (adsiedit.msc)](/previous-versions/windows/it-pro/windows-server-2003/cc773354(v=ws.10))

For more information about the ldifde command, see [Ldifde](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731033(v=ws.10))
