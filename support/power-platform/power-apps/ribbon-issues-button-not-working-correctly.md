---
title: A button in the command bar is not working correctly
description: Fixes an issue in which a button in the command bar is not working correctly.
ms.reviewer: krgoldie, srihas
ms.topic: troubleshooting
ms.date: 05/15/2021
---
# A button in the command bar is not working correctly

_Applies to:_ &nbsp; Power Apps  
_Original KB number:_ &nbsp; 4552163

## Determine why a button is not working correctly

\<Add intro info>

Please select one of the following options that best matches your situation to help us provide the best resolution. The first tab is selected by default.

### [The button does nothing when clicked](#tab/nothing)

#### Fix a button that does nothing when clicked

\<Add intro info + steps>

Please select one of the following repair options:

##### Option 1: Delete the command with the incorrect JavaScriptFunction declaration

<details>
<summary><b>The command is in the unmanaged Active solution</b></summary>

###### Delete the command with the invalid JavaScriptFunction declaration in the unmanaged Active solution

\<Add intro info + steps>

</details>

<details>
<summary><b>The command is from a custom managed solution that my company authored</b></summary>

###### Delete a command from a custom managed solution

\<Add intro info + steps>

</details>

<details>
<summary><b>The command is from a custom managed solution that my company did not author (i.e. from third-party/ISV)</b></summary>

###### Delete a command from a custom managed solution from a third-party/ISV

\<Add intro info + steps>

</details>

##### Option 2: Fix the command JavaScriptFunction declaration

<details>
<summary><b>The command is in the unmanaged Active solution</b></summary>

###### Fix the command JavaScriptFunction declaration in the unmanaged Active solution

\<Add intro info + steps>

</details>

<details>
<summary><b>The command is from a custom managed solution that I authored</b></summary>

###### Fix a command from a custom managed solution

\<Add intro info + steps>

</details>

<details>
<summary><b>The command is from a custom managed solution that I did not author or my organization does not own (i.e. from a third-party/ISV)</b></summary>

###### Fix a command from a custom managed solution from a third-party/ISV

\<Add intro info + steps>

</details>

### [I get a Script Error "Invalid JavaScript Action Library"](#tab/error)

#### Fix a button that displays an error when clicked

When a ribbon command bar button is clicked and an error occurs, it is typically caused by incorrect ribbon [command](/powerapps/developer/model-driven-apps/define-ribbon-commands) customizations.

##### Fix Script Error "Invalid JavaScript Action Library"

\<Add intro info + steps>

Select one of the following options that matches your particular scenario:

<details>
<summary><b>The command is in the unmanaged Active solution</b></summary>

The approach to fix the command will vary depending if your definition is the only one, or if there are other inactive definitions, and whether or not the changes were intentional.

Please select the option that reflects your scenario:

- <details>
  <summary><b>The command does not have any intentional modifications and I would like to remove this custom layer</b></summary>

  **Fix Script Error Invalid JavaScript Action Library from the unmanaged Active solution - Delete Layer**

  \<Add intro info + steps>

  </details>

- <details>
  <summary><b>The command has additional modifications that I would like to retain and want to fix this solution layer</b></summary>

  **Fix Script Error "Invalid JavaScript Action Library" from the unmanaged Active solution**

  \<Add intro info + steps>

  </details>

</details>

<details>
<summary><b>The command is from a custom managed solution that I authored</b></summary>

###### Fix a command from a custom managed solution

\<Add intro info + steps>

</details>

<details>
<summary><b>The command is from a custom managed solution that I did not author or my organization does not own (i.e. from a third-party/ISV)</b></summary>

###### Fix a command from a custom managed solution from a third-party/ISV

\<Add intro info + steps>

</details>

<details>
<summary><b>The command is in a Microsoft published managed solution</b></summary>

###### Fix a command from a Microsoft published managed solution

\<Add intro info + steps>

</details>

### [I get a different error](#tab/different-error)

#### Fix a button that displays an error when clicked

When a ribbon command bar button is clicked and an error occurs, it is typically caused by incorrect ribbon [command](/powerapps/developer/model-driven-apps/define-ribbon-commands) customizations.

##### Fix other types of errors

\<Add intro info + steps>

Please select one of the following repair options:

###### Option 1: Delete the command with the invalid JavaScriptFunction declaration

<details>
<summary><b>The command is in the unmanaged Active solution</b></summary>

**Delete the command with the invalid JavaScriptFunction declaration in the unmanaged Active solution**

\<Add intro info + steps>

</details>

<details>
<summary><b>The command is from a custom managed solution that my company authored</b></summary>

**Delete a command from a custom managed solution**

\<Add intro info + steps>

</details>

<details>
<summary><b>The command is from a custom managed solution that my company did not author (i.e. from third-party/ISV)</b></summary>

**Delete a command from a custom managed solution from a third-party/ISV**

\<Add intro info + steps>

</details>

###### Option 2: Fix the command JavaScriptFunction declaration

<details>
<summary><b>The command is in the unmanaged Active solution</b></summary>

**Fix the command JavaScriptFunction declaration in the unmanaged Active solution**

\<Add intro info + steps>

</details>

<details>
<summary><b>The command is from a custom managed solution that I authored</b></summary>

**Fix a command from a custom managed solution**

\<Add intro info + steps>

</details>

<details>
<summary><b>The command is from a custom managed solution that I did not author or my organization does not own (i.e. from a third-party/ISV)</b></summary>

**Fix a command from a custom managed solution from a third-party/ISV**

\<Add intro info + steps>

</details>

<details>
<summary><b>The command is in a Microsoft published managed solution</b></summary>

**Fix a command from a Microsoft published managed solution**

\<Add intro info + steps>

</details>
