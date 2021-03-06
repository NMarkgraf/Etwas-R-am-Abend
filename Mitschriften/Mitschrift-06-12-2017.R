#
# Das hier ist eine Kommentarzeile
#
# Wir belegen Variabeln a und A mit Werten
a <- c("FOM", "und", "R", "sind", "SUPER")
A <- 42
#
mode(a)
#
str(a)
#
typeof(a)
#
# Alle Objekte in R k�nnen mit dem *r*e*m*ove Befehl
# auch wieder gel�scht werden:
#
rm(a)
#
# Wir erstellen einen Vektor mit Zeichenketten:
people <- c("Klaus", "Max", "Jens", "Dieter")
# 
# Nun testen wir jedes Element der Liste, ob es mit "Max"
# �bereinstimmt. Wir erhalten einen Vektor mit 
# Wahrheitswerten (TRUE und FALSE):
people == "Max"
#
#
# Nehmen wir vier Gewichte (von Personen):
weight <- c(67, 80, 72, 90)
weight
# Objekte k�nnen einen Namen tragen:
names(weight)
# Noch haben Sie keinen, aber wir k�nnen das �ndern:
names(weight) <- people
# Nun haben die Gewichte Namen:
weight
# Das k�nnen wir nutzen, z.B. in einem barplot:
barplot(weight)
#
#
# Wir bauen uns einen Datenrahmen (data.frame):
Name <- c("Anna", "Beria", "Carlo", "Edda")
Geschlecht <- c("weiblich", "weiblich", "m�nnlich", "weiblich")
Groesse <- c(1.60, 1.68, 1.81, 1.71)
Gewicht <- c(52, 60, 80, 70)
#
df <- data.frame(
  Name = Name,
  Geschlecht = Geschlecht,
  Groesse = Groesse,
  Gewicht = Gewicht
)
#
# Wir schauen uns nun diesen Datenrahmen an.
# Dazu laden wir erst einmal Mosaic:
library(mosaic)
inspect(df)
#
#
# Schauen wir uns die mittlere Gr��e an:
mean(df$Groesse)
#
# Oder gleich alle wichtigen Kennzahlen des Gewichts:
favstats(df$Gewicht)
#
#
#
miete03 <- read.table(file="https://tinyurl.com/yblxykf3", header=T)
inspect(miete03)
tally( ~ rooms, data=miete03)
tally( ~ rooms, data=miete03, format="proportion")
options(digits=1)
tally( ~ rooms, data=miete03, format="proportion")
options(digits=6)
bargraph( ~ rooms, data=miete03)
bargraph( ~ rooms, data=miete03, format="proportion")
