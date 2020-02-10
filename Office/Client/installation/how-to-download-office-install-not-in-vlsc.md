---
title: "Title goes here"
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
ms.date: 2/5/2019
audience: Admin|ITPro|Developer
ms.topic: article
ms.service OR ms.prod: see https://docsmetadatatool.azurewebsites.net/allowlists
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- SharePoint Online 
ms.custom: 
- CI ID
- CSSTroubleshoot 
ms.reviewer: MS aliases for tech reviewers and CI requestor, without "@microsoft.com".  
description: "How to resolve the error "Virus Found" in SharePoint Server 2013 when the antivirus scanner is unavailable ."
---

# How to download and run Office 2019 installation files not in VLSC

## Summary

Office files can be downloaded separately. 

## More information

> [!IMPORTANT]
> The steps below apply only to the following programs: 
> - Office Professional Plus 2019
> - Office Standard 2019
> - Visio Professional 2019
> - Visio Standard 2019
> - Project Professional 2019
> - Project Standard 2019

Follow the steps below to download and install your Office 2019 software or application:

Note: The screenshots below are examples that may not match your own experience.

1. Create a folder on your desktop and name it “Office 2019”.
2. Browse to https://www.microsoft.com/en-us/download/details.aspx?id=49117 and select Download.
![Select the file to download.](../media/how-to-download-install-1.png)
3. Select the arrow next to the Save As option.
![Select Save As. ](../media/how-to-download-install-2.png)
4. Create a new folder for the file. (The name of the folder is irrelevant.)
![Create a new folder. ](../media/how-to-download-install-3.png)
5. Double click the .EXE file.
![Double click the executable file.](../media/how-to-download-install-4.png)
6. A pop up window will display the Microsoft Software License Terms. Check the box and select Continue.
![Accept the Microsoft Software License Terms.](../media/how-to-download-install-5.png)
   > [!NOTE]
   > You might be requested to select a location where you want the files saved.

7. Open your browser and go to https://config.office.com.

8. Under Create a new configuration, select Create.
![Select Create.](../media/how-to-download-install-6.png)
9. Under Products and releases, select 32-bit.
![Select the 32-bit option.](../media/how-to-download-install-7.png)
10. In the next screen, select the product or app that you want to deploy.
![Select the product or app you want to deploy. ](../media/how-to-download-install-8.png)
![Select the product or app.](../media/how-to-download-install-9.png)
11. Choose your Language and then select Next.
![Choose your preferred language.](../media/how-to-download-install-10.png)
12. Under Installation options, select the options that match your needs (or do nothing) and then select Next.
![Change the options if desired.](../media/how-to-download-install-11.png)
13. Under Update and Upgrade, select the options that match your needs (or do nothing) and then select Next.
![Change more options if desired.](../media/how-to-download-install-12.png)
14. Select the Multiple Activation Key (MAK) option. Enter the volume license key specific to the software, move the Autoactivate slider to On, and then select Next.
![Enter the volume licnese key.](../media/how-to-download-install-13.png)
15. Enter your name or the name of your company or organization and then select Next.
![Enter your name or your company's name.](../media/how-to-download-install-14.png)
16. Under Application preferences, select Finish.
![Select Finish. ](../media/how-to-download-install-15.png)
17. Select Export in the upper-right corner of the page.
![Select Export.](../media/how-to-download-install-16.png)
18. In the File Name text box, type “Configuration” (if it does not already show this) and then select Save as to save it to the folder you created.
    > [!NOTE]
    > Make a note of this location as it will be needed for the following steps. 

    ![Type Configuration in the text box.](../media/how-to-download-install-17.png)
    ![Select Save.](../media/how-to-download-install-18.png)
19. Open an elevated Command Prompt. (Select the Windows button, type “CMD”, right-click Command Prompt, and select Run as administrator.)<br/>
![Open a Command Prompt.](../media/how-to-download-install-19.png)
![Run as Administrator.](../media/how-to-download-install-20.png)
20. Type “cd “(c+d+space bar). Copy the file path of the location where you downloaded the file and paste it in the command prompt window.
![Copy the filepath.](../media/how-to-download-install-21.png)
![Paste the location in the command prompt.](../media/how-to-download-install-22.png)
21. Select Enter. The Command Prompt Line is now updated to the location where the files were downloaded:
    > [!NOTE]
    > This will vary depending on where you created the folder for the downloaded file.

    ![The command line should show the path where the downloaded files are. ](../media/how-to-download-install-23.png)
22. Copy and paste the following command in the Command Prompt window and select Enter:

    > Setup /configure configuration.xml

    ![Enter the command into the command line.](../media/how-to-download-install-24.png)

23. The Office installation will start.
![The installation will start. ](../media/how-to-download-install-25.png)
![Office splash screen.](../media/how-to-download-install-26.png)
 


## How to Activate Microsoft Office 2019 using a product key

If automatic activation did not work, you can manually activate your software by following the steps below:

1. Open a Word, Excel, or PowerPoint file. Select File. 
![Open an Office program.](../media/how-to-download-install-27.png)
 
2. Select Help or Account. 
![Select Help or Account.](../media/how-to-download-install-28.png)
3. Select Change Product Key. 
![Select Change Product Key.](../media/how-to-download-install-29.png)
4. Enter the product key in the field box and then select Install.
![Enter the product key.](../media/how-to-download-install-30.png)
The Office installation will begin. 
