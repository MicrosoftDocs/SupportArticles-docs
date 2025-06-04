---
title: Mail Contacts Lose Access To Encrypted Content
description: Provides a workaround for an issue in which mail contacts in groups either lose access or have intermittent access to encrypted content.
ms.date: 06/04/2025
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sensitivity Labels
  - CI 162121, 3921
  - CSSTroubleshoot
  - no-azure-ad-ps-ref
ms.reviewer: sathyana
appliesto: 
  - Microsoft 365 (Enterprise, Business, Government, Education)
search.appverid: MET150
---

# Mail contacts in groups have intermittent access to encrypted content

## Symptoms

External users who are mail contacts in a Microsoft 365 group report that they have no access, or only intermittent access, to encrypted content.

## Cause

This known issue affects mail contacts in groups that have usage rights to content that's encrypted by Microsoft Purview Information Protection.

**Note:** Encryption is commonly applied by using sensitivity labels that are created and published from the Microsoft Purview portal.

## Workaround

Use the following steps to work around the issue:

1. Identify all group members that are mail contacts:

   1. Run the following PowerShell cmdlets to connect to [Microsoft Graph PowerShell](/powershell/microsoftgraph/authentication-commands#use-connect-mggraph):

      ```powershell
      Install-Module Microsoft.Graph.Groups -Scope CurrentUser -Force
      Connect-MgGraph -Scopes "Group.Read.All", "GroupMember.Read.All"
      ```

   2. Run the following PowerShell commands to verify the object type for each group member:

      ```powershell
      # Specify the DisplayName of the group.
      $groupDisplayName = "<group DisplayName>"

      # Get the group ID.
      $groupId = (Get-MgGroup -Filter "displayName eq '$groupDisplayName'").Id

      # List group members including their Id, DisplayName, and ObjectType.
      Get-MgGroupMember -GroupId $groupId -All | Select-Object -Property Id, 
        @{Name='DisplayName';Expression={$_.AdditionalProperties.'displayName'}}, 
        @{Name='ObjectType';Expression={$_.AdditionalProperties.'@odata.type'}} | FL
      ```

      The following command output lists the group members, showing whether they're mail contacts or users:

      > Id          : c0a70f60-9927-4841-9e10-ef58455422e1  
      > DisplayName : Aisling Ní Dhómhnaill  
      > ObjectType  : #microsoft.graph.user  
      >   
      > Id          : 34b63b74-66f7-4be1-ab7f-b7f7d003e0c6  
      > DisplayName : Qamar Mounir  
      > ObjectType  : #microsoft.graph.orgContact  

2. For each external user that's identified as a mail contact in the affected group, select one of the following options:

   - **Convert to a guest**: Add the external user to the group as a [guest](/azure/active-directory/external-identities/add-users-administrator#add-guest-users-to-a-group).
   
   - **Grant direct permissions**: Directly grant the external user permissions on the encrypted content rather than through group membership.

3. Remove the mail contacts from the group.
