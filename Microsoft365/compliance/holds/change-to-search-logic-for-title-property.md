---
title: Change to search logic for the Title property
description: Describes a change to the Title property when conducting eDiscovery searches in the Microsoft Purview compliance portal.
ms.author: luche
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
applies to: 
  - Office 365 Security & Compliance Center
ms.custom: 
  - CI 115091
  - CSSTroubleshoot
ms.reviewer: markjjo
ms.date: 06/24/2024
---

# Change to search logic for the "Title" property

If you use the Microsoft Purview compliance portal to create content searches and eDiscovery holds (especially if you use the [Query Based Hold](/microsoft-365/compliance/ediscovery-cases?preserve-view=true&view=o365-worldwide#step-4-place-content-locations-on-hold) feature), you should be aware of a change coming to the way that the Title property is handled.

When the SharePoint managed property Title is used in a search query or a query-based hold, the results can come from several different places, including the text of a Word or PowerPoint document. Since the primary objective of the Title property is to create a descriptive title, this method doesn't always work and returns incorrect information.

As of June 1, 2020, a change will be rolled out in Microsoft 365 to address this discrepancy. When creating a search query that uses the Title property, the results will no longer pull from the body text of Word or PowerPoint documents. Any new search queries should be written to reflect this behavior, and any existing search queries or query-based holds should be updated.

> [!NOTE]
> This change will apply to all SharePoint and OneDrive documents created or modified after June 1, 2020. Existing documents will not be updated.

## Create or modify queries

If you use the "Title:expression" filter in a query-based hold, make sure that you include the same expression as free-text terms in the query.

For example, don't write your query in either of these ways:

```console
    'Title:foo AND bar'
    'Title:foo bar'
```

These two expressions are the same (the AND operator is implied by default).

Update your query in one of the following ways to ensure that your search results don't change after the rollout is complete:

```console
    '(Title:foo OR foo) AND bar'
    '(Title:foo OR foo) bar'
```

By using this method, the term "foo" must also exist in the body of a Word or PowerPoint document to match the query. This might result in the search returning a larger set of documents, but the results will be consistent after the rollout.

## Verify existing queries

Some of your existing search queries or query-based holds might be affected by this change. To identify which ones should be modified, follow these steps:

### Step 1: Connect to Security & Compliance Center PowerShell

1. Save the following text to a Windows PowerShell script file by using a filename suffix of .ps1. (For example, ConnectSCC.ps1.)

    ```powershell
    # Get login credentials

    $UserCredential = Get-Credential

    $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid -Credential $UserCredential -Authentication Basic -AllowRedirection

    Import-PSSession $Session -AllowClobber -DisableNameChecking

    $Host.UI.RawUI.WindowTitle = $UserCredential.UserName + " (Security & Compliance Center)"
    ```

1. On your local computer, open Windows PowerShell and go to the folder where you saved the script.

1. Run the script.

    `.\ConnectSCC.ps1`

1. When prompted for your credentials, enter your email address and password, and then select **OK**.

### Step 2: Run PowerShell commands to report on content searches, eDiscovery searches, eDiscovery holds, and retention policies

Copy each of the following commands and run them in Security & Compliance Center PowerShell. They return any content searches, eDiscovery searches, eDiscovery holds, or retention policies that utilize the "Title" field.

- To find any Content Searches (not associated with an eDiscovery case) that utilize the Title field:

    ```powershell
    Get-ComplianceSearch | ?{$_.ContentMatchQuery -like '*Title:*' -or $_.ContentMatchQuery -like '*Title=*'}
    ```

- To find any eDiscovery cases that have associated searches that utilize the Title field:

    ```powershell
    Get-ComplianceCase | %{Get-ComplianceSearch -Case $_.Name} | ?{$_.ContentMatchQuery -like '*Title:*' -or $_.ContentMatchQuery -like '*Title=*'}
    ```

- To find any eDiscovery holds (query-based holds) that utilize the Title field:

    ```powershell
    Get-ComplianceCase | %{Get-CaseHoldPolicy -Case $_.Name} | %{Get-CaseHoldRule -Policy $_.Name} | ?{$_.ContentMatchQuery -like '*Title:*' -or $_.ContentMatchQuery -like '*Title=*'}
    ```

- To find any retention policies with retention rules that utilize the Title field:

    ```powershell
    Get-RetentionCompliancePolicy | %{Get-RetentionComplianceRule -Policy $_.Guid} | ?{$_.ContentMatchQuery -like '*Title:*' -or $_.ContentMatchQuery -like '*Title=*'}
    ```

### Step 3: Revise queries that use the "Title" field

If you discover any query that uses the Title field, update the query as shown in the preceding Create or modify queries section so that it uses a full-text expression equal to "Title:expression".

## More information

For more information on managing eDiscovery and creating holds, see the following articles:

- [Get started with eDiscovery (Standard)](/microsoft-365/compliance/ediscovery-cases?preserve-view=true&view=o365-worldwide)
- [Overview of retention policies](/microsoft-365/compliance/retention-policies?preserve-view=true&view=o365-worldwide)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
