--Create the amazon_prodcuts table--
CREATE TABLE amazon_products (
                                 product_id INT,        -- Original dataset ID (0,1,2,3...)
                                 asin VARCHAR(20) PRIMARY KEY, -- ASIN is the stable unique identifier
                                 title TEXT,
                                 product_group VARCHAR(50),
                                 sales_rank INT,
                                 similar_products TEXT,
                                 categories TEXT
);

--Create amazon_reviews table--
CREATE TABLE amazon_reviews (
                                id SERIAL PRIMARY KEY,
                                asin VARCHAR(20),
                                review_date DATE,
                                customer_id VARCHAR(30),
                                rating INT,
                                votes INT,
                                helpfulness INT,
                                FOREIGN KEY (asin) REFERENCES amazon_products(asin) ON DELETE CASCADE
);


--remove duplicates--
WITH Deduplicated AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY asin ORDER BY sales_rank ASC) AS row_num
    FROM amazon_products
)
DELETE FROM amazon_products
WHERE asin IN (
    SELECT asin FROM Deduplicated WHERE row_num > 1
);

--Handle Missing values
DELETE FROM amazon_products
WHERE asin IS NULL OR title IS NULL OR sales_rank IS NULL; --ensure no critical columns like asin, title, or sales_rank contain NULL values--


-- Create Index for faster query searching--
CREATE INDEX idx_asin ON amazon_products (asin);
CREATE INDEX idx_salesrank ON amazon_products (sales_rank);
CREATE INDEX idx_review_asin ON amazon_reviews (asin);
CREATE INDEX idx_review_customer ON amazon_reviews (customer_id);

DROP INDEX IF EXISTS idx_category;
CREATE INDEX idx_category_hash ON amazon_products (md5(categories));

--find best selling products--
SELECT title, sales_rank
FROM amazon_products
WHERE sales_rank > 0  -- Excludes -1 (invalid rankings)
ORDER BY sales_rank ASC
LIMIT 10;

--Find products with high purchasing rate
SELECT asin, title,
       LENGTH(similar_products) - LENGTH(REPLACE(similar_products, '|', '')) + 1 AS similar_count
FROM amazon_products
WHERE similar_products IS NOT NULL AND similar_products <> ''
ORDER BY similar_count DESC
LIMIT 10;

--Find Products with Low Co-Purchases--
SELECT asin, COUNT(*) AS co_purchase_count
FROM amazon_products
WHERE similar_products IS NOT NULL
GROUP BY asin
ORDER BY co_purchase_count ASC;
