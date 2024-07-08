# Lab 2 - Linked Services

*Vereisten*

Om het lab te kunnen starten is het van belang dat [Lab 1 - Integration Runtimes](../Lab1/LabInstructions1.md) is afgerond.

*Doel*

Om data over de zojuist aangemaakte IRs te laten verlopen moeten er connecties met de betreffende diensten gemaakt worden. Gedurende het lab leg je meerdere connecties, met o.a.:

* een SQL database (bijv. een bronsysteem of Data Warehouse)
* een Storage account (bijv. zoals een Data Lake)
* een File system (bijv. een share)

> ### Achtergrond informatie: Azure Data Factory autoriseren tot bronnen. ###
> * Sommige van deze bronnen kun je benaderen met behulp van *managed identity*: in dat geval worden binnen **[Azure Entra ID](https://learn.microsoft.com/nl-nl/entra/fundamentals/whatis)** rechten uitgedeeld aan de Data Factory.  
> * Andere bronnen zul je moeten benaderen met een *secret*, bijvoorbeeld een certificaat of een gebruikersnaam/wachtwoord. Deze *secrets* sla je in Azure centraal op in de **[Azure Key Vault](https://learn.microsoft.com/nl-nl/azure/key-vault/general/overview)**. Vanuit daar kun je dan eenvoudig bepalen welke diensten welke *secrets* mogen bekijken.

## Opdracht 1 - Azure Key Vault

Azure Data Factory is eenvoudig te koppelen met Azure Key Vault, waarin we wachtwoorden en connection strings opslaan. We kunnen een verbinding naar een bron dan laten vullen door een *secret* uit de *Key Vault*. Op het moment dat ADF verbinding maakt met die bron, zal ADF eerst de *secret* ophalen uit de Key Vault.

Voordat we echter *secrets* uit de Key Vault kunnen benaderen, zullen we de Key Vault eerst moeten aankoppelen als *Linked Service*.

1. Ga de ADF. Klik vervolgens weer op Manage. Ga naar **Linked Services**.
2. klik op **New**, en zoek naar **Key vault**. Klik de **Azure Key vault** aan.
3. Geef de Linked services een duidelijke naam.

> Het aangeraden format is om te beginnen met LS_, de naam van de dienst in je resourcegroup en eindigend met _omgeving.
> * Praktijkvoorbeeld: `LS_KV_Dataplatform_PRD`
> * Trainingsvoorbeeld: `LS_KV_kvr4g_Training`
> 
> In de naamgeving is een minteken (`-`) niet toegestaan. Een *underscore* (`_`) is wel mogelijk.

6. Kies de **Azure Subscription** die je in de training gebruikt
7. Kies bij **Azure Key vault Name** de key vault uit jouw Key Vault (deze start met `kv_`).
8. Klik op de knop **Test Connection** om te valideren dat de verbinding tot stand gebracht kan worden. Gaat dit fout, laat het weten aan de trainer.
9. Als test klaar is en een **Groen bolletje** geeft, kan de Linked Service aangemaakt worden door op **Create** te klikken.
   ![Instellingen voor Azure Key Vault](https://github.com/jstofferswortellsmart/ADF-Training-light-202406/assets/170087926/02bcc429-cde9-4205-b471-83cab3837d67)

11. De Linked Service naar de Azure Key Vault is nu aangemaakt, maar deze is nog niet gepubliseerd. Klik op de **Blauwe knop** met de tekst **Publish all** en vervolgens op de knop **Publish**. Door te publishen komen de aanpassingen live te staan, en kan de Key Vault gebruikt worden.

> ### Achtergrond informatie: CI/CD met Azure DevOps. ###
> In deze training voeren we wijzigingen direct uit op de **Main Branch**.  
> In de praktijk zal er sprake zijn van een Ontwikkel-, Test-, Acceptatie en Productieomgeving (OTAP). Wijzigingen worden dan niet direct op de Main Branch (Productieomgeving) uitgevoerd, maar in een featurebranch achter de Ontwikkel- of Testomgeving. Met behulp van één of meerdere **Pull Request(s)** in **[Azure DevOps](https://learn.microsoft.com/nl-nl/azure/devops/user-guide/what-is-azure-devops?view=azure-devops)** worden de wijzigingen vervolgens gevalideerd en verwerkt in de Acceptatie- en Productieomgeving.

## Opdracht 2 - Databases

Met de Key Vault aangesloten is het mogelijk om wachtwoorden op te halen om een beveiligde verbinding op te zetten met bijvoorbeeld de databases.

1. Klik op **New**, en zoek naar **SQL**. Dubbelklik de **Azure SQL Databases** aan.
2. Geef de Linked services een duidelijke naam:
> Bijvoorbeeld: 
> * `LS_sqldb_source`
> * `LS_sqldb_target`
3. Kies bij **Connect via integration runtime** de eigen gemaakte **Azure IR**.
4. Kies bij de **Azure Subscription** het abonnement waaronder je werkt.
5. Kies bij de **Server Name** de Server naam in zoals deze in je resourcegroup staat.
6. Kies bij de **Database Name** de source Database naam in zoals deze in je resourcegroup staat. De source database begint met **sqldb-source-** als naam.
7. Vul bij de **User Name** het SQL admin account in genaamd: **sqladmin**.
8. Bij de optie tussen **Password** en **Azure Key Vault**, kies de Key vault.
9. Kies bij **AKV linked service** de eerder aangemaakte Key Vault Linked Service.
10. Kies bij **Secret Name** de optie **sqladmin**
11. Klik op de knop **Test Connection** om te valideren dat de verbinding tot stand gebracht kan worden. Gaat dit fout, laat het weten aan de trainer.
12. Als test klaar is en een **Groen bolletje** geeft, kan de Linked Service aangemaakt worden door op **Create** te klikken.
13. Doe Opdracht 2 nogmaals, maar nu voor de **sqldb-target** Database.
    ![Instellingen voor sqldb_source](https://github.com/jstofferswortellsmart/ADF-Training-light-202406/assets/170087926/9cc4d07e-405a-4476-8fc7-0876ee858c8b)

Je hebt nu twee Linked Services aangemaakt. Dit maakt het voor ADF mogelijk om verbinding te maken met de twee databases.

## Opdracht 3 - Storage Account

De tweede bron die we toevoegen is een Storage Account. Deze kunnen we bijvoorbeeld gebruiken als *landing zone* voor de data, of als Data Lake.

1. klik op **New**, en zoek naar **storage**. Klik de **Azure Blob Storage** aan.
2. Geef de Linked services een duidelijke naam:
> Bijvoorbeeld: 
> * `LS_blob_training`
3. Kies bij **Connect via integration runtime** de eigen gemaakte **Azure IR**.
4. Kies bij **Storage account name** het storage account dat begint met ***st*** zoals deze in je resourcegroup staat.
5. Klik op de knop **Test Connection** om te valideren dat de verbinding tot stand gebracht kan worden. Gaat dit fout, laat het weten aan de trainer.
6. Als test klaar is en een **Groen bolletje** geeft, kan de Linked Service aangemaakt worden door op **Create** te klikken.
   ![Instellingen voor Blob storage](https://github.com/jstofferswortellsmart/ADF-Training-light-202406/assets/170087926/940d77ca-a08b-4c64-8390-ed12652b19de)

> ### Achtergrond informatie: Minder instellingen voor Storage Account. ###
> De rechten op het Storage Account zijn uitgedeeld via Azure Entra ID. Hier heb je dus geen *secret* voor hoeven gebruiken.

## Opdracht 4 - Publish

1. Vergeet je laatste wijzigingen niet te publiseren.  
   Klik op de **Blauwe knop** met de tekst **Publish all** en vervolgens op de knop **Publish**. Door te publishen komen de aanpassingen live te staan, en kan de Key Vault gebruikt worden.

## Inhoudsopgave

0. [De Azure omgeving prepareren](../0Prep/LabVoorbereiding0.md)
1. [Integration Runtimes](../Lab1/LabInstructions1.md)
2. [Linked Services](../Lab2/LabInstructions2.md)
3. [Datasets](../Lab3/LabInstructions3.md)
4. [Pipelines](../Lab4/LabInstructions4.md)
5. [Triggers](../Lab5/LabInstructions5.md)
6. [Activities](../Lab6/LabInstructions6.md)
7. [Batching en DIUs](../Lab7/LabInstructions7.md)
8. [Copy to CSV in Storage Account](../Lab8/LabInstructions8.md)
