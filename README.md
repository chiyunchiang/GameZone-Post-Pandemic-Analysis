# GameZone-Post-Pandemic-Analysis
## Table of Contents

[Project Background](https://github.com/chiyunchiang/GameZone-Post-Pandemic-Analysis/blob/main/README.md#project-background)


[Executive Summary](https://github.com/chiyunchiang/GameZone-Post-Pandemic-Analysis/blob/main/README.md#executive-summary)

[Sales Trend and Growth Rate](https://github.com/chiyunchiang/GameZone-Post-Pandemic-Analysis/blob/main/README.md#sales-trend-and-growth-rate)

[Key Product Performance](https://github.com/chiyunchiang/GameZone-Post-Pandemic-Analysis/blob/main/README.md#key-product-performance)

[Customer Growth Rate and Repeat Purchase Trend](https://github.com/chiyunchiang/GameZone-Post-Pandemic-Analysis/blob/main/README.md#customer-growth-rate-and-repeat-purchase-trend)

[Sales by Platforms and Channels](https://github.com/chiyunchiang/GameZone-Post-Pandemic-Analysis/blob/main/README.md#sales-by-platforms-and-channels)

[Reccomandations](https://github.com/chiyunchiang/GameZone-Post-Pandemic-Analysis/blob/main/README.md#reccomandations)

[Clarifying Questions, Assumptions, and Caveats](https://github.com/chiyunchiang/GameZone-Post-Pandemic-Analysis/blob/main/README.md#clarifying-questions-assumptions-and-caveats)


## Project Background
Based on the provided sales data, GameZone is a global e-commerce company specializing in the sale of video game products. After analyzing the data, I will offer recommendations to the sales and marketing teams.

## Executive Summary
Between 2019 and 2021, GameZone completed 21,000 orders, generating an average annual revenue of $2 million. North America (NA) and EMEA contributed 83% of the revenue, with the Nintendo Switch being the most popular product from GameZone, accounting for nearly 48% of the total orders.

Order numbers and sales increased steadily from 2019 to 2020, reaching a record high in the fourth quarter of 2020. However, they decreased significantly after 2021.
Despite the rapid decline in 2021, the percentage of repeat customers increased by 7%. GameZone can increase its profits by expanding its top product line, optimizing bundling, and introducing loyalty programs, thereby significantly enhancing customer lifetime value. This strategy can instill hope in the sales and marketing teams about the potential for customer retention. Targeting the growth of APAC and LATAM markets, and improving the mobile App use will further bolster GameZone's market position.

## Sales Trend and Growth Rate
- GameZone averages $2 million in annual sales and  7,200 orders a year.
- Sales surged in 2020 due to the pandemic, but declined by 87% by 2021.
- Before 2021, GameZone exhibited seasonality, with sales spikes in November and December and decreases in February and October.
- After March 2021, when most physical stores reopened, sales decreased and remained low every month.
- NA and EMEA contributed 80% of the sales, with NA having more than half of the sales.
## Key Product Performance
- Sales of most products increased during the pandemic. The PlayStation 5 Bundle increased by 364%, and the Lenovo IdeaPad by 207%.
- The gaming monitor, Nintendo Switch, PlayStation 5 Bundle, and Lenovo IdeaPad contributed 97% of the sales.
- The Nintendo Switch accounts for 48% of the order numbers.
- The gaming monitor accounts for 1.9 million (32%) of sales.
- Due to the price. The PlayStation 5 Bundle contributed 1.5 million (26%) to sales, accounting for only 4% of the order numbers. JBL Headset accounts for 20% of the order numbers, with only 2% of the total sales.
## Customer Growth Rate and Repeat Purchase Trend
- GameZone's unique customers reached their peak of 12,000 in 2020, then decreased to 1500 in 2021.
- The repeat customer percentage decreased by 1% from 2019 to 2020 and then surged to 15% in 2021.
- 2021 had the lowest number (1,500) of unique customers but also the highest repeat customer percentage (15%).
## Sales by Platforms and Channels
- The direct channel accounts for 85% (5.1 million) of the sales.
- The affiliate channel has the highest AOV ($319), whereas the email channel has the lowest at $187.
- The website accounts for 98% (5.9 million) of the sales, with AOV($303), while the app has 2% of total sales and AOV($74).
## Reccomandations
### Maximizing Product Offering
- Expanding highly performing products: Increase the variations of the highly performing products category, such as gaming monitors, the Nintendo Switch, and PlayStation.
- Using a bundle sale: Pair unpopular products with high-performing ones, such as gaming monitors paired with a gaming mouse and a gaming headset.
### Customer Growth and Retention
- Introducing a loyalty programme: Target single-purchase customers with loyalty tier rewards and special offers to improve retention.
- Revitalize customer acquisition: By expanding acquisition channels, including various social media platforms and partnerships with influencers and celebrities.
### Optimizing Channels and Platforms
- Expand affiliate and social media partnerships: Increase affiliate partnerships or offer higher commissions to attract influential marketers, thereby enhancing brand reach.
- Improve the mobile app user experience: By making the mobile app more user-friendly, customers can make fewer efforts to purchase products, thereby boosting sales.
### Region Growth Strategy
- Boost growth in APAC and LATAM: advertisements and promotions adapt to local culture to increase sales in APAC and LATAM.
- Focus on the high-performance market: Continue to allocate resources to North America and EMEA by catering to a broader range of customer groups and addressing their specific needs.
## Clarifying Questions, Assumptions, and Caveats
### Questions for stakeholders
#### USD_PRICE missing or showing $0
- How is the USD_PRICE data collected and recorded in the system?
- If USD_PRICE is missing, can it be derived from another field (e.g., local currency + exchange rate)?
- Are $0 test transactions, free promotions, or data errors that should be excluded from analysis?
- How should we handle orders with a $ 0 value in our metrics? Should they be excluded from AOV calculations since they may distort averages?
- Are there default prices or historical averages we can use to fill gaps?

#### Missing COUNTRY_CODE
- Are there alternative fields (e.g., shipping_zip, billing_country) that could help infer missing country codes?
- Is there a priority list of high-value countries where missing data is most problematic?
  
### Assumptions and Caveats
- Duplicates within ORDER_ID: There are 145 duplicate rows for ORDER_ID. Could delete duplicates if needed, but the volume is low.
- SHIP_TS earlier than PURCHASE_TS: The time zones may be mismatched between SHIP_TS and PURCHASE_TS, or this discrepancy could be due to pre-orders, backorders, or data-entry errors. It should be monitored when the issue recurs.

