---
title: Length of the property is too long
description: Fixes an issue that triggers a Length of the property is too long error when you add sender domains to an inbound connector in Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: rrajan, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Length of the property is too long when you add sender domains to an inbound connector

_Original KB number:_ &nbsp; 4014351

## Problem

When you add sender domains to an inbound connector in Microsoft Exchange Online, you receive the following error message:

> The length of the property is too long. The maximum length is 2243 and the length of the value provided is xxx.

## Cause

This problem occurs because the maximum length for the value that's stored in the `senderdomains` attribute in an inbound connector should be less than or equal to 2,243 characters.

## Resolution

To resolve this problem, follow these steps:

1. Make sure that the length of domains that are added in the list of sender domains is less than 2,243 characters.
2. For the other set of domains, create a new inbound connector that has similar settings to the one in which you receive the error message.

> [!NOTE]
> The number of domains that can be added to the `senderdomains` attribute on the inbound connector is based on the length of domain names that are added.

Other than domain name, `smtp:` and `;1` (cost) are also counted against the stated character limit. Also, an additional character is counted for each domain that's added to the list, except for the last domain in the list.

For example, if you plan to add the domainA.com and DomainCDF.com domains to the list of sender domains, the length of the characters can be determined by using the following Windows PowerShell cmdlets.

> [!NOTE]
> In these cmdlets, assume the cost to be **1**. (This can be changed based on the requirement.)  
> ("smtp:domainA.com;1").length + 1  
> ("smtp:domainB.com;1").length + 1  

If you split the list of domains, and if you want to verify whether the number of included domains is equal to or less than the limit of 2,243, follow these steps:

1. Create a .csv file that has a column heading and all the domains of the list to the .csv file, and then import the data from the .csv file to a variable. In the following example, the column name is *domainname*.  

    ```powershell
    $tochecklist=Import-Csv -Path "Path of the csv file"
    ```

2. Run the following set of cmdlets to check for the result.

    > [!NOTE]
    > If the result is **True**, the length of the string is good enough to be added to the inbound connector. Here the current line item is put into the `$entry` variable, and you have to use `$entry.columnname ($entry.domainname)` for the value in the column heading.

    To add the domains to an existing inbound connector, run the following cmdlets:

    ```powershell
    $output=@()
    $inboundconnector=get-InboundConnector -Identity "Name of the inbound connector to which the domains have to be added"
    foreach ($entry in $tochecklist) {$output+="smtp:Domain"+$entry.domainname+".com;1"} $output+=$inboundconnector.senderdomains
    $totalcharactercount=(($output -join ("")).Length + $output.count) - 1
    ($totalcharactercount -lt 2243) -or ($totalcharactercount -eq 2243)
    ```

    To add the domains to a new inbound connector, run the following cmdlets:

    ```powershell
    $output=@()
    foreach ($entry in $tochecklist) {$output+="smtp:Domain"+$entry.domainname+".com;1"}
    $totalcharactercount=(($output -join ("")).Length + $output.count) - 1
    ($totalcharactercount -lt 2243) -or ($totalcharactercount -eq 2243)
    ```
  
3. If the result from step 2 is **True**, and if you want to commit the changes to an existing inbound connector, run the following cmdlet:

    ```powershell
    Set-InboundConnector -Identity
    $inboundconnector.Identity -senderdomains $output
    ```

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
