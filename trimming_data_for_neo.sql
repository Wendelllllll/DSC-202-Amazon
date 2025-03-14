# Check Data Structure
SELECT COUNT(*)
FROM amazon_products;

SELECT *
FROM amazon_products
LIMIT 100;

SELECT asin,
       title,
       product_group,
       sales_rank
FROM amazon_products;


# Co_purchased node
SELECT asin AS product_asin,
       UNNEST(string_to_array(similar_products, '|')) AS similar_asin
FROM amazon_products
WHERE similar_products IS NOT NULL
  AND similar_products <> '';

# Category node
# First trimming/Check the top 100 categories
SELECT COUNT(*) FROM amazon_products WHERE sales_rank IS NOT NULL AND sales_rank > 0;

WITH top_products AS (
  SELECT asin
  FROM amazon_products
  WHERE sales_rank IS NOT NULL AND sales_rank > 0
  ORDER BY sales_rank ASC
),
category_names AS (
  SELECT DISTINCT
    sub.asin AS product_asin,
    TRIM(BOTH ' ' FROM regexp_replace(sub.cat_chunk, '\[.*$', '')) AS category_name
  FROM (
    SELECT
      p.asin,
      UNNEST(
        string_to_array(
          regexp_replace(p.categories, '\]', ']|', 'g'),
          '|'
        )
      ) AS cat_chunk
    FROM amazon_products p
    JOIN top_products tp ON p.asin = tp.asin
    WHERE p.categories IS NOT NULL
      AND p.categories <> ''
  ) sub
  WHERE sub.cat_chunk <> ''
    AND TRIM(BOTH ' ' FROM regexp_replace(sub.cat_chunk, '\[.*$', '')) <> ''
)
SELECT
  category_name,
  COUNT(*) AS frequency
FROM category_names
GROUP BY category_name
ORDER BY frequency DESC
LIMIT 100;


#Final trimming with irrelavent categories removed
WITH top_products AS (
  SELECT asin
  FROM amazon_products
  WHERE sales_rank IS NOT NULL AND sales_rank > 0
  ORDER BY sales_rank ASC
),
category_names AS (
  SELECT DISTINCT
    sub.asin AS product_asin,
    TRIM(BOTH ' ' FROM regexp_replace(sub.cat_chunk, '\[.*$', '')) AS category_name
  FROM (
    SELECT
      p.asin,
      UNNEST(
        string_to_array(
          regexp_replace(p.categories, '\]', ']|', 'g'),
          '|'
        )
      ) AS cat_chunk
    FROM amazon_products p
    JOIN top_products tp ON p.asin = tp.asin
    WHERE p.categories IS NOT NULL
      AND p.categories <> ''
  ) sub
  WHERE sub.cat_chunk <> ''
    AND TRIM(BOTH ' ' FROM regexp_replace(sub.cat_chunk, '\[.*$', '')) <> ''
    AND TRIM(BOTH ' ' FROM regexp_replace(sub.cat_chunk, '\[.*$', '')) NOT IN ('General', 'Genres', 'Subjects', 'Categories', 'Reference', 'Formats', 'Authors, A-Z')
    AND TRIM(BOTH ' ' FROM regexp_replace(sub.cat_chunk, '\[.*$', '')) !~ '^\(\s*[A-Z]\s*\)$'
)
SELECT
  product_asin,
  category_name
FROM category_names;