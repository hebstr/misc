require(tidyverse)
require(broom)

# database fictive  --------------------------------------------
pols_df <- map_dfc(1:6, ~ tibble(pol = abs(rnorm(100))))
metabs_df <- map_dfc(1:100, ~ tibble(metab = abs(rnorm(100))))
load("vars_df.RData")

df <- bind_cols(pols_df, vars_df, metabs_df,
                .name_repair = "check_unique")

rm(pols_df, vars_df, metabs_df)
#---------------------------------------------------------------

volcano <- \(data, ...) {

pols <- list(...)
var_commun <- c("sexe", "age")
vars <- list(p1 = c(var_commun, "var_1"),
             p2 = c(var_commun, "var_1", "var_2"),
             p3 = c(var_commun, "var_2", "var_3"),
             p4 = c(var_commun, "var_1", "var_2", "var_3"),
             p5 = c(var_commun, "var_1", "var_2", "var_3"),
             p6 = c(var_commun, "var_1", "var_3"))

for (i in seq_along(pols)) {
  
    lm <- map_df(data %>% select(starts_with("metab")) %>% names(),
                 ~ lm(reformulate(c(pols[[i]], vars[[i]]), paste0("log(", .x,")")), data) %>%
                   tidy() %>%
                   filter(term == pols[[i]]) %>%
                   mutate(metab = ifelse(term == pols[[i]], .x, term), .after = term))
    
    assign(pols[[i]], lm, .GlobalEnv)
    
    message(paste(pols[[i]], "ajusté sur", vars[i]))
    
    assign(paste0("vplot_", pols[[i]]),
           map_df(pols[[i]], ~ eval(as.name(.x))) %>%
             ggplot(aes(estimate, -log10(p.value))) +
             geom_point(alpha = 0.5),
           envir = .GlobalEnv)

    }

}

volcano(df, "pol...1", "pol...2", "pol...3", "pol...4", "pol...5", "pol...6")
