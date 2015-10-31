library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)

get_year_data <- function(year) {
  year_data <- read.csv(sprintf('yob%s.txt', year), header = FALSE)
  names(year_data) <- c('name', 'sex', 'count')
  year_data %>% mutate(year = year)
}

years <- 1880:2014
all_data <- bind_rows(lapply(years, get_year_data))


biases <- all_data %>%
  spread(sex, count, fill = 0) %>%
  rename_(female = 'F', male = 'M') %>%
  mutate(total = female + male,
         femaleness = female / total,
         bias = abs(femaleness - 0.5))

write.csv(biases, 'biases.csv', row.names = FALSE)

name_data <- read_csv('biases.csv')

ggplot(name_data,
       #filter(name_data, total > 100),
       aes(x = year, y = femaleness)) +
  geom_jitter(size = 0.7) +
  scale_x_continuous(name = "", limits = c(1880, 2020),
                     breaks = seq(1880, 2000, by = 20)) +
  scale_y_continuous(name = "", limits = c(0, 1), breaks = c(0, 0.5, 1),
                     labels = c("All Boys", "Equal", "All Girls")) +
  theme_bw(base_size = 14) +
  theme(text = element_text(family = font))


name_summary <- name_data %>%
  group_by(year) %>%
  summarise(mean_femaleness = mean(femaleness),
            var_femaleness = var(femaleness))

ggplot(name_summary, aes(x = year, y = var_femaleness)) +
  geom_point()