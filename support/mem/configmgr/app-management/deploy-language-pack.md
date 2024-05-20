---
title: Deploy a Windows language pack as an application
description: This article describes how to deploy a language pack as an application in Configuration Manager, including logs that you can use to track the deployment.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Application Management\Application Deployment (Devices)
---
# How to deploy a Windows language pack as an application in Configuration Manager

This article describes how to deploy a Windows language pack as an application in Configuration Manager, including logs that you can use to track the deployment.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4468362

## Deploy a language pack as an application

To deploy a language pack as an application in Configuration Manager, follow these steps:

1. In Configuration Manager console, go to **Software Library** > **Application management** > **Applications**, and then select **Create Application**.

    :::image type="content" source="media/deploy-language-pack/create-application.png" alt-text="Screenshot of the Create application button.":::

2. On the **General** page of the **Create Application Wizard**, select **Manually specify the application information**, and then select **Next**.

    :::image type="content" source="media/deploy-language-pack/general-page.png" alt-text="Screenshot of the General page." border="false":::

3. On the **General Information** page, specify information about the application, such as the application name and comments, and then select **Next**.

    :::image type="content" source="media/deploy-language-pack/specify-info.png" alt-text="Screenshot of the General information page.":::

4. On the **Application Catalog** page, specify information about how to display the application to users in the Application Catalog, and then select **Next**.
5. On the **Deployment Types** page, select **Add** to open the **Create Deployment Type Wizard**.

    :::image type="content" source="media/deploy-language-pack/deployment-types.png" alt-text="Screenshot of the Add button on the Deployment page." border="false":::

6. On the **General** page, select **Script Installer** from the **Type** list, and then select **Next**.

    :::image type="content" source="media/deploy-language-pack/select-type.png" alt-text="Screenshot of selecting type on the General page." border="false":::

7. On the **General Information** page, enter application name, and then select **Next**.

    :::image type="content" source="media/deploy-language-pack/enter-name.png" alt-text="Enter application name on the General Information page." border="false":::

8. On the **Content** page, specify the content location, enter the following for **Installation program**, and then select **Next**.

    `DISM /Online /Add-Package /PackagePath:.\`

    :::image type="content" source="media/deploy-language-pack/installation-program.png" alt-text="Specify content information.":::

9. On the **Detection Method** page, select **Add Clause**.

    :::image type="content" source="media/deploy-language-pack/add-clause.png" alt-text="Add clause on the Detection Method page.":::

10. For **Detection Rule**, select **Registry** from the **Setting Type** drop-down list, select **HKEY_LOCAL_MACHINE** for **Hive**, enter `SYSTEM\CurrentControlSet\Control\MUI\UILanguages\<language name>` in **Key**, (for example, `SYSTEM\CurrentControlSet\Control\MUI\UILanguages\fr-FR`), and then select **OK**.

    :::image type="content" source="media/deploy-language-pack/detection-rule.png" alt-text="Detection rule page details.":::

11. Select **Next**.
12. On **User Experience** page, select **Install for system** from the **Installation behavior** drop-down list, specify a **Logon requirement**, and then select **Next**.

    :::image type="content" source="media/deploy-language-pack/user-experience.png" alt-text="Specify user experience.":::

13. On the **Requirements** page, you can specify installation requirements by clicking **Add**.

    The following example requires deploying the language pack on Windows 10 version 1803.

    > [!NOTE]
    > Language packs are specific to OS versions. Therefore, for example, Windows 10 version 1803 language packs only work in version 1803, but not other versions.  

    Example

    1. Select **Custom** for **Category**, and then select **Create**.

        :::image type="content" source="media/deploy-language-pack/category.png" alt-text="Select custom for Category in Create Requirement dialog box.":::

    2. Specify details at **Create Global Condition**.

        :::image type="content" source="media/deploy-language-pack/global-condition.png" alt-text="Screenshot of the details in the Create Global condition window.":::

    3. Enter **1803** for **Value**, and then select **OK**.

        :::image type="content" source="media/deploy-language-pack/value.png" alt-text="Screenshot shows value 1803 is entered in Create Requirement dialog box.":::

14. On **Summary** page, confirm the settings, and then select **Next**.
15. Wait for the wizard to complete, and then select **Close** to exit the wizard.

    :::image type="content" source="media/deploy-language-pack/completion.png" alt-text="Completion page in the Create Deployment Type Wizard.":::

16. Select **Next**.

    :::image type="content" source="media/deploy-language-pack/next.png" alt-text="Select next button in the Deployment Types page.":::

17. On **Summary** page, confirm the settings for the application, and then select **Next**.
18. Wait for the wizard to complete, and then select **Close** to exit the wizard.
19. After the application is created successfully, deploy it to the required collections.
20. On the client device, open **Software Center**, select the application, and then select **Install**.

    :::image type="content" source="media/deploy-language-pack/install-application.png" alt-text="Install application from Software Center.":::

21. Verify that the language pack was installed successfully by running the following command from an elevated command prompt:

    ```console
    DISM /online /Get-intl
    ```

    The following is sample output:

    :::image type="content" source="media/deploy-language-pack/result.png" alt-text="Screenshot of the Command result.":::

## Use logs to track policy and application installation

You can use the following logs to track policy and application installation:

- Use **PolicyAgent.log** to check whether a policy is downloaded or not. In the following example, **88BF878E...** is the deployment ID.

    :::image type="content" source="media/deploy-language-pack/policyagent.png" alt-text="Screenshot of the PolicyAgent log example.":::

- Use **AppDiscovery.log** to check the discovery or detection of an application on client devices.

    :::image type="content" source="media/deploy-language-pack/appdiscovery.png" alt-text="Screenshot of the AppDiscovery log example.":::

- Use **AppIntentEval.log** to check the current state of the application and its applicability.

    :::image type="content" source="media/deploy-language-pack/appintenteval.png" alt-text="Screenshot of the AppIntentEval log example.":::

- Use **AppEnforce.log** to track application installation on the client and to check the exit code to verify that installation completed successfully.

    :::image type="content" source="media/deploy-language-pack/appenforce.png" alt-text="Screenshot of the AppEnforce log example.":::

- Use **DISM.log** to determine whether installation started.

    :::image type="content" source="media/deploy-language-pack/dism.png" alt-text="Screenshot of the DISM log example.":::
