---
title: Can't install 64-bit Office with 32-bit Office
description: Describes why you may receive the error message You cannot install the 64-bit version of Office 2010 because you have 32-bit Office products installed.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - DownloadInstall\SxS\SxSOrPerpetual
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: meerak
appliesto: 
  - Office 2010
ms.date: 06/06/2024
---

# You receive the error message "You cannot install the 64-bit version of Office 2010 because you have 32-bit Office products installed"

## Symptoms

When you try to install the 64-bit version of a Microsoft Office 2010 suite or the 64-bit version of a Microsoft Office 2010 product, you receive the following error message at the beginning of the installation process:

```adoc
You cannot install the 64-bit version of Office 2010 because you have 32-bit Office products installed. These 32-bit products are not supported with 64-bit installations:

<products>

If you want to install 64-bit Office 2010, you must uninstall all 32-bit Office products first, and then run setup.exe in the x64 folder. If you want to install 32-bit Office 2010, close this Setup program, and then either go to the x86 folder at the root of your CD or DVD and run setup.exe, or get the 32-bit Office 2010 from the same place you purchased 64-bit Office 2010.
```

The placeholder <**products**> represents any version of Microsoft Office and also any component that you downloaded separately from the Microsoft Download Center that applies to Microsoft Office. See the "More Information" section for a list of these products.

## Cause

The 64-bit version of Office 2010 is incompatible with the 32-bit version of Office 2010 products or with the 32-bit version of Office 2010 components that are listed in the "More Information" section. 

Additionally, you cannot install 64-bit versions of Office 2010 products and 32-bit versions of Office 2010 products on the same computer. For example, if you install the 32-bit version of Microsoft Office Professional 2010 and then try to install the 64-bit version of Microsoft Project Professional 2010, you receive the error message that is mentioned in the "Symptoms" section.

## Resolution

To install the 64-bit version of Office 2010, you must uninstall the products that are listed in the error message. Note the products that are listed in the error message, and then follow these steps for your version of Windows. (The product names that appear in the error message are the same product names that appear in the Programs Control Panel that you will use to uninstall them.)

To remove Office, see [Uninstall Office from a PC](https://support.office.com/article/uninstall-office-from-a-pc-9dd49b83-264a-477a-8fcc-2fdf5dbf61d8?redirectSourcePath=%252fen-us%252farticle%252fhow-to-uninstall-or-remove-microsoft-office-2010-suites-90635a1d-aec8-4653-b358-67e1b766fc4d).

You can also use the following instructions to remove a single component.

### Windows Vista or Windows 7

1. While the error message is displayed on your screen, note the names of the products that are listed.   
2. Click **Start**, and then click **Control Panel**.   
3. Under **Programs**, click **Uninstall a Program**.   
4. Locate one of the products that you noted in step 1, right-click the product name, and then select **Uninstall**.   
5. Repeat step 3 until you have uninstalled all the products that you noted in step 1.   

After you remove all previous 32-bit versions, you can try to install the 64-bit version of Office 2010.

### Known issues with this resolution

#### Restart of your computer is requested during Uninstall

You may receive a message to restart your computer, depending on the product that you are uninstalling. When this message is displayed, you must restart the computer to finish the uninstallation process. If you do not restart your computer, you may receive different error messages when you try to install Office later.

#### Application compatibility and the 64-bit version of Office

We strongly recommend that customers use the 32-bit version of Office 2010 even on 64-bit versions of Windows because of application compatibility. If you have add-ins on your computer, especially if you sync your mobile phone together with Microsoft Outlook, check with the add-in manufacturer to see whether a 64-bit version of the add-in is available before you install the 64-bit version of Office 2010.

For more information about the differences between the 32-bit and 64-bit versions of Office, visit the following websites:

[Choose between the 64-bit or 32-bit version of Office](https://support.office.com/article/choose-between-the-64-bit-or-32-bit-version-of-office-2dee7807-8f95-4d0c-b5fe-6c6f49b8d261?ocmsassetID=HA010369476&CorrelationId=6f42bedf-c669-4508-b4ef-37b0c5a8e72c)

[64-bit editions of Office 2013](https://technet.microsoft.com/library/ee681792.aspx)

[Compatibility Between the 32-bit and 64-bit Versions of Office 2010](https://msdn.microsoft.com/library/ee691831%28office.14%29.aspx)

Microsoft does provide 32-bit and 64-bit versions of the following components for Office 2010. You can install the 64-bit versions of these components to work with the 64-bit version of Office 2010.

- Microsoft Access Database Engine 2010   
- Microsoft Access Runtime 2010   

## More Information

The following list includes those products that may be displayed in the error message and that must be removed in order to install the 64-bit version of Office 2010.

### Microsoft Office 2010 products and components

#### 32-bit versions of Microsoft Office 2010 suites

- Microsoft Office Home and Business 2010   
- Microsoft Office Home and Student 2010   
- Microsoft Office Standard 2010   
- Microsoft Office Small Business Basics 2010   
- Microsoft Office Professional 2010   
- Microsoft Office Professional Plus 2010   

#### 32-bit versions of Microsoft Office 2010 individual products


- Microsoft Access 2010   
- Microsoft Excel 2010   
- Microsoft Office Groove 2010   
- Microsoft InfoPath 2010   
- Microsoft OneNote 2010   
- Microsoft Outlook 2010   
- Microsoft PowerPoint 2010   
- Microsoft Project Standard 2010   
- Microsoft Project Professional 2010   
- Microsoft Publisher 2010   
- Microsoft SharePoint Designer 2010   
- Microsoft Visio Standard 2010   
- Microsoft Visio Professional 2010   
- Microsoft Visio Premium 2010   

Note: Microsoft Office Groove 2010 may be displayed in the error message but is not listed among the programs in Control Panel. You must uninstall Microsoft SharePoint Workspace 2010 in Control Panel to remove Microsoft Office Groove 2010 from the error message.

#### 32-bit versions of Microsoft Office 2010 components

- Microsoft Access Runtime 2010   
- Microsoft Access Database Engine 2010
