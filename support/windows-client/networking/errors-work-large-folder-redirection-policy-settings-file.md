---
title: Errors when you have a large Folder Redirection policy settings file in Windows
description: Describes the problems that you may experience when you have a large Folder Redirection policy file. Provides a workaround.
ms.date: 09/14/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: herbertm, kaushika
ms.custom: sap:folder-redirection-and-offline-files-and-folders-csc, csstroubleshoot
---
# Errors when you have a large "Folder Redirection" policy settings file in Windows

This article provides a workaround for the problems that you may experience when you have a large "Folder Redirection" policy file.

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 978098

## Symptoms

Consider the following scenario:

- You set Folder Redirection policy settings for many folders in an environment.
- The folders are configured to use **Advanced Settings** when the user is a member of a group.
- The first time that you add all the groups to the list of folders, a large Folder Redirection policy settings file is created for many groups as expected.

In this scenario, you may encounter one or more of the following symptoms when you work with the large Folder Redirection policy settings file on a computer that is running Windows Vista, Windows Server 2008, Windows Server 2008 R2, or Windows 7.

### Symptom 1

When you open the Folder Redirection policy settings, you find that the folders don't display the settings. Instead, the folders are displayed as **Not configured**.

### Symptom 2

When you try to show the settings of the Folder Redirection policy in the Group Policy Management Console (GPMC), you receive the following error message in the **Folder Redirection Policy Details** section:

> An unknown error occurred while data was gathered for this extension. Details: FRSettingRead failed with -2147467259

> [!NOTE]
> For Symptom 1 and for Symptom 2, these symptoms occur on policies that are created and that are populated by using the Local Group Policy Editor on a computer that is running Windows Server 2003, Windows Server 2008, or a version of Windows that is newer than Windows Server 2008.

### Symptom 3

When you try to apply the new Folder Redirection policy settings to a domain user account on a computer that is running Windows Vista or a newer version of Windows, the settings aren't applied. Additionally, you may receive the following error message in the Application log:

> Log Name: Microsoft-Windows-GroupPolicy/Operational  
Source: Microsoft-Windows-GroupPolicy  
Event ID: 7016  
Task Category: None  
Level: Error  
Keywords:  
User: SYSTEM  
>
> Description:  
Completed Folder Redirection Extension Processing in **xxx** milliseconds.  
>
> Event Xml:  
\<Event xmlns="`http://schemas.microsoft.com/win/2004/08/events/event`">  
...  
\<EventData>  
\<Data Name="ErrorCode">2147942413\</Data>  
\<Data Name="CSEExtensionName">Folder Redirection\</Data>  
\<Data Name="CSEExtensionId">{25537BA6-77A8-11D2-9B6C-0000F8080861}\</Data>  
\</EventData>  
\</Event>  

## Cause

These issues occur because of two limitations in the system API that the Folder Redirection engine uses to read the .ini files from SYSVOL.

### Cause of Symptom 1 and Symptom 2

- For an .ini file that was created in Windows Vista or in a newer version of Windows

    These issues occur because the Folder_Redirection section of the .ini files is larger than 32,767 characters. However, the limit for the combined SID list for all folders is 32,767 characters. This limit is encountered when the `GetPrivateProfileSection` API is used to read the section.

    > [!NOTE]
    > If the SIDs typically have 48-50 characters, you can have about 670 SIDs in a policy for all folders before this issue occurs.

- For an .ini file that was created in Windows Server 2003

    These issues occur because the limit for the number of groups for each redirected folder in a policy is exceeded. This limit depends on the length of the SID string that represents the group and also on the length of the redirection path. For example, you can have about 230 groups for a single folder if a SID string is about 48-50 characters, and if the UNC path of the folder is 80 characters.

    > [!NOTE]
    >
    > - The aggregate size of all folders can exceed 32,767 characters.
    > - The first time that you open an existing policy, the settings may be converted to a newer format on a computer that is running Windows Vista or a newer version of Windows. This behavior may occur if the existing policy was created by using the Local Group Policy Editor in Windows Server 2003. This behavior also occurs when the policy settings are shown in the Settings view in the GPMC. Therefore, a policy might work by using the old .ini file format, depending on the settings. However, a policy might not work by using the new file format, depending on the settings.

### Cause of Symptom 3

This issue occurs because of a limit of the `GetPrivateProfileString` API that is used to read this section.

The list of groups is stored as a string of SIDs in an .ini file. When the list exceeds 32,767 characters, this problem occurs. Each string that represents a SID in the .ini file is typically about 48-50 characters. Therefore, you can have around 300 entries for each redirected folder.

## Workaround

To work around these problems, split the policy into smaller policies. Make sure that the total size of each policy file is smaller than the 32,767 character limit.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article.

## More information

The Folder Redirection policy settings use a new .ini file format in Windows Vista and in newer versions of Windows to support new options when you apply the settings. This technology lets you redirect more folders compared to the Folder Redirection policy settings in Windows Server 2003.

For more information about the Folder Redirection feature, see [General information about the Folder Redirection feature](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732275(v=ws.10)).
