---
title: Users don't receive SharePoint Online alert notifications
description: This article describes an issue that users don't receive SharePoint Online alert notifications, and provides a solution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-six
appliesto:
- SharePoint Online
---

# Users don't receive SharePoint Online alert notifications

## Problem

In an Office 365 environment, users don't receive SharePoint Online alert notifications as expected. Specifically, users may experience one or more of the following symptoms:  

- Alert email messages aren't received after an alert is created.

- Alerts don't work. Alerts aren't received.

- Task list notifications don't work.

- Workflow email messages aren't received.

- The workflow doesn't work.

## Solution

To resolve this issue, follow these steps:

1. Investigate the user's permissions for the list, for the library, or for the task list. Make sure that the user account has at least Read permissions on the object.

    - If these permissions are present, go to step 2.
    
    - If these permissions aren't present, direct the user to the site administrator to have these permissions corrected.

1. Verify that new alerts work. To do this, create a new alert on a test library or on a test list. Perform an action to generate the alert. For example, add, edit, or delete an item. Then, wait 15 minutes. If the alert isn't received, collect the following information, and then contact Microsoft Office 365 technical support:

    - Verify the last known time that alerts were received.
    
    - Record the exact steps to reproduce the issue in the new alert.

1. If the new alert is received but existing alerts aren't received, delete and then re-create all the user's alerts on the site. To do this, follow the steps in the following "Delete and re-create alerts" section.

### Delete and then re-create alerts

To restore alert notification functionality, delete and then re-create all alerts. These steps must be performed on every site and on every subsite where the issue occurs. Be aware that fixing alerts on the root site doesn't resolve the issue on all subsites. 

To delete and re-create an alert, follow these steps:

1. Browse to the user's alert settings in SharePoint Online.

1. Click the gear icon for the **Settings** menu, and then click **Site settings**.

1. Under **Site Administration**, click **User alerts**.

1. Select the user account in the **Display alerts for** drop-down selection.

1. Select all alerts, and then click **Delete Selected Alerts**.

1. Set up a new alert. To do this, follow these steps:

    1. Browse to the list or library where you would like to create the alert.
    
        - If it's a library, click the LIBRARY tab, click **Alert Me** on the ribbon, and then click **Set alert on this library**.
            
        - If it's a list, click the LIST tab or the CALENDAR tab (depending on the kind of list.). Click **Alert Me** on the ribbon, and then click **Set alert on this list**.
    
    1. Use the default settings on the New Alert page to set up the new alert, and then click **OK**.

1. Test alert functionality. Perform an action to generate the alert. For example, add, edit, or delete an item. Then, wait 5 to 10 minutes to receive the alert.

1. Complete these steps for the alerts you deleted in step 5.

## More information

This issue may occur if permissions aren't granted to the user's account in order to access the sites, the library, or the list in which the user wants to use alert functionality. This means that users must have permissions to the list or to the library for alerts and to the task list for tasks and for workflows.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
