library(readxl)
library(ggplot2)
library(directlabels)
library(langcog)

raw_meat <- read_excel("mtpcc.xls", sheet = "Boneless")

meat <- raw_meat %>%
  gather(Animal, Availability, -Year, -Population) %>%
  arrange(desc(Availability)) %>%
  mutate(Total = Availability * Population * 1e6,
         Animal = factor(Animal, levels = unique(Animal)))

ggplot(meat, aes(x = Year, y = Total, colour = Animal)) +
  geom_line() +
  scale_y_continuous(name = "Availability (pounds)\n",
                     limits = c(0, 2e10),
                     breaks = seq(0, 2e10, by = 5e9),
                     labels = c("0", "5 billion", "10 billion",
                                "15 billion", "20 billion")) +
  scale_x_continuous(name = "",
                     breaks = seq(1910, 2010, by = 10)) +
  scale_colour_solarized()

ggplot(meat, aes(x = Year, y = Availability, colour = Animal)) +
  geom_line() +
  scale_y_continuous(name = "Availability per capita (pounds)\n") +
  scale_x_continuous(name = "",
                     limits = c(min(meat$Year), max(meat$Year) + 5),
                     breaks = seq(1910, 2010, by = 10)) +
  geom_dl(aes(label = Animal),
          method = list(dl.trans(x = x + 0.2), "last.bumpup", cex = 0.8,
                        fontfamily = "Open Sans")) +
  scale_colour_solarized(guide = FALSE) +
  theme(text = element_text(family = "Open Sans"))
