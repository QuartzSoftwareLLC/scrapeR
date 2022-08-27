# scrapeR

## Introduction

scrapeR is a framework inspired by the `scrapy` python framework. It is meant to be used for batching multiple crawlers and reusing item pipelines between them.

The basic components of a scrapeR project are `queues, steps, pipelines, and runners`.

**Pipelines** are an organizational tool of a combination of different scraping and processing steps that are applied to the original *queue* of data. Each pipeline begins with a list input and will run each step in the pipeline. Pipelines can steps are similar to classic functional programming functions but have the advantage of delayed execution, reusability, parallelization, and documentation.

The **steps** that comprise *pipelines* can either be `parsers or transformers`. **Parsers** are *steps* that are applied to each item of the *queue* in parallel. **Transformers** are *steps* that are applied to entire *queue* and are important for summarizing and consolidating the results.