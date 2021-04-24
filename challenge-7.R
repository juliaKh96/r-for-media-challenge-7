# # B. Kießling
# Challenge 7: plotly und leaflet
# Zur Überprüfung dienen erneut die beiden Outputs (plot und map)

# plotly Verhältnis Arbeitlosigkeit und Migration -----------------------------

#[x] 1. Lade den Datensatz stadtteil_profil_updated.rds in das Objekt stadtteile
#[x] 2. Erstelle ein Scatter-Plot mit arbeitslosenanteil_in_percent_dez_2019 auf der y-Achse
#       und anteil_der_bevolkerung_mit_migrations_hintergrund_in_percent auf der x-Achse
#[x] 3. Löse das Problem beim Column arbeitslosenanteil_in_percent_dez_2019, sodass sich dieser richtig visualisieren lässt
#     Tipp: Die Funktion as.numeric() wird dir dabei weiterhelfen
#[x] 4. Runde die beiden zu visualierenden Columns auf eine Nachkommastelle
#[x] 5. Beschrifte die x-Achse und y-Achse und erstelle einen Titel für den Plot
#[x] 6. Nutze die Argumente text und hoverinfo und stelle die Hoverinfo wie im Beispieldiagramm dar
#     Tipp: Für die Gestaltung der Hoverinformationen findest du alle Informationen hier: https://plotly.com/r/text-and-annotations/ im Abschnitt Custom Hover Text
#[x] 7. Speichere den Plot mit htmlwidgets::saveWidget(as_widget(plotobject), "myfirstplot.html")
#[x] 8. Interpretiere die Daten

# leaflet: Arbeitslosigkeit pro Stadtteil ----------------------------------

#[x] 1. Lade den Datensatz stadtteile_wsg84.RDS in das Objekt stadtteile_gps
#[x] 2. Benenne die Columns im Objekt stadtteile_gps von Stadtteil und Bezirk und stadtteil und bezirk um
#[x] 3. Joine beide Datensätze in das Objekt stadtteile und nutze die Funktion %>% st_as_sf() am Ende der Pipe, um das Objekt als sf zu konvertieren
#[x] 4. Erstelle ein leaflet Objekt und wähle ein Design über addProviderTiles(), 
#[x] 5. Setze setView() auf (9.993682, 53.551086 = und wähle eine Zoom-Stufe
# 6. Ergänze die Code-Fragmente
# 7. Speichere die Map mit htmlwidgets::saveWidget(as_widget(mapobject), "myfirstmap.html")

# Wir werden die Map in der nächsten Einheit weiter gestalten!

# load packages
library(plotly)
library(leaflet)
library(tidyverse)
library(sf)

# load data for plot
glimpse(stadtteile)

stadtteile <- readRDS("data/stadtteile_profil_updated.rds")
objekt<-plot_ly(data=stadtteile, x=~round(anteil_der_bevolkerung_mit_migrations_hintergrund_in_percent, digits=1), 
        y=~round(arbeitslosenanteil_in_percent_dez_2019, digits=1), 
        type="scatter", mode="markers", hoverinfo="text", 
        text=~paste('</br>Migrationsanteil:',round(anteil_der_bevolkerung_mit_migrations_hintergrund_in_percent, digits=1),
                    '</br>Arbeitslosenanteil:', round(arbeitslosenanteil_in_percent_dez_2019, digits=1),
                    '</br>Stadtteil:', stadtteil)) %>% 
  layout(title="Verhältnis zwischen Menschen mit Migrationshintergrund und Arbeitslosen", 
         xaxis=list(title="Migranten in %"), yaxis=list(title="Arbeitslosen in %"))

stadtteile$arbeitslosenanteil_in_percent_dez_2019<-as.numeric(stadtteile$arbeitslosenanteil_in_percent_dez_2019)

htmlwidgets::saveWidget(as_widget(objekt), "meinersterplot.html")

#Interpretation: Der Migrantenanteil ist fast in jedem Stadtteil deutlich größer, 
#als der Arbeitslosenanteil. Das heißt, dass die Migranten arbeiten gehen und nichts zur Arbeitslosenlage beitragen. 


##LEAFLET Arbeitslosigkeit pro Stadtteil  

# load data for map

stadtteile_gps <- readRDS("data/stadtteile_wsg84.rds") 
stadtteile_gps<-stadtteile_gps %>% 
  rename(stadtteil = Stadtteil, bezirk=Bezirk)

# join data
stadtteile <- stadtteile %>% 
  left_join(stadtteile_gps) %>% 
  st_as_sf()

leaflet() %>% 
  addProviderTiles(providers$Esri.WorldTopoMap) %>% 
  setView(lng =9.993682, lat= 53.551086, zoom=11) %>% 
  addMarkers(lng= 10.0044158, lat=53.5529259)

# leaflet 
bins <- c(0, 2, 4, 6, 8, 10, Inf)
pal <- colorBin("YlOrRd", domain = stadtteile$arbeitslosenanteil_in_percent_dez_2019, bins = bins)

leaflet() %>% 
  addProviderTiles() %>% 
  setView() %>% 
  addPolygons(data = ,
              fillColor = ~pal(arbeitslosenanteil_in_percent_dez_2019),
              weight = ,
              opacity = ,
              color = ,
              fillOpacity = )



