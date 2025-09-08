---
title: Execution failed Configure Legacy Exchange Support error
description: Describes an issue that returns an Execution failed error message. Occurs when you use the Hybrid Configuration wizard. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Execution failed Configure Legacy Exchange Support error when you run the Hybrid Configuration wizard

_Original KB number:_ &nbsp; 2816904

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Symptoms

When you try to run the Hybrid Configuration wizard to enable a hybrid configuration in Microsoft 365, you receive the following error message:

> Hybrid Configuration Failed with error "execution failed: Configure Legacy Exchange Support"

## Cause

This issue may occur for one of the following reasons.

- Cause 1: The External Schedule+ Free Busy public folder for Microsoft Exchange Server 2003 Support was not installed. In this case, the **OU=EXTERNAL (FYDIBOHF25SPDLT)** public folder is missing from the public folder hierarchy.
- Cause 2: The admin account isn't mail-enabled.
- Cause 3: After Exchange Server 2003 is uninstalled, the Servers container in the Administrative Group (the First Administrative Group or another custom administrative group in Exchange 2003) is empty.

## Resolution 1 - Add the OU=EXTERNAL (FYDIBOHF25SPDLT) public folder

Add the **OU=EXTERNAL (FYDIBOHF25SPDLT)** public folder. To do this, follow these steps on the mail server:

1. Connect to the server that contains the on-premises Exchange 2010 public folder.
2. Open the Exchange Management Shell, and then run the following cmdlet:

    ```powershell
    Add-PsSnapin Microsoft.Exchange.Management.Powershell.Setup
    ```

3. Install a new External Schedule+ Free Busy public folder. To do this, run the following cmdlet:

    ```powershell
    Install-FreeBusyFolder
    ```

4. Run the following cmdlet, and then make sure that all public folder servers have the External Schedule+ Free Busy public folder.

    ```powershell
    Update-PublicFolderHierarchy
    ```

> [!NOTE]
> To check whether the folder is present, open the Exchange Management Shell on the on-premises Exchange server, and then run the following command:

```powershell
Get-PublicFolder "\NON_IPM_SUBTREE\SCHEDULE+ FREE BUSY" -recurse | fl identity
```

Then, in the output, look for a folder that has the following Identity:

```console
\NON_IPM_SUBTREE\SCHEDULE+ FREE BUSY\EX:/O=<OrganizationName>/OU=EXTERNAL (FYDIBOHF25SPDLT)
```

## Resolution 2 - Mail-enable the Exchange admin account

> [!NOTE]
> You should always mail-enable Exchange admin accounts. If the Exchange admin account isn't mail-enabled, the Hybrid Configuration wizard may fail during the Set-HybridConfiguration or Update-HybridConfiguration process, and you may receive the following error message:
>
> **ERROR:Updating hybrid configuration failed with error 'Subtask ValidateConfiguration execution failed: Configure Legacy Exchange Support" as a symptom of the Admin account not being mail enabled.**

## Resolution 3 - Use ADSI Edit to remove the empty Servers container

> [!WARNING]
> This procedure requires ADSI Edit. Using ADSI Edit incorrectly can cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that problems that result from the incorrect use of ADSI Edit can be resolved. Use ADSI Edit at your own risk.

1. Start ADSI Edit. To do this, select **Start**, select **Run**, type *adsiedit.msc*, and then select **OK**.
2. Expand the **Configuration** container (<**ServerName**>.<**DomainName**.com>), and then expand **CN=Configuration,DC=\<DomainName>,DC=local**.
3. Expand **CN=Services**, expand **CN=Microsoft Exchange**, and then expand **CN=\<ExchangeOrganizationName>**.
4. Expand **CN=Administrative Groups**, and then **expand CN=first administrative group** (where first administrative group belongs to Exchange 2003).
5. Expand **CN=Servers**, and then verify that there are no server objects listed in the **Servers** container.
6. Right-click the empty **CN=Servers** container, and then select **Delete**.

## More information

The External Schedule+ Free Busy folder is used in hybrid scenarios when Exchange Server 2003 or Microsoft Office Outlook 2003 is used on premises. This external folder is installed on the Exchange 2010 public folder server so that the server can do the following:

- Intercept free/busy requests
- Send the requests to Microsoft 365 for lookup

This process is performed only for the accounts that are migrated from on-premises installations to the cloud. Exchange Server 2003 users still have calendaring functionality.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
