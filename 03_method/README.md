# Method

The objective of this project is to infer product demand from service-level behaviour. However, raw service data is inconsistent and cannot be analysed directly without transformation. This layer converts raw service records into a structured format that enables comparison across providers and aggregation of service patterns.

# Data Extraction

Service data is sourced from the underlying dataset and filtered to include:

UK-based providers
services containing “knotless” in the name or category

This creates a focused segment for analysis while preserving real-world variation in service naming.

# Normalisation

Raw service names are transformed into structured attributes using SQL-based rules.
These include:

service family (e.g. knotless_braids)
style variant (e.g. standard, boho, goddess)
size band (e.g. small, medium, large)
length band (e.g. bob, waist, mid_back)
service modifiers (e.g. refresh, kids)

This process allows inconsistent naming formats to be converted into a consistent analytical structure.

The purpose of this transformation is to enable:

frequency analysis of services
comparison across providers
mapping of services to product dependencies
identification of structurally embedded demand

# Reproducibility
The SQL used to perform this transformation is included in this directory.
