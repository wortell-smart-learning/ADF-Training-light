# Lab 6 - Activities

*Vereisten*

Om het lab te kunnen starten is het van belang dat [Lab 4 - Pipelines](../Lab4/LabInstructions4.md) is afgerond.  
Het is niet noodzakelijk dat [Lab 5 - Triggers](../Lab5/LabInstructions5.md) is gedaan.

*Doel*

We hebben al enkele activities gebruikt zoals Copy, Execute Pipeline en Set variable. Er zijn er nog veel meer en sommige zijn heel handig als je deze met elkaar laten samenwerken om zodoende geavanceerde pipelines te creëeren. Volg de volgende opdrachten stap voor stap.

## Opdracht 1 - Stored Procedure uitvoeren

Stored Procedures zijn opgeslagen programma's op de database. Vaak worden acties op de database (zoals het leegmaken van een tabel, of het starten van een proces binnen de database) in een stored procedure "gevangen". Met ADF kun je deze nu orchestreren.

1. Klik bij Pipelines op **Pipeline Actions** en op **New Pipeline**.

2. Noem de pipeline: `PL_Process_Dates_Training`.

3. Uit de lijst met **Activities**, klik op de optie **General**. Klik en sleep **Stored Procedure** op het canvas.

4. Noem de **Stored Procedure** als volgt: **USP_DL_Dates**. Klik vervolgens op de tab **Settings**.

5. Kies bij **Linked service** voor de `LS_sqldb_target` en bij **Stored Procedure name** de **[Stg].[USP_DL_Dates]**.

6. Klik op **Stored procedure parameters** en vervoglens op **import**. De parameters van de stored procedure worden nu ingeladen.

7. Vul bij **StartYear** het volgende in: **1900**.

8. Vul bij **EndYear** het volgende in: **2099**.

9. Klik op de **Blauwe knop** met de tekst **Publish all** en vervolgens op de knop **Publish**.

10. Klik op **Debug** en wacht tot de pipeline klaar is.

## Opdracht 2 - Conditioneel filteren

Je kunt data uit de database ook gebruiken om je orchestratie mee uit te voeren, bijvoorbeeld:

* Een proces dat alleen mag starten als er een bepaalde rij in je instellingen-tabel aanwezig is
* Voor elke klant die er in de Customers-tabel aanwezig is een eigen pipeline starten

Allereerst halen we hier data op uit een SQL-database, en doen een filtering op die data binnen de ADF pipeline.

1. Klik bij Datasets op **Dataset Actions** en op **New Dataset**.

2. Zoek op **SQL** en kies **Azure SQL Database**. Klik vervolgens op **Continue**.

3. Noem de Dataset als volgt: `DS_asql_SalesLT_Customers_Training` en kies als linked service de `LS_sqldb_source`.

4. Kies bij **Table** voor **SalesLT.Customer** en klik op **OK**.

5. Klik bij Pipelines op **Pipeline Actions** en op **New Pipeline**.

6. Noem de pipeline: `PL_Filter_SalesPersonal_Training`.

7. Uit de lijst met **Activities**, klik op de optie **General**. Klik en sleep **Lookup** op het canvas.

8. Noem de lookup: **Lookup_SalesPersonal**.

9. Ga naar de tab **Settings** en kies bij **Source dataset** de `DS_asql_SalesLT_Customers_Training`.

10. Zet het vinkje uit bij **First row only**.

11. Klik bij **Use query** op de optie **query** en type of plak de onderstaande code en klik op **OK**. 

    SELECT
    COUNT(*) AS Registered_Customers,
    SalesPerson

    FROM [SalesLT].[Customer]

    GROUP BY SalesPerson

12. Uit de lijst met **Activities**, klik op de optie **Iteration & conditionals**. Klik en sleep **filter** op het canvas.

13. Sleep het **groene blokje** van de Lookup naar de filter activity. Zodat deze aan elkaar zijn verbonden.

14. Geef de **filter** de naam **Best seller**.

15. klik op de tab **Settings** en klik bij **Items** op het veld er naast en vervolgens op **Add dynamic content**.

