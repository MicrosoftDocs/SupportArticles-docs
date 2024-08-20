---
title: Some rules are disabled and can't be enabled
description: Explains that some rules may be disabled after you upgrade to Outlook 2010, Outlook 2007, or Outlook 2003 if the size of your rules exceeds the 32-KB limit. Includes several suggested workarounds to decrease the size of your rules.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Rules, search and Printing\Other
  - Outlook for Windows
  - CI 119623
  - CSSTroubleshoot
ms.reviewer: sercast
search.appverid: 
  - MET150
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Office Outlook 2007
  - Office Outlook 2003
ms.date: 01/30/2024
---
# Some rules are disabled, and you receive an error message when you try to create or enable rules in Outlook

_Original KB number:_ &nbsp; 886616

## Symptoms

After you upgrade to Office Outlook 2003 (or later), you may notice that some of your rules are disabled and can't be enabled. Other rules work correctly. If you try to enable the rules that are disabled, you receive the following error message:

> One or more rules couldn't be uploaded to Exchange server and have been deactivated. This could be because some of the parameters aren't supported or there's insufficient space to store all your rules.

## Cause

- Mailboxes on Microsoft Exchange Server 2007, Exchange Server 2010, or Exchange Server 2013

    This behavior occurs if the rules that are in your mailbox exceed the rules quota established for your mailbox. The rules size limit for mailboxes in Exchange Server 2007 (and later) has a default size of 64 KB per mailbox. The total rules size limit is also customizable limit up to 256 KB per mailbox.

- Mailboxes on Exchange Server 2003

    This behavior occurs if the rules that are in your mailbox exceed a size of 32 kilobytes (KB). The total rules size limit for mailboxes on Exchange Server 2003 is 32 KB. The rules limit for Exchange 2003 can't be changed.

In Outlook 2003 and later, the size of rules has increased mostly to provide support for the Unicode format.

## Workaround

If your mailbox is on Exchange Server 2007 or later, you can ask your Exchange administrator to increase the rules quota for your mailbox.

The following example command sets the rules quota to the maximum value of 256 KB.

```powershell
Set-Mailbox john@contoso.com -RulesQuota:256kb
```

The following example command allows you to view the current rules quota for a mailbox.

```powershell
Get-Mailbox john@contoso.com |FL displayname, rulesquota
```

If your Exchange administrator can't increase the rules quota for your mailbox, try one of the following workarounds that apply to all versions of Exchange.

To work around this behavior so that your rules are restored, use one or more of the following methods to decrease the size of your existing rules.

### Method 1

Rename your rules to a shorter name. To rename a rule in Outlook, follow these steps.

For Outlook 2010 and later versions:

1. On the **File** tab, click **Info**.
2. Click **Manage Rules and Alerts**.
3. On the **E-mail Rules** tab, click the rule that you want to rename.
4. Click **Change Rules**, and then click **Rename Rule**.
5. Type a new, shorter name for the rule, and then click **OK**.
6. Click **OK** to close the **Rules and Alerts** dialog box.

For Outlook 2007 and Outlook 2003:

1. On the **Tools** menu, click **Rules and Alerts**.
2. On the **E-mail Rules** tab, click the rule that you want to rename.
3. In the **Change Rule** list, click **Rename Rule**.
4. Type a new, shorter name for the rule, and then click **OK**.
5. Click **OK** to close the **Rules and Alerts** dialog box.

### Method 2

Delete any old rules. To delete a rule in Outlook, follow these steps:

For Outlook 2010 and later versions:

1. On the **File** tab, click **Info**.
2. Click **Manage Rules and Alerts**.
3. On the **E-mail Rules** tab, click the rule that you want to rename.
4. Click the **Delete** button, and then click **Yes** to confirm the deletion.
5. Click **OK** to close the **Rules and Alerts** dialog box.

For Outlook 2007 and Outlook 2003:  

1. On the **Tools** menu, click **Rules and Alerts**.
2. On the **E-mail Rules** tab, click the rule that you want to delete.
3. Click **Delete**, and then click **Yes** to confirm the deletion.
4. Click **OK** to close the **Rules and Alerts** dialog box.

### Method 3

Combine similar rules to reduce the overall size of your rules. If it's possible, combine similar rules to reduce the overall size of your rules. After you have combined similar rules, delete the rules that you don't need anymore. To edit an existing rule in Outlook, follow these steps.

For Outlook 2010 and later versions:

