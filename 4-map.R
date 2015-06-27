library(dplyr)
library(ggplot2)
load("./data/russia_map.rda")
load("./data/data_medinc.rda")

# странные регионы
loosers <- data_medinc %>%
  filter(income == "less_20000") %>%
  select(-income) %>%
  arrange(mean_income) %>%
  mutate(lvl = round((freq / total_n)*100, digits=1),
         mean_to_mean = mean_income > 31566) %>%
  filter(mean_to_mean == "FALSE") %>%
  mutate(weird = lvl > 75 & mean_income > 20000) %>%
  filter(weird == "TRUE") %>%
  select(region, mean_income, lvl)

# хорошие регионы
winners <- data_medinc %>%
  filter(income == "less_20000") %>%
  select(-income) %>%
  arrange(mean_income) %>%
  mutate(lvl = round((freq / total_n)*100, digits=1),
         mean_to_mean = mean_income > 31566) %>%
  filter(mean_to_mean == "FALSE") %>%
  mutate(weird = lvl < 50 & mean_income > 20000) %>%
  filter(weird == "TRUE") %>%
  select(region, mean_income, lvl)

test <- subset(russia_map, NL_NAME_1 %in% winners$region)
test2 <- subset(russia_map, NL_NAME_1 %in% loosers$region)

theme_opts <- list(theme(panel.grid.minor = element_blank(),
                         panel.grid.major = element_blank(),
                         panel.background = element_blank(),
                         panel.border = element_blank(),
                         axis.line = element_blank(),
                         axis.text.x = element_blank(),
                         axis.text.y = element_blank(),
                         axis.ticks = element_blank(),
                         axis.title.x = element_blank(),
                         axis.title.y = element_blank(),
                         plot.title = element_text(size=22)))

russia <- ggplot(russia_map, aes(x = long, y = lat, group = group)) + 
  geom_polygon(color="grey", opacity=0.5, fill="white") +
  coord_equal() + theme_opts
russia

win_loose <- russia + geom_polygon(data=test, aes(x = long, y = lat, group = group),
                                   fill="green", color="grey") +
  geom_polygon(data=test2, aes(x = long, y = lat, group = group),
               fill="red", color="grey")
win_loose
ggsave("./img/map1.png")
