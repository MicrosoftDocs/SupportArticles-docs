---
title: Share calendar and contacts in Microsoft 365
description: Learn how to share calendar and contacts in Microsoft 365.
ms.date: 01/30/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendar\Sharing calendars
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Microsoft 365
search.appverid: MET150
---
# Sharing calendar and contacts in Microsoft 365

_Original KB number:_ &nbsp; 10157

This article discusses the following two topics:

- How to set up a shared calendar or contacts list for your entire organization or large group of users.
- How to Share calendar or contacts with specific users.

**Who is it for?**

Microsoft 365 users who want to share calendar or contacts list to others.

**How does it work?**

We'll begin by asking you the task you want to do. Then we'll take you through a series of steps that are specific to your situation.

**Estimated time of completion:**

30-60 minutes.

## Welcome to the guide

Select the scenario that you're trying to configure for your users. After you select the scenario, follow the step-by-step instructions.

- [Set up a shared calendar or contacts list for my entire organization or large group of users](#which-microsoft-365-plan-do-you-use)
- [Share calendar or contacts with specific users](#what-do-you-want-to-share)

### Which Microsoft 365 plan do you use

Select the plan that your organization subscribes to in Microsoft 365.

Not sure which Microsoft 365 plan your organization uses? Go to [https://portal.microsoftonline.com](https://portal.microsoftonline.com) and login using your Microsoft 365 administrator credentials.

**Small Business:**

If you see the below administrative interface, then you're using the Small Business plan.

:::image type="content" source="media/how-to-share-calendar-and-contacts/small-business-admin-interface.png" alt-text="Screenshot that shows the administrative interface of Small Business plan." border="false":::

**Enterprise | Midsize | Education:**

If you see the below administrative interface, then you're using the Enterprise/Midsize or Education plan.

 :::image type="content" source="media/how-to-share-calendar-and-contacts/enterprise-midsize-edu-plan-admin-interface.png" alt-text="Screenshot that shows the administrative interface of Enterprise, Midsize or Education plan.":::

- [Small Business](#create-a-new-shared-mailbox-and-assign-permissions)
- [Enterprise | Midsize | Education](#create-a-security-group-for-your-organization-or-group-of-users)

### Create a new shared mailbox and assign permissions

To set up a common, shared calendar or contacts list that people in your organization can access and edit, you simply need to create a shared mailbox. After you create the shared mailbox, users that are members of the shared mailbox will be able to access the shared calendar and contacts.

> [!NOTE]
> Because creating a mailbox to be used for shared calendar or contacts list involves creating a shared mailbox, the people that can access the shared calendar or contacts list can also access and respond to email sent to the shared mailbox.

Before you begin, sign in to the Microsoft 365 portal, and then select **Admin** in the top navigation.

1. Go to **Admin** > **Users & Groups**.
2. On the **Users & Groups page**, select **Shared Mailboxes**, and then select **Add**![Add icon](./media/how-to-share-calendar-and-contacts/add-icon.png).
3. On the **Add a shared mailbox** page, enter the following information:

   - **Mailbox name**: This name appears in the address book, on the To field in email, and in the list of shared mailboxes on the Shared Mailboxes page. It's required and should be user-friendly so people recognize what it is.
   - **Email address**: Enter the email address for the shared mailbox. It's required.
4. Select **Next**.
5. On the **Add members** page, select **Add**![Add icon](./media/how-to-share-calendar-and-contacts/add-icon.png).
6. In the search field, type a person's name and then select **Search**. The person is added to the list of members.
7. When you're done adding members, select **Finish**.

> [!NOTE]
> If new users are created in your organization, who need access to this shared calendar or contact list, you'll need to add them to the membership list of shared mailbox.

#### How do I access a shared mailbox

Depending on the email client you choose, the detailed instructions for accessing the shared calendar or contact list are listed below:

##### Outlook

**Open a shared calendar in Outlook**

If you have permissions to a shared mailbox, the shared calendar associated with the shared mailbox is automatically added to your My Calendars list.

1. In Outlook, select **Calendar**.
2. In the folder pane, under **My Calendars**, select the shared calendar.

   :::image type="content" source="media/how-to-share-calendar-and-contacts/select-shared-calendar.png" alt-text="Screenshot that shows the shared calendar selected in the My Calendars page.":::

**Open a shared contacts list in Outlook**

If you have permissions to a shared mailbox, the contacts folder from the shared mailbox is automatically added to your My Contact list.

1. In Outlook, select **People**.
2. Under **My Contacts**, select the contacts folder for the shared contacts list.

   :::image type="content" source="media/how-to-share-calendar-and-contacts/select-contacts-folder.png" alt-text="Screenshot that shows the contacts folder selected under the My Contacts page.":::

##### Outlook Web App

> [!NOTE]
> You can't access shared contacts list for a shared mailbox from Outlook Web App.

**Open a shared calendar using Outlook Web App**

1. Sign in to your Microsoft 365 account using a Web browser. Select **Calendar**.
2. Right-click **OTHER CALENDARS**, and then select **Open calendar**.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/open-calendar.png" alt-text="Screenshot that shows the open calendar option selected.":::

3. In **From Directory**, search for the shared calendar you want to open. Select the shared mailbox you want to open and select **Open**.

     :::image type="content" source="media/how-to-share-calendar-and-contacts/use-from-directory-to-open-calendar.png" alt-text="Screenshot that shows the operation to open a calendar by using From Directory functionality.":::

4. The shared calendar displays in your Calendar folder list.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/shared-calendar-shown.png" alt-text="Screenshot that shows a shared calendar displays in the Calendar folder list.":::

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [The issue wasn't resolved](#the-issue-wasnt-resolved).

### Create a security group for your organization or group of users

To set up a shared calendar or contacts list that people in your organization can access and edit, you need to first create a security group that includes the people that you want to be able to access the shared calendar or contacts list.

> [!NOTE]
> If you already have a security group that contains the people that you want to be able to access the shared calendar or contacts, you can skip to this section.

Before you begin, sign in to the Exchange admin center (EAC) at [https://outlook.office365.com/ecp/](https://outlook.office365.com/ecp/) using your Microsoft 365 tenant administrator credentials. As a Microsoft 365 Enterprises, Midsize, or Education admin, you can also access EAC by selecting **Admin** > **Exchange** in the Microsoft Online Portal.

1. In the EAC, navigate to **Recipients** > **Groups**.
2. Select **New**![New icon](./media/how-to-share-calendar-and-contacts/new-icon.gif) > **Security group**.
3. On the **New security group page**, provide the appropriate details for the security group, including the membership for the new security group.

> [!NOTE]
> If new users are created in your organization, who need access to this shared calendar or contact, you'll need to add them to the security group.

#### Create a shared mailbox and assign Full Access permission for the security group

After you have a security group that includes the people that you want to be able to access the shared calendar or contact list, you need to create a shared mailbox and use the security group that you created in the previous step as the membership list.

After you set up the shared mailbox, users that are members of the security group will be able to access the shared calendar and contacts list.

> [!NOTE]
> Because creating a mailbox to be used for shared calendar or contacts list involves creating a shared mailbox, the people that can access the shared calendar or contacts list will also be able to access and respond to email sent to the shared mailbox.

Before you begin, sign in to the Exchange admin center (EAC) at [https://outlook.office365.com/ecp/](https://outlook.office365.com/ecp/) using your Microsoft 365 tenant administrator credentials. As a Microsoft 365 Enterprises, Midsize, or Education admin, you can also access EAC by selecting **Admin** > **Exchange** in the Microsoft Online Portal.

##### Step 1: Create the shared mailbox

1. Go to **Recipients** > **Shared** > **Add**![Add icon](./media/how-to-share-calendar-and-contacts/add-icon.png).
2. Type values in the required Display name and Email address fields.

   > [!NOTE]
   > The **Send As** permission field isn't required to let your users access the shared calendar and shared contacts list. To provide the members of the security group access to the shared calendar and contacts list, you need to assign them **Full Access** permission to the shared mailbox by editing the shared mailbox after you have created it.
3. Select **Save**, select **Yes** in the **No permission granted** warning dialog box.

##### Step 2: Assign the security group Full Access permission to the shared mailbox

1. In EAC, under **Recipients** > **Shared**, double-click the shared mailbox that you created in the previous step, and then select **Mailbox delegation**. Under **Full Access**, select **Add**![Add icon](./media/how-to-share-calendar-and-contacts/add-icon.png), and then select the security group that you want to be able to access the shared calendar and contacts list for the shared mailbox.

2. Select **Save** to save your changes and create the shared mailbox. These steps let the members of the security group access the shared calendar and contact list.

#### How do I access a shared mailbox

Depending on the email client you choose, the detailed instructions for accessing the shared calendar or contact list are listed below:

##### Outlook

**Open a shared calendar in Outlook**

If you have permissions to a shared mailbox, the shared calendar associated with the shared mailbox is automatically added to your My Calendars list.

1. In Outlook, select **Calendar**.
2. In the folder pane, under **My Calendars**, select the shared calendar.

   :::image type="content" source="media/how-to-share-calendar-and-contacts/select-shared-calendar.png" alt-text="Screenshot that shows the shared calendar selected in the My Calendars list.":::

**Open a shared contacts list in Outlook**

If you have permissions to a shared mailbox, the contacts folder from the shared mailbox is automatically added to your My Contact list.

1. In Outlook, select **People**.
2. Under **My Contacts**, select the contacts folder for the shared contacts list.

   :::image type="content" source="media/how-to-share-calendar-and-contacts/select-contacts-folder.png" alt-text="Screenshot that shows the contacts folder selected in the My Contacts page.":::

##### Outlook Web App

> [!NOTE]
> You can't access shared contacts list for a shared mailbox from Outlook Web App.

**Open a shared calendar using Outlook Web App**

1. Sign in to your Microsoft 365 account using a Web browser. Select **Calendar**.
2. Right-click **OTHER CALENDARS**, and then select **Open calendar**.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/open-calendar.png" alt-text="Screenshot that shows the open calendar tab selected." border="false":::

3. In **From Directory**, search for the shared calendar you want to open. Select the shared mailbox you want to open and select **Open**.

     :::image type="content" source="media/how-to-share-calendar-and-contacts/use-from-directory-to-open-calendar.png" alt-text="Screenshot that shows the operation to open a calendar by using From Directory functionality.":::

4. The shared calendar displays in your Calendar folder list.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/shared-calendar-shown.png" alt-text="Screenshot that shows a shared calendar displays in the Calendar folder list.":::

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [The issue wasn't resolved](#the-issue-wasnt-resolved).

### What do you want to share

Specify if you would like to share either your calendar or contacts with specific users.

> [!NOTE]
> Contacts can only be shared via the Microsoft Office Outlook email client.

- [Calendar](#which-email-client-is-in-use-if-you-want-to-share-calendar)
- [Contact](#which-email-client-is-in-use-if-you-want-to-share-contact)

### Which email client is in use (if you want to share calendar)

Individual users can share calendar with specific users using either Microsoft Office Outlook client or Outlook Web App. Specify which client you would like to use to start sharing.

- [Microsoft Outlook](#what-is-the-organizational-location-of-the-user-youre-sharing-your-calendar-with-in-outlook)
- [Outlook Web App](#what-is-the-organizational-location-of-the-user-youre-sharing-your-calendar-with-in-outlook-web-app)

### What is the organizational location of the user you're sharing your calendar with in Outlook

You can share your calendar with specific users who can be located both within your organization or any external organization (such as an outside partner, vendor etc.)

- [Same organization as me](#share-calendar-within-the-organization-using-microsoft-outlook)
- [External organization](#share-calendar-outside-the-organization-using-microsoft-outlook)

### Share calendar within the organization using Microsoft Outlook

#### To share your calendar

1. Select **Calendar**.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/calendar-tab.png" alt-text="Screenshot that shows the Calendar option selected.":::

2. Select **Home** > **Share Calendar**.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/share-calendar.png" alt-text="Screenshot that shows the Sharing Calendar tab selected.":::

3. In the email that opens, type the name of the person in your organization that you want to share your calendar with in the **To** box. In **Details**, specify the level of details that you want to share with the person in your organization, and then select **Send**.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/send-shared-calendar.png" alt-text="Screenshot of an opening email sending a shared calendar.":::

4. The person in your organization receives the sharing invitation in email, and then select **Open this calendar**.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/open-this-calendar.png" alt-text="Screenshot that shows the Open this Calendar tab selected.":::

5. The shared calendar displays in the person's Calendar list.

#### To change calendar sharing permissions

1. Select **Calendar**.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/calendar-tab.png" alt-text="Screenshot that shows the Calendar option selected.":::

2. Select **Home** > **Calendar Permissions**.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/calendar-permissions-tab.png" alt-text="Screenshot that shows the Calendar Permissions tab selected.":::

3. On the **Permissions** tab, make any changes to the calendar sharing permissions.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/permissions-tab.png" alt-text="Screenshot that shows the setting under Permissions tab.":::

4. Select **OK**.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [The issue wasn't resolved](#the-issue-wasnt-resolved).

### Share calendar outside the organization using Microsoft Outlook

#### To share your calendar

1. Select **Calendar**.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/calendar-tab.png" alt-text="Screenshot that shows the Calendar option selected.":::

2. Select **Home** > **Share Calendar**.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/share-calendar.png" alt-text="Screenshot that shows the Sharing Calendar tab selected.":::

3. In the email that opens, type the name of the person outside of your organization that you want to share your calendar with in the **To** box. In **Details**, specify the level of details that you want to share with the person outside of your organization, and then select **Send**.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/send-shared-calendar.png" alt-text="Screenshot of an opening email sending a shared calendar.":::

   If the following error displays when you try to send your sharing invitation, you have tried to share more details than is supported by the settings in your organization. If this occurs, under Details, choose to share a different level of details. Only an admin in your organization can change the sharing policy settings for your organization. For more information, see the end of this section.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/error-when-sending-sharing-invitation.png" alt-text="Screenshot of an error message when sending a shared calendar.":::

4. The person outside of your organization receives the sharing invitation in email, and then selects **Open this calendar**.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/open-this-calendar.png" alt-text="Screenshot that shows the Open this Calendar tab selected.":::

5. The shared calendar displays in the person's Calendar list.

#### To change calendar sharing permissions

1. Select **Calendar**.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/calendar-tab.png" alt-text="Screenshot that shows the Calendar option selected.":::

2. Select **Home** > **Calendar Permissions**.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/calendar-permissions-tab.png" alt-text="Screenshot that shows the Calendar Permissions tab selected.":::

3. On the **Permissions** tab, make any changes to the calendar sharing permissions.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/permissions-tab.png" alt-text="Screenshot that shows the setting under Permissions tab.":::

4. Select **OK**.

**Did you get the error when trying to share your contacts with people outside your organization?**

- If yes, see [Share calendar and contacts outside the organization using Microsoft Outlook](#share-calendar-and-contacts-outside-the-organization-using-microsoft-outlook).
- If no, see [Complete sharing calendar outside the organization](#complete-sharing-calendar-outside-the-organization).

### What is the organizational location of the user you're sharing your calendar with in Outlook Web App

You can share your calendar with specific users who can be located both within your organization or any external organization (such as an outside partner, vendor etc.)

- [Same organization as me](#share-calendar-within-the-organization-using-outlook-web-app-owa)
- [External organization](#share-calendar-outside-the-organization-using-outlook-web-app-owa)

### Share calendar within the organization using Outlook Web App (OWA)

#### To share your calendar

1. Sign in to your Microsoft 365 account using a web browser. Select **Calendar** > **Share**.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/share-tab-in-calendar.png" alt-text="Screenshot that shows the Share tab in Calendar.":::

2. Type the name or email address of the person you want to share your calendar with in the **Share with** box. This box works just like the **To** box in an email message. You can add more than one person to share your calendar with.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/compose-shared-calendar.png" alt-text="Screenshot that shows the page to compose a shared calendar message.":::

3. After you've added who you want to share your calendar with, select how much information you want them to see. **Full details** will show the time, subject, location, and other details of all items in your calendar. **Limited** **details** will show the time, subject, and location, but no other information. **Availability** only will show only the time of items on your calendar.

4. You can edit the **Subject** if you want.

5. By default, your primary calendar will be shared. If you have created other calendars, you can select one of them to share instead.

6. After you've finished adding people to share with, setting their access levels, and choosing which calendar to share with them, select **Send**. If you decide not to share your calendar right now, select **Discard**.

Each person in your organization that you shared your calendar with will receive an email message telling them that you've shared your calendar with them. People inside your organization will have two buttons on the invitation - one to add your calendar to their calendar view, and another to share their calendar with you. The email will also include a URL that can be used to access the calendar.

:::image type="content" source="media/how-to-share-calendar-and-contacts/add-calendar-button.png" alt-text="Screenshot that shows the ADD CALENDAR button on the invitation.":::

The calendar will display under PEOPLE'S CALENDARS.

:::image type="content" source="media/how-to-share-calendar-and-contacts/calendar-shown-under-peoples-calendars.png" alt-text="The calendar displayed under PEOPLE'S CALENDARS 1" border="false":::

#### To change calendar sharing permissions

1. Right-click the calendar you want to change permission for, and then select **Permissions**.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/change-permissions-on-calendar.png" alt-text="The calendar displayed under PEOPLE'S CALENDARS 2" border="false":::

2. Do one of the following, and then select **Save**:

   - Use the drop-down menu to change the level of details that you're sharing with a person.
   - Select the delete icon![delete icon](./media/how-to-share-calendar-and-contacts/delete-icon.png) to stop sharing your calendar with a person.

        :::image type="content" source="media/how-to-share-calendar-and-contacts/stop-sharing-calendar.png" alt-text="The calendar displayed under PEOPLE'S CALENDARS 3" border="false":::

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [The issue wasn't resolved](#the-issue-wasnt-resolved).

### Share calendar outside the organization using Outlook Web App (OWA)

#### To share your calendar

1. Sign in to your Microsoft 365 account using a web browser. Select **Calendar** > **Share**.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/share-tab-in-calendar.png" alt-text="the Share tab in Calendar" border="false":::

2. Type the name or email address of the person you want to share your calendar with in the **Share with** box. This box works just like the **To** box in an email message. You can add more than one person to share your calendar with.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/compose-shared-calendar.png" alt-text="Screenshot that shows the page to compose a shared calendar message.":::

3. After you've added who you want to share your calendar with, select how much information you want them to see. **Full details** will show the time, subject, location, and other details of all items in your calendar. **Limited** **details** will show the time, subject, and location, but no other information. **Availability** only will show only the time of items on your calendar.

4. You can edit the **Subject** if you want.

5. By default, your primary calendar will be shared. If you have created other calendars, you can select one of them to share instead.

6. After you've finished adding people to share with, setting their access levels, and choosing which calendar to share with them, select **Send**. If you decide not to share your calendar right now, select **Discard**.

If your organization and the organization of the person you're sharing your calendar with are federated through Microsoft 365 or Exchange, the invitation will also have two buttons - one to add your calendar to their calendar view, and another to share their calendar with you.

:::image type="content" source="media/how-to-share-calendar-and-contacts/add-calendar-button.png" alt-text="the ADD CALENDAR button":::

If the external user's organization and your organization are federated through Microsoft 365 or Exchange, the person will see your calendar under PEOPLE's CALENDARS. However, if the external user's organization and your organization aren't federated through Microsoft 365 or Exchange, the user will need to access your mailbox by clicking the URL in the body of the message.

:::image type="content" source="media/how-to-share-calendar-and-contacts/calendar-shown-under-peoples-calendars.png" alt-text="Screenshot that shows the calendar displayed under PEOPLE'S CALENDARS list.":::

#### To change calendar sharing permissions

1. Right-click the calendar you want to change permission for, and then select **Permissions**.

    :::image type="content" source="media/how-to-share-calendar-and-contacts/change-permissions-on-calendar.png" alt-text="Screenshot that shows the permissions tab selected.":::

2. Do one of the following, and then select **Save**:

   - Use the drop-down menu to change the level of details that you're sharing with a person.
   - Select the delete icon :::image type="icon" source="./media/how-to-share-calendar-and-contacts/delete-icon.png" alt-text="Screenshot of the delete icon."::: to stop sharing your calendar with a person.

        :::image type="content" source="media/how-to-share-calendar-and-contacts/stop-sharing-calendar.png" alt-text="Screenshot that shows the save option to save the permission setting.":::

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [The issue wasn't resolved](#the-issue-wasnt-resolved).

### Which email client is in use (if you want to share contact)

You can share contacts with specific users using only Microsoft Office Outlook client.

> [!NOTE]
> Outlook Web App (OWA) doesn't currently support sharing a contacts folder with other people.

#### What is the organizational location of the user you're sharing your contacts with

You can share a contacts folder with people that are located in your organization or outside of your organization by using Microsoft Outlook. For example, you might want to share a contacts folder with a partner or vendor.

- [Same organization as me](#share-contacts-within-your-organization-using-microsoft-outlook)
- [External organization](#share-contacts-outside-your-organization-using-microsoft-outlook)

### Share contacts within your organization using Microsoft Outlook

#### To share your contacts

1. In **People**, in the **Folder Pane**, select the contact folder that you want to share with a person in your organization.

2. Select **Home**. Then, in the **Share** group, select **Share Contacts**.

   :::image type="content" source="media/how-to-share-calendar-and-contacts/share-contacts-tab.png" alt-text="Screenshot that shows the Share Contacts tab in the Home page.":::

3. In the **To** box, enter the name of the recipient for the sharing invitation message. If you want to, you can change the **Subject**.

   :::image type="content" source="media/how-to-share-calendar-and-contacts/send-shared-contact.png" alt-text="Screenshot that shows a sharing invitation message.":::

4. If you want to, request permission to view the recipient's default **People** folder. To do so, select the **Request permission to view recipient's Contacts** folder check box.

   > [!NOTE]
   > If you want to request access to a contacts folder other than the recipient's default **People** folder, you must send an email message that asks for permissions to that particular folder. This option only requests access to the recipient's default **People** folder.

5. In the message body, type any information that you want to include, and then select **Send**. Review the confirmation dialog box, and then if correct, select **OK**.

6. The person in your organization receives the sharing invitation in email, and select **Open this Contacts folder**.

   :::image type="content" source="media/how-to-share-calendar-and-contacts/open-this-contacts-folder.png" alt-text="Screenshot that shows the Open this Contacts folder tab selected.":::

#### To change contact folder sharing permissions

1. In **People**, in the **Folder Pane**, select the contact folder for which you want to change permissions.
2. Select **Folder**. Then, in the **Properties** group, select **Folder Permissions**.

3. On the **Permissions** tab, do one of the following:

   - **Revoke or change access permissions** for everyone In the **Name** box, select **Default**. Under **Permissions**, in the **Permission Level** list, select **None** to revoke permissions or any of the other options to change permissions.
   - **Revoke or change access permissions** for one person In the **Name** box, select the name of the person whose access permissions you want to change. Under **Permissions**, in the **Permission Level** list, select None to revoke permissions or any of the other options to change permissions.

     :::image type="content" source="media/how-to-share-calendar-and-contacts/contacts-properties.png" alt-text="Screenshot that shows the permissions tab in Contact Properties.":::
4. select **OK**.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [The issue wasn't resolved](#the-issue-wasnt-resolved).

### Share contacts outside your organization using Microsoft Outlook

#### To share your contacts

1. In **People**, in the **Folder Pane**, select the contact folder that you want to share with a person in your organization.

2. Select **Home**. Then, in the **Share** group, select **Share Contacts**.

   :::image type="content" source="media/how-to-share-calendar-and-contacts/share-contacts-tab.png" alt-text="Screenshot that shows the Share Contacts tab on the Home page.":::

3. In the **To** box, enter the name of the recipient for the sharing invitation message. If you want to, you can change the **Subject**.

   :::image type="content" source="media/how-to-share-calendar-and-contacts/send-shared-contact.png" alt-text="Screenshot that shows a sharing invitation message.":::

4. If you want to, request permission to view the recipient's default **People** folder. To do so, select the **Request permission to view recipient's Contacts** folder check box.

   > [!NOTE]
   > If you want to request access to a contacts folder other than the recipient's default **People** folder, you must send an email message that asks for permissions to that particular folder. This option only requests access to the recipient's default **People** folder.

5. In the message body, type any information that you want to include, and then select **Send**. Review the confirmation dialog box, and then if correct, select **OK**.

   If the following error displays when you try to send the sharing invitation, sharing contacts with people outside of your organization isn't supported by the sharing policy for your organization. Only an admin in your organization can change the sharing policy for your organization. For more information, see the end of this section.

   :::image type="content" source="media/how-to-share-calendar-and-contacts/folder-sharing-is-not-available-error.png" alt-text="Screenshot that shows an error displays when sending the sharing invitation.":::

6. The person in your organization receives the sharing invitation in email, and selects **Open this Contacts folder.

   :::image type="content" source="media/how-to-share-calendar-and-contacts/open-this-calendar.png" alt-text="Screenshot that shows the Open this Calendar tab selected.":::

#### To change contact folder sharing permissions

1. In **People**, in the **Folder Pane**, select the contact folder for which you want to change permissions.

2. select **Folder**. Then, in the **Properties** group, select **Folder Permissions**.

3. On the **Permissions** tab, do one of the following:

   - **Revoke or change access permissions** for everyone In the **Name** box, select **Default**. Under **Permissions**, in the **Permission Level** list, select **None** to revoke permissions or any of the other options to change permissions.
   - **Revoke or change access permissions** for one person In the **Name** box, select the name of the person whose access permissions you want to change. Under **Permissions**, in the **Permission Level** list, select None to revoke permissions or any of the other options to change permissions.

     :::image type="content" source="media/how-to-share-calendar-and-contacts/contacts-properties.png" alt-text="Screenshot that shows the permissions tab in Contact Properties.":::

4. select **OK**.

**Did you get the error when trying to share your contacts with people outside your organization?**

- If yes, see [Share calendar and contacts outside the organization using Microsoft Outlook](#share-calendar-and-contacts-outside-the-organization-using-microsoft-outlook).
- If no, see [Complete sharing calendar outside the organization](#complete-sharing-calendar-outside-the-organization).

### The issue wasn't resolved

Sorry, we couldn't resolve your issue with this guide. Provide feedback on this walkthrough, and then use the resources below to continue troubleshooting.

Visit the [Microsoft 365 Community](https://go.microsoft.com/fwlink/?linkid=2003907) for self-help support. Do one of the following:

- Use search to find a solution to your issue.
- Use the Help Center or the Troubleshooting tool that are both available from the top of every community page.
- Sign in with your Microsoft 365 admin credentials, and then post a question to the community.

### Share calendar and contacts outside the organization using Microsoft Outlook

If you receive sharing policy errors when you try to send calendar or contact folder sharing requests to people outside of your organization, the required sharing policy settings aren't configured in your organizations sharing policy. Sharing contact and calendar information with people outside of your organization must be enabled by a Microsoft 365 administrator in your organization.

Select the role you're in your organization to continue.

- [End User](#share-calendar-outside-the-organization-using-microsoft-outlook-end-user)
- [Microsoft 365 administrator](#change-the-default-sharing-policy-in-microsoft-365)

### Share calendar outside the organization using Microsoft Outlook (End user)

If you're an end user and not a Microsoft 365 administrator, contact your Microsoft 365 administrator and let them know you receive an error when trying to share your calendar or contacts with people outside of your organization. After external sharing has been enabled, you'll be able to share your calendar and contacts with people outside of your organization.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [The issue wasn't resolved](#the-issue-wasnt-resolved).

### Change the default sharing policy in Microsoft 365

If you're a Microsoft 365 administrator, you can change the default sharing policy for your organization if you want to allow people in your organization to share full calendar details with people outside of your organization. You can also allow people in your organization to share a contacts folder with people outside of your organization. Select the plan that your organization subscribes to in Microsoft 365.

#### Microsoft 365 Small Business Plan

Before you begin, sign in to the Exchange admin center (EAC) at [https://outlook.office365.com/ecp/](https://outlook.office365.com/ecp/) using your Microsoft 365 tenant administrator credentials. As a Microsoft 365 Small Business admin, you need to access EAC by using the direct URL. The Microsoft 365 Small Business Microsoft Online Portal doesn't have an option to access EAC.  As a Microsoft 365 Small Business admin, you need to access EAC by using the direct URL. The Microsoft 365 Small Business Microsoft Online Portal doesn't have an option to access EAC.

1. Navigate to **Organization** > **Sharing**.
2. In the list view, under **Individual Sharing**, select the **Default Sharing Policy**, and then select **Edit**![Edit icon](./media/how-to-share-calendar-and-contacts/edit-icon.gif).
3. In the **Sharing Policy** dialog box, select **Sharing with all domains**, and then select **Edit**![Edit icon](./media/how-to-share-calendar-and-contacts/edit-icon.gif).

4. To let your users share full calendar details with people outside of your organization, select **Share your calendar** folder. Then, under **Specify what information you want to share**, select **All calendar appointment information, including time, subject, location and title**.

5. To let your users share a contact folder with people outside of your organization, under **Specify what information you want to share**, select **Share your contacts folder**.
6. In the **Sharing Rule** dialog box, select **Save**.
7. In the **Sharing Policy** dialog box, select **Save** to set the rules for the sharing policy.

#### Microsoft 365 Enterprise | Midsize | Education plan

Before you begin, sign in to the Exchange admin center (EAC) at [https://outlook.office365.com/ecp/](https://outlook.office365.com/ecp/) using your Microsoft 365 tenant administrator credentials. As a Microsoft 365 admin for Enterprises, Midsize, or Education, you can also access EAC by selecting **Admin** > **Exchange** in the Microsoft Online Portal.

1. Navigate to **Organization** > **Sharing**.
2. In the list view, under **Individual Sharing**, select the **Default Sharing** **Policy**, and then select **Edit**![Edit icon](./media/how-to-share-calendar-and-contacts/edit-icon.gif).
3. In the **Sharing Policy** dialog box, select **Sharing with all domains**, and then select **Edit**![Edit icon](./media/how-to-share-calendar-and-contacts/edit-icon.gif).

4. To let your users share full calendar details with people outside of your organization, select **Share your calendar** folder. Then, under **Specify what information you want to share**, select **All calendar appointment information, including time, subject, location and title**.

5. To let your users share a contact folder with people outside of your organization, under **Specify what information you want to share**, select **Share your contacts folder**.

6. In the **Sharing Rule** dialog box, select **Save**.
7. In the **Sharing Policy** dialog box, select **Save** to set the rules for the sharing policy.

After you change the sharing policy, people in your organization will be able to successfully share their full calendar details and contacts with people outside your organization.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [The issue wasn't resolved](#the-issue-wasnt-resolved).

### Complete sharing calendar outside the organization

If you didn't receive an error when you sent the sharing invitation to a person outside of your organization, the required sharing policy settings are already enabled for your organization. You were able to successfully share calendar and contacts with people outside your organization.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [The issue wasn't resolved](#the-issue-wasnt-resolved).
