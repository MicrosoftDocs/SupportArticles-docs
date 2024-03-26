---
title: How to upgrade your Project global template after you install Project 2013
description: Describes different scenarios for upgrading the global template when you first start Project 2013.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Project 2013 Standard
  - Project Professional 2013
ms.date: 03/31/2022
---

# How to upgrade your Project global template after you install Project 2013

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require you to reinstall the operating system. Microsoft cannot guarantee that these problems can be resolved. Modify the registry at your own risk.

## Summary

Assume that you install Microsoft Project 2013 on a computer on which an earlier version of Project is installed. When you first start Project 2013, you're prompted to select options for upgrading the global template.

## More Information

### Project 2007 is already installed on the computer

When a user starts Project for the first time after it's installed and Project 2007 is already installed on the computer, the user is presented with the Planning Wizard. The wizard presents the following options: 

- **Upgrade automatically. Design customization items will be copied to Microsoft Project automatically**. If the user selects this option, the global template will be upgraded. The user is then presented with the Welcome to Project screen.

  If the user selects Start, the user will be walked through each section of the wizard that is listed at the top of the window. When the user finishes the walk-through, the user sees a screen that displays a dummy project plan.

  If the user instead selects the Skip intro link, the user is presented directly with the screen that displays the dummy project plan.  

  In either case, the user should close the dummy project plan, either through File/Close or by pressing the "X" in the upper-right corner. After the user does so, the user will be presented with the usual first screen whenever starting Project.
- **Upgrade manually. You can choose which items you want to copy to Microsoft Project.** If the user selects this option and then clicks **OK**, the user is presented with the **Organizer** dialog box. This gives the user the opportunity to select the items that the user wants to upgrade. 

  Should the user click **Cancel** at any time, the user is presented with the same screens that were described earlier and should follow the same actions. However, the user's global template won't yet be upgraded with the user's previous customizations.

  The next time that the user starts Project, the user will again be presented with the initial Planning Wizard. This behavior will continue until the option to automatically upgrade is selected or a manual upgrade is performed or until the user selects the **Don't tell me about this again checks box.   
- **Cancel. Don't perform the upgrade at this time.** If the user selects this option and then clicks **OK**, the user will be presented with the same screens that were described earlier and should follow the same actions. However, the user's global template won't be upgraded with the user's previous customizations.

  The next time that the user starts Project, the user will again be presented with the initial Planning Wizard. This behavior will continue until ether the option to automatically upgrade is selected or a manual upgrade is performed.

  If the user clicks **Cancel**, this has the same effect as selecting the **Cancel. Don't perform the upgrade at this time** option.   
- Don't tell me about this again. If a user selects this option together with any one of the previous options, the user won't be presented with the Planning Wizard dialog again. This option is most frequently used when a user does not want to upgrade the Global.mpt file of the user's earlier version but instead wants to start by using a new, default Global.mpt file.    
Notes

- Whichever option the user selects, the user's previously used Global.mpt file will still be present on the user's system. It's located in the file share as stated in the Planning Wizard. The user can upgrade the Global.mpt file at any time after the installation of Project 2013.    
- If a user wants to have a clean Global.mpt file at any time, the user's existing Global.mpt file can be deleted from the file system. (However, Project must not be running at the time.) In this situation, the next time that Project is started, it creates a new default template. However, all previous customizations will be lost, including any custom VBA macros. It may be prudent for the user to make a Backup copy of any Global.mpt file before deletion.   

### Project 2010 is already installed on the computer

When a user starts Project the first time after it is installed and Project 2010 is already installed on the computer, the user is presented with the Planning Wizard.

It's almost identical to the wizard that is presented when an upgrade from Project 2007 is performed. The main difference is that the path that contains the original Global.mpt file includes the number 14 instead of 12. (The number 12 in this path indicates the earlier version of Project.)

Other than this, the process is identical to the process that is outlined in "Project 2007 is already installed on the computer."

### How to enable the Planning Wizard

Important Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

If users aren't sure whether they followed the instructions correctly during the first use of Project 2013, they can force Project to start in such a way that it gives them the same initial options that were originally presented. The users can then be guided through the Planning Wizard process. 

To force the Planning Wizard to reappear when Microsoft Project is started, enable or add the following registry key or registry value on the user's computer. To do so, follow these steps.

**Note** These steps are the same regardless of whether it's an upgrade from Project 2007 or from Project 2010.

**Important** Before you begin to edit the registry, you should back it up. You can back up the whole registry or only the part that you're changing.

To back up the whole registry, follow these steps:

1. Click **Start**, and then click **Run**.    
2. In the **Open** box, type regedit.    
3. In the navigation pane, click **My Computer** to export all the registry.    
4. On the **Registry** menu, click **Export Registry File**.    
5. Browse to a location to store the exported file, and then type a name for the new file.

To edit the registry to force the Planning Wizard to reappear when Microsoft Project is started, follow these steps:

1. Click **Start**, and then click **Run**.    
2. In the **Open** box, type regedit.    
3. In the navigation pane, move to the following location: 

   **HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\MS Project**   
4. Under this node location, check whether a **Previous Global** node exists.   
5. If a **Previous Global** node exists, select it. If a **Previous Global** node doesn't exist, go to step 10.    
6. In the right-side pane, you see the **No Alert** value name. Select **No Alert**.    
7. In the right-side pane, you again see the **No Alert** value name. Double-click **No Alert**.   
8. In the **Value Data** box, type 0 (zero).   
9. Exit Registry Editor.    
10. If a **Previous Global** node doesn't exist, right-click **MS Project**.    
11. Point to **New**, and then click **Key**. A new key appears with a temporary name.   
12. Type Previous Global as the name for the new key, and then press Enter.    
13. Right-click **Previous Global**.    
14. Point to **New**, and then click **DWORD Value**. The new value appears with a temporary name.    
15. Type No Alert for the new value, and then press Enter.    
16. Double-click **No Alert**.   
17. In the **Value Data** box, type 0 (zero).   
18. Exit Registry Editor.    

### No earlier version of Project is installed

When a user starts Project the first time after it is installed and no earlier version of Project is installed, the user is presented with the **Welcome to Project** screen. It's a dummy project plan, and you can safely close it without saving. You can do so either through **File**/**Close** or by pressing the "X" in the upper-right corner. After you do so, you'll be presented with the usual first screen whenever you start Project.