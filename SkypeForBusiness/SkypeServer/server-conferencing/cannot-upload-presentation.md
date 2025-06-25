---
title: Lync clients cannot upload a presentation
description: Lync clients cannot complete the upload of Microsoft PowerPoint presentations if the Lync Server conferencing content storage limit is not configured correctly.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.reviewer: kkodali
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Lync Server 2013
  - Lync Server 2010 Enterprise Edition
  - Lync Server 2010 Standard Edition
ms.date: 03/31/2022
---

# Lync clients cannot upload a Microsoft PowerPoint presentation

## Symptoms

This issue will occur under the following circumstances:

- The meeting presenter is adding a Microsoft PowerPoint presentation to a meeting that is hosted by Lync Server   
- The Lync client will stop loading the Microsoft PowerPoint presentation and provide the following error in a Lync error dialog:

   **<filename.pptx> can't be uploaded because it exceeds your allowable file size** 

## Cause

The Lync Server Web Conferencing service will convert the <filename.pptx> file into several files of the BIN file type. The conversion to the BIN file type expands the size of the Microsoft PowerPoint presentation. If this expansion process exceeds the maximum value that is set for the Lync Server content storage for conferences then the upload process will fail.

> [!NOTE]
> The BIN files will be copied by the Lync Server Web Conferencing Service to the 1-WebServices-1\CollabContent folder of the Lync Server Filestore share.

## Resolution

The Lync Server Set-CsConferencingConfiguration PowerShell cmdlet can be used to correct issue.

Use the steps listed below to set the Lync Server content storage maximum to a higher value:

**Using Server 2008 or Server 2008 R2**

1. Click on Start, All Programs, Microsoft Lync Server 2010 or Microsoft Lync Server 2013   
2. Choose Lync Server Management Shell   

**Using Server 2012**

1. Press the Windows logo key to access the Start Page   
2. Click on the Lync Server Management Shell tile   

Enter a Lync Server PowerShell command that is similar to the example listed below:

```powershell
Set-CsConferencingConfiguration -Identity site:Redmond -MaxContentStorageMb 150 
```

> [!NOTE]
> The Lync Server Web Conferencing service conversion of a <filename.pptx> file into several BIN files can use up to 4 times the disk space of the <filename.pptx> file 

## More Information

For more details on using the Set-CsConferencingConfiguration PowerShell Command:

[Set-CsConferencingConfiguration](/previous-versions/office/skype-server-2010/gg412969(v=ocs.14))

For more details on Lync Server 2010 Web Conferencing:

[Features and Functionality of Web Conferencing and A/V Conferencing](/previous-versions/office/skype-server-2010/gg425913(v=ocs.14))

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
