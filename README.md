
# scrapeR

## Overview

scrapeR is a framework inspired by the `scrapy` python framework. It is
meant to be used for batching multiple crawlers and reusing item
pipelines between them.

The basic components of a scrapeR project are
`queues, steps, pipelines, and runners`.

**Pipelines** are an organizational tool of a combination of different
scraping and processing steps that are applied to the original *queue*
of data. Each pipeline begins with a list input and will run each step
in the pipeline. Pipelines can steps are similar to classic functional
programming functions but have the advantage of delayed execution,
reusability, parallelization, and documentation.

The **steps** that comprise *pipelines* can either be
`parsers or transformers`. **Parsers** are *steps* that are applied to
each item of the *queue* in parallel. **Transformers** are *steps* that
are applied to entire *queue* and are important for summarizing and
consolidating the results.

## Installation

``` r
# Install the development version from GitHub:
# install.packages("devtools")
devtools::install_github("quartzsoftwarellc/scrapeR")
```

# Usage

``` r
library(rvest)
library(scrapeR)

start_url <- "https://en.wikipedia.org/wiki/Cat"

spider("cats") %>%
    add_queue(start_url) %>%
    add_parser(~ {
        read_html(.x) %>%
            html_nodes(".mw-headline") %>%
            html_text() 
                    }
    ) %>%
    run() %>%
    paste(sep = "")
```

    ##  [1] "Etymology and naming"      "Taxonomy"                 
    ##  [3] "Evolution"                 "Domestication"            
    ##  [5] "Characteristics"           "Size"                     
    ##  [7] "Skeleton"                  "Skull"                    
    ##  [9] "Claws"                     "Ambulation"               
    ## [11] "Balance"                   "Senses"                   
    ## [13] "Vision"                    "Hearing"                  
    ## [15] "Smell"                     "Taste"                    
    ## [17] "Whiskers"                  "Behavior"                 
    ## [19] "Sociability"               "Communication"            
    ## [21] "Grooming"                  "Fighting"                 
    ## [23] "Hunting and feeding"       "Play"                     
    ## [25] "Reproduction"              "Lifespan and health"      
    ## [27] "Disease"                   "Ecology"                  
    ## [29] "Habitats"                  "Ferality"                 
    ## [31] "Impact on wildlife"        "Interaction with humans"  
    ## [33] "Shows"                     "Infection"                
    ## [35] "History and mythology"     "Superstitions and rituals"
    ## [37] "Coats"                     "See also"                 
    ## [39] "References"                "External links"
