# Собираем сет данных в опрятном формате
library(dplyr)

load("./data/med_income.rda")
load("./data/income2.rda")

# Собираем средние зп для med_income сета
# Сначала упорядочим строки в соответствии с med_income
income2 <- income2[match(med_income$region, income2$region),]

# Делаем новую переменную mean_income в сете med_income
med_income$mean_income <- income2$mean_income
