---
title: How to download and run Office LTSC installation files not in VLSC
description: Describes how to install Office LTSC with files that are not in VLSC or with a product key. 
ms.author: v-six
author: simonxjx
manager: dcscontentpm
audience: Admin
ms.topic: article
ms.prod: office-perpetual-itpro
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Office
ms.custom:
- CI 157620
- CI 113921
- CSSTroubleshoot 
ms.reviewer: joselr
---
# How to install Office LTSC installation files not found in VLSC

Office files can be downloaded separately.

> [!IMPORTANT]
> The steps below apply only to the following programs:
>
> - Office LTSC Professional Plus 2021
> - Office LTSC Standard 2021
> - Visio LTSC Professional 2021
> - Visio LTSC Standard 2021
> - Project Professional 2021
> - Project Standard 2021

Follow the steps below to download and install your Office LTSC, Visio LTSC, or Project 2021 software or application:

> [!NOTE]
> The screenshots below are examples that may not match your own experience.

1. In Microsoft Edge, browse to the [Office Deployment Tool](https://www.microsoft.com/download/details.aspx?id=49117) and then select **Download**.

    > [!NOTE]
    > The file will automatically be saved to the *Downloads* folder on your device. Office LTSC 2021 requires version of **16.0.14326.20404** or later of the Office Deployment Tool. This version was released on September 17, 2021.

2. Select the **Open file** link under the file name.

    :::image type="content" source="./media/how-to-download-office-install-not-in-vlsc/open-file-link.png" alt-text="Screenshot that shows the Open file link under the file name in the Downloads window.":::

3. A pop-up window will display the Microsoft Software License Terms. Check the box to accept the terms and select **Continue**.

   > [!NOTE]
   > You might be requested to select a location where you want the files saved. If so, select the folder that you created.

    :::image type="content" source="./media/how-to-download-office-install-not-in-vlsc/microsoft-software-license-terms.png" alt-text="Screenshot of the Microsoft Software License Terms.":::

4. You are requested to select a folder to store the extracted files. Select **Desktop** > **Make New Folder** > **OK**.

5. If you have purchased Office LTSC Professional Plus 2021, Visio LTSC Professional 2021, and Project Professional 2021, you can use the sample configuration file (*configuration-Office2021Enterprise.xml*), included with the Office Deployment Tool to install your products. You can skip to Step 22 in these instructions. If you have only purchased one of these products, continue with the following steps to use the Office Customization Tool.

6. Browse to the [Microsoft 365 Apps admin center](https://config.office.com). Do not attempt to sign in. Scroll down to see the options available without signing in at the bottom of the page.

7. Under **Create a new configuration**, select **Create** to open the Office Customization Tool.

    > [!NOTE]
    > The following steps describe the simplest creation of a configuration file. For more information about the various configuration options, see [Configuration options for the Office Deployment Tool](/deployoffice/office-deployment-tool-configuration-options).

    :::image type="content" source="./media/how-to-download-office-install-not-in-vlsc/create-new-configuration.png" alt-text="Screenshot that shows the Create button to create a new configuration.":::

8. Under **Products and releases** > **Architecture**, select **64-bit**.

    > [!NOTE]
    > For more information, see [Choose between the 64-bit or 32-bit version of Office](https://support.microsoft.com/office/2dee7807-8f95-4d0c-b5fe-6c6f49b8d261).

    :::image type="content" source="./media/how-to-download-office-install-not-in-vlsc/select-architecture.png" alt-text="Screenshot of the page to select the architecture option.":::

9. Under **Products**, select the product(s) that you want to deploy.

    :::image type="content" source="./media/how-to-download-office-install-not-in-vlsc/select-products.png" alt-text="Screenshot of the page to select products.":::

10. Under **Update channel**, Office LTSC 2021 Perpetual Enterprise will be listed as the Update Channel. Do not change.

    :::image type="content" source="./media/how-to-download-office-install-not-in-vlsc/update-channel.png" alt-text="Screenshot of the page to select update channel.":::

11. Under **Apps**, determine which apps are installed using the toggles and then select **Next**.

    :::image type="content" source="./media/how-to-download-office-install-not-in-vlsc/select-apps.png" alt-text="Screenshot of the page to select apps.":::

12. Under **Language**, select the primary language and then select **Next**.

    :::image type="content" source="./media/how-to-download-office-install-not-in-vlsc/select-language.png" alt-text="Screenshot of the page to select languages.":::

13. Under **Installation**, select the options that match your needs (or do nothing) and select **Next**.

    :::image type="content" source="./media/how-to-download-office-install-not-in-vlsc/select-installation-options.png" alt-text="Screenshot of the page to select installation options.":::

14. Under **Update and upgrade** > **Update and upgrade options**, select the options that match your needs (or do nothing).

    :::image type="content" source="./media/how-to-download-office-install-not-in-vlsc/select-update-options.png" alt-text="Screenshot of the page to select update options.":::

15. Under **Upgrade options**, select if you need to keep any of the products already installed on the device (or do nothing) and then select **Next**.

    :::image type="content" source="./media/how-to-download-office-install-not-in-vlsc/select-upgrade-options.png" alt-text="Screenshot of the page to select upgrade options.":::

16. Under **Licensing and activation**, select the **Multiple Activation Key (MAK)** option, type the volume license key specific to the product and switch the **Autoactivate** slider to **On**, and then select **Next**.

    > [!NOTE]
    >
    > - By default, users have to accept the End User License Agreement. You can switch the **Automatically accept the EULA** slider to **Off** to accept it for them.
    > - Under **Product activation**, only the **User based** option can be selected.
    > - If your organization uses Key Management Service (KMS) activation, select the **KMS Client Key** option instead.

    :::image type="content" source="./media/how-to-download-office-install-not-in-vlsc/select-licensing-activation-options.png" alt-text="Screenshot of the page to select licensing and activation options.":::

17. Under **General**, type your name or the name of your company or organization and then select **Next**.

    :::image type="content" source="./media/how-to-download-office-install-not-in-vlsc/provide-organization-name-configuration-purposes.png" alt-text="Screenshot of the page to provide organization name and configuration purposes.":::

18. Under **Application preferences**, select **Finish**.

    :::image type="content" source="./media/how-to-download-office-install-not-in-vlsc/application-preferences.png" alt-text="Screenshot of the page that shows application preferences.":::

19. In the upper-right corner of the page, select **Export**.

    :::image type="content" source="./media/how-to-download-office-install-not-in-vlsc/export-button.png" alt-text="Screenshot that shows the Export button.":::

20. In the **Default File Format** window, select a format for Office LTSC 2021, and then select **OK**.

    :::image type="content" source="./media/how-to-download-office-install-not-in-vlsc/default-file-format.png" alt-text="Screenshot of the page to select the default file format.":::

21. In the **Export configuration to XML** window, check the **I accept the terms in the license agreement** option. In the **File Name** text box, type *Configuration*, select **Export** and then move the *Configuration.xml* file to the new folder that is created in Step 4.

    > [!NOTE]
    > Depending upon the browser you use will be where the file is saved. Make note of where your browser saves the file. If you are using Microsoft Edge, the *Configuration.xml* file will be stored in the *Downloads* folder.

    :::image type="content" source="./media/how-to-download-office-install-not-in-vlsc/export-configuration-xml.png" alt-text="Screenshot of the Export configuration to XML page.":::

22. Open an elevated Command Prompt. (Select the **Windows** button, type *CMD*, right-click **Command Prompt**, and then select **Run as administrator**.)

23. Type `cd <file path>` and then press **Enter**. The Command Prompt line is now updated to the location where the files were downloaded.

    > [!NOTE]
    > The \<file path\> placeholder corresponds to the file path of the location where you downloaded the file.

24. Run the following command:

    ```cmd
    Setup /configure configuration.xml
    ```

    > [!NOTE]
    > If you are on a slow or limited bandwidth internet connection, use the following command instead:
    >
    > ```cmd
    > Setup /download configuration.xml
    > ```

25. The Office installation will start.

## How to activate Office LTSC using a product key

If automatic activation did not work, you can manually activate your software by following the steps below:

1. Open a Word, Excel, or PowerPoint file, and then select **File**.

2. Select **Account** > **Change Product Key**.

    :::image type="content" source="./media/how-to-download-office-install-not-in-vlsc/change-product-key.png" alt-text="Screenshot of the page to change product key.":::

3. Type the product key in the field box and then select **Activate Office**.

    > [!NOTE]
    > You may have to close the Office application and restart it in order to see Office as licensed.
