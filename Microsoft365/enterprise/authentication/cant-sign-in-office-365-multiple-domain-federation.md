---
title: AADSTS50107 when trying to sign in to Office 365 with multiple domain federations
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
localization_priority: Normal
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
audience: ITPro 
ms.topic: article 
ms.service: o365-solutions
description: Users from multiple federated domain (top level or child domains) are unable to sign in to office 365
appliesto:
- Office 365 Identity Management
---

# You can't sign in to Office 365 from multiple federated domains

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## PROBLEM

Users from multiple federated domains (top-level or child domains) cannot sign in to Office 365. Additionally, they receive the following error message:

**Sorry, but we're having trouble signing you in.**
**AADSTS50107: Requested federation realm object 'http:// <*ADFShostname*>/adfs/services/trust' does not exist.**

## CAUSE

This issue occurs for one of the following reasons:

- The Issuance Transform rule is required to change the issuer from the default Active Directory Federation Service (AD FS) instance host name to the issuer set if the domain that's federated is missing.
- The Issuance Transform rule is not updated after you add child domains.

This issue occurs when multiple top-level domains are federated to the same AD FS instance for tenants.

## SOLUTION

1. Go to [Azure AD RPT Claim Rules](https://adfshelp.microsoft.com/AadTrustClaims/GenerateClaims), and then click **Next**.
2. Specify the value for **Immutable ID** (sourceAnchor) -> **User Sign In** (for example, UPN or mail). If multiple top-level domains are federated, select **Yes** when you are prompted to respond to "**Does the Azure AD trust with AD FS support multiple domains?**"
3. Connect to the Office 365 PowerShell, and then export the list of domains to a .csv file (for example, output.csv). To do this, run the following cmdlets:

   ```powershell
   Import-Module MSOnline
   ```
   ```powershell
   Connect-MsolService
   ```
   ```powershell
   Get-MsolDomain | Select-Object Name, RootDomain, Authentication | ConvertTo-Csv -NoTypeInformation | % {$_.Replace('"','')} | Out-File output.csv
   ```
4. Click **Generate Claims**, and then copy the PowerShell cmdlets from the **Claim Rules** section.
5. Save the cmdlets as a PowerShell script (for example, updatelclaimrules.ps1), and then run the following command to run the script on the primary AD FS server:

   ```powershell
   .\Updateclaims.ps1
   ```
6. The script makes a Backup of the existing Issuance Transform rules as a .txt file in the current working directory.

If you want to restore the issuance rules that you backed up by using the script, run the following cmdlet, and specify the Backup file that you created in step 5. In the following example, the Backup file is *Backup 2018.12.26_09.21.03*.txt.
```powershell
Set-AdfsRelyingPartyTrust -TargetIdentifier "urn:federation:MicrosoftOnline" -IssuanceTransformRulesFile "Backup 2018.12.26_09.21.03.txt"
```
