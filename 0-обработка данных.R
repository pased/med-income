# Обработка данных

# Сначала собираем данные их экселя
# Данные опроса
library(readxl)

med_income <- read_excel("./data/raw/Электронное приложение к отчету по зарабатной плате апрель-май 2005_v3.xlsx",
                         sheet = 3)
med_income <- med_income[1:47,1:12]
names(med_income) <- med_income[1,]
med_income <- med_income[-1,]

# Кириллица в названии переменных только мешает, сохраним ее в отдельный вектор
factor_levels <- names(med_income)
save(factor_levels, file="./data/factor_levels.rda")

# Переименуем переменные в латинице
names(med_income) <- c("region",
                       "less_10000",
                       "10000_14999",
                       "15000_19999",
                       "less_20000",     
                       "20000_24999",
                       "25000_29999",
                       "30000_34999",
                       "35000_39999",
                       "40000_49999",
                       "50000_more",
                       "total_n")

# Теперь среднюю зп в 2015 из экселей росстата
income <- read_excel("./data/raw/tab08.xlsx")
income <- income[8:104,1:2]
names(income) <- c("region", "mean_income")
income <- na.omit(income)
save(income, file="./data/region_mean_income2015.rda")

# Приводим в соответствие с росстатом названия регионов
med_income$region[1] <- "Республика Северная Осетия - Алания"
med_income$region[11] <- "Чувашская Республика - Чувашия"
med_income$region[30] <- "Республика Татарстан (Татарстан)"
med_income$region[40] <- "г.Санкт-Петербург "
med_income$region[42] <- "г.Москва"
med_income$region[45] <- "Ханты-Мансийский авт. округ-Югра"
save(med_income, file="./data/med_income.rda")  #результат в файл

# Собираем средние зп в регионах попавших в опрос
income2 <- subset(income, region %in% med_income$region)
save(income2, file="./data/income2.rda")  #результат в файл
