---
title: Element savedquery has incomplete content
description: Provides a solution to an error that occurs when you try to import a Microsoft Dynamics 365 solution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# The element savedquery has incomplete content. List of possible elements expected: LocalizedNames error occurs when importing a Microsoft Dynamics 365 solution

This article provides a solution to an error that occurs when you try to import a Microsoft Dynamics 365 solution.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4463330

## Symptoms

When attempting to import a solution in Dynamics 365, you receive the following error:

> "This solution package cannot be imported because it contains invalid XML. You can attempt to repair the file by manually editing the XML contents using the information found in the schema validation errors, or you can contact your solution provider.
Error code 8004801a."

If you select **Technical Details**, you see the following message along with other error details:

> "Schema validation of the customizations.xml file within the compressed solution package file failed. To manually validate and edit the file, you can download the schema file [here](https://go.microsoft.com/fwlink/?LinkId=196060) and use an XML editor that supports schema validation to get more details."

The textbox showing more details include the following information:

> "The element 'savedquery' has incomplete content. List of possible elements expected: 'LocalizedNames'."

The textbox also includes extra details such as part of the FetchXML used for the saved query (view).

## Cause

This error indicates a saved query (view) is included in the solution and the XML for that saved query definition is missing the LocalizedNames section. Which may occur if someone has manually modified the customizations.xml file.

## Resolution

To allow the solution to import successfully, the LocalizedNames section within the XML for the saved query needs to be added.

1. Extract the contents of the solution .zip file you're trying to import.
2. Open the customization.xml file in a text editor.
3. Refer to the error details that should include part of the fetchxml section from the saved query. You may need to find a unique section of this XML and then search within the customization.xml file to find a matching saved query.
4. Once you've located the saved query that is referenced in the error details, update the XML to include the LocalizedNames section. An example of a saved query is provided below with the missing section.

    ```xml
    <savedquery unmodified="1">
                <isquickfindquery>0</isquickfindquery>
                <isprivate>0</isprivate>
                <isdefault>0</isdefault>
                <savedqueryid>{65ffaf9a-e8c5-432d-860b-32f841b00d87}</savedqueryid>
                <queryapi></queryapi>
                <layoutxml>
                  <grid name="resultset" jump="name" select="1" icon="1" preview="1">
                    <row name="result" id="accountid">
                      <cell name="name" width="300" />
                      <cell name="telephone1" width="100" />
                      <cell name="address1_city" width="100" />
                      <cell name="primarycontactid" width="150" />
                      <cell name="accountprimarycontactidcontactcontactid.emailaddress1" width="150" disableSorting="1" />
                      <cell name="statecode" width="100" />
                    </row>
                  </grid>
                </layoutxml>
                <querytype>0</querytype>
                <fetchxml>
                  <fetch version="1.0" output-format="xml-platform" mapping="logical">
                    <entity name="account">
                      <attribute name="name" />
                      <attribute name="telephone1" />
                      <attribute name="address1_city" />
                      <attribute name="primarycontactid" />
                      <link-entity alias="accountprimarycontactidcontactcontactid" name="contact" from="contactid" to="primarycontactid" link-type="outer" visible="false">
                        <attribute name="emailaddress1" />
                      </link-entity>
                      <attribute name="statecode" />
                    </entity>
                  </fetch>
                </fetchxml>
                <IntroducedVersion>9.0.0.0</IntroducedVersion>
                <LocalizedNames>
                  <LocalizedName description="All Accounts" languagecode="1033" />
                </LocalizedNames>
              </savedquery>
    ```

5. After correcting the XML, select all of the components you extracted from the solution file and send them to a new .zip file.
6. Attempt to import the solution again.

> [!NOTE]
> If there are multiple saved queries (views) missing the \<LocalizedNames> section, the steps may need to be repeated for each view.

## More information

If you aren't sure of the correct saved query (view) name to provide for this section, you can find the name using the `savedqueryid` value and the Dynamics 365 WebAPI. In the example above, the `savedqueryid` value is 65ffaf9a-e8c5-432d-860b-32f841b00d87. You can then access the following URL in your web browser to return the name of the view:

`https://<your dynamics 365 URL>/api/data/v9.0/savedqueries(<savedqueryid>)?$select=name`

Example:

`https://contoso.crm.dynamics.com/api/data/v9.0/savedqueries(65ffaf9a-e8c5-432d-860b-32f841b00d87)?$select=name`
