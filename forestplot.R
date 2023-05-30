library(ggstats)
library(broom.helpers)

mv_data <- mv_model %>% model_list_terms_levels()

x <-
ggcoef_model(mv_model,
             exponentiate = TRUE,
             colour = NULL,
             significance = NULL,
             add_reference_rows = FALSE,
             show_p_values = FALSE,
             signif_stars = FALSE,
             categorical_terms_pattern = "{var_label} (ref: {reference_level})",
             point_stroke = 0.2,
             errorbar_height = 0.2,
             stripped_rows = FALSE) +
  theme_classic() %+replace%
  theme(line = element_line(linewidth = 0.3),
        rect = element_blank(),
        axis.text = element_text(color = "#292929",
                                 size = 7),
        axis.title = element_text(color = "#292929",
                                  size = 7),
        axis.title.y = element_text(angle = 0),
        panel.spacing = unit(0, "npc"),
        panel.border = element_blank(),
        #plot.margin = margin(0,0,0,0)
        panel.grid = element_blank(),
        strip.text = element_blank())

output(x, width = 6, height = 3.5)


