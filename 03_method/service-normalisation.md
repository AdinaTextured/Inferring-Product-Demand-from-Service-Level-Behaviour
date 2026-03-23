# Service Normalisation Method Overview

This project analyses service-level behaviour to infer product demand. However, raw service data is highly inconsistent, with variations in naming, formatting, and level of detail across providers.
To enable analysis, service names were normalised into structured fields representing:
service family
style variation
size
length
service modifiers (e.g. refresh, children’s services)

Normalisation enables:

aggregation of service frequency
comparison across providers
mapping of services to product dependencies
identification of structurally embedded demand

# Source Data Characteristics

Raw service data includes:

inconsistent naming conventions
multiple descriptors within a single service name
mixed use of size, length, and styling terms
varying levels of specificity

Example raw service names:

“Medium Boho Knotless Braids - Bob Length”
“Large Knotless Braids”
“Small Knotless Goddess Braids (Waist Length)”
“Medium Knotless Refresh”

These variations require decomposition into structured attributes.

# Normalised Fields
Service Family
All records in this dataset are mapped to:
knotless_braids to reflects the focus segment of the case study.

Style Variant
Represents the stylistic variation of the braid.

Value	Description
standard	Default knotless braids
boho	Includes loose / curly strands
goddess	Similar to boho, often more defined curls
fulani	Includes Fulani-style patterns
frontal	Includes frontal-based braid styles
refresh	Maintenance or touch-up service
Size Band

Represents braid thickness.

Value	Description
jumbo	Very large braids
large	Large braids
medium	Medium braids
small	Small braids
small_medium	Mixed sizing
unknown	Not specified
Length Band

Represents braid length where available.

Value	Description
bob	Short / bob length
short	Above shoulder
mid_back	Mid-back length
waist	Waist length
bum	Hip / bum length
unknown	Not specified
Service Modifiers
is_refresh_service

Boolean flag indicating whether the service is a maintenance or touch-up.

Derived from:

“refresh”
similar terminology in service name
is_kids_service

Boolean flag indicating whether the service is targeted at children.

Derived from:

“kids”
“child”
category indicators
Price Normalisation

Prices are stored in minor units in the raw dataset.

They are converted to GBP using:

price_gbp = price_minor / 100

This enables easier comparison across services.

# Filtering Rules

The dataset is filtered to include only:

services containing “knotless” in the name or category
services located in the UK (England in this extract)
Exclusion Rules

The following records are excluded or flagged:

placeholder providers (e.g. “DELETE”)
incomplete or clearly invalid entries

A separate flagged dataset is retained to preserve traceability.

# Limitations
Some services lack explicit size or length information
Naming conventions vary significantly across providers
Some classifications (e.g. boho vs goddess) may overlap
Product dependencies are not directly observed and will be inferred in later stages
