# Lab 5 - Triggers

*Vereisten*

Om het lab te kunnen starten is het van belang dat [Lab 4 - Pipelines](../Lab4/LabInstructions4.md) is afgerond.

*Doel*

 We hebben nu pipelines gemaakt en handmatig aangezet. Dit is natuurlijk erg omslachtig, zeker als je incrementeel of nachtverwerkingen wilt realiseren. Dit kunnen wij automatiseren door het gebruik van triggers. Volg de opdrachten stap voor stap.

## Opdracht 1 - Triggers

1. Klik links op de **gereedschapskist** (Manage). Klik vervolgens aan de linkerkant op **Triggers**. 

2. Klik op **New**, een nieuw scherm zal naar voren komen om trigger aan te kunnen maken. 

3. Geef de trigger een duidelijke naam. Het aangeraden format begint met TR_, naam van de pipeline die getriggerd wordt.

4. Kies bij **Type** de optie **Schedule**. Zet de **Start date** op vandaag en 10 minuten later dan het nu is.

> ### Achtergrond informatie: Verschillende type triggers ###
> Er zijn meer verschillende type opties:
> * Schedule:  
>   Een **Schedule trigger** kan 1 of meerdere pipelines uitvoeren op het opgegeven schema. Je hebt zelf de controle en flexibiliteit wanneer een trigger af moet gaan en stelt je in staat om dus een start en einddatum in te stellen.
>   
> * Tumbeling window:  
>   Een **Tumbeling window trigger** kan 1 pipeline uitvoeren voor elk gedefineerd tijdsframe. Je gebruikt deze voor tijdgebaseerde data, zodat je hier iets mee kan doen.
>   
> * Event Trigger:  
>   Een **Event trigger** kan 1 of meerdere pipelines uitvoeren gebaseerd op een gebeurtenis in een blobstorage. Zoals bij het aanmaken of verwijderen van een bestand.
>   
> * Custom Trigger:  
>   Een **Custom trigger** kan 1 of meerdere pipeles uitvoeren gebaseerd op een event uit de **Event Grid** dienst.

5. Vul bij **Time zone** het volgende in: **Amsterdam** en kies de optie **Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna (UTC+1)**.

6. Zet de **Recurrence** op 1 minuten.

7. Vink **Specify an end date** aan en zet deze op 5 minuten later dan de gekozen **Start date** en klik vervolgens op **OK**.

8. Klik links op het **Potloodje** (Author) en klik vervolgens de `PL_copy_master` pipeline aan.

9. Klik op **Add trigger** en vervolgens **New/Edit**.

10. Klik bij **Choose Triggers** de trigger die je zojuist hebt gemaakt. Het scherm van de trigger zal verschijnen. Mocht het al later zijn dan de tijd die je had ingesteld pas deze nu aan inclusief de eindtijd.

> Toelichting:
> In de vorige stappen heb je via **gereedschapskist** (Manage) een trigger aangemaakt.
> Je kan ook eerst naar de betreffende pipeline gaan waarvoor je een trigger wilt creëren en vanaf daar onder de stap **Choose Triggers** op **+New** klikken.
> In dat geval voer je stappen 3 t/m 7 uit nadat je stappen 8 t/m 10 hebt gedaan.

11. Zet de **Status** op **Started** en klik op **OK** en vervolgens nog één keer op **OK**.

12. Klik op de **Blauwe knop** met de tekst **Publish all** en vervolgens op de knop **Publish**.

13. Klik aan de linkerkant op **Monitor** en ga naar **pipeline runs**. Klik rond de starttijd op **Refresh**, je zult zien dat je pipeline automatisch is afgetrapt.

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
