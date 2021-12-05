rm(list=ls())
graphics.off()
options(stringsAsFactors = FALSE)
options(na.strings = c("","NA"," "))
cat("\014")

library(tidyverse)

calls = read_csv("~/Data/Documents/42/APT42/data_training/day02/calls.csv")
shortlist = read_csv("~/Data/Documents/42/APT42/data_training/day02/shortlist.csv") %>%
  pull(numbers)

unique(calls$from, calls$to)

calls_short = calls %>%
  filter(to %in% shortlist)

infos = tibble(number = shortlist)
infos = calls_short %>% count(from) %>%
  left_join(infos, ., by = c("number" = "from")) %>%
  rename(outCall = n)
infos = calls_short %>% count(to) %>%
  left_join(infos, ., by = c("number" = "to")) %>%
  rename(inCall = n) %>%
  mutate(totCall = outCall + inCall)

infos %>%
  filter(inCall < 8)

# Graph analysis
# http://www.sthda.com/english/articles/33-social-network-analysis/135-network-visualization-essentials-in-r/

library(igraph)

#  Get distinct source names
sources = calls_short %>%
  distinct(from) %>%
  rename(label = from)
# Get distinct destination names
destinations = calls_short %>%
  distinct(to) %>%
  rename(label = to)
# Join the two data to create node
# Add unique ID for each country
nodes = full_join(sources, destinations, by = "label") 
nodes = nodes %>%
  mutate(id = 1:nrow(nodes)) %>%
  select(id, everything()) %>%
  mutate(label = as.character(label))
  
head(nodes, 3)


# Rename the n.call column to weight
phone.call = calls_short %>%
  mutate(weight = 1)
# (a) Join nodes id for source column
edges = phone.call %>%
  mutate(from = as.character(from)) %>%
  left_join(nodes, by = c("from" = "label")) %>% 
  rename(from2 = id)
# (b) Join nodes id for destination column
edges = edges %>% 
  mutate(to = as.character(to)) %>%
  left_join(nodes, by = c("to" = "label")) %>% 
  rename(to2 = id)
# (c) Select/keep only the columns from and to
edges = select(edges, from2, to2, weight) %>%
  rename(to = to2, from = from2)
head(edges, 3)


net.igraph = graph_from_data_frame(
  d = edges, vertices = nodes, 
  directed = TRUE
)
shortlist_id = left_join(tibble(shortlist=as.character(shortlist)), nodes, by=c("shortlist" = "label")) %>%
  pull(id)
V(net.igraph)$color = ifelse(V(net.igraph)$name %in% as.character(shortlist_id), "red", "white")
V(net.igraph)$size = ifelse(V(net.igraph)$name %in% as.character(shortlist_id), 10, 2)
V(net.igraph)$label = ifelse(V(net.igraph)$label %in% shortlist, V(net.igraph)$label, "")
V(net.igraph)$label = str_sub(V(net.igraph)$label, 8)

set.seed(123)
plot(net.igraph, edge.arrow.size = 0.2,
     layout = layout_with_graphopt)

# Flag 9971

