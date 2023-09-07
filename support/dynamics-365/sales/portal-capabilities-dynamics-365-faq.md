---
title: Portal capabilities for Dynamics 365 FAQ
description: Describes Portal capabilities for Dynamics 365 FAQ.
ms.reviewer: 
ms.date: 03/31/2021
ms.subservice: d365-sales-portal-addon
---
# Portal capabilities for Microsoft Dynamics 365 FAQ

There are many commonly asked questions about what Dynamics 365 Portals can do and how certain functionality can be achieved. This document covers many of those common questions and their answers.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4456128

## Licensing and Provisioning

- **How can I get a portal subscription?**

    A portal subscription can be acquired through two means:
    1. We provide one portal addon with the purchase of certain types and quantities of Dynamics 365 user license. Details are present in [Dynamics 365 pricing and licensing guide](https://go.microsoft.com/fwlink/?LinkId=866544&clcid=0x409). It's important to note that you only get one portal addon with user licenses even if you have bought multiple types or quantities of valid licenses.
    2. Other portal subscription can be purchased by purchasing a Portal Add-on subscription. This subscription is an addon subscription to Dynamics 365 and is available to be purchased if you have appropriate Dynamics 365 licenses.

- **How can I change Portal Type and audience after a Portal is provisioned?**

    After provisioning a portal, you can change the portal type and audience by following the steps listed in [How to change the audience and type of a Dynamics 365 Portal](https://support.microsoft.com/help/4091253).

- **How can I change a Portal's Base URL (i.e subdomain of microsoftcrmportals.com URL) once a Portal is provisioned?**

    After provisioning a portal, you can change base URL of the portal by following [this documentation](/dynamics365/customer-engagement/portals/change-base-url).

- **How can I delete a Portal once it's provisioned?**

    Each portal is composed of two parts:
    1. Portal host - It's the website that runs the portal code.
    2. Portal solutions - These are the solutions installed in your Dynamics 365 organization when a portal is provisioned

    To delete a portal completely requires deleting the portal host, and uninstalling the portal solutions from your Dynamics 365 organization.

    To reset the portal host, follow the steps listed in [Reset a portal](/powerapps/maker/portals/admin/reset-portal). It's important to note that resetting the portal host doesn't affect the configuration done in your Dynamics 365 organization.

    To delete the portal solutions, you'll have to delete solutions from the Dynamics 365 solutions area. You can navigate to the Solutions area within the Dynamics 365 web application by selecting **Settings**, and then selecting **Solutions**. The order in which portal solutions should be uninstalled is provided in [Portal Troubleshooting, Part Three: Uninstalling Portal Solutions](https://community.dynamics.com/blogs/post/?postid=30cb2a9f-fbfe-4c92-9166-3b60bf98b731).

## Dynamics 365 organization lifecycle

- **We recently moved our Dynamics 365 organization from one geo/tenant to another. How do we handle Portals connected to our organization?**

    When you move your Dynamics 365 organization from one geo/tenant to another, associated Portals to that organization won't move automatically. Also since your organization is moved, a portal associated to that organization won't work and will throw an error on startup.

    To associate your portal again to the relevant organization, you can follow these steps:

    1. You should reset your existing Portal host from the existing tenant/geo by following steps mentioned in [Reset a portal](/powerapps/maker/portals/admin/reset-portal).
    1. This step will delete your associated Portal resources and the Portal URL won't be accessible after the operation completes.
    1. Once your existing Portal is reset, then you need to go to your new tenant (or to new geo of existing tenant) and provision a portal available there.

- **We recently did a restore of our Dynamics 365 organization from an old backup, and now the Portal connected to that org isn't working. How do we fix it?**

    When a dynamics 365 organization is restored from a backup, there are various changes that are done in your organization that can break your Portal's connection with the org. Follow these steps to fix it:

  - If the organization ID is the same after the restore operation, and Portal solutions are also present:

    1. Go to the [Dynamics 365 online Administration Center](/dynamics365/marketing/power-platform-admin-center).
    2. Select the **Applications** tab.
    3. Select your Portal, and select **Manage** to open the Portal Admin center.
    4. Select **Portal Details.**
    5. Change **Portal State** to **Off** and then select **Update.**
    6. Once it completes, change the **Portal State** back to **On** and then select **Update.**
    7. Once both steps are done, your Portal would be restarted and will also create a connection with the org again.

  - If the organization ID is different after the restore operation or Portal solutions are deleted from your org:

    1. In this case, it's better to reset the Portal using steps mentioned in [Reset a portal](/powerapps/maker/portals/admin/reset-portal).

- **We recently changed the URL of our Dynamics 365 organization and our Portal stopped working. How do we fix it?**

    When you change the URL of your Dynamics 365 organization, your portal will stop working because it can't identify the Dynamics 365 URL anymore. To fix it, follow these steps:

    1. Go to the [Dynamics 365 online Administration Center](/dynamics365/marketing/power-platform-admin-center).
    2. Select the **Applications** tab.
    3. Select your Portal, and select **Manage** to open the Portal Admin center.
    4. Select **Portal Actions**.
    5. Select **Update Dynamics 365 URL** and go through the instructions.
    6. Once done, your portal will restart and will start working again.

## Debugging and Fixing Problems

- **When accessing my Portal, I see a generic error page. How can I find error details?**

    Whenever a server error occurs while trying to render the portal, a generic error page is shown to end users along with timestamp and Activity ID of that error. Portal administrators can configure their portal to get the actual error details that are helpful in debugging and fixing issues. You can use one or both of the following options:

    1. **Disable the custom error page**

        It will turn off the custom error page and will allow you to see the complete stack trace of any error when navigating to that page. Follow [these steps](/powerapps/maker/portals/admin/view-portal-error-log#custom-error).

        > [!NOTE]
        > It's advisable to use this only when you are developing a portal. Once your portal is live for your users, you should enable custom errors again.

    1. **Enable diagnostic logging**

        It will allow you to get all the portals errors in an Azure blob storage. To enable it, follow the steps described [here](/powerapps/maker/portals/admin/view-portal-error-log#access-portal-error-logs).

        When you enable diagnostic logging, you can search for particular errors which users reported by using the Activity ID shown on the generic error page. That Activity ID is logged along with the error details and is useful to find the actual issue.

## Portal Administration and Management

- **How can I use a Custom Sign-in Provider on my Portal?**

    Dynamics 365 portals support any custom sign-in provider that provides support for standard authentication protocols. We support OpenIdConnect, SAML2, and WS-Fed protocols for any custom IDP. Oauth2 is only supported for a fixed set of known IDP's. For more information about how set up an IDP configuration, see [Access portal error logs](/powerapps/maker/portals/admin/view-portal-error-log#access-portal-error-logs).

- **How can I get new Portal releases in my sandbox Portal first before it gets applied to production?**

    Any Portal release is done in two phases, Early Upgrade and GA (General Availability). During the Early Upgrade phase, we only upgrade portals that are marked for early upgrade. To get the new Portal release in your sandbox (dev/test) environment, you can enable your Portal for Early Upgrade.

    For more information about the process, see [Upgrade a portal](/powerapps/maker/portals/admin/upgrade-portal).

- **How can I use a vanity domain name with my Portal?**

    You can enable your portal to use a vanity domain name in place of standard `microsoftcrmportals.com` domain name. To do it, follow the steps provided in [Administer your portal](/dynamics365/portals/manage-portal#link-your-dynamics-365-portal-to-a-custom-domain).

- **How can I remove an entity from Global Search?**

    See [Remove an entity from global search](/powerapps/maker/portals/configure/search#remove-an-entity-from-global-search)

- **How can I rebuild the search index?**

    See [Rebuild full search index](/powerapps/maker/portals/configure/search#rebuild-full-search-index)

