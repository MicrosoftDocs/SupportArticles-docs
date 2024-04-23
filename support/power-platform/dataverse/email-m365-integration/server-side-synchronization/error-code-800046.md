---
title: Help with error code 800046
description: Provides a resolution for the error code 800046 in Microsoft Dataverse.
ms.date: 04/23/2024
ms.custom: 
author: rahulmital
ms.author: rahulmital
---
# Help with Error code: 800046

## Symptoms

When a user tries to Test and Enable a mailbox and the associated Graph user does not have an Exchange subscription.  

## Cause

Test and Enable failed because the user associated with the email address does not have a valid Exchange license.  

## Resolution

Verify that the user has a valid Exchange license assigned.  Step by Step process to fix this problem:  

1. Assign licenses by using the Licenses page. 

   1. In the admin center, go to the Billing > Licenses page. 
   2. Select product. 
   3. On the product details page, select Assign licenses. 
   4. In the Assign licenses to user’s pane, begin typing a name, and then choose it from the results to add it to the list. You can add up to 20 users at a time. 
   5. Select Turn apps and services on or off to assign or remove access to specific items. 
   6. When you're finished, select Assign, then close the right pane. 

   > [!IMPORTANT]
   > Licensed users must be assigned at least one security role to access customer engagement apps. Security roles can be assigned either directly or indirectly as a member of a group team. 

   > [!NOTE]
   > After assigning the Microsoft Dynamics 365 license to the user, it may take a few minutes for this change to sync from Office 365 to Microsoft Dynamics 365. Exchange may also need to create a mailbox for the user which can take additional time. 

2. Verify the user is not in administrative access mode. 

   1. Sign in to your Microsoft Dynamics 365 organization as a user with the System Administrator role. 
   2. Navigate to Settings and then select Email Configuration. 
   3. Select Mailboxes. 
   4. Change the selected view from My Active Mailboxes to Active Mailboxes. 
   5. Open the user's mailbox record. 
   6. Select the user selected in the Owner field to open the User record. 
   7. Expand the Administration tab. 
   8. Verify the Access Mode is set to Read-Write.   

3. Test and Enable the mailbox again. 

   1. Open the mailbox record if it is not already open. 
   2. Select the Test & Enable Mailbox button. 
   3. Wait for the Test & Enable process to complete. If the test results are not Success, review the Alerts area within the mailbox record. 
