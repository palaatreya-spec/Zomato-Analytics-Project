# EDA Findings — Source-Backed Dataset

The uploaded restaurant dataset contains 224,520 records. The following findings were calculated directly from the uploaded CSV after normalizing ratings and cost-for-two.

## 1. Rating and engagement

The correlation between valid restaurant rating and rating count is approximately **0.392**, indicating a moderate positive association. Higher-rated restaurants tend to have more rating activity in this dataset, but this is observational and does not imply that ratings cause engagement.

## 2. Pricing and quality

The correlation between valid rating and cost-for-two is approximately **0.269**, a weak-to-moderate positive association. Higher listed price is therefore associated with somewhat higher ratings, but price alone is not a reliable predictor of restaurant quality.

## 3. Engagement and pricing

The correlation between rating count and cost-for-two is approximately **0.287**. More expensive restaurants tend to have somewhat more rating activity, but the relationship is not strong enough to treat price as an engagement driver.

## 4. Largest markets

The largest city groups are Delhi NCR, Mumbai, Bengaluru, Pune and Hyderabad. Delhi NCR contains the largest restaurant supply in the source.

## 5. City-level signals

Among the largest markets, Bengaluru has the highest average valid rating at approximately **3.61**, while Delhi NCR and Mumbai are both around **3.51**. Chandigarh has the highest online-order adoption among the top 10 cities at approximately **60.7%**.

## 6. Cuisine mix

North Indian, Chinese and Fast Food are the largest cuisine categories by restaurant presence. Desserts and Beverages show relatively stronger average ratings among major cuisine categories, while Mughlai has a higher median listed cost-for-two.

## 7. Analytical caution

These are descriptive relationships from a cross-sectional restaurant dataset. They should not be presented as causal effects. The source has no order-level revenue, customer history or experiment design.

## Recommended business questions

- Which cities combine market scale with strong quality and digital adoption?
- Which cuisine categories have high supply but weaker ratings?
- Does digital-order availability vary systematically by market type?
- Which high-engagement restaurants sit in lower price bands?
- Which markets have unusually high pricing but weaker quality signals?
