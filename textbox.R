label <-
"Lorem ipsum dolor **sit amet,** consectetur adipiscing elit,
sed do *eiusmod tempor incididunt* ut labore et dolore magna
aliqua.m dolor sit amet, consectetum dolor **sit amet,** consectetu
m dolor **sit amet,** consectetum dolor **sit amet,** consectetu"

gg <- 
ggplot(df) +
  aes(x = suivi_jr/2,
      y = 0,
      label = label,
      hjust = 0.5,
      vjust = 0.5) +
  geom_textbox(width = unit(1, "npc")) +
  geom_point(color = "black", size = 2) +
  scale_discrete_identity(aesthetics = c("color", "fill", "orientation")) +
  xlim(0, suivi_jr) +
  ylim(0-0.01,0+0.01)

output(ddd, width = 7, height = 4)
