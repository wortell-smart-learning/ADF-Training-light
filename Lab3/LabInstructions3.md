# Lab 3 - Datasets 

*Vereisten*

Om het lab te kunnen starten is het van belang dat [Lab2 - Linked Services](../Lab2/LabInstructions2.md) is afgerond.

*Doel*

Nu de Linked Services aangemaakt zijn, kan ADF bij de vooraf gedefiniëerde databronnen zoals een SQL Database of een Blob Storage Account. De volgende stap is het specificeren welke data je wilt gebruiken. Denk aan een tabel in een database of een .csv bestand op een storage account. Hiervoor ga je een **Dataset** aanmaken. Dit gaan we in onderstaande opdrachten doen.

## Opdracht 1 - Source Database

De eerste *dataset* die we aankoppelen is een tabel die binnen onze brondatabase leeft.

1. Klik links op het **Potloodje** (Author). Aan de linkerkant zie je een lijst met categorien zoals: Pipelines, Datasets, Data flows en Power Query.  
   Vandaag leggen we de focus op **Pipelines** en **Datasets**.
2. Naast **Datasets** zie je op dit moment een 0 staan, wanneer je met jouw muis op het vak van **Datasets** gaat staan zie je een optie met **3 bolletjes** (Datasets Actions) verschijnen aan de rechterkant. Klik de **Dataset Actions** aan en klik vervolgens op **New Dataset**. Nota bene: De optie **New Dataset** is ook beschikbaar wanneer je de rechtermuisknop op datasets gebruikt.
3. Een vergelijkbaar scherm als bij de **Linked Services** zal verschijnen. Zoek naar **SQL**. Dubbelklik de **Azure SQL Databases** aan.
4. Geef de Dataset een duidelijke naam. Het aangeraden format is om te beginnen met `DS_`, het type dataset, eventueel het *schema* waarbinnen de tabel zich bevindt, de tabelnaam en eindigend met _omgeving.
   * Praktijkvoorbeeld: `DS_sql_dwh_dimdatum_acc`
   * Trainingsvoorbeeld: `DS_asql_SalesLT_Address_training`
5. Bij **Linked Services** kies je de Linked Service die verwijst naar de brondatabase (`LS_sqldb_source`).
6. De IR wordt automatisch toegepast vanuit de Linked Service. De optie om een **Table name** te selecteren zal nu ook verschenen zijn, klik hierop en kies voor **SalesLT.Address**. Voltooi het aanmaken door onderaan de pagina op **OK** te klikken.
7. Wanneer de **Dataset** is aangemaakt kom je in het overzichtscherm van de dataset. Klik op het brilletje (**Preview Data**) om een voorbeeld van de data te zien.
8. Klik op de tab **Schema**. Met de knop **Import schema** download je de kolommen uit de geselecteerde tabel en de bijhorende datatypes, in dit geval is dit automatisch gedaan bij het aanmaken van de dataset. Voor deze opdracht importeren we het schema, vanaf [Lab 6 - Activities](../Lab6/LabInstructions6.md) gaan we dit dynamisch doen.

> ### Achtergrond informatie: Voor- of nadelen van het importeren van het schema ###
> **Voordelen**
> * Door de kolommen met datatypes te importeren, kan ADF beter overweg met data. Zo kan je gemakkelijker werken met datums, kunnen cijfers eenvoudiger worden opgeteld en wordt na één of meerdere transformaties het uiteindelijke datatype afgedwongen.
> * Doordat ADF weet welke datatypes de kolommen bevat, kan ADF foutmeldingen afgeven wanneer je bijvoorbeeld string-data in een integer kolom probeert te laden.
> * Het kan de performance van een query verbeteren. De hoeft niet alleen doorlooptijd te besparen, maar kan met een Azure Integration Runtime ook de kosten drukken.
>
> **Nadelen**
> * Wanneer één dataset gebruikt wordt om meerdere tabellen uit een bronapplicatie te halen, is het niet mogelijk om het schema te importeren bij het aanmaken van de dataset.
> * Wanneer het schema in de bronapplicatie regelmatig wijzigt, wil je niet parallel je dataset moeten aanpassen.
   
10. Doe Opdracht 1 nogmaals, maar nu voor de **sqldb-target** Database voor de tabbellen **Address**, **ProductCategoryDiscount** en **SalesPersonal**.

