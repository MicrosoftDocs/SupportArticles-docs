---
title: How to update contact information in Exchange Online in Office 365
description: Describes the kind of contact information that administrators and users can change by using the Exchange admin center in Office 365. Also describes how administrators can limit the kind of contact information that users can change.
author: simonxjx
audience: ITPro
ms.service: exchange-online
ms.topic: article
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.author: v-six
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
---
# How to update contact information in Exchange Online in Office 365

## Introduction

This article describes how administrators and users can update personal contact information by using the Exchange admin center in Microsoft Office 365. It also discusses how administrators can limit the kind of contact information that users can update.

## More information

Administrators and users can update the following personal contact information by using the Exchange admin center:

Photo

General:

- First name
- Initial
- Last name
- Display name

Contact location:

- Street
- City
- State/Province
- ZIP/ Postal code
- Country/Region
- Office

Contact numbers:

- Work phone
- Fax
- Home phone
- Mobile number

> [!NOTE]
> Only managed users can update their personal contact information. Users who are in organizations that use directory synchronization can't update their contact information by using the Exchange admin center. For organizations that use directory synchronization, use on-premises tools to update contact information.

### How to update contact information

> [!NOTE]
> The below instruction is only applicable to the classic OWA, available at [this URL](https://outlook.office365.com/owa/?path=/classic). It will be deprecated in future, and you may need to use alternative ways to update your profile information, like [Microsoft 365 Delve](https://support.microsoft.com/en-us/office/view-and-update-your-profile-in-delve-4e84343b-eedf-45a1-aeb9-8627ccca14ba).

1. Sign in to Outlook Web App.
2. Click **Settings**, and then click **Options**.
3. In the left navigation pane, click **My account**.
4. Make the changes that you want, and then click **Save**.

> [!NOTE]
> The offline address book (OAB) will not be updated for at least 24 hours.

### How administrators can update users' contact information

1. Sign in to the Office 365 portal ([https://portal.office.com](https://portal.office.com)) as an administrator.
2. Click **Admin**, and then click **Exchange**.
3. In the left navigation pane, click **Recipients**, and then click **Mailboxes**.
4. Double-click the user whose contact information you want to change.
5. In the **User Mailbox** window, click **Contact Information**.
6. Make the changes that you want, and then click **Save**.

### How administrators can limit users' ability to update their own contact information

This procedure must be applied to all user role policies in an organization.

1. Sign in to the Office 365 portal ([https://portal.office.com](https://portal.office.com)) as an administrator.
2. Click **Admin**, and then click **Exchange**.
3. In the left navigation pane, click **permissions**, and then click **user roles**.
4. Select the role that's assigned to the user. By default, the Default Role Assignment Policy is assigned to all users.
5. Click **Edit** (![A screen shot of the Edit icon ](./media/update-contact-information/edit.png)).
6. In the **Role Assignment Policy** window, under **Contact Policy**, make sure that the **MyContactInformation** and the **MyProfileInformation** check boxes are cleared.

    > [!NOTE]
    > You can also control the level of access for the user by clicking to select the two check boxes and then clicking to clear specific options that are listed under the two check boxes.
7. Click **Save**.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
