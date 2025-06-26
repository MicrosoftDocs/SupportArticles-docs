---
title: Administrative limit for this request was exceeded error
description: Describes an issue that triggers a limit for this request was exceeded error when you try to add recipient domains to outbound connector in Microsoft 365.
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
# Administrative limit for this request was exceeded error when you add recipient domains to outbound connector

_Original KB number:_ &nbsp; 4014346

## Symptoms

When you try to add recipient domains to any of the outbound connectors in Microsoft Exchange Online, you receive the following error message:

> The administrative limit for this request was exceeded.

## Cause

This issue occurs if the list of recipient domains on an outbound connector contains more than 1266 domains.

## Resolution

To resolve this issue, follow these steps:

1. Make sure that the number of domains that are added to the outbound connector in the list of recipient domains is not greater than 1266.
2. For additional domains, create a new outbound connector that has a similar configuration to the one that triggers the error. Add the remaining domains to the newly created outbound connector.
3. To determine the number of domains in the existing connector, run the following cmdlet in Exchange Online PowerShell:

    ```powershell
    $outboundconnector=get-outboundconnector "Name of the outbound connector"

    $outboundconnector.recipientdomains.count
    ```

4. To add the new set of domains to the existing connector through PowerShell without having to add each one manually through Exchange Online admin center, follow these steps:

    1. Create a .csv file that lists all the domains, and make sure there's a column heading. In the following example, the column heading name is **Domainname**:

        |Domainname|
        |---|
        |`Contoso.com`|
        |`Fabrikam.com`|

    2. Import the data from the .csv file to a variable that's named domainname:

        ```powershell
        $domainname=Import-Csv -Path "Actual path of the csv file"
        ```

    3. Append the domains to the existing set of domain names by running the following cmdlet:

        ```powershell
        foreach ($entry in $domainname){$outboundconnector.RecipientDomains+=$entry.domainname}
        ```

        > [!NOTE]
        >
        > - `$outboundconnector` is populated with the cmdlet from step 3.
        > - The current line item is put in the $entry variable.
        > - To use the value in the column heading, you must use `$entry.columnname` (`$entry.domainname`).

    4. Commit the changes to the outbound connector by running the following cmdlet:

    ```powershell
    Set-OutboundConnector $outboundconnector.identity -recipientdomains $outboundconnector.RecipientDomains
    ```

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/)
