# Voorbereiding - De Azure omgeving prepareren

*Vereisten*

Om aan deze training te beginnen is het belangrijk dat je een eigen Azure-omgeving hebt met voldoende rechten om Azure Data Factory en bijbehorende resources te kunnen inrichten.

*Doel*

Gedurende de training heb je een werkende omgeving nodig om **hands-on** aan de slag te kunnen gaan met de Azure Data Factory.

In deze reeks opdrachten wordt de omgeving ingericht, zet je de data klaar en richt je de database in. Volg de opdrachten stap voor stap.

## Opdracht 1 - Azure services uitrollen

1. Klink op de onderstaande **deploy to azure** knop. Mocht je de handout fysiek hebben ontvangen, ga naar de Github repo aangegeven door de trainer.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fwortell-smart-learning%2FADF-Training-light%2Fmain%2F0Prep%2FLabEnvironment%2Fazuredeploy.json)

2. In het deployscherm zijn alle vereisten velden al voorzien van waardes. Je dient alleen zelf een resourcegroup aan te maken door op de **create new** te klikken. Vul hier een naam in en klik vervolgens op OK. 

> Een *best practice* is om de naam van een resourcegroup te laten beginnen met `rg-` gevolgd door een omschrijvende naam en eindigend met een `-omgeving`. 
>
> * Praktijkvoorbeeld:* `rg-dataplatform-dev`
> * Trainingsvoorbeeld:* `rg-adf-training`
>

3. Klik op de knop **Review + Create**. De code wordt vervolgens gevalideerd. Als de validatie geslaagd is wordt dit aangegeven door een groene balk en wordt de knop **Create**  beschikbaar. Klik op de knop en de uitrol van de omgeving zal starten. Mocht er iets fout gaan gedurende de uitrol, laat dit weten aan de trainer.

4. Als de uitrol voltooid is krijg je daar een melding van en hoera! Jouw omgeving is klaar voor gebruik! 

## Opdracht 2 - Data klaar zetten

5. Ga terug naar de Azure portal (portal.azure.com) en zoek binnen je resourcegroup naar het **Storage Account** en klik deze aan.
5. In de Blade (Navigatiebalk aan de linkerkant) vind je onder het kopje **Data storage** de optie **Containers**, klik deze aan.
5. Je zult zien dat er al een container is genaamd **data**, klik deze aan. De container is nog leeg en deze gaan wij vullen met de bestanden **ProductCategoryDiscount.csv** en **SalesPersonal.csv**.
5. In de horizontale navigatiebalk zie je een aantal opties zoals:
    * Upload
    * Change access level
    * refresh
5. Klik op **Upload**, klik op **browse for files** en selecteer het bestaand genaamd **ProductCategoryDiscount.csv** of sleep het bestand vanuit explorer naar het drag 'n drop gebied in de portal en klik vervolgens op de **Upload** knop.
5. Het bestand wordt geupload en zou binnen enkele seconden in de container verschijnen.


## Opdracht 4 - Database inrichten

11. Ga terug naar je resourcegroup. In de lijst zie je 2 databases (sqldb-source en sqldb-target) en 1 server. De sqldb-source is al ingericht en voorzien van data (AdventureWorksLT).
11. Klik de **sqldb-target** database aan en vervolgens in de Blade op **Query editor (preview)**.
    * De loginnaam van het sqladmin-account zou al ingevuld staan, voer vervolgens het wachtwoord **WortellSmartLearning.nl** in.
11. Wanneer je ingelogd bent, zie je een query-interface voor je en de tabbellen, views en stored procedure mappen aan de linkerkant.
11. Ga terug naar de Github map van 0Prep en in de map **LabEnvironment**. Klik vervoglens op het .sql bestand genaamd **Target-Database.sql**. De code zou nu zichtbaar worden, selecteer alle code en plak deze in de Query editor en klik vervolgens op de knop **Run**.
11. Wanneer de query is uitgevoerd, is jouw database klaar voor gebruik!

## Inhoudsopgave

1. [De Azure omgeving prepareren](../0Prep/LabVoorbereiding0.md)
2. [Integration Runtimes](../Lab1/LabInstructions1.md)
3. [Linked Services](../Lab2/LabInstructions2.md)
4. [Datasets](../Lab3/LabInstructions3.md)
5. [Pipelines](../Lab4/LabInstructions4.md)
6. [Triggers](../Lab5/LabInstructions5.md)
8. [Activities](../Lab6/LabInstructions6.md)
9. [Batching en DIUs](../Lab7/LabInstructions7.md)
