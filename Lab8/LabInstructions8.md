# Lab 8 - Copy to CSV in Storage Account

*Vereisten*

Om het lab te kunnen starten is het van belang dat [Lab 3 - Datasets](../Lab3/LabInstructions3.md) is afgerond.  
Het is belangrijk kennis te hebben genomen van [Lab 6 -Activities](../Lab6/LabInstructions6.md).

*Doel*

We gaan een dynamische pipeline maken die data extraheert uit een SQL Database en in CSV format opslaat binnen een storage account.

## Opdracht 0 - Azure Data lake Storage aanmaken
Nu we toekomen aan de specifieke casus, hebben we daarvoor ook een specifieke resource nodig: "Azure Data lake storage"  
Met behulp van de volgende stappen, gaan jullie deze zelf aanmaken.

1. Ga naar Portal.azure.com
2. Kies voor Create a resource
3. Zoek naar Storage account
4. Kies voor Storage account
5. Kies voor Plan **Storage account** en klik op Create  

6. Kies de default subscription
7. Kies de default Resource group
8. Storage account name "dlsr4g"
9. Region "(Europe) North Europe"
10. Kies de default Performance
11. Kies de default Redundancy

12. Vink **Enable hierarchical namespace** aan op tabblad ***Advanced***
13. Klik onderaan op Review + Create
14. Klik op **Create**

## Opdracht 1 - Linked Service aanmaken naar Azure Data Lake Storage (dlsr4g)
Nu we een nieuwe resource hebben, moeten we hiervoor ook een Linked Service aanmaken.
Een paar aandachtspunten om niet te vergeten:

* Suggestie voor naam: **LS_dlsr4g_training**
* Vergeet je Integration Runtime niet aan te passen
* De resource is te vinden in de Azure Subscription
* Test je connection voor de volledigheid

## Opdracht 2 - Dataset aanmaken
Nu je de locatie van de resource hebt aangegeven. Zal je Azure Data Factory moeten uitleggen:
* Op welke locatie de bestanden worden weggeschreven, en;
* Welke kenmerken aan de bestanden wordt meegegeven.

**File Path**
* De locatie moet dynamische worden, hiervoor kan je Lab6 Opdracht 3 raadplegen ter inspiratie.
* Container: ct-ops-<Afdeling>
* Directory: data/<database>/<schema>/<object>
* File name: <object>__yyyyMMdd_HHmmss


 
> ### Extra informatie - @concat() ###  
> In de Container, Directory en File Name ga je één of meerdere parameters combineren met 'harde tekst'.
> Hiervoor kan je de Functie @Concat() gebruiken, een voorbeeld:
>   
> @concat(  
>   'harde-tekst',  
>   dataset().parameternaam  
> )

> ### Extra informatie - yyyyMMdd_HHmmss ###  
> Gebruik de volgende code om de datum en tijd in je bestandsnaam te krijgen:  
> formatDateTime(utcnow(), 'yyyyMMdd_HHmmss')


**Overige kenmerken**
De overige kenmerken zijn gegeven in de Power Point Presentatie

## Opdracht 3 - Pipeline aanmaken

* Voorbeeld "Export sqldb-source objects to Landing Zone


## Opdracht 4 - Resultaat bekijken in ADL

* Stel vast dat directories door ADF zijn aangemaakt in Azure Data Lake (ADL)
* Stel vast welke bestandsnaam de bronnen hebben gekregen


## Opdracht 5 - Input verder parameteriseren

Brainstorm van mogelijke praktijkoplossingen?
* Input parameters in een table in plaats van alle information schema objecten?
* Niet volledige tabellen overzetten, maar incrementeel?
* Kolommen uitsluiten indien niet van toepassing?







## Einde Lab 8

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
