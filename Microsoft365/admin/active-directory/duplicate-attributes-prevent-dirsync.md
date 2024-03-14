---
title: Troubleshoot directory synchronization errors with event 6941
description: Discusses an issue in which an admin receives a  Directory Synchronization Error Report email message in Microsoft 365 that indicates invalid attributes are preventing directory synchronization. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
ms.custom: 
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Azure Active Directory
  - Microsoft 365
ms.date: 10/20/2023
---

# Duplicate or invalid attributes prevent directory synchronization in Microsoft 365

## Symptoms

In Microsoft 365, an administrator receives the following email message warning when directory synchronization finishes:

```output
From: [MSOnlineServicesTeam@MicrosoftOnline.com](mailto:msonlineservicesteam@microsoftonline.com)Subject: Directory Synchronization Error Report
```

The error report in the email message may contain one or more of the following error messages:

- A synchronized object with the same proxy address already exists in your Microsoft Online Services directory.
- Unable to update this object because the user ID is not found.
- Unable to update this object in Microsoft Online Services because the following attributes associated with this object have values that may already be associated with another object in your local directory.
- Unable to update this object because the following attributes associated with this object have values that may already be associated with another object in your local directory services: [UserPrincipalName *john\@contoso.com*;]. Correct or remove the duplicate values in your local directory.
- Unable to update this object because the following attributes associated with this object have values that may already be associated with another object in your local directory services: [ProxyAddresses SMTP:*john\@contoso.com*;]. Correct or remove the duplicate values in your local directory.

Additionally, if you're running Microsoft Entra ID (Connect) Sync Service, an instance of event ID 6941 that contains one of the following error messages is logged in the Application login Event Viewer:

```asciidoc
Event ID: 6941
Log Name: Application
Source: ADSync
Level: Error
Details:
ECMA2 MA export run caused an error. 

Error Name: AttributeValueMustBeUnique
Error Detail: Unable to update this object because the following attributes associated with this object have values that may already be associated with another object in your local directory services: [UserPrincipalName john@contoso.com;]. Correct or remove the duplicate values in your local directory. Please refer to https://support.microsoft.com/kb/2647098 for more information on identifying objects with duplicate attribute values.
```

```output
Event ID: 6941
Log Name: Application
Source: ADSync
Level: Error
Details:
ECMA2 MA export run caused an error.

Error Name: InvalidSoftMatch
Error Detail: Unable to update this object because the following attributes associated with this object have values that may already be associated with another object in your local directory services: [ProxyAddresses SMTP:john@contoso.com;]. Correct or remove the duplicate values in your local directory.
```

## Cause

This issue may occur if user objects in the on-premises Active Directory Domain Services (AD DS) schema have duplicate or invalid alias values, and if these user objects aren't synced from the AD DS schema to Microsoft 365 correctly during directory synchronization.

All alias values in Microsoft 365 must be unique for a given organization. Even if you have multiple unique suffixes after the at sign (@) in the Simple Mail Transfer Protocol (SMTP) address, all alias values must be unique.

In an on-premises environment, you can have alias values that are the same as long as they're unique based on the suffixes after the at sign (@) in the SMTP address.

If you create objects that have duplicate alias values in the cloud for Microsoft 365, to make the aliases unique, one alias has a unique number appended to it. (For example, if the duplicate alias values are "Albert", one of them becomes "Albert2" automatically. If "Albert2" is already being used, the alias becomes "Albert3", and so on.) However, if objects that have duplicate alias values are created in your on-premises AD DS, an object collision occurs when directory synchronization runs, and object synchronization fails.

## Solution

To resolve this issue, determine duplicate values and values that conflict with other AD DS objects. To do so, use one of the following methods.

<a name='method-1-use-the-idfix-microsoft-azure-active-directory-synchronization-tool-error-remediation-tool'></a>

### Method 1: Use the IdFix Microsoft Entra Synchronization Tool Error Remediation Tool

Use the IdFix Microsoft Entra Synchronization Tool Error Remediation Tool to identify duplicate or invalid attributes. To resolve duplicate attributes by using the IdFix Tool, see the following Microsoft Knowledge Base article:

