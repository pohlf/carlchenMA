# Carlchen ist ne liebe Maus
# drum helf ich ihr beim coden aus

install.packages("psych")
install.packages("tidyverse")
library(psych)
library(tidyverse)

# lädt Daten über API von soscisurvey
link <- "https://www.soscisurvey.de/Reparaturverhalten/index.php?act=FEg7wVXYyihsDJwGNIpOlcNm&vQuality&useSettings&rScript"
eval(parse(link, encoding="UTF-8"))

names(ds)

# Beispiel für Themenblock 1: Reparaturerfahrung
# Nehmen wir an, dass die Spalten für Fragen 1-6 'AR01' bis 'AR06' sind
themenblock1 <- c("AR01", "AR02", "AR03", "AR04", "AR05", "AR06")


ds1 <- ds %>% 
  select(starts_with(themenblock1))

# Erstelle eine Kopie von ds1 und konvertiere Faktoren und logische Werte in numerische Werte
ds1_numeric <- ds1 %>%
  mutate(across(where(is.factor), ~ as.numeric(as.factor(.)) - 1)) %>%
  mutate(across(where(is.logical), ~ as.numeric(.))) %>%
  mutate(across(where(is.character), ~ as.numeric(.))) %>%
  mutate(across(where(is.vector), ~ as.numeric(.))) %>%
  drop_na()

tibble(ds1_numeric)

# Berechne Cronbach's Alpha
cronbach_alpha_block1 <- psych::alpha(ds1_numeric, check.keys=TRUE)
print(cronbach_alpha_block1)
ds1