> Suggesties voor tenaamstellingen:
> * DS_targetsql_stg_Address_training
> * DS_targetsql_stg_ProductCategoryDiscount_training
> * DS_targetsql_stg_SalesPersonal_training

## Opdracht 2 - Storage Account / File system

1. Klik de **Dataset Actions** aan en klik vervolgens op **New Dataset**.
2. Zoek naar **storage**. Klik de **Azure Blob Storage** aan.
3. Kies voor vervolgens voor **DelimitedText** (csv), als format type.
   > ### Achtergrond informatie: Welk bestandsformaat ###
   > Je ziet hier een aantal veelvoorkomende bestandsformaten:
   >
   > * Excel
   > * Json
   > * XML
   > * DelimitedText (csv)
   >
   > Voor Cloud Dataplatforms wordt daarnaast het **Parquet**-formaat veel gebruikt. Parquet is zeer compact in de opslag, geoptimaliseerd voor analyses (Column-based i.p.v. Row-based) en bevat datatypes (in tegenstelling tot CSV-bestanden, waar komma's, punten, lijstscheidingstekens, string delimiters en datumnotaties nogal eens tot verwarring leiden - om maar niet te spreken over encoding).
   >
   > Voor nu gebruiken we hier even CSV - groot voordeel daarvan voor nu is dat het door mensen leesbaar is, zodat je kunt inzien wat er gebeurt.
4. Geef de Dataset een duidelijke naam.

> Suggesties voor tenaamstellingen:
> * DS_blob_data_ProductCategoryDiscount_training
> * DS_blob_data_SalesPersonal_training

5. Bij **Linked Services** kies het **storage account**. (In de vorige lab werd **LS_blob_training** als naam gesuggereerd.)
6. De optie om een pad op te geven zal verschijnen. Klik op het witte mapje (**Browse**). Kies vervolgens de map **data** en het bestand genaamd **ProductCategoryDiscount.csv**.
7. Klik op **OK** en vervolgens nog een keer op **OK** om de Dataset te voltooien.
8. Klik op **Preview data**, je zult zien dat de data er nog niet erg gaaf uitziet. Om dit aan te passen dienen we nog 1 of 2 aanpassingen te verrichten.
9. Kies bij **Column delimiter** voor de opties **Semicolon (;)**. en vink aan **First row as header** als deze nog niet aan staat. Wanneer je nu weer op **Preview data** klikt zou het in een tabel moeten zijn met kolommen.
10. Doe Opdracht 2 nogmaals, kies nu het .csv bestand **SalesPersonal.csv**.

> ### Achtergrond informatie: Repeterend werk efficiënter uitvoeren. ###
> We hebben alle datasets nu handmatig aangemaakt door via de User Interface de benodigde velden in te vullen.
> Het gebruik van de User Interface is handig om de verschillende opties te leren kennen.
> Naarmate je meer bekend bent met ADF en/of wanneer je vertrouwen toeneemt, wil je deze handmatige repeterende werkzaamheden efficiënter doen.
> ADF biedt hiervoor twee mogelijkheden: Dupliceren of coderen.  
>
> Wanneer je opdracht 2 opnieuw zou doen voor de **SalesPersonal.csv**, kan je er ook voor kiezen om de eerder gemaakte **ProductCategoryDiscount.csv** te dupliceren.  
> Dit doe je door met de rechtermuisknop op de DS voor ProductCategoryDiscount te klikken en voor de optie **Clone** te kiezen.  
> Een exacte kopie wordt gemaakt met een suffix in de tenaamstelling.  
> Vanaf hier kan je de wijzigen doen die de nieuwe dataset uniek maken, en handhaven wat gelijk is aan het gedupliceerde voorbeeld.
>
> Naast het dupliceren kan je ook gebruik maken van de JSON code die achter de User Interface is opgebouwd.
> Deze code vind je achter de knop **{}** ("View the JSON code representation of this resource") rechtsbovenin de dataset.
> Als een kladblok bestand kan je deze code bewerken, kopiëren of een kopie van elders hierin plakken.

11. Klik op de **Blauwe knop** met de tekst **Publish all** en vervolgens op de knop **Publish**. 

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
