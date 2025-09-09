---
title: Error We couldn't start OneNote the last time we tried
ms.author: meerak
author: Cloud-Writer
manager: dcscontentpm
ms.date: 06/06/2024
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - OneNote 2016
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Open\Errors
  - CI 117067
  - CSSTroubleshoot
ms.reviewer: subhbasu
description: How to resolve the error We couldn't start OneNote the last time we tried.
---

# "We couldn't start OneNote the last time we tried" error

*Written and maintained by [Gaurav Singh](https://social.technet.microsoft.com/profile/gaurav0327/), Support Engineer Office Core*.

## Symptoms

When you start OneNote for the first time, you see the following errors if you cancel the sign-in prompt:

- Start Normally
- Delete the Notebook Cache
- Delete Settings

A sign-in prompt appears at the first launch:

:::image type="content" source="media/couldnt-start-onenote-the-last-time-error/sign-in-prompt.png" alt-text="Screenshot of the sign-in prompt at the first launch.":::

Error message:

> We couldn't start OneNote the last time we tried. What do you want us to do?
> We're not sure what went wrong.

:::image type="content" source="media/couldnt-start-onenote-the-last-time-error/error-message.png" alt-text="Screenshot of the error message after canceling the sign-in prompt." border="false":::

If you select **Delete Notebook Cache** or **Delete Settings**, OneNote will start, but displays the message "You don't have any open notebooks."

:::image type="content" source="media/couldnt-start-onenote-the-last-time-error/error-message-notebook.png" alt-text="Screenshot of the error message, showing you don't have any open notebooks.":::

## Cause

This issue might be caused by one of the following reasons:

- Microsoft OneNote is a "freemium" product. The first time the user starts OneNote after it's installed, the license will update automatically to the same license as the version of Office that is already installed on the device and will create different registry entries at the following location: `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\OneNote`.
- When OneNote starts for the first time, it will check the Office suite license to see whether it's a free version, the Home & Student version, or the Enterprise version, and will try to update OneNote to match the same license as the version of Office already installed. This situation will produce the "Sign-in" prompt in an attempt to validate the license.
- Microsoft is only providing support for the free Home & Student version unless you upgrade to the Office Pro or Enterprise suites of the products through either Customer Service and Support (CSS) or Microsoft Premier.

You may also receive this error if the subkey under this location is changed/corrupted or deleted.

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

OneNote validates the installation through the **FirstBootStatus** registry key.

If the key is not located or not found at the location (which is normal for a new installation), then the installation will create the registry entries:

`HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\OneNote`

To avoid this behavior, set the value for **FirstBootStatus** to show that OneNote is already installed. Do this by following the steps in one of the methods:

- For a single device, use the Registry Editor:
   1. Select the Windows Start button, select **Run**, and then type **`regedit`** to launch the Registry Editor.
   2. Locate the `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\OneNote` key.
   3. Right-click **FirstBootStatus**, change the value to 02000202.

- For multiple devices, create (or deploy) the registration hive before the first launch of the OneNote application (or with the installation) via script or GPO:

   1. Open the Group Policy Management console by running the command `gpmc.msc`.
   2. Expand the tree, right-click the OU you want this policy to be applied to.
   3. Right-click on the OU ManagementTeam, and select **Create a GPO in this domain, and Link it here…**
   4. Give the policy a new name and select **OK**.
   5. Right-click the newly created GPO Deploy Registry Policy, and select **Edit**.
   6. In the Group Policy Management Editor window, select **Computer Configuration** > **Preferences** > **Windows Settings** > **Registry**.
   7. Right-click the **Registry** node, then select **New** > **Registry Item**.
   8. In the new window, select the Registry Hive where your registry key exists and select the browse button (…) to select the existing registry value.
   9. Select the registry value to update.

## More information

- In April 2018, Microsoft announced that OneNote for Windows Desktop would no longer be included in the default installation of Microsoft 365 client products.
- Starting in August 2018, OneNote was removed for customers who installed Microsoft 365 client products on Windows 10. See [OneNote 2016 is missing after installing Microsoft 365 or Office 2019](https://support.office.com/article/onenote-2016-is-missing-after-installing-office-365-or-office-2019-1844ba87-7248-4bd8-a735-66a52f98e6e5) for more information.
- The preferred version of OneNote for Windows 10 devices is the "Universal" version of OneNote known as OneNote for Windows 10 (store app).
- Since many corporate customers preferred to use OneNote for Windows Desktop, Microsoft announced in November 2019 during Ignite that OneNote would be added back into the installation of Microsoft 365 client subscriptions.
- Starting March 10, 2020, OneNote Win32 was added to the default installation of Microsoft 365 for all licenses with client apps and Office 2019.
- There are no plans to retire the separate (standalone) download at this time. OneNote will continue to be available [here](https://www.onenote.com/download).

### Impact to administrators

- Administrators who don't manage the deployment of Microsoft 365 clients to their users and instead let Microsoft control the installation will find that OneNote is included by default for all new installations of Microsoft 365 Apps starting March 10 from all update channels.
- Administrators who manage the deployment of Microsoft 365 clients to their users will see no change in their deployments.
- Administrators who decided to exclude OneNote from installations will continue to see OneNote excluded from new installs.
- Administrators who decided to include OneNote with their installations will continue to see OneNote included with new installs.

### For standalone installation via Office Deployment Tool

To install via the [Office Deployment Tool](https://support.microsoft.com/help/4026267), add the following code:

```xml
<Configuration>
   <Add>
      <Product ID="OneNoteFreeRetail">
       <Language ID="MatchOS"/>
      </Product>
   </Add>
   <Display Level="None" AcceptEULA="TRUE" />
</Configuration>
```

Reference: [Deployment guide for OneNote](/deployoffice/deployment-guide-onenote)

### References

- Get OneNote: [Mac](https://onenote.com/get) | [iOS](https://app.adjust.com/ux3h90) | [Android](https://app.adjust.com/l1lwt7) | [Windows](https://www.microsoft.com/p/onenote-for-windows-10/9wzdncrfhvjl) | [OneNote Online](https://www.onenote.com/notebooks)
- Suggestions: [Feedback for Microsoft 365](https://feedbackportal.microsoft.com/)
- Help: [Answers.Microsoft.com](https://answers.microsoft.com/)
- [Install or reinstall OneNote 2016 for Windows](https://support.office.com/article/install-or-reinstall-onenote-2016-for-windows-c08068d8-b517-4464-9ff2-132cb9c45c08?ui=en-US&rs=en-US&ad=US)
- [Your OneNote](https://techcommunity.microsoft.com/t5/office-365-blog/your-onenote/ba-p/954922)
- [What's new in OneNote for Windows 10](https://support.office.com/article/what-s-new-in-onenote-for-windows-10-1477d5de-f4fd-4943-b18a-ff17091161ea?ui=en-US&rs=en-US&ad=US)
- [What's the difference between OneNote and OneNote 2016?](https://support.office.com/article/what-s-the-difference-between-onenote-and-onenote-2016-a624e692-b78b-4c09-b07f-46181958118f?ui=en-US&rs=en-IN&ad=IN)
- [Get started with OneNote](https://support.office.com/article/get-started-with-onenote-e768fafa-8f9b-4eac-8600-65aa10b2fe97?ui=en-US&rs=en-US&ad=US)
- [How to locate your OneNote notebooks](https://support.microsoft.com/office/32cb2bd7-afe7-44d2-a711-398a88421287)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
