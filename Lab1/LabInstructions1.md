# Lab 1 - Integration Runtimes

*Vereisten*

Om het lab te kunnen starten is het van belang dat 0Prep is afgerond.

*Doel*

De Azure Data Factory maakt gebruik van een *Integration Runtime (IR)*. In feite is dit de plek waar je pipeline "uitgevoerd" wordt: bijvoorbeeld in een specifieke Azure-region of on-premises.

> ### Achtergrond informatie: Verschillende soorten Integration Runtime ###
> Er zijn drie typen Integration Runtime binnen Azure Data Factory
> 1. Azure Integration Runtime
> 2. Self-hosted Integration Runtime
> 3. Azure-SSIS Integration Runtime
>
> In de training wordt *Azure Integration Runtime* gebruikt.  
> Een afweging om liever voor *Self-hosted Integration Runtime* te kiezen is bijvoorbeeld de voorspelbaarheid in kosten:  
> Bij *Azure Integration Runtime* betaal je namelijk per gebruik, terwijl je bij *Self-hosted Integration Runtime* vaste kosten hebt.

## Opdracht 1 - Azure Integration Runtime aanmaken

> ### Achtergrond informatie: "Auto Resolve Integration Runtime" ###
> Binnen ADF krijg je altijd een Azure Integration Runtime "cadeau": een zogenaamde "Auto Resolve" IR. Dat betekent dat Azure wereldwijd met je meekijkt welke plek handig zou zijn om jouw pipeline uit te gaan voeren en er eentje voor je uitkiest. Dat kan handig zijn om de eerste stappen te maken, maar het is aan te raden om explicieter te zijn waar je data verwerkt wordt. Deels vanuit performance- en kostenoverwegingen, maar ook vanuit security- en compliance-perspectief (weten waar je data verwerkt wordt).

In deze eerste opdracht gaan we daarom een Azure Integration Runtime aanmaken waarin je zelf de locatie aangeeft.

1. Ga naar de [Azure portal](portal.azure.com). Klik de Data Factory aan. Een nieuwe pagina zal laden met een knop **Launch Studio** klik deze aan. Je wordt nu naar de pagina van de ADF geleid.
2. Klik links op de **gereedschapskist** (Manage). Klik vervolgens aan de linkerkant op **Integration runtimes**. Je zult zien dat er al een **AutoResolveIntegrationRuntime** bestaat. Dit is de standaard IR binnen Azure waarmee je tussen de verschillende diensten als SQL Database, Azure Data Lake Store e.d. data mee kan verplaatsen.
3. Klik op **New**, klik op **Azure, Self-Hosted** en op **continue** en vervolgens op **Azure** en weer **continue**. Je kunt nu een nieuwe **Azure Integration Runtime** aanmaken, waarbij je ook specifiek de **Region** kunnen aangeven. Hiermee weet je zeker dat de data altijd binnen deze regio blijft.
4. Geef de IR een naam en kies de **Region** waarbinnen de rest van je resources zich bevinden.

> Qua naamgeving is het handig om te beginnen met `IR-` gevolgd door wat voor een soort IR het is, de -regio en de -omgeving.
> * Praktijkvoorbeeld: `IR-AzureResolve-NorthEurope-TST`
> * Trainingsvoorbeeld: `IR-AzureResolve-NorthEurope-Training`

6. Klik op **Create**

Je IR wordt nu aangemaakt en zou binnen enkele seconden klaar moeten zijn.

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
