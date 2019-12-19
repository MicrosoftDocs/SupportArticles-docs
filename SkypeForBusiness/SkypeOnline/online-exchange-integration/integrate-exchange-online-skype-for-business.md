---
title: Integrate Exchange Online with Skype for Business hybrid deployment
description: Describes the requirements for integrating Exchange Online with Skype for Business Online, Lync Server 2013, or a Lync Server 2013 hybrid deployment. Includes troubleshooting steps and links to additional deployment documentation.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: skype-for-business-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: dahans
ms.custom: CSSTroubleshoot
appliesto:
- Exchange Online
- Skype for Business Online
---

# Integrate Exchange Online with Skype for Business Online, Lync Server 2013, or a Lync Server 2013 hybrid deployment

## Summary

This article discusses the configuration steps and requirements to integrate Exchange Online in Office 365 (with or without an on-premises Exchange Server 2013 deployment in hybrid mode) with Lync Server 2013, Skype for Business Online (formerly Lync Online) in Office 365, or a hybrid combination of both. The following user configurations are considered in this article:

- A user mailbox on Exchange Online integrated with Skype for Business Online  
- A user mailbox on Exchange Online integrated with Lync Server 2013 on-premises
  - In this configuration, directory synchronization isn't required. However, we recommend it.   
  - This configuration is partly supported. See the "More Information" section.    
- A user mailbox on Exchange Online integrated with Skype for Business Online through a Lync Server 2013 hybrid deployment
  - Directory synchronization and single sign-on (SSO) are required as part of setting up a Lync hybrid deployment.   
   
Through integration with Exchange Server 2013, you can provide the following features to your Lync users. However, some features depend on certain steps being taken and therefore will not work until all the steps are finished. This article highlights the features that will be available after that step is finished.

- Connectivity with Exchange Web Services (EWS) provides the following functionality:
  - Outlook integration   
  - Free/Busy   
  - OOF messages   
  - Conversation history   
  - High resolution contact photos   
  - Unified contact store   
- Outlook Web App instant messaging (IM) and presence.   
- Outlook Web App online meeting scheduling.   

## Deployment

1. Configure the Domain Name System (DNS) records for Lync federation and Lync client discovery so that Microsoft Outlook Web App can determine where the user's Lync server is located.
   
   **With Skype for Business Online only**

   DNS Records should all point to Skype for Business Online. For more information, go to the following Microsoft Knowledge Base article:
   
   [2566790](https://support.microsoft.com/help/2566790) Troubleshooting Skype for Business Online DNS configuration issues in Office 365   

   **With Lync Server 2013 or a Lync Server 2013 hybrid deployment**

   DNS records should all point to on-premises. For more information, go to the following Microsoft websites: 
      - [Planning for Lync Server 2013 Hybrid Deployments](https://technet.microsoft.com/library/jj205403.aspx)   
      - [Determine DNS Requirements](https://technet.microsoft.com/library/gg398758.aspx)   

    > [!IMPORTANT]
    > Stop here if you're using only Exchange Online integrated with Skype for Business Online. The following steps apply only if you’re using on-premises Lync or Exchange resources.

2. Make sure that Exchange Online has access to the user's Lync SIP address. Exchange uses the Active Directory ProxyAddresses attribute to determine the user's Session Initiation Protocol (SIP) address. If the attribute doesn't contain the user's SIP address, Outlook Web App won't be able to connect.

   **With Lync Server 2013 only (with directory synchronization)**

   No additional action is required.

    **With Lync Server 2013 only (without directory synchronization)**
      - Directory synchronization is recommended for this scenario.   
      - Connect to the Exchange Admin Center (EAC), and then add the user’s SIP address. Use the following Microsoft TechNet website for guidance: [Add or Remove Email Addresses for a Mailbox](https://technet.microsoft.com/library/bb123794.aspx)

        > [!NOTE]
        > Make sure that you add the SIP address by using the correct format (for example, sip: **user\@contoso.com**, where **user\@contoso.com** represents the email address of the user).   

    **With Skype for Business Online in a hybrid deployment with Lync Server 2013**
      - Directory synchronization is required for this scenario as part of setting up a Lync hybrid deployment.   
      - No action is necessary beyond implementing DirSync. The msRTCSIP-PrimaryUserAddress attribute is set on-premises and synchronized to Microsoft Office 365.   

3. Make sure that Lync has access to the user’s Exchange email address. After you confirm this step, connectivity with EWS should begin to work.With Lync Server 2013 only (with directory synchronization)If the Lync Server 2013 users never had a mailbox on-premises, you must manually populate the **MAIL** attribute in the on-premises Active Directory schema.
    
     With Lync Server 2013 only (without directory synchronization)
      - Directory synchronization is recommended for this scenario.   
      - Because Lync Server 2013 users don’t have a mailbox on-premises, you must manually populate the MAIL attribute in the on-premises Active Directory schema.   

   With Skype for Business Online in a hybrid deployment with Lync Server 2013
      - Directory synchronization is required for this scenario. Because Skype for Business Online users don’t have a mailbox in the cloud, there's no other way to manually specify the MAIL attribute.   
      - Directory synchronization is a prerequisite for a Lync Server 2013 hybrid deployment.   

4. Configure a shared SIP address space. This integrates on-premises Lync Server 2013 with Exchange Online. The same SIP domain address space is supported by both Lync Server and the Exchange Online service.

  **With Lync Server 2013 or a Lync Server 2013 Hybrid Deployment**

  Using the Lync Server Management Shell, configure the Edge Server for federation by running the Set-CSAccessEdgeConfiguration cmdlet, and use the parameters in the following example:
  
  ```powershell
   Set-CsAccessEdgeConfiguration -AllowFederatedUsers $True 
  ```
  The *AllowFederatedUsers* parameter specifies whether internal users can communicate with users from federated domains. This property also determines whether internal users can communicate with users in a shared SIP address space scenario with Lync Server and Exchange Online.

   For more information, go to the following Microsoft TechNet website: [Configure integration between on-premises Skype for Business Server and Outlook Web App](https://technet.microsoft.com/library/hh533880.aspx)

5. Add a hosting provider. Lync Server has to trust the connection attempt from the Exchange Online Access Edge. After this step is complete, IM and presence should begin to work in Exchange Server 2013 Outlook Web App.

   **With Lync Server 2013 only**

   Run the following cmdlet from Lync Management Shell. (Notice that the EnableSharedAddressSpace flag is set to False.)

   ```powershell
    New-CsHostingProvider -Identity "Exchange Online" -Enabled $True -EnabledSharedAddressSpace $False -HostsOCSUsers $False -ProxyFqdn "exap.um.outlook.com" -IsLocal $False -VerificationLevel UseSourceVerification
   ```

   **With a Lync Server 2013 hybrid deployment**

   Run the same cmdlet that is given for Lync Server 2013 only, but set the EnableSharedAddressSpace flag to True. The EnableSharedAddressSpace flag indicates to Lync that the hosting provider can service users in a shared SIP address space.

    For more information, go to the following Microsoft TechNet website: [Configure integration between on-premises Skype for Business Server and Outlook Web App](https://technet.microsoft.com/library/hh533880.aspx)

6. Add trusted applications.

   > [!NOTE]
   > This step applies to Exchange Online only or to Exchange hybrid customers who are trying to integrate with Lync Server 2013 or Lync hybrid deployments.

    **With Lync Server 2013 or a Lync Server 2013 Hybrid deployment integrating with Exchange Online only**

    No additional action is required. This step isn't needed with Exchange Online.

    **With Lync Server 2013 or a Lync Server 2013 hybrid deployment integrating with an Exchange Server 2013 hybrid deployment**

    Lync Server 2013 and Exchange Server 2013 must be configured to use OAuth for server to server authentication. For more information, go to the following Microsoft TechNet website:

     - [Plan to integrate Skype for Business and Exchange](https://technet.microsoft.com/library/jj721919.aspx)   
     
     Both Lync and Exchange must be added as Partner Applications. For more information about how to configure Partner Applications between Exchange Server 2013 and Lync Server 2013, go to the following TechNet website:
     - [Configure partner applications in Skype for Business Server and Exchange Server](https://technet.microsoft.com/library/jj688151.aspx)   

7. In a Lync Server 2013 or Lync hybrid deployment, make sure that the on-premises Lync Server trusts the Office 365 authentication service. After this last step is complete, the Outlook Web App in Exchange Server 2013 will display the **Online Meeting** link when scheduling a meeting in OWA.

   **With Lync Server 2013 or a Lync Server 2013 hybrid deployment**

   Trusting the Office 365 authentication service enables Lync Server to trust connection attempts from Exchange Online. For more information about this step, go to the following TechNet website:
    - [Configure server-to-server authentication for a Skype for Business Server hybrid environment](https://technet.microsoft.com/library/jj204990.aspx)   

## More information

The following table lists the supported features and configurations for Lync and Exchange integration. For more information about supported Lync hybrid scenarios, go to the following Microsoft TechNet website:

[Integration with Exchange and SharePoint](https://technet.microsoft.com/library/jj945633.aspx)

|Lync and Exchange integration features|Outlook integration (EWS, MAPI)|Outlook Web App integration (IM/P)|Outlook Web App online meetings (scheduling)|Unified Contact Store|High-resolution contact photos|
|----|-----|----|----|---|---|
|Skype for Business Online only|Supported|Supported|Supported|Supported|Supported|
|Lync Server 2013 only|Supported|Supported|Supported|Not supported|Supported|
|Lync Server 2013 hybrid deployment with Skype for Business Online|Supported|Supported|Supported|Supported*|Supported|

*Supported only for Skype for Business Online users in the hybrid deployment.

The following Microsoft Knowledge Base articles will help you troubleshoot specific features of Exchange and Lync integration. If you’re still having problems with any specific feature after you follow the steps in this article, see the appropriate articles in this section for more information.

### Integration with Outlook and Exchange Web Services

- [2436962 ](https://support.microsoft.com/help/2436962) "There was a problem connecting to Microsoft Office Outlook. The email address used in your default Outlook profile is different" error message when you sign in to Skype for Business Online   
- [2787614 ](https://support.microsoft.com/help/2787614) Conversation history, contact cards, Free/Busy, and Out of Office information are unavailable when Lync fails to connect to Exchange   
- [2298541 ](https://support.microsoft.com/help/2298541) You’re repeatedly prompted for Exchange credentials after you sign in to Lync   

### Exchange Unified Contact Store and the Lync contact list

- [2435699 ](https://support.microsoft.com/help/2435699) Contacts in Skype for Business Online appear offline or aren't searchable in the address book   
- [2811654 ](https://support.microsoft.com/help/2811654) Lync contact list is empty or read-only after a user's Exchange mailbox is disconnected, unlicensed, or moved   
- [2757458 ](https://support.microsoft.com/help/2757458) Users are unable to modify their contact lists in Lync 2010 and Lync for Mac 2011   

### Exchange high-resolution contact photos in Lync

- [2497721 ](https://support.microsoft.com/help/2497721) User contact photos in Lync aren't displayed correctly   
- [2860366 ](https://support.microsoft.com/help/2860366) You can't upload a photo from Lync 2013 to Skype for Business Online   

### Instant messaging and online meeting scheduling in Outlook Web App

- [2565604 ](https://support.microsoft.com/help/2565604) Can't schedule Skype for Business Online meetings, see presence info, or send IMs from Outlook Web App in Office 365   

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
