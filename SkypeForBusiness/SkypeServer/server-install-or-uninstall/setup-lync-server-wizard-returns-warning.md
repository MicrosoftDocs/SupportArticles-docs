---
title: Setup Lync Server Components wizard returns Host not found in topology
description: Resolves an issue in which Setup Lync Server Components wizard returns the warning Host not found in topology during the Lync Server Edge server installation.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.reviewer: miadkins
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Lync Server 2010 Enterprise Edition
  - Lync Server 2010 Standard Edition
  - Lync Server 2013
ms.date: 03/31/2022
---

# Setup Lync Server Components wizard returns the warning "Host not found in topology" during the Lync Server Edge server installation

## Symptoms

The Setup Lync Server components wizard will display the following warning upon completion of its process:

```adoc
Host name: Server01-ms2
WARNING! Host not found in topology.
All roles will be uninstalled.
Disabling unused roles...
```

The following Lync Server Edge Server roles will not be installed after the Setup Lync Server components wizard completes the installation process:

- Lync Server Access Edge   
- Lync Server Replica Replicator Agent   
- Lync Server Web Conferencing Edge   
- Lync Server Audio/Video Edge   
- Lync Server Audio/Video Authentication   

## Cause

The Windows server computer that will host the Lync Server Edge Server services roles:

- Does not have a FQDN or primary DNS suffix that matches the FQDN that was used to define the single server Lync Server Edge server pool   
- The FQDN or primary DNS suffix of one or more of the Windows server computers does not match the FQDN information that was used to define the multiple server Lync Server Edge server pool    

## Resolution

Use the following steps to update the host name and primary DNS suffix of the Windows server computer that will be hosting the Lync Server Edge server roles:

1. From the desktop of the Windows server computer that will be hosting the Lync Server Edge server   
2. Click on Start and open Control Panel   
3. Click on the System and Security link to open it   
4. Click on the System link to open it   
5. Click on the Change System Settings link to access the System Properties dialog   
6. Review the Windows server computer's host name value.

    > [!NOTE]
    > The Windows server computer's host name value should be a FQDN with a primary DNS suffix that matches the information that was used when defining the Lync Server Edge pool using Lync Server Topology Builder.   
7. If the primary DNS suffix needs to be updated click on the change button and then the More button. If the primary DNS suffix does not need to be updated then skip this step and move to step 8
  
   1. Enter the correct FQDN for the primary DNS suffix   
   2. Click on the OK button to close the DNS Suffix and NetBios Computer Name dialog   

8. If the Windows server computer's host name value needs to be updated click on the Change button
   1. Enter the correct host name for the Windows server computer   
   2. Click on the OK button to close the Computer Name/Domain Changes dialog
9. Click on the OK button to close the System properties dialog   
10. You will be prompted to restart the Windows server computer before the name changes will take affect   

## More Information

[Configure the DNS Suffix for Edge Servers](/previous-versions/office/skype-server-2010/gg398488(v=ocs.14))

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).