1. On the **File**  tab, click Info.
2. Click **Manage Rules and Alerts**.
3. On the **E-mail Rules** tab, click the rule that you want to rename.
4. Click **Change Rule**, and then click **Edit Rule Settings**.
5. Modify the rule as appropriate.
6. Click **OK** to close the **Rules and Alerts** dialog box. 

For Outlook 2007 and Outlook 2003:  

1. On the **Tools** menu, click **Rules and Alerts**.
2. On the **E-mail Rules** tab, click the rule that you want to edit.
3. In the **Change Rule** list, click **Edit Rule Settings**.

    Modify the rule as appropriate.
4. When you're finished, click **Finish**, and then click **OK** to close the **Rules and Alerts** dialog box.

> [!NOTE]
> If the rule is a client-only rule, you must click **OK** two times to close the **Rules and Alerts** dialog box.

### Method 4

Move your personal folders (.pst) file to a location that has the shortest path name. If you have rules that move e-mail messages to a .pst file, move your .pst file to a location that has the shortest path name as possible. For example, move your .pst file to a location such as C:\\<file_name>.pst. To move your .pst file in Outlook, follow these steps:

1. In the Navigation Pane, right-click **Personal Folders** or the folder name that appears for your .pst file, and then click **Properties for <folder_name>**.

    > [!NOTE]
    > This folder will always be a top-level folder in the Navigation Pane, in **Mail**.

2. On the **General** tab, click **Advanced**.
3. In the **Filename** text box, make a note of the complete path and file name of the .pst file.
4. Click **OK** two times to close the **<folder_name> Properties** dialog box.
5. Quit Outlook.
6. Use Microsoft Windows Explorer to move your .pst file to the new location.

    By default, the location for a .pst file is the drive:\Documents and Settings\\<user_name>\Local Settings\Application Data\Microsoft\Outlook folder. The default location is a hidden folder. To use Windows Explorer to locate this folder, you must first turn on the display of hidden folders. To do this, follow these steps:

      1. In Windows Explorer, click **Folder Options** on the **Tools** menu.
      2. Click the **View** tab.
      3. In the **Advanced Settings** section, click **Show hidden files and folders** under **Hidden files and folders**.
      4. If you want to see all file name extensions, click to clear the **Hide extensions for known file types** check box under **Files and Folders**.

          > [!NOTE]
          > Hidden folders appear dimmed to indicate they are not typical folders.
      5. Click **OK**.

7. Use one of the following methods to open the mail item in Control Panel:

   - To do this on a Windows XP-based computer or on a Windows Server 2003-based computer, click **Start**, click **Control Panel**, click **User Accounts**, and then click **Mail**.

        > [!NOTE]
        > If you are using the Classic view, click **Start**, click **Control Panel**, and then double-click **Mail**.

   - To do this on a Microsoft Windows 2000-based computer, click **Start**, point to **Settings**, click **Control Panel**, and then double-click **Mail**.

8. Click **Show Profiles**, and then click the profile that contains your .pst file.
9. Click **Properties**, and then click **Data Files**.
10. Click the .pst data file that you moved, and then click **Settings**.
11. When you are prompted that the data file could not be found at the old location, click **OK**.
12. Locate and then click your .pst file in the new folder location, and then click **Open**.
13. Click **OK**, and then click **Close** two times.
14. Click **OK**.
15. Quit Control Panel.
16. Restart Outlook.

### Method 5

Clear the **on this machine only** check box. If you use a rule to move e-mail messages to a .pst file, click to clear the **on this machine only** check box unless you are accessing your Exchange Server e-mail from different client computers. To do this in Outlook, follow these steps:

For Outlook 2010 and later versions:

1. On the **File**  tab, click **Info**.
2. Click **Manage Rules and Alerts**.
3. On the **E-mail Rules** tab, click the rule that you want to rename.
4. Click **Change Rule**, and then click **Edit Rule Settings**.
5. Click to clear the **On this machine only** check box if the check box is selected.
6. Complete the **Rules Wizard**. Click **OK** to close the **Rules and Alerts** dialog box.

For Outlook 2007 and Outlook 2003:

1. On the **Tools** menu, click **Rules and Alerts**.
2. On the **E-mail Rules** tab, click the rule that you want to edit.
3. In the **Change Rule** list, click **Edit Rule Settings**.
4. If selected, click to clear the **on this machine only** check box.
5. Complete the Rules Wizard.
6. Click **OK** to close the **Rules and Alerts** dialog box.

    > [!NOTE]
    > If you use client-only rules that point to local resource files, for example moving items to a folder in a .pst file, and you use multiple computers to access Microsoft Outlook, rule conflicts may occur. Therefore, some client-only rules may be disabled.
