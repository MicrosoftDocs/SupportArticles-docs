---
title: Enable Office Professional Plus 2010 to run on a terminal server
description: Discusses how to enable Office Professional Plus 2010 to run on a terminal server.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Office Professional Plus 2010
ms.date: 03/31/2022
---

# How to enable Office Professional Plus 2010 to run on a terminal server

## Summary

This article describes how Microsoft Developer Network (MSDN) and Microsoft TechNet subscription customers can enable Microsoft Office Professional Plus 2010 to run on a server on which Office 2010 was installed and activated and on which the Terminal Services (Remote Desktop Services) server role was later added.

## Introduction 

Consider the following scenario:

- You install Office Professional Plus 2010 by using an MSDN or TechNet subscription.   
- You successfully activate Office Professional Plus 2010.   
- You want to use Windows Server 2008 Terminal Services to let users use Office Professional Plus 2010 applications from their workstations.   

In this scenario, you must install an additional product key for Office Professional Plus 2010. 

> [!NOTE]
> If the Terminal Services (Remote Desktop Services) role is already enabled on the server, OEM keys are not valid, and you must use the special Terminal Services product key to install Office 2010 on the server as retail.

## More Information

### How to install an additional product key for Office Professional Plus 2010 to enable Terminal Services

To install an additional product key to enable Terminal Services, use one of the following methods. 

#### Method 1

1. If you are an MSDN subscriber, you should go to your MSDN Subscriptions Product Keys page by clicking the following link: [https://msdn.microsoft.com/subscriptions/securedownloads/cc137106.aspx](https://msdn.microsoft.com/subscriptions/securedownloads/cc137106.aspx)

   If you are a TechNet subscriber, you should go to your TechNet Subscriptions Product Keys page by clicking the following link: [https://technet.microsoft.com/subscriptions/securedownloads/cc137106.aspx](https://technet.microsoft.com/subscriptions/securedownloads/cc137106.aspx)

1. Start the update of the current installation of Office Professional Plus 2010. To do this, follow these steps:
   1. Close all open Office 2010 applications.   
   2. Click **Start**, and then click **Control Panel**.   
   3. If you are using Windows Server 2003, click **Add or Remove Programs**.
        
      If you are using Windows Server 2008 or Windows Server 2008 R2, click **Program and Features**.   
   4. In the list of programs that are installed, click **Microsoft Office Professional Plus 2010**, and then click **Change**.   
   
3. In the **Microsoft Office Professional Plus 2010** dialog box, click the **Enter a Product Key** option, and then click **Continue**.

    :::image type="content" source="media/office-pro-plus-2010-terminal-server/enter-product-key.png" alt-text="Screenshot to select the Continue option after selecting the Enter a Product Key option." border="false":::
4. Install the Terminal Services product key that you obtained from your MSDN or TechNet subscription. To do this, follow these steps:
      1. Make sure that the computer is connected to the Internet.   
      2. Enter the product key, click to select the **Attempt to automatically activate my product online** check box, and then click **Continue**.   
      3. Click **Install Now**.   
      4. When a dialog box appears that informs you that the configuration is successful, click **Close**.    
   
5. Complete the activation. To do this, follow these steps:
   1. Start an Office 2010 application.   
   2. Follow the instructions to complete the activation.   
   
6. Verify the activation status. To do this, follow these steps:
    1. Restart the Office 2010 application.   
    2. In the Office 2010 application, click the **File** tab, and then click **Help**.   
    3. Notice the activation status.   

#### Method 2

1. Follow step 1 of Method 1 to obtain the Terminal Service enablement for the Office 2010 product key from your MSDN or TechNet subscription.   
2. Open a Command Prompt window. 

    To do this if you are using Windows Server 2003, click **Start**, click **Run**, type cmd, and then click **OK**. 
    
    To do this if you are using Windows Server 2008 or Windows Server 2008 R2, follow these steps:
    
      1. Click **Start**, type cmd in the **Search** box, right-click **cmd.exe**, and then click **Run as administrator**.   
      2. In the **User Account Control** dialog box, click **Yes**.   
   
3. Install the additional product key, and then activate Office Professional Plus 2010.

    To do this if you are using the x86 version of Office Professional Plus 2010 on an x64 version of the Windows operating system, follow these steps:
       
    1. At the command prompt, run the following command:

       ```powershell
       cscript "%ProgramFiles(x86)%\Microsoft Office\Office14\ospp.vbs" /inpkey: <Product_Key>
          ```
       > [!NOTE]
       > In this command, the placeholder <**Product_Key**> represents the product key that you want to install.   
     2. Run the following command:

        ```powershell
        cscript "%ProgramFiles(x86)%\Microsoft Office\Office14\ospp.vbs" /act
        ```
    In other situations, follow these steps:
    1. At the command prompt, run the following command:

       ```
       cscript "%ProgramFiles%\Microsoft Office\Office14\ospp.vbs" /inpkey: <Product_Key>
       ```   
    2. Run the following command:

       ```
       cscript "%ProgramFiles%\Microsoft Office\Office14\ospp.vbs" /act   
       ```
