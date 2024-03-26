---
title: Cannot connect to your account when activate Office from Microsoft 365
description: Describes how to troubleshoot Office from Microsoft 365 installation and activation issues.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Microsoft 365
  - Microsoft Visio Pro for Microsoft 365
  - Project Online Desktop Client
ms.date: 03/31/2022
---

# "Sorry, we can't connect to your account. Please try again later" error when you activate Office from Microsoft 365

## Summary

This article discusses how to troubleshoot the activation issues in Microsoft Office from Microsoft 365. Activation fails and you receive one the following error messages:  

**We are unable to connect right now. Please check your network and try again later.**

**Sorry, we can't connect to your account. Please try again later.**

## More information

This issue might be caused by one of several circumstances. Follow these steps to help troubleshoot the issue. After each step, check to see whether the issue is fixed. If not, proceed to the next step.

### Step 1: Identify and fix activation issues by using the Support and Recovery Assistant for Microsoft 365  

The [Microsoft Support and Recovery Assistant](https://support.microsoft.com/office/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72f) runs on Windows PCs and can help you identify and fix activation issues with Microsoft 365.

### Step 2: Check whether you're behind a proxy server  

Are you behind a proxy server? If you're not sure, ask your administrator. If so, you (or your administrator) might have to change the proxy settings for Windows HTTP clients. To do this, follow these steps: 
 
1. Open a Command Prompt window as an administrator. To do this, click **Start**, type cmd.exe in the search box, right-click **cmd.exe** in the list, and then click **Run as administrator**.    
2. Type the following command, and then press Enter:
    ```powershell
    netsh winhttp set proxy < Address of proxy server >
    ```

### Step 3: Check whether you're behind a firewall  

Are you behind a firewall? If you're not sure, ask your administrator. If you're behind a firewall, it might have to be configured to enable access to the following:

- `https://officecdn.microsoft.com`
- `https://ols.officeapps.live.com/olsc`
- `https://activation.sls.microsoft.com`
- `https://odc.officeapps.live.com`
- `https://crl.microsoft.com/pki/crl/products/MicrosoftProductSecureServer.crl`
- `https://crl.microsoft.com/pki/crl/products/MicrosoftRootAuthority.crl`
- `https://crl.microsoft.com/pki/crl/products/MicrosoftProductSecureCommunicationsPCA.crl`
- `https://www.microsoft.com/pki/crl/products/MicrosoftProductSecureCommunicationsPCA.crl`
- `go.microsoft.com`
- `office15client.microsoft.com`
 
Each firewall will have a different method for enable access to these URIs. Check your software's documentation for instructions or ask your administrator to do this for you. 

For more information about Microsoft 365 Apps for enterprise URLs and IP addresses, see the following Microsoft article: [Microsoft 365 URLs and IP address ranges](https://technet.microsoft.com/library/hh373144.aspx)

### Step 4: Check whether you have the appropriate license   
 
1. Sign in to the Microsoft 365 portal.     
2. Click **Settings** :::image type="icon" source="./media/issue-when-activate-office-from-office-365/setting-icon.png"::: and then click **Office 365 settings**.    
3. Locate the **Assigned licenses** area.    
4. If you see **The latest desktop version of Office**, then you have an Office subscription assigned correctly.    
5. If you don't see **The latest desktop version of Office**, contact your administrator or see the Office article [What Microsoft 365 business product or license do I have?](https://support.office.com/article/What-Office-365-business-product-or-license-do-I-have-f8ab5e25-bf3f-4a47-b264-174b1ee925fd) 

### Step 5: If you previously activated an Office 2013 program on the computer, try to remove the existing product key   

To manually remove existing product keys for an Office 2013 program, follow these steps: 
 
1. Open a Command Prompt window, type one of the following commands, and then press Enter:  
   - If you're running 64-bit Windows with 32-bit Office:   

     ```powershell
     cscript.exe "%ProgramFiles(x86)%\Microsoft Office\Office15\ospp.vbs" /dstatus
     ```       
   - If you're running 32-bit Windows, or running 64-bit Office with 64-bit Windows:  

     ```powershell
     cscript.exe "%ProgramFiles%\Microsoft Office\Office15\ospp.vbs" /dstatus 
     ```     
     
2. Examine the output. Look for and locate the last five characters of the installed product key.    
3. Remove all product keys. To remove a product key, type the following command and then press Enter:

    ```powershell
    cscript ospp.vbs /unpkey: <Last five characters of product key>
    ```
 
Here's an example of the output of steps 5a through 5c:   

```AsciiDoc
Microsoft Windows [Version 6.1.7601] 
Copyright (c) 2009 Microsoft Corporation. All rights reserved. 
C:\Windows\system32>cd "C:\Program Files (x86)\Microsoft Office\Office15" 
C:\Program Files (x86)\Microsoft Office\Office15>cscript ospp.vbs /dstatus 
Microsoft (R) Windows Script Host Version 5.8 
Copyright (C) Microsoft Corporation. All rights reserved. 
---Processing-------------------------- 
--------------------------------------- 
SKU ID: 82cef0d9-d31d-456e-a3fa-ae2637ea2984 
LICENSE NAME: Office 15, OfficeProPlusSubR_Subscription edition 
LICENSE DESCRIPTION: Office 15, TIMEBASED_SUB channel 
EXPIRATION: 10/11/2013 4:59:59 PM 
LICENSE STATUS: ---NOTIFICATIONS--- 
ERROR CODE: 0xC004F005 
ERROR DESCRIPTION: The Software Licensing Service reported that the product key 
does not match the product key for the license. 
Last 5 characters of installed product key: RMYP4
--------------------------------------- 
---Exiting----------------------------- 
C:\Program Files (x86)\Microsoft Office\Office15>cscript ospp.vbs /unpkey:RMYP4 
Microsoft (R) Windows Script Host Version 5.8 
Copyright (C) Microsoft Corporation. All rights reserved. 
---Processing-------------------------- 
--------------------------------------- 
Uninstalling product key for: Office 15, OfficeProPlusSubR_Subscription edition 
<Product key uninstall successful> 
--------------------------------------- 
---Exiting-----------------------------
```
        
For more information, see the following Microsoft Knowledge Base articles: 
 
- [Troubleshoot installing Office](https://support.office.com/article/Troubleshoot-installing-Office-365-Office-2016-and-Office-2013-35ff2def-e0b2-4dac-9784-4cf212c1f6c2)    
- [Unlicensed product and activation errors in Office](https://support.office.com/article/Unlicensed-Product-and-activation-errors-in-Office-0d23d3c0-c19c-4b2f-9845-5344fedc4380)    
 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
