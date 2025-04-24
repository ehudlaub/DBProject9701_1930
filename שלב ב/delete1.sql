BEGIN;
DELETE FROM Supplier
WHERE supplierId IN (
  SELECT s.supplierId
  FROM Supplier s
  LEFT JOIN supplies sp ON s.supplierId = sp.supplierId
  WHERE s.contractStart < '2003-01-01'
  GROUP BY s.supplierId
  HAVING COALESCE(SUM(sp.cost), 0) < 1000000
);
