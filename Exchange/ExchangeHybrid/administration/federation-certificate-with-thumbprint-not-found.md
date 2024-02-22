---
title: Manage Federation Wizard can't roll to a new certificate
description: Fixes an issue in which the Manage Federation Wizard doesn't update the certificate in Microsoft 365 after you select the Roll certificate to make the next certificate as the current certificate check box.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
  - CI 160743
ms.reviewer: chrisbur, jhayes, v-six
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Exchange Online
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Federation certificate with the thumbprint cannot be found when using the next certificate

_Original KB number:_ &nbsp; 2810692

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the [Microsoft 365 Hybrid Configuration wizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Symptoms

Consider the following scenario in a hybrid deployment of on-premises Exchange Server and Exchange Online in Microsoft 365:

- The current certificate that was created for the federation trust on the hybrid server is unintentionally deleted.
- The current certificate must be replaced for the trust to work correctly.
- A new certificate is created.
- You run the Manage Federation Wizard, and then you select the **Roll certificate to make the next certificate as the current certificate** check box to use the new certificate.

In this scenario, the wizard doesn't update the certificate as expected. When you try to use the `Set-FederationTrust -Identity` cmdlet to make the federation trust use the next certificate as the current certificate, you receive the following error message:

> [PS] C:\>Set-FederationTrust -Identity "Microsoft Federation Gateway" -PublishFederationCertificate  
> Federation certificate with the thumbprint "\<thumbprint of the current certificate>" cannot be found.  
> \+ CategoryInfo : InvalidResult: (:) [Set-FederationTrust], FederationCertificateInvalidException  
> \+ FullyQualifiedErrorId : 906B427C,Microsoft.Exchange.Management.SystemConfigurationTasks

## Cause

This issue occurs if the new certificate is missing from the certificate store. In this case, the Manage Federation Wizard can't roll to the new certificate.

## Resolution

To fix this issue, update the Active Directory object for the federation trust by adding the thumbprint for the next federation certificate to the object. This lets the Manage Federation Wizard or the `Set-FederationTrust` cmdlet successfully process the rollover request.

To do this, follow these steps:

1. Log on to the Exchange 2010 hybrid deployment server as a domain admin.
2. Open Active Directory Service Interfaces (ADSI) Edit. To do this, click **Start**, click **Run**, type `ADSIEdit.msc`, and then click **OK**.
3. After the ADSI Edit window is loaded, right-click **ADSI Edit** in the navigation pane, and then click **Connect To**.
4. In the Connection Settings window, click **Select a well known Naming Context** in the **Connection Point** area, and then click **Configuration**.
5. In the **Computer** area, select **Default (Domain or server that you are logged into)**, and then click **OK**.
6. Locate **CN=Configuration, DC=\<DOMAIN>, DC=\<COM>, CN=Services, CN=Microsoft Exchange, CN=\<ORGANIZATION NAME>, CN=Federation Trusts**.

    > [!NOTE]
    > Replace the values in the placeholders (\< >) with the values that are specific to your environment.

7. Right-click **CN=Microsoft Federation Gateway**, and then click **Properties**.
8. Double-click the `msExchFedOrgNextCertificate` property, and then copy the whole value.

    > [!NOTE]
    > This value might be populated only if you experience the issue that's described in the Symptoms section. If the value isn't populated, you can't continue with the remaining steps.

9. Close the `msExchFedOrgNextCertificate` property.
10. Double-click the `msExchFedOrgPrivCertificate` property, and then paste the value that you copied in step 8. The thumbnail of the current certificate will be replaced with the thumbnail of the next certificate.
11. Click **OK** to set the value.
12. Manually force Active Directory replication. Or, wait for the change to replicate throughout your Active Directory infrastructure.

    > [!NOTE]
    > For more information about how to force Active Directory replication, go to [Force replication over a connection](/previous-versions/windows/it-pro/windows-server-2003/cc776188(v=ws.10)).

13. In the Exchange Management Console, run the Manage Federation Wizard again. The current certificate and the next certificate should be the same.
14. Select the **Roll certificate to make the next certificate as the current certificate** check box, and then complete the steps in the wizard.
15. Test the configuration by using the `Test-Federation` cmdlet. The results should show that the validation of the federation certificate was successful.

    > [!NOTE]
    > For more information about the `Test-FederationTrust` cmdlet, go to [Test-FederationTrust](/powershell/module/exchange/test-federationtrust).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Windows Azure Active Directory Forums](https://social.msdn.microsoft.com/Forums/en-US/home?forum=windowsazuread) website.
