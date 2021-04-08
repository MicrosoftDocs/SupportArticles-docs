---
title: Email message body is blank in Outlook
description: Describes an issue that occurs when the Avgoutlook. Addin add-in is enabled in Outlook.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
- Outlook for Windows
- CSSTroubleshoot
ms.reviewer: aruiz
appliesto:
- Outlook 2016
- Outlook 2013
- Microsoft Outlook 2010
- Microsoft Office Outlook 2007
- Microsoft Office Outlook 2003
search.appverid: MET150
---
# Email message body is blank in Outlook

_Original KB number:_ &nbsp; 2854787

## Symptoms

When you view an email message in Microsoft Outlook, the message body is blank.

## Cause

This problem may occur because of an incompatibility between the `Avgoutlook.Addin` add-in and Outlook.

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To resolve this problem, follow these steps to disable the `Avgoutlook.Addin` add-in. If the problem is, we recommend that you contact the vendor of the add-in to ask about an updated version of the add-in.

1. Exit Microsoft Outlook if it is running.
2. Start Registry Editor. To do this, use one of the following procedures, as appropriate for your version of Windows.

    Windows 10, Windows 8.1 and, Windows 8: Press the Windows key+R to open a Run dialog box, type *regedit* in the **Open** box, and then press **OK**.

    In Windows 7 or Windows Vista: Select **Start**, type *regedit* in the **Start Search** box, and then press Enter.

3. Locate and then select the following registry subkey, depending on the type of Office and Windows installations that you have.

    - 32-bit Office plus 32-bit Windows

      `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\Outlook\Addins\avgoutlook.Addin`
    - 64-bit Office plus 64-bit Windows

      `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\Outlook\Addins\avgoutlook.Addin`
    - 32-bit Office plus 64-bit Windows

      `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\Outlook\Addins\avgoutlook.Addin`

4. Right-click the **LoadBehavior** value, and then select **Modify**.
5. Change the **Value Data** value to **0**, and then select **OK**.
6. Start Microsoft Outlook.

> [!NOTE]
> To re-enable this add-in in Outlook, change the `LoadBehavior` value to **3**.

## More information

The Friendly Name of the `Avgoutlook.Addin` add-in is *AVG Addin for MS Outlook*.

For AVG software download information, go to the following AVG website:

[AVG Software Downloads](https://www.avg.com/free-antivirus-download)

> [!NOTE]
> Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.
