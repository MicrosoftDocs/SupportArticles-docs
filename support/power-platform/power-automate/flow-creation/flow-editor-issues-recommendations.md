---
title: Flow Editor Issues and Recommendations
description: Describes Flow Editor issues and recommendations.
ms.reviewer: 
ms.date: 03/31/2021
ms.subservice: power-automate-flow-creation
---
# Flow Editor issues and recommendations

This article describes Flow Editor issues and recommendations.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4517231

## Some tokens from previous steps missing in Token Picker

- Some users have complained that they don't see all the tokens from previous steps while attempting to add dynamic content to a parameter.
- This behavior is expected since Flow's Token Picker filters the tokens based on the data type of the parameter. The token picker for a string parameter only see a filtered list of tokens that are strings.

## Using attachments with manual triggers

- Users attempting to use files with manual triggers can add an input of type file and add the file content in the value. The file can then be imported while triggering the run.
- Later steps can use the file and filename as a token in their parameters. The file name can be extracted using the expression `triggerBody()['file'] ['name']` in token picker.

## Adding an action between two cards

- The **+** button to add a new action between two action cards isn't visible until the user hovers over the edge between the two actions.
- The **+** button won't be visible if a recommendation card to Add an action is open anywhere in the Flow.

## Adding Dynamic links within an HTML Editor

- A few actions like Send an Email(O365) and Post a Message(Teams) allow Flow authors to use a generic HTML Editor while crafting the message. Some customers would like to add a dynamic link to these messages.

- Select the **</>** option in the respective parameter of the action. Which will enable the HTML Editor. The customer can then use an html tag along the lines of `"<a href = "{Link Token from previous step}">File</a>`.

- After a flow run, the link will now be visible at the corresponding client.

## No document ID or document number while using BusinessCentral Connector

- Consider a scenario where user authors a flow that is supposed to create a Purchase Invoice in one step, and then create the lines for the Purchase Invoice in the next step.
- The Document ID or Document Number field isn't present by default in the Action definition for the Document Central actions. Because of not setting the document ID, the user experiences a failure at runtime as document ID isn't being populated.
- As a workaround, the flow needs to be exported and the definition json needs to be modified to insert the documentID under the inputs body of the action. The modified definition will then need to be imported back into Flow.

## Where's my SharePoint site?

- If you don't see your SharePoint site in the dropdown, it's likely because you haven't visited the site recently. The list only shows some of your most recently used sites. You must select **Enter a custom value** from the dropdown and type in the site you're looking for manually.
