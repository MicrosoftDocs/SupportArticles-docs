---
title: Lync client administrative delegates cannot use the Lync Meeting add-in
description: Describes an issue in which the delegate receives You do not have permissions to schedule Lync Meetings on behalf of the owner of this account error message.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: skype-for-business-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: miadkins 
ms.custom: CSSTroubleshoot
appliesto:
- Lync 2010
- Lync 2013
- Skype for Business 2015
---

# Lync client administrative delegates cannot use the Lync Meeting add-in to create a meeting for their manager

## Symptoms

Assume that a Microsoft Lync-enabled user account is configured by using one of the following telephony settings: 

- PC-to-PC only    
- Audio/video disabled    
- Remote call control    
- Remote call control only   

> [!NOTE]
> This article does not address similar issues that occur when Lync user accounts are configured by using a telephony setting of Enterprise Voice.

In this situation, the following two symptoms occur. These symptoms are caused by the following two separate configuration issues.

### Issue 1

- The Lync meeting administrative delegate receives the following error message when he or she tries to use the Lync Meeting add-in in Microsoft Outlook to create a meeting for his or her Lync meeting manager: 

    ```adoc
    You do not have permissions to schedule Lync Meetings on behalf of the owner of this account. Please contact the owner of the account to get delegate permissions in Microsoft Lync.
    ```
- The Lync meeting administrative delegate does not list her or his Lync meeting manager as a contact in the **People I Manage Calls For** contact group of her or his Lync client.   
- The Lync meeting manager lists his or her Lync meeting administrative delegate as a contact in the **Delegates** contact group of his or her Lync client.

### Issue 2

The Lync meeting administrative delegate does not receive a response from the Lync Meeting add-in in Outlook when the delegate tries to create a meeting for his or her Lync meeting manager.   

## Cause

**Issue 1**

The Lync meeting manager cannot complete the configuration process that is required to enable his or her selected Lync meeting delegate. This can be caused by timing issues that exist between the two Lync clients that will be participating in the Lync meeting delegation relationship.

**Issue 2**

The Lync meeting manager removed his or her Lync meeting delegate from the Calendar Access configuration on the **File** tab's **Account Settings** section of his or her Outlook client.

## Resolution

This troubleshooting process requires all Lync users who will be sharing the Lync meeting delegation relationship to be present at their client computers. These Lync users will have to have their Outlook clients and Lync clients open. Make sure that these users can communicate with one another throughout this step-by-step process.

### Issue 1

Follow these steps on the Lync meeting manager's Windows client computer:

1. With the Lync client open, locate the Lync meeting administrative delegate in the **Delegates** contact group, and then select it.

    > [!NOTE]
    > If the Lync meeting administrative delegate is not in the **Delegates** contact group, go to step 4.

2. Right-click the selected contact, and then select the **Remove from group** option from the list.

    > [!NOTE]
    > If this is the removal of the last contact in the **Delegates** contact group, the **Delegates** contact group will be removed from the Lync client because it is no longer needed. 

3. Wait for approximately five minutes for the updated Lync user information to complete its replication process.   
4. Access the notification area icon on the desktop of the Windows client.   
5. Right-click the Lync icon, and then click the **Exit** menu option.   
6. Open the Lync meeting manager's Outlook client.   
7. On the Outlook client's **File** tab, click **Account Settings**, and then select the **Delegate Access** link.   
8. Locate and then select the nonfunctional Lync meeting administrative delegate from the Outlook delegates' list. If the Lync meeting administrative delegate is not in the Outlook delegates' list, go to step 12.   
9. Click **Remove** to remove the delegate from the **Delegate Access** list.   
10. Click OK button to accept the changes and close the **Delegate Access** dialog box.   
11. Open the Lync client, and then sign back in.    
12. Follow steps 6 through 8 and then go to step 14   
13. In the **Outlook Delegates** dialog box, click **Add**, and then select the administrative delegate from the Exchange global address list (GAL).   
14. Click **Add**, and then click **OK**.    
15. In the **Outlook Delegate permissions** dialog box, click **OK** to add the default permissions for the administrative Lync meeting delegate to the Calendar and Tasks folders of the Lync meeting manager's Exchange mailbox.

    > [!NOTE]
    > The administrative Lync meeting delegate requires SendOnBehalf and Editor permissions on the Calendar folder of the Lync meeting manager's Exchange mailbox.

16. In the **Outlook Delegates** dialog box, click **OK** to complete the process. 

### Issue 2

Follow these steps on the Lync meeting manager's Windows client computer:

