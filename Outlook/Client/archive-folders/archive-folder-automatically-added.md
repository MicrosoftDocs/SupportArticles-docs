---
title: Archive folder is automatically added to your Office 365 mailbox
description: Explains why an Archive folder may automatically be added to your Office 365 mailbox
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# Archive folder is automatically added to your Office 365 mailbox

## Summary

An Archive folder has automatically been added to your Office 365 mailbox. At the end of December 2016, Office 365 was updated to automatically create the Archive folder upon any access to the Exchange mailbox, initial or subsequent. 

## Known issues

### Duplicate Archive1 folder

You may get the duplicate folder Archive1 in addition to the Archive folder. If newly archived email is being moved to the Archive1 folder, follow these steps in Outlook and Outlook on the Web: 
 
1. Configure your email account to use Online Mode.  
   - Click **File**, **Account Settings**, **Account Settings...** .    
   - In the **Account Settings** dialog box, click your email account on the **Email** tab, and then click **Change**.    
   - Click to clear the **Use Cached Exchange Mode** checkbox, click **Next**, and then click **Finish**.    
     
2. Close and restart Outlook.    
3. After Outlook restarts, move all content to the folder that is currently designated as the default archive folder. In this case, it is the Archive1 folder.    
4. Delete the non-default folder named Archive .  
5. Close Outlook.    
6. Log into your Exchange Online mailbox via Outlook on the Web ([http://portal.office.com](http://portal.office.com/)).    
7. In the Office 365 portal, click the **Settings** cog, and under **Your app settings**, click the **Mail** option.  
   - Make a note of where the **Mail** setting link is in this menu since later you will need to navigate back to it in a different language    
     
8. Click **General**, and then click **Region and time zone**.Change **Language** to something other than English.  
   - Choose something easy to translate in case you can’t find your way back to these settings.    
     
9. Once you click **Save** to save the new language change, go back into email and notice the folders are all in the new language.  
   - If you chose Español (Mexico), note the Archive1 folder name has been renamed to Archivo.    
     
10. Now, click on the **Settings** cog and navigate to the **Mail** options link under Your app settings again  
   - Change the **General, Regions and time zone, Language** setting back to English (United States).    
     
11. Start Outlook and reset your email account to use **Cached Exchange Mode**.    
 
### Archive folder in unexpected location

You may find your Archive folder in an unexpected location, for example, as a subfolder of Deleted Items. To move the Archive folder to the default location, follow these steps in Outlook on the Web: 
 
1. Configure your email account to use Online Mode.  
   - Click **File**, **Account Settings**, **Account Settings...** .    
   - In the **Account Settings** dialog box, click your email account on the **Email** tab, and then click **Change**.    
   - Click to clear the **Use Cached Exchange Mode** checkbox, click **Next**, and then click **Finish**.    
     
2. Close and restart Outlook.    
3. After Outlook restarts, backup the content of the folder currently designated as the default archive folder. You can do this by creating a new folder and moving the email from the Archive folder to the new folder, or by exporting the Archive folder contents to an Outlook Data File (.pst).    
4. Close Outlook.    
5. Log into your Exchange Online mailbox via Outlook on the Web ([http://portal.office.com](http://portal.office.com/)).    
6. Click the **Mail** tile.    
7. Navigate to the Archive folder that is in the unexpected location.    
8. Delete the Archive folder.
 
    > [!IMPORTANT]
    > Become familiar with steps 9-11 as you must perform those steps immediately after this step.    
9. In the Office 365 portal, click the **Settings** cog, and under **Your app settings**, click the **Mail** option.  
   - Make a note of the location of the **Mail** setting link since you will later need to navigate back to it while the user interface is in a different language    
     
10. Click **General**, and then click **Region and time zone**.Change **Language** to something other than English.  
    - Choose something easy to translate in case you can’t find your way back to these settings.    
     
11. Once you click **Save** to save the new language change, go back into email and notice the folders are all in the new language.  
    - If you chose Español (Mexico), note the new folder Archivo has been created as a top level folder.    
     
12. Now, click on the **Settings** cog and navigate to the **Mail** options link under Your app settings again  
    - Change the **General, Regions and time zone, Language** setting back to English (United States). This top level folder is renamed to Archive.    
     
13. Start Outlook and reset your email account to use **Cached Exchange Mode**.    
 
## More Information

The One Click Archive feature was available on the web version of Outlook in Office 365 for more than a year before the Outlook 2016 user interface was updated to show the Archive button. If an Archive folder did not exist, clicking on the Archive button in Outlook 2016 would prompt you to create the Archive folder or select an existing folder as the target folder for One Click Archive. However, with the change documented here, the folder has since been created without a prompt or any other user interaction. 

For more information on the One-Click Archive feature in Outlook 2016, see [Archive in Outlook 2016 for Windows](https://support.office.com/article/Archive-in-Outlook-2016-for-Windows-25f75777-3cdc-4c77-9783-5929c7b47028?ui=en-US&rs=en-US&ad=US).