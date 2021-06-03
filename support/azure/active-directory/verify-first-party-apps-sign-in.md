---
title: Verify first-party Microsoft applications in sign-in reports
description: Describes how to verify first-party Microsoft applications in sign-in reports
ms.date: 04/02/2021
ms.prod-support-area-path: 
ms.reviewer: jafritts
---
# Verify first-party Microsoft applications in sign-in reports

When you are reviewing your sign-in reports, you may see an application in your sign-in report that you don’t own and want to identify the application. You also may wonder how you signed into that app, as you don’t remember accessing the app.

Here is an example of a sign-in report:

:::image type="content" source="media/verify-first-party-apps-sign-in/microsoft-application-sign-in-report.png" alt-text="An example of a sign-in report in Azure Active Directory." border="true":::

For example, when you access **docs.microsoft.com**, the application shown in the sign-in log may say **dev-rel-auth-prod**, which is not descriptive regarding **doc.microsoft.com**.

Though the apps listed in sign-in reports are indeed owned by Microsoft, and are not suspicious applications, there is a way that you can verify whether an Azure AD service principal found in your AAD logs is owned by Microsoft.

## Verify a first-party Microsoft Service Principal in your AAD tenant

1. Visit the [AAD Enterprise Applications blade](https://portal.azure.com/#blade/Microsoft_AAD_IAM/StartboardApplicationsMenuBlade/AllApps/menuId/)

2. Select **All applications** in the left-hand menu.

3. In the **Application Type** drop-down menu, select **Microsoft Applications** and hit apply.  All applications listed here are owned by Microsoft.

   :::image type="content" source="media/verify-first-party-apps-sign-in/select-microsoft-applications-in-application-type-menu.png" alt-text="Select Microsoft Applications in the Application Type drop-down menu." border="true":::
  
4. In the search box below the selectable drop-down menus, filter the list by adding a specific **Display Name** or **Application ID**.

   :::image type="content" source="media/verify-first-party-apps-sign-in/add-display-name-in-search-box.png" alt-text="Enter a display name in the search box." border="true":::

5. Select the desired app, then select **Properties** in the left-hand menu to open the listed app's properties and confirm the message that:

   ``You can’t delete this application because it’s a Microsoft first party application.``

   :::image type="content" source="media/verify-first-party-apps-sign-in/you-cant-delete-this-application.png" alt-text="A message that displays the statement you can’t delete this application because it’s a Microsoft first party application." border="true":::

## Verify a 1st Party Microsoft Service Principal through PowerShell

1. Open the Azure Active Directory Module in PowerShell

2. In the PowerShell module, enter the following cmdlet:

   ```cmd
   Get-AzureADServicePrincipal -Filter "DisplayName eq '(DISPLAY NAME)’" | fl *
   ```

   Replace **(DISPLAY NAME)** with the app’s actual display name.

3. Review the result's **AppOwnerTenantId**.

   :::image type="content" source="media/verify-first-party-apps-sign-in/review-the-app-owner-tenant-id.png" alt-text="The output of a request to show the Azure AD service principal." border="true":::

   In the previous screenshot, **f8cdef31-a31e-4b4a-93e4-5f571e91255a** is the Microsoft Service's AAD tenant ID.

## Application IDs for commonly used Microsoft applications

The following table lists some, but not all, first party Microsoft applications. You may see these applications in the Sign-ins report in Azure AD.  

|Application Name|Application IDs|
|--|--|
|ACOM Azure Website|23523755-3a2b-41ca-9315-f81f3f566a95|
|Azure Data Lake|e9f49c6b-5ce5-44c8-925d-015017e9f7ad|
|Azure Lab Services Portal|835b2a73-6e10-4aa5-a979-21dfda45231c|
|Azure Portal|c44b4083-3bb0-49c1-b47d-974e53cbdf3c|
|Bing|9ea1ad79-fdb6-4f9a-8bc3-2b70f96e34c7|
|Common Data Service|00000007-0000-0000-c000-000000000000|
|CRM Power BI Integration|e64aa8bc-8eb4-40e2-898b-cf261a25954f|
|Media Analysis and Transformation Service|944f0bd1-117b-4b1c-af26-804ed95e767e<br>0cd196ee-71bf-4fd6-a57c-b491ffd4fb1e|
|Microsoft App Access Panel|0000000c-0000-0000-c000-000000000000|
|Microsoft Approval Management|65d91a3d-ab74-42e6-8a2f-0add61688c74<br>38049638-cc2c-4cde-abe4-4479d721ed44|
|Microsoft Authentication Broker|29d9ed98-a469-4536-ade2-f981bc1d605e|
|Microsoft Cloud App Security|3090ab82-f1c1-4cdf-af2c-5d7a6f3e2cc7|
|Microsoft Docs|18fbca16-2224-45f6-85b0-f7bf2b39b3f3|
|Microsoft Dynamics ERP|00000015-0000-0000-c000-000000000000|
|Microsoft Edge Insider Addons Prod|6253bca8-faf2-4587-8f2f-b056d80998a7|
|Microsoft Forms|c9a559d2-7aab-4f13-a6ed-e7e9c52aec87|
|Microsoft Intune Web Company Portal|74bcdadc-2fdc-4bb3-8459-76d06952a0e9|
|Microsoft Office|d3590ed6-52b3-4102-aeff-aad2292ab01c|
|Microsoft Office 365 Portal|00000006-0000-0ff1-ce00-000000000000|
|Microsoft Office Web Apps Service|67e3df25-268a-4324-a550-0de1c7f97287|
|Microsoft Power BI|871c010f-5e61-4fb1-83ac-98610a7e9110|
|Microsoft Storefronts|28b567f6-162c-4f54-99a0-6887f387bbcc|
|Microsoft Stream Portal|cf53fce8-def6-4aeb-8d30-b158e7b1cf83|
|Microsoft Support|fdf9885b-dd37-42bf-82e5-c3129ef5a302|
|Microsoft Teams|1fec8e78-bce4-4aaf-ab1b-5451cc387264|
|Microsoft Teams Services|cc15fd57-2c6c-4117-a88c-83b1d56b4bbe|
|Microsoft Teams Web Client|5e3ce6c0-2b1f-4285-8d4b-75ee78787346|
|O365 Suite UX|4345a7b9-9a63-4910-a426-35363201d503|
|Office 365 Exchange Online|00000002-0000-0ff1-ce00-000000000000|
|Office 365 Management|00b41c95-dab0-4487-9791-b9d2c32c80f2|
|Office 365 Search Service|66a88757-258c-4c72-893c-3e8bed4d6899|
|Office 365 SharePoint Online|00000003-0000-0ff1-ce00-000000000000|
|Office Delve|94c63fef-13a3-47bc-8074-75af8c65887a|
|Office Online Client AAD- Augmentation Loop|2abdc806-e091-4495-9b10-b04d93c3f040|
|Office Online Client AAD- Loki|b23dd4db-9142-4734-867f-3577f640ad0c|
|Office Online Client AAD- Maker|17d5e35f-655b-4fb0-8ae6-86356e9a49f5|
|Office Online Client MSA- Loki|b6e69c34-5f1f-4c34-8cdf-7fea120b8670|
|Office Online Search|a9b49b65-0a12-430b-9540-c80b3332c127|
|Office.com|4b233688-031c-404b-9a80-a4f3f2351f90|
|Office365 Shell WCSS-Client|89bee1f7-5e6e-4d8a-9f3d-ecd601259da7|
|OfficeShredderWacClient|4d5c2d63-cf83-4365-853c-925fd1a64357|
|OneDrive SyncEngine|ab9b8c07-8f02-4f72-87fa-80105867a763|
|OneNote|2d4d3d8e-2be3-4bef-9f87-7875a61c29de|
|Outlook Mobile|27922004-5251-4030-b22d-91ecd9a37ea4|
|Power BI Service|00000009-0000-0000-c000-000000000000|
|Sway|905fcf26-4eb7-48a0-9ff0-8dcc7194b5ba|
|Vortex [wsfed enabled]|5572c4c0-d078-44ce-b81c-6cbf8d3ed39e|
|Windows Search|26a7ee05-5602-4d76-a7ba-eae8b7b67941|
|Yammer|00000005-0000-0ff1-ce00-000000000000|
|Yammer Web|c1c74fed-04c9-4704-80dc-9f79a2e515cb|
|Yammer Web Embed|e1ef36fd-b883-4dbf-97f0-9ece4b576fc6|

## More information

For more information, please see: [Sign-in activity reports in the Azure Active Directory portal](https://docs.microsoft.com/azure/active-directory/reports-monitoring/concept-sign-ins#sign-ins-report)