1. With the Lync client open, locate the Lync meeting administrative delegate in the **Delegates** contact group, and then select it.

    > [!NOTE]
    > If the Lync meeting administrative delegate is not in the **Delegates** contact group, go to step 3.

2. Right-click the selected contact, and select the **Remove from group** option from the list. Wait for approximately five minutes for the updated Lync user information to complete the replication process.

    > [!NOTE]
    > If this is the removal of the last contact in the **Delegates** contact group, the **Delegates** contact group will be removed from the Lync client because it is no longer needed.

3. Access the notification area icon on the desktop of the Windows client computer.   
4. Right-click the Lync icon, and then click **Exit**.   
5. Open the Lync meeting manager's Outlook client.   
6. On the Outlook client's **File** tab, click **Account Settings**, and then select the **Delegate Access** link.   
7. Open the Lync client, and then sign back in.   
8. In the **Outlook Delegates** dialog box, click **Add**, and then select the administrative delegate from the Exchange global address list (GAL).   
9. Click **Add**, and then click **OK**.   
10. In the **Outlook Delegate permissions** dialog box, click **OK** to add the default permissions for the administrative Lync meeting delegate to the Calendar and Tasks folders of the Lync meeting manager's Exchange mailbox.

    > [!NOTE]
    > The administrative Lync meeting delegate requires Editor permissions on the Calendar folder of the Lync meeting manager's Exchange mailbox. 

11. In the **Outlook Delegates** dialog box, click **OK** to complete the process.

> [!IMPORTANT]
> After you follow the steps that were mentioned for issue 1 or issue 2, the Lync meeting manager's Lync client will add the Lync meeting administrative delegate to their **Delegates** contact group, and the Lync meeting administrator's Lync client will add the Lync meeting manager's contact to their **People I manage Calls For** contact group. If this does not occur within 10 minutes, review the troubleshooting steps in the "More Information" section.

> [!NOTE]
> If this is the first administrative delegate to be added for the Lync meeting manager, the **Delegates** contact group will be added to the UI of the manager's Lync client, and then the Lync meeting administrative delegate will be added to the **Delegates** contact group. If this is the first manager to be added for the Lync meeting administrative delegate, the **People I Manage Calls For** contact group will be added to the UI of the delegate's Lync client, and the Lync meeting manager will be added to the **People I Manage Calls For** contact group.

## More Information

The addition of the **Delegates** and the **People I Manage Calls For** contact groups and their respective contacts that are paired for the Lync meeting delegation roles depend on the Lync client's ability to complete a network connection to the Exchange server's MAPI service. This network connection is administered by the Lync client's built-in UCMAPI service. The MAPI connection to the Exchange server's MAPI service makes sure that the administrative delegate has the appropriate permissions for Lync meeting administration applied to the calendar folder of the Lync meeting manager's mailbox before the Lync meeting delegation relationship is established. Creating the contact groups and their respective contacts should take approximately 10 minutes. 

If this process takes more than 10 minutes, follow these steps to make sure that the Lync clients can complete the needed MAPI connection to the Exchange server MAPI service. You can follow these steps on the Lync client of either the Lync meeting manager or the Lync meeting administrative delegate.

1. Make sure that the Lync client is open and functional.   
2. Access the notification area icon on the desktop of the Windows client computer.   
3. Hold down the CTRL key, and right-click the Lync icon that is located in the notification area.   
4. Click **Configuration information**.   
5. Scroll down to locate the **MAPI Information** entry in the list that is displayed.   
6. If the connection is valid, the **MAPI Status** area will display **MAPI Status Ok**. This means that the failure to establish the Lync meeting delegation relationship is not caused by network connectivity issues between the Lync client and the Exchange server MAPI service.   
7. If the Lync client’s **MAPI Status** reads area contains the following text, there may be connectivity issues between the Lync client and the Exchange MAPI service:

    ```adoc
    Lync is in the process of connecting to the Exchange server. This process may take a few minutes. Some features will not be available until the connection is complete.;MAPI unavailable; retrying connection;
    ```

    If this error message persists, the Lync meeting delegation functionality will not be rendered by the Lync client and server services. Troubleshooting the issue at this point will require knowledge of the Exchange server deployment and its supportive network environment. If this is the case, please contact Microsoft support for help in troubleshooting this issue.   

> [!NOTE]
> Lync Basic does not include any Delegate functionality, and problems may occur for Lync Basic client users who have delegates.

For more information, see [Client comparison tables for Lync Server 2013](https://technet.microsoft.com/library/gg425836%28v=ocs.15%29.aspx).