[2857385](https://support.microsoft.com/help/2857385) "Duplicate" is displayed in the ERROR column for two or more objects after you run the IdFix tool

<a name='method-2-map-an-existing-on-premises-user-to-an-azure-ad-user'></a>

### Method 2: Map an existing on-premises user to a Microsoft Entra user

To do so, see the following Microsoft Knowledge Base article:

[2641663](https://support.microsoft.com/help/2641663) How to use SMTP matching to match on-premises user accounts to Microsoft 365 user accounts for directory synchronization

<a name='method-3-determine-attribute-conflicts-that-are-caused-by-objects-that-werent-created-in-azure-ad-through-directory-synchronization'></a>

### Method 3: Determine attribute conflicts that are caused by objects that weren't created in Microsoft Entra ID through directory synchronization

To determine attribute conflicts that are caused by user objects that were created by using Microsoft 365 management tools (and that weren't created in Microsoft Entra ID through directory synchronization), follow these steps:
 
1. Determine the unique attributes of the on-premises AD DS user account. To do so, on a computer that has Windows Support Tools installed, follow these steps:  
   1. Click **Start**, click **Run**, type ldp.exe, and then click **OK**. 
   2. Click **Connection**, click **Connect**, type the computer name of an AD DS domain controller, and then click **OK**.
   3. Click **Connection**, click **Bind**, and then click **OK**.
   4. Click **View**, click **Tree View**, select the AD DS domain in the **BaseDN** drop-down list, and then click **OK**.
   5. In the navigation pane, locate and then double-click the object that isn't syncing correctly. The Details pane on the right side of the window lists all object attributes. The following example shows the object attributes:

      :::image type="content" source="./media/duplicate-attributes-prevent-dirsync/object-attributes.png" alt-text="Screenshot shows an example of object attributes." border="false":::

   6. Record the values of the userPrincipalName attribute and each SMTP address in the multivalue proxyAddresses attribute. You'll need these values later.  

      |Attribute name|Example|Notes|
      |----------|----------|----------|
      |proxyAddresses|proxyAddresses (3): x500:/o=Exchange/ou=Exchange Administrative Group (GroupName)/cn=Recipients/cn=GUID; smtp:7628376@service.contoso.com; SMTP:7628376@contoso.com;|The number that's displayed in parentheses next to the attribute label indicates the number of proxy address values in the multivalue attribute. Each distinct proxy address value is indicated by a semicolon (;). The primary SMTP proxy address value is indicated by uppercase "SMTP:"|
      |userPrincipalName|7628376@contoso.com||

      > [!NOTE]
      > Ldp.exe is included in Windows Server 2008 and in the Windows Server 2003 Support Tools. The Windows Server 2003 Support Tools are included in the Windows Server 2003 installation media. Or, to obtain the tool, go to the following Microsoft website: [Windows Server 2003 Service Pack 2 32-bit Support Tools](https://go.microsoft.com/fwlink/?linkid=100114)

2. Connect to Microsoft 365 by using the Azure Active Directory module for Windows PowerShell. To do so, follow these steps:  
   1. Click **Start**, click **All Programs**, click **Microsoft Entra ID**, and then click **Azure Active Directory module for Windows PowerShell**.
   2. Type the following commands in the order in which they're presented, and press Enter after each command:

      ```powershell
      $cred = get-credential
      ```

      > [!NOTE]
      > When you are prompted, enter your Microsoft 365 administrator credentials.

      ```powershell
      Connect-MSOLService –credential $cred
      ```

      Leave the console window open. You'll have to use it in the next step.

3. Check for the duplicate userPrincipalName attributes in Microsoft 365.

   In the console connection that you opened in step 2, type the following commands in the order in which they're presented, and press Enter after each command:

   ```powershell
   $userUPN = "<search UPN>"
   ```

   > [!NOTE]
   > In this command, the placeholder "search UPN" represents the UserPrincipalName attribute that you recorded in step 1f.

   ```powershell
   get-msoluser –UserPrincipalName $userUPN | where {$_.LastDirSyncTime -eq $null}
   ```

   Leave the console window open. You'll use it again in the next step.

4. Check for duplicate proxyAddressesattributes. In the console connection that you opened in step 2, type the following commands in the order in which they're presented, and press Enter after each command:

   ```powershell
   $UserCredential = Get-Credential
   Connect-ExchangeOnline -Credential $UserCredential
   ```

5. For each proxy address entry that you recorded in step 1f, type the following commands in the order in which they're presented, and press Enter after each command:

   ```powershell
   $proxyAddress = "<search proxyAddress>"
   ```

   > [!NOTE]
   > In this command, the placeholder"search proxyAddress" represents the value of a proxyAddresses attribute that you recorded in step 1f.

   ```powershell
   Get-EXOMailbox | Where {[string] $str = ($_.EmailAddresses); $str.tolower().Contains($proxyAddress.tolower()) -eq $true} | foreach {get-MsolUser -ObjectID $_.ExternalDirectoryObjectId | Where {($_.LastDirSyncTime -eq $null)}}
   ```

Items that are returned after you run the commands in step 3 and 4 represent user objects that weren't created through directory synchronization and that have attributes that conflict with the object that isn't syncing correctly.

After you determine conflicting or invalid attribute values, troubleshoot the issue by following the steps in the following Microsoft Knowledge Base article:

[2643629](https://support.microsoft.com/help/2643629) One or more objects don't sync when the Azure Active Directory Sync tool is used

## More information

The Windows PowerShell commands in this article require the Azure Active Directory module for Windows PowerShell. For more information about Azure Active Directory module for Windows PowerShell, go to the following Microsoft website:

[Microsoft Entra Cmdlets](/previous-versions/azure/jj151815(v=azure.100))

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
