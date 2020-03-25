---
title: Search logic change to "Title" property in the Security and Compliance Center
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
ms.date: 3/24/2020
audience: ITPro
ms.topic: article
ms.service: O365-Comp
localization_priority: Normal
search.appverid:
- SPO160
- MET150
applies to: Office 365 Security & Compliance Center
ms.custom: 
- CI 115091
- CSSTroubleshoot 
ms.reviewer: markjjo 
description: Describes a change to the "Title" property when conducting eDiscovery searches in the Security and Compliance Center. 
---

# Change to search logic for the "Title" property in the Security and Compliance Center

If you use the Security & Compliance Center to create content searches and eDiscovery holds (especially if you use the [Query Based Hold](https://docs.microsoft.com/microsoft-365/compliance/ediscovery-cases?view=o365-worldwide#step-4-place-content-locations-on-hold) feature), you should be aware of a change coming to the way that the Title property is handled. 

When the SharePoint managed property Title is used in a search query or a query-based hold, the results can come from several different places, including the text of a Word or PowerPoint document. Since the primary objective of the Title property is to create a descriptive title, this method doesn't always work and returns incorrect information.

As of June 1, 2020, a change will be rolled out in Microsoft 365 to address this discrepancy. When creating a search query that uses the Title property, the results will no longer pull from the body text of Word or PowerPoint documents. Any new search queries should be written to reflect this behavior, and any existing search queries or query-based holds should be updated.

> [!NOTE]
> This change will apply to all SharePoint and OneDrive documents created or modified after June 1, 2020. Existing documents will not be updated.

## Create or modify queries

If you use the "Title:expression" filter in a query-based hold, make sure that you include the same expression as free-text terms in the query.

For example, don't write your query in either of these ways:

```
    'Title:foo AND bar'
    'Title:foo bar'
```

These two expressions are the same (the AND operator is implied by default).

Update your query in one of the following ways to ensure that your search results don't change after the rollout is complete:

```
    '(Title:foo OR foo) AND bar'
    '(Title:foo OR foo) bar'

```

By using this method, the term "foo" must also exist in the body of a Word or PowerPoint document to match the query. This may result in the search returning a larger set of documents, but the results will be consistent after the rollout. 

## Verify existing queries

Some of your existing search queries or query-based holds might be affected by this change. To identify which ones should be modified, follow these steps:

### Step 1: Connect to Security & Compliance Center PowerShell 

1.    Save the following text to a Windows PowerShell script file by using a filename suffix of .ps1. (For example, ConnectSCC.ps1.)

```
# Get login credentials 

$UserCredential = Get-Credential 

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid -Credential $UserCredential -Authentication Basic -AllowRedirection 

Import-PSSession $Session -AllowClobber -DisableNameChecking 

$Host.UI.RawUI.WindowTitle = $UserCredential.UserName + " (Security & Compliance Center)"
```

2.    On your local computer, open Windows PowerShell and go to the folder where you saved the script.
 
3.    Run the script. 

```
.\ConnectSCC.ps1
```

4.    When prompted for your credentials, enter your email address and password, and then select **OK**.

### Step 2: Run PowerShell commands to report on content searches, eDiscovery searches, eDiscovery holds, and retention policies 

Copy each of the following commands and run them in Security & Compliance Center PowerShell. They will return any content searches, eDiscovery searches, eDiscovery holds, or retention policies that utilize the "Title" field.

 
- To find any Content Searches (not associated with an eDiscovery case) that utilize the Title field:
```
Get-ComplianceSearch | ?{$_.ContentMatchQuery -like '*Title:*' -or $_.ContentMatchQuery -like '*Title=*'}
```
 
- To find any eDiscovery cases that have associated searches that utilize the Title field:
```
Get-ComplianceCase | %{Get-ComplianceSearch -Case $_.Name} | ?{$_.ContentMatchQuery -like '*Title:*' -or $_.ContentMatchQuery -like '*Title=*'}
```

- To find any eDiscovery holds (query-based holds) that utilize the Title field:
```
Get-ComplianceCase | %{Get-CaseHoldPolicy -Case $_.Name} | %{Get-CaseHoldRule -Policy $_.Name} | ?{$_.ContentMatchQuery -like '*Title:*' -or $_.ContentMatchQuery -like '*Title=*'}
```
 
- To find any retention policies with retention rules that utilize the Title field:
```
Get-RetentionCompliancePolicy | %{Get-RetentionComplianceRule -Policy $_.Guid} | ?{$_.ContentMatchQuery -like '*Title:*' -or $_.ContentMatchQuery -like '*Title=*'}
```
 
### Step 3: Revise queries that use the "Title" field

If you discover any query that uses the Title field, update the query as shown in the Create or modify queries section above so that it uses a full-text expression equal to "Title:expression".

## More information
For more information on managing eDiscovery and creating holds, see the following articles:
- [Manage eDiscovery cases in the Security & Compliance Center](https://docs.microsoft.com/microsoft-365/compliance/ediscovery-cases?view=o365-worldwide)
- [Overview of retention policies](https://docs.microsoft.com/microsoft-365/compliance/retention-policies?view=o365-worldwide)


Still need help? Go to [Microsoft Community](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fanswers.microsoft.com%2F&data=02%7C01%7Cv-todmc%40microsoft.com%7C98910814456c474880f108d7cf62d97d%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637205895885805857&sdata=9%2FYStDGvrU5ZIYXB7guowmaPlKazab0U%2BTpiBIItDaQ%3D&reserved=0).