16. Klik onder **Activity outputs** op **Lookup_SalesPersonal value array** en klik op **OK**.
    ![Verduidelijking van de gewenste Dynamische code](https://github.com/jstofferswortellsmart/ADF-Training-light-202406/assets/170087926/fa1e84e2-3f72-4798-88b7-cd944474409c)

17. Klik bij **Condition** op het veld er naast en vervolgens op **Add dynamic content**.

18. Ga naar **Functions**, en type of plak de volgende code: `@greaterOrEquals(item().Registered_Customers,100)` en klik op **OK**.
    ![Verduidelijking van welk deel van de code uit de tabbladen gehaald kan worden](https://github.com/jstofferswortellsmart/ADF-Training-light-202406/assets/170087926/243091bc-82d6-4f72-ac3f-ba60405423fa)

19. Klik op de **Blauwe knop** met de tekst **Publish all** en vervolgens op de knop **Publish**.

20. Klik op **Debug** en wacht tot de pipeline klaar is, bekijk de resultaten door op de **Output** van de **Best seller** stap te kijken.
    ![Zoek de pipeline op in de monitor](https://github.com/jstofferswortellsmart/ADF-Training-light-202406/assets/170087926/e84869ba-5ab8-40a6-ab96-320205f4e4c5)
    ![Raadpleeg de output van pipeline Best seller](https://github.com/jstofferswortellsmart/ADF-Training-light-202406/assets/170087926/8833004e-99a0-4629-9c95-c8d8e116cb6d)
    ![Verwacht eindresultaat](https://github.com/jstofferswortellsmart/ADF-Training-light-202406/assets/170087926/dfbae160-a309-4fab-bb49-b77e5772518e)

> ### Toelichting ###
> In de query die bij de *Lookup* is gebruikt had natuurlijk meteen een *HAVING* statement meegegeven kunnen worden, om hetzelfde resultaat te bereiken.
> Doordat we deze voorwaarde nu uit de query halen en in een **Filter** activiteit stoppen, creëer je de mogelijkheid om deze filter voorwaarde te parameteriseren in ADF.
> Het parameterisering van deze conditie hebben we in deze opdracht niet uitgevoerd in verband met de duur van de training. De benodigde kennis om dit zelf uit te voeren heb je wanneer je deze opdracht combineert met de ervaring uit Lab 4, opdracht 3.

## Opdracht 3 - Dynamische pipelines/ Datasets

Tot nu toe hebben we alle tabellen stuk voor stuk ingeladen, met eigen datasets en pipelines. Dat is echter (gelukkig) niet nodig in ADF: je kunt je pipelines en datasets *dynamisch* maken. Dat houdt in:

* Je voegt parameters toe aan je dataset (bijvoorbeeld voor de tabelnaam)
* Je laat het *schema* leeg. ADF doet nu een *schema infer*, wat betekent dat het schema op het moment van uitvoeren bepaald wordt.
* Bij het gebruiken van de dataset geef je de benodigde parameters mee.

Zo kun je bijvoorbeeld een lijst op te halen tabellen uitlezen uit een CSV-bestand of SQL-configuratietabel, waarna je ze met een ForEach-loop één voor één uitleest.

1. Klik bij Datasets op **Dataset Actions** en op **New Dataset**.

2. Zoek op **SQL** en kies **Azure SQL Database**. Klik vervolgens op **Continue**.

3. Noem de Dataset als volgt: `DS_asql_sqldb_SourceTables_Training` en kies als linked service de `LS_sqldb_source`.

4. Laat de **Table name** leeg en klik op **OK**.

> Kijk optioneel bij het tabblad **Schema** en constateer dat er nu geen mapping aanwezig is.
> Ook de optie **Import schema** levert nu een foutmelding op. Dit is logisch omdat we in de vorige stap geen tabel hebben geselecteerd.
> Zoals aangekondigd zullen deze stappen dynamisch worden vormgegeven.
 
5. Herhaal stap 1 t/m 4 voor de **sqldb-target** en noem de Dataset als volgt: `DS_asql_sqldb_TargetTables_training`.

6. Wanneer de Dataset voor de **sqldb-target** is aangemaakt, ga naar de tab **Parameters** en klik op **New**.

7. Geef de parameter de **name** `TargetTableName`, laat het **Type** op `String` en laat de **Default value** leeg.

8. Ga naar de tab **Connection** en vink **Enter manually** aan. Vul het eerste veld **schema name** met de tekst `Stg`. Klik vervolgens het tweede veld aan en kies vervolgens voor **Add dynamic content**.

9. Kies uit de lijst de parameter genaamd: **TargetTableName** en klik vervolgens op **OK**.
    ![Verduidelijking van stappen 8 en 9](https://github.com/jstofferswortellsmart/ADF-Training-light-202406/assets/170087926/94dcaef2-e189-4a3c-8edb-7fb0a79d603c)

10. Klik bij Pipelines op **Pipeline Actions** en op **New Pipeline**.

11. Noem de Pipeline als volgt: `PL_copy_deltaload_Training`.

12. Uit de lijst met **Activities**, klik op de optie **General**. Klik en sleep **Lookup** op het canvas.

13. Geef de **lookup** de naam `Lookup_SourceTables`, klik vervolgens op de **Settings** tab en kies bij **Source dataset** de `DS_aqsl_sqldb_SourceTables_training`.

14. Klik bij **Use query** de optie **Query** aan. Klik vervolgens in het query veld en plak of type de volgende query:

    ```sql
    /* Met de volgende query halen we uit het information schema alle tabellen uit het schema "SalesLT" */
    SELECT 
    TABLE_SCHEMA AS Table_Schema,
    TABLE_NAME AS Table_Name
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = 'SalesLT' AND TABLE_TYPE = 'BASE TABLE'
    ```

15. Indien **First row only** staat aangevinkt, zet deze uit.

16. Uit de lijst met **Activities**, klik op de optie **Iteration & Conditionals**. Klik en sleep **ForEach** op het canvas.

17. Sleep het **Groene blokje** van **Lookup_SourceTables** naar de **ForEach** zodat deze opeenvolgend aan elkaar zijn verbonden.

18. Geef de **ForEach** de naam `ForEachTable` en klik op de tab **Settings**.

19. Klik op het vlak naast **Items** en vervolgens op **Add dynamic content**. Kies voor `Lookup_SourceTables value array`.

20. klik op de **plus** in de **ForEachTable**. Kies nu de activity **Copy Data**.
    ![Verduidelijking stappen 16 t/m 20](https://github.com/jstofferswortellsmart/ADF-Training-light-202406/assets/170087926/b0a9fb35-92ff-47ab-9c67-e456965a288c)

21. Geef de **Copy data** de naam `Copy Tables` en klik vervolgens op de tab **Source** en kies voor de **Source dataset** de `DS_aqsl_sqldb_SourceTables_training`.

22. Klik bij **Use query** de optie **Query** aan. Klik vervolgens in het query veld en vervolgens op **Add dynamic content** en type of plak de onderstaande query en druk vervolgens op **OK**:

    ```sql
    /* Deze query haalt het schema en de tabel op uit de query die in de Lookup_SourceTables is gebruikt.  
    Omdat deze query in een Copy activity zit binnen een ForEach activity, is het resultaat één regel.  
    Op deze manier is de input voor welke tabel geëxtraheerd gaat worden, dynamisch vastgesteld. */
    SELECT *
    FROM @{item().Table_Schema}.@{item().Table_Name}
    ```

    ![Verduidelijking stappen 20 t/m 22](https://github.com/jstofferswortellsmart/ADF-Training-light-202406/assets/170087926/67b3eece-8f7a-4543-8c98-569f0ff8ba0c)

23. Klik op de tab **Sink** en kies vervolgens de `DS_aqsl_sqldb_TargetTables_training` linked service, klik daarna op het veld naast **TargetTableName** gevolgd door **Add dynamic content** en type of plak de onderstaande query en druk vervolgens op **OK**: 

    ```sql
    @item().Table_Name
    ```

24. Klik op het veld naast **Pre-copy script** en vervolgens op **Add dynamic content** en plak of type: 

    ```sql
    TRUNCATE TABLE Stg.@{item().Table_Name}
    ```

    ![Verduidelijking stappen 23 t/m 24](https://github.com/jstofferswortellsmart/ADF-Training-light-202406/assets/170087926/cd2ba9e4-8f62-4636-bffd-d1d763bfdc4d)


25. Klik op de **Blauwe knop** met de tekst **Publish all** en vervolgens op de knop **Publish**.

26. Klik op **Debug** en wacht tot de pipeline klaar is.

## Einde Lab 6

## Inhoudsopgave

0. [De Azure omgeving prepareren](../0Prep/LabVoorbereiding0.md)
1. [Integration Runtimes](../Lab1/LabInstructions1.md)
2. [Linked Services](../Lab2/LabInstructions2.md)
3. [Datasets](../Lab3/LabInstructions3.md)
4. [Pipelines](../Lab4/LabInstructions4.md)
5. [Triggers](../Lab5/LabInstructions5.md)
6. [Activities](../Lab6/LabInstructions6.md)
7. [Batching en DIUs](../Lab7/LabInstructions7.md)
8. [Eerste Data Flows](../Lab8/LabInstructions8.md)
9. [Data integratie flows](../Lab9/LabInstructions9.md)
