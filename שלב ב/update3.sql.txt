BEGIN;

ALTER TABLE supplier
ADD COLUMN isExpensive BOOLEAN;

UPDATE supplier
SET isExpensive = TRUE
WHERE supplierId IN (
  SELECT supplierId
  FROM supplies
  GROUP BY supplierId
  HAVING AVG(cost) > 500
);

UPDATE supplier
SET isExpensive = FALSE
WHERE isExpensive IS NULL;

SELECT *
FROM supplier;
