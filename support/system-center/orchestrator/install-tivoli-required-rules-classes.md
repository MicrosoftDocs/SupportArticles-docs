---
title: Install Tivoli required rules and classes
description: Describes how to install the required rules and classes for Opalis Integration Pack for IBM Tivoli Enterprise Console.
ms.date: 06/26/2024
ms.reviewer: irfanr, jfanjoy
---
# Install Opalis Integration Pack for IBM Tivoli Enterprise Console class and rule definitions

The Opalis Integration Pack for IBM Tivoli Enterprise Console requires that new classes and rules be incorporated into IBM Tivoli Enterprise Console to function properly. This article describes how to install the required rules and classes.

_Applies to:_ &nbsp; All versions of Orchestrator  
_Original KB number:_ &nbsp; 2491953

The IBM Tivoli Enterprise Console application leverages custom rules and classes by providing the ability to create a rule base and then import desired classes and rules into that rule base. For the purposes of the Integration Pack for IBM Tivoli Enterprise Console, it's recommended to create a new rule base and to import the Opalis Event classes and rules into that new rule base by leveraging the following two files:

- opalis.baroc - Provides the class definitions for Opalis Events that are to be created in IBM Tivoli Enterprise Console.
- opalis.rls - Provides the rule definitions for Opalis Events that are to be created and updated in IBM Tivoli Enterprise Console.

> [!NOTE]
> The current release of the Opalis Integration Pack for IBM Tivoli Enterprise Console doesn't have these files included. This is scheduled to be corrected in the next release. In the meantime, these files can be acquired by opening a service request with Microsoft Product Support.

## Create a new rule base using the Tivoli Command Shell  

To create a new rule base using the Tivoli Command Shell, follow the steps below:

1. On the IBM Tivoli Enterprise Console server, create a new folder where the Opalis rule base will be saved (for example, `C:\Opalis_RB`).

2. Open a Tivoli Command Shell instance (typically available by selecting **Start** > **Programs** > **Tivoli** > **Tivoli Command Shell**).

3. Type `wrb -crtrb -path <Rule Base Path> <Rule Base Name>` and press Enter (for example, `wrb -crtrb -path C:\Opalis_RB Opalis_RB`).

## Create a new rule base using the Tivoli Desktop

To create a new rule base using the Tivoli Desktop, follow the steps below:

1. On the IBM Tivoli Enterprise Console server, create a new folder where the Opalis rule base will be saved (for example, `C:\Opalis_RB`).

2. Open the Tivoli Desktop application (typically available by selecting **Start** > **Programs** > **Tivoli** > **Tivoli Desktop**). Sign in when prompted.

3. Right-click **EventServer**, and then select **Rule Bases...**

4. From the menu bar, select **Create** > **Rule Base...**

5. Type a name for the rule base (for example, Opalis_RB) and a folder path where the rule base will be saved (for example, C:\Opalis_RB).

6. Select **Create & Close**.

## Import class and rule definitions using the Tivoli Command Shell

To import rule and class definitions using the Tivoli Command Shell, follow the steps below:

1. Copy the opalis.baroc and opalis.rls files to a temporary folder (for example, `C:\Temp`).

2. Open a Tivoli Command Shell instance (typically available by selecting **Start** > **Programs** > **Tivoli** > **Tivoli Command Shell**).

3. Type `wrb -imprbclass <Class File> <Rule Base>` and press Enter (for example, `wrb -imprbclass C:/Temp/opalis.baroc Opalis_RB`).

4. Type `wrb -imprbrule <Rule File> <Rule Base>` and press Enter (for example, `wrb -imprbrule C:/Temp/opalis.rls Opalis_RB`).

5. Type `wrb -imptgtrule opalis EventServer <Rule Base>` and press Enter (for example, `wrb -imptgtrule opalis EventServer Opalis_RB`).

6. Type `wrb -comprules <Rule Base>` and press Enter (for example, `wrb -comprules Opalis_RB`).

7. Type `wrb -loadrb -use <Rule Base>` and press Enter (for example, `wrb -loadrb -use Opalis_RB`).

8. Restart the **EventServer**. To do this, type `wstopesvr` and press Enter. Then type `wstartesvr` and press Enter.

## Import class and rule definitions using the Tivoli Desktop

To import rule and class definitions using the Tivoli Desktop, follow the steps below:

1. Open the Tivoli Desktop application (typically available by selecting **Start** > **Programs** > **Tivoli** > **Tivoli Desktop**). Sign in when prompted.

2. Right-click **EventServer**, and then select **Rule Bases...**

3. Right-click the desired rule base, and then select **Import...**

4. Under **Rule Sets**, type a folder path where the opalis.rls file is located (for example, `C:/Temp/opalis.rls`), and then select **Import Rule Set**.

5. Under **Class Definitions**, type a folder path where the opalis.baroc file is located (for example, `C:/Temp/opalis.baroc`) and then select **Import Class Definitions**.

6. Select **Import & Close**.

7. Right-click the desired rule base, and then select **Compile...**

8. Select **Compile**. When completed, select **Close**.

9. Right-click the desired rule base, and then select **Load...**

10. Select **Load and activate the rule base**, and then select **Load & Close**.

11. Close the **Event Server Rule Bases** window.

12. Right-click **EventServer**, and then select **Shut Down**.

13. Right-click **EventServer**, and then select **Start-up**.
