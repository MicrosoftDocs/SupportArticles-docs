---
title: User contact photos in Lync aren't displayed correctly
description: Describes scenarios in which a user's contact photos don't display correctly in Microsoft Skype for Business Online in Microsoft Office 365.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.reviewer: dahans
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
---

# User contact photos in Lync aren't displayed correctly

## Problem

When you connect to Skype for Business Online (formerly Lync Online), you may experience the following issues: 

- Issue 1: You can't view your own contact photo in Lync 2010 or Lync 2013.   
- Issue 2: Other contacts can't see your photo. This includes external contacts.   
- Issue 3: High-resolution contact photos don't display in conferences and online meetings in Lync 2013.   

## Solution

### Resolution for Issue 1

To resolve issue 1, upload a photo from the Office 365 portal. Depending on which version of Exchange mailbox the user has, there are different upload options. For more information about how to upload a photo from Lync 2010 or Lync 2013, go to the following Microsoft website:

[Change your picture in Lync](https://office.microsoft.com/redir/ha102925442.aspx)

### Resolution for Issue 2

If external contacts report that they can't view your contact photos, make sure that the photos aren't published in Active Directory by using the thumbnailPhoto attribute. In this case, the photos aren't available to external contacts because the photos are stored in the local Active Directory Domain Services (AD DS).

An external contact won't be able to retrieve photos from a local source. Only users within the same organization are expected to be able to retrieve photos in Skype for Business Online.

### Resolution for Issue 3

High-definition photos are displayed only in Lync 2013 and the Microsoft Lync Web App. If users are logged in to Lync 2010, the standard-definition photos are displayed instead of high-resolution versions. Or, if users are logged in to Lync 2013, and if photos for certain contacts aren't high resolution, you should make sure that the contacts have an Exchange 2013 mailbox and have a high-resolution photo uploaded.

## More Information

These issues may occur for one of the following reasons:

- Issue 1 usually occurs when one of the following conditions is true: 
  - No photo was uploaded.   
  - The photo doesn't meet the size or type requirements.    
  - The user's Exchange mailbox is unavailable.   
- Issue 2 occurs when the photo is inaccessible to the contact. This can occur because the Exchange mailbox is unavailable or because the photo is stored in Active Directory and is inaccessible to external contacts.   
- Issue 3 occurs when users are logged into Lync 2010 or when the user whose photo isn't displaying doesn't have an Exchange 2013 mailbox.   

### How to upload photos to Exchange Online through PowerShell

First, connect to Exchange Online by using remote PowerShell by using the instructions at the following Microsoft website: 

[Connect to Exchange Online Using Remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell)

As soon as you are connected, use the Set-UserPhoto cmdlet to upload a photo directly to the user's Exchange mailbox. For more information about the Set-UserPhoto cmdlet and its usages, go to the following Microsoft TechNet website: 

[Set-UserPhoto](/powershell/module/exchange/set-userphoto)

### How to populate the "thumbnailPhoto" attribute in AD DS

If you are running the Microsoft Azure Active Directory Sync Tool , run a Windows PowerShell script to populate the thumbnailPhotoattribute in the on-premises Active Directory schema. To do this, follow these steps:

1. Start Notepad, and then paste the following Windows PowerShell script into Notepad:

    ```powershell
    $SAMName=Read-Host "Enter a username"
    
    $root = [ADSI]'GC://dc=contoso,dc=local'
    $searcher = new-object System.DirectoryServices.DirectorySearcher($root)
    $searcher.filter = "(&(objectClass=user)(sAMAccountName=$SAMName))"
    $user = $searcher.findall()
    $userdn = $user[0].path
    $userdn = $userdn.trim("GC")
    $userdn = "LDAP" + $userdn
    
    function Select-FileDialog
    {
    param([string]$Title,[string]$Directory,[string]$Filter="All Files (*.*)|*.*")
    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    $objForm = New-Object System.Windows.Forms.OpenFileDialog
    $objForm.InitialDirectory = $Directory
    $objForm.Filter = $Filter
    $objForm.Title = $Title
    $objForm.ShowHelp = $true
    $Show = $objForm.ShowDialog()
    If ($Show -eq "OK")
    {
    Return $objForm.FileName
    }
    Else 
    {
    Write-Error "Operation canceled by user."
    }
    }
    
    $photo = Select-FileDialog -Title "Select a photo" -Directory "%userprofile%" -Filter "JPG Images (*.jpg)|*.jpg|PNG Images (*.png)|*.png"
    
    $user = [ADSI]($userdn)
    [byte[]]$file = Get-Content $photo -Encoding Byte
    
    # clear previous image if exist 
    $user.Properties["thumbnailPhoto"].Clear()
    
    # write the image to the user's thumbnailPhoto attribute by converting the byte[] to Base64String 
    $result = $user.Properties["thumbnailPhoto"].Add($file)
    
    # commit the changes to AD 
    $user.CommitChanges()
    
    if ($result -eq "0")
    {
    Write-Host "Photo successfully uploaded."
    } 
    else
    {
    Write-Error "Photo was not uploaded."
    }
    ```

2. On line 2 of the script, edit the GC location to reflect the local Active Directory schema. In this example, we use the Contoso.local domain. Therefore, in this example, line 2 is as follows:

    ```powershell
    $root = [ADSI]'GC://dc=contoso,dc=local'
    ```
1. On the **File** menu, click **Save**.    
1. In the **Save As Type** box, click All Files (\*.*).   
1. In the **File name** box, type UploadADPhoto.ps1, and then click **Save**.  
1. Start Windows PowerShell, and then move to the location where you saved the script.    
1. Run the script, type the alias of the user, and then press Enter. A **File-Open** dialog box prompts you for the image file in either a JPG or PNG format.   
1. Click **Open**. The results are displayed on the screen.   
1. If the picture was successfully uploaded, take one of the following actions:
      - Let the Azure Active Directory Sync Tool synchronize.   
      - Force synchronization. For more information about how to force synchronization, go to the following Microsoft website: 

        [Synchronize your directories](https://onlinehelp.microsoft.com/office365-enterprises/ff652557.aspx#bkmk_synchronizedirectories)   
   
10. Wait 12 to 24 hours for all changes to take effect.   

> [!NOTE]
> If the photo was published by using this method, external contacts such as Windows Live Hotmail users and other federated organizations can't display the photo. The photo can't be displayed because the file can't be accessed from external locations.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).