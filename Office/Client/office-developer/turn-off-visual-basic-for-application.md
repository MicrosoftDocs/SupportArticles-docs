---
title: How to turn off Visual Basic for Applications when you deploy Office
description: Describes that how to turn off Visual Basic for Applications when you deploy Office.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
appliesto:
- Office Professional Plus 2016
- Office Standard 2016
- Office Standard 2013
- Office Professional 2013
- Office Home and Student 2013
- Office Home and Business 2013
- Office Professional Plus 2013
- Office Standard 2010
- Office Professional 2010
- Office Home and Student 2010
- Office Home and Business 2010
- Office Professional Academic 2010
- Office Professional Plus 2010
- Microsoft Office Standard Edition 2003
- Microsoft Office Professional Edition 2003
---

# How to turn off Visual Basic for Applications when you deploy Office

## Summary

This article describes how to disable Microsoft Visual Basic for Applications during the deployment of the versions of Microsoft Office that are listed in the "Applies To" section.

## More Information

Visual Basic for Applications, although not a security risk in itself, can be used by other users to compromise security. However, you can install Office without Visual Basic for Applications support. 

The following methods can be used to remove Visual Basic for Applications support in Office. 

Note The Custom Maintenance Wizard and the Custom Installation Wizard can be used only with the Enterprise edition of Microsoft Office. 

### Method 1: Custom Installation Wizard

> [!NOTE]
> This method can be used only with the Enterprise edition of Microsoft Office.

The Custom Installation Wizard is included with the Microsoft Office Resource Kit (ORK). The wizard can be used to create a custom TRANSFORM file that is used with Setup.exe to customize the installation of Office features during Setup. To create a TRANSFORM file that removes Visual Basic for Applications support during installation, follow these steps.

> [!NOTE]
> To create the TRANSFORM file , you must install the ORK. You can install the ORK from the ORK folder on the CD for an Enterprise edition of Office. 

1. Start the Custom Installation Wizard, and then click **Next**.   
2. In the **Name and path of MSI file to open** box, type the full path and file name of your .msi file, and then click Next two times.

    **Note** An .msi file is included with the Office installation CD. For example, type D:\PROPLUS.MSI.   
3. In the **Name and path of MST file** box, type the path and file name with which you want to save your custom Setup file, and then click Next three times.   
4. In the Set Feature Installation States page of the Custom Installation Wizard, in the **For each of the following Microsoft Office features, click to select the default installation state** list, expand Office Shared Features.   
5. Click **Visual Basic for Applications**, and then click Not Available, Hidden, Locked. 

    You receive the following message:

    **You have chosen not to install Visual Basic for Applications. Microsoft Access requires this component and will not be installed if you continue. Additional features in Microsoft Office, including some wizards and templates, will not work properly.**

    **Do you want to install Microsoft Office without Visual Basic for Applications?**

6. Click **Yes**, and then click **Finish**. After the transform file is created, click **Exit** to exit the Custom Installation Wizard.   

For more information about how to cutomize Office installations and about how to use the Custom Installation Wizard, go to the following Microsoft websites: 

Office 2016

[(Preview) Office 2016 Administrative Template files (ADMX/ADML) and Office Customization Tool](https://www.microsoft.com/download/details.aspx?id=49030)

Office 2013

[Use the OCT to customize Office 2013](https://technet.microsoft.com/library/cc179132%28v=office.15%29.aspx)

[Customize Setup before installing Office 2013](https://technet.microsoft.com/library/cc179121.aspx)

Office 2010

[Customize Office 2010](https://technet.microsoft.com/library/cc179132%28v=office.14%29.aspx)

The 2007 Office system

[Customize the 2007 Office system](https://technet.microsoft.com/library/cc179132%28office.12%29.aspx)

### Method 2: Custom Maintenance Wizard

> [!NOTE]
> This method can be used only with the Enterprise edition of Microsoft Office.

The Custom Maintenance Wizard is included with the Microsoft Office Resource Kit (ORK). The wizard is used to create a Custom Maintenance Wizard customization file (CMW file) that can be used to update an existing Office installation. To create a CMW file to remove Visual Basic for Applications support, follow these steps.

> [!NOTE]
> To create the CMW file , you must install the ORK. You can install the ORK from the ORK folder on the CD for an Enterprise edition of Office. 

1. Start the Custom Maintenance Wizard, and then click Next.   
2. In the **Name and path of MSI file to open** box, type the full path and file name of your .msi file, and then click Next two times.

    **Note** An .msi file is included with the Office installation CD. For example, for Microsoft Office XP Professional Plus, you would type     D:\PROPLUS.MSI.   
3. Click Next two times, and then on the Set Feature Installation States page, in the **For each of the following Microsoft Office features, click to select the desired installation state** list, expand Office Shared Features.   
4. Click Visual Basic for Applications, and then click Not Available, Hidden, Locked.

    You receive the following message:

    **You have chosen not to install Visual Basic for Applications. Microsoft Access requires this component and will not be installed if you continue. Additional features in Microsoft Office, including some wizards and templates, will not work properly.**

    **Do you want to install Microsoft Office without Visual Basic for Applications?**

5. Click Yes, and then click Finish. After the Custom Maintenance Wizard configuration file (CMW file) is created, click Exit to exit the Custom Maintenance Wizard.   

### Method 3: System Policy

System Policy Editor is included with the Microsoft Office Resource Kit (ORK). System Policy Editor can be used to turn off Visual Basic for Applications support for Office programs.

Turning on the **Disable VBA for Office applications** policy sets the VBAOFF DWORD value to 1 in the following registry subkey:

Office 2016

**HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Office\16.0\Common**

Office 2013

**HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Office\15.0\Common**

Office 2010

**HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Office\14.0\Common**

The 2007 Office system

**HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Office\12.0\Common**

Office 2003

**HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Office\11.0\Common**

Office XP

**HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Office\10.0\Common**

This registry setting prevents Microsoft Excel, Microsoft FrontPage, Microsoft Outlook, Microsoft PowerPoint, Microsoft Publisher, and Microsoft Word from using Visual Basic for Applications. 

### Method 4: Stand-alone Office installation

During or after an Office installation, you can specify the features that you want installed. To do this, follow these steps:

1. In Office Setup, on the **Choose installation options for all Office applications and tools** page, in the **Features to install** list, expand Office Shared Features.   
2. Click **Visual Basic for Applications**, and then click Not Available.   
3. Continue the Office installation or update.   

Microsoft Access requires Visual Basic for Applications. To enable the installation of Access and disable Visual Basic for Applications in all other Office programs, install a stand-alone version of Microsoft Access, and then install Office as a custom installation that has Visual Basic for Applications disabled.

### Method 5: Manually add the VBAOff registry subkey

The VBAOff registry subkey can be added manually to disable Visual Basic for Applications functionality for all users on a computer after Office is installed. To add the VBAOff registry key, follow these steps:

1. Exit your version of all Office programs.   
2. Click **Start**, click **Run**, type regedit, and then click **OK**.   
3. Locate and then click to select one of the following registry keys, depending on the version of the product that you are using:
   - For Office 2016, locate and then click to select **HKEY_LOCAL_MACHINE\Software\Microsoft\Office\16.0\Common**.

    - For Office 2013, locate and then click to select **HKEY_LOCAL_MACHINE\Software\Microsoft\Office\15.0\Common**.

    - For Office 2010, locate and then click to select **HKEY_LOCAL_MACHINE\Software\Microsoft\Office\14.0\Common**.   
   - For the 2007 Office system, locate and then click to select **HKEY_LOCAL_MACHINE\Software\Microsoft\Office\12.0\Common**.   
   - For Office 2003, locate and then click to select **HKEY_LOCAL_MACHINE\Software\Microsoft\Office\11.0\Common**.   
   - For Office XP, locate and then click to select **HKEY_LOCAL_MACHINE\Software\Microsoft\Office\10.0\Common**.   
   
4. After you select the key that is specified in step 3, point to **New** on the **Edit** menu, and then click **DWORD Value**.   
5. Type VBAOff, and then press ENTER.   
6. Right-click **VBAOff**, and then click **Modify**.   
7. In the **Value data** box, type 1, and then click **OK**.   
8. On the **File** menu, click **Exit** to quit Registry Editor.   

**Note** You can also disable Visual Basic for Applications functionality for the current user only. You can do this by selecting the **HKEY_CURRENT_USER** path for the appropriate product that is shown in step 3.

For more information, view the article in the Microsoft Knowledge Base:

[287567](https://support.microsoft.com/help/287567) Considerations for disabling VBA in Office XP