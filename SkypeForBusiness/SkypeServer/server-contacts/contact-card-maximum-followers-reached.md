---
title: Lync contact card displays Maximum Followers Reached
description: The Lync  contact will not display presence and display a Maximum Followers Reached message when the maximum number of subscriptions for category has been reached or exceeded for that Lync user (contact)
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: skype-for-business-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: seemarah 
ms.custom: CSSTroubleshoot
appliesto:
- Lync Server 2010 Enterprise Edition
- Lync Server 2010 Standard Edition
- Lync Server 2013
---

# Lync contact card includes the message - Maximum Followers Reached

## Symptoms

- A Lync contact might display no presence and will have a contact card that includes the message - Maximum Followers Reached   
- The following warning event will be logged in the Lync Server Event log:

    ```adoc
    Log Name: Lync Server
    Source: LS User Services
    Event ID: 32078
    Level: Warning
    User: N/A
    OpCode:
    Logged: mm/dd/yyyy hh:mm:ss AM|PM
    Task Category: (1006)
    Keywords: Classic
    Computer: server01.contoso.com
    Description:
    Reached the maximum category subscriptions per publisher limit for one of the users.The last user who reached the limit is cashton@contoso.com. Use Dbanalyze or Snooper resource kit tools to see the complete list of users who reached the limit
    Cause: 
    A user has reached the limit for maximum category subscriptions per publisher. Check the event log description for more details
    Resolution:
    Please use server management tools to change the limit. Increasing the limit to a higher value might have performance implications
    ```

## Cause

A Lync user has been added as a contact by another Lync user and has reached or exceeded the maximum category subscriptions per publisher limit specified by the current Lync server presence policy. 

InformationWhen one Lync user adds another Lync user as a contact, the first Lync user is subscribing to five categories of information about the second Lync user. Updates for these categories of information are automatically sent to the first Lync user. The user model assumes a default of 1000 category subscriptions per Lync user. This means that a Lync user could be a contact of as many as 200 other Lync users.

For detailed information on how the MaxCategorySubscription value of the Lync client presence policy impacts Lync user presence, review the TechNet blog listed below:

[What to do if you are too popular?](https://blogs.technet.com/b/jenstr/archive/2010/11/05/what-to-do-if-you-are-too-popular.aspx?commentposted=true#commentmessage)

## Resolution

The following step-by-step information describes how to analyze and update the current presence policy settings for the Lync user's MaxCategorySubscription 

**Using Server 2008**

Perform the following steps from a computer that has the Lync Server Administrative Tools installed:
1. Click on the Start button, then click on All Programs   
2. Click on Microsoft Lync Server, then select Lync Server Management Shell   
3. In the Lync Server Management Shell enter the following PowerShell command:

   **Get-CsPresencePolicy**   

> [!NOTE]
> The output from the Get-CsPresencePolicy command will display the configurations of the Global, Site, and User level presence policies. The default value for MaxCategorySubscription is 1000.

For detailed information on reviewing the MaxCategorySubscription value of a presence policy, review the TechNet article listed below:

[Get-CsPresencePolicy](https://technet.microsoft.com/library/gg398463.aspx)

For detailed information on updating the MaxCategorySubscription value of a presence policy, review the TechNet article listed below:

[Set-CsPresencePolicy](https://technet.microsoft.com/library/gg425782.aspx)

For detailed information on creating a new presence policy, review the TechNet article listed below:

[New-CsPresencePolicy](https://technet.microsoft.com/library/gg412747.aspx)

> [!NOTE]
> Updating MaxCategorySubscription to a higher value could impact network bandwidth on the Lync server network.

**Using Server 2012**

Perform the following steps from a computer that has the Lync Server Administrative Tools installed:

1. Click the Windows logo key to access the Start screen, click on the Lync Server Management Shell tile   
2. Follow steps 2 through 3 that are previously listed in the Using Server 2008 section of this article    

## More Information

For detailed information on Lync Server user models and capacity planning, review the TechNet articles listed below:

- [Lync Server 2010 User Models](https://technet.microsoft.com/library/gg398811%28v=ocs.14%29.aspx)
- [User models in Skype for Business Server](https://technet.microsoft.com/library/gg398811.aspx)
- [Capacity Planning Requirements and Recommendations](https://technet.microsoft.com/library/gg425715%28v=ocs.14%29.aspx)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
