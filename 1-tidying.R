# Собираем сет данных в опрятном формате
library(tidyr)

load("./data/med_income.rda")
load("./data/income2.rda")

# Собираем средние зп для med_income сета
# Сначала упорядочим строки в соответствии с med_income
income2 <- income2[match(med_income$region, income2$region),]

# Делаем новую переменную mean_income в сете med_income
med_income$mean_income <- income2$mean_income

med_income <- tbl_df(med_income)

data_medinc <- med_income %>%
  gather(income, freq, -region, -mean_income, -total_n)

data_medinc$region <- factor(data_medinc$region)
data_medinc$total_n <- as.numeric(data_medinc$total_n)
data_medinc$mean_income <- as.numeric(data_medinc$mean_income)
data_medinc$freq <- as.numeric(data_medinc$freq)

save(data_medinc, file="./data/data_medinc.rda")
