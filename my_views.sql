-- Vue ALL_WORKERS
CREATE OR REPLACE VIEW ALL_WORKERS AS
SELECT WORKERS_FACTORY_1.last_name, WORKERS_FACTORY_1.first_name, age, start_date
FROM WORKERS_FACTORY_2, WORKERS_FACTORY_1
WHERE end_date IS NULL AND WORKERS_FACTORY_2.first_name = WORKERS_FACTORY_1.first_name
ORDER BY start_date DESC;

-- Vue ALL_WORKERS_ELAPSED
CREATE OR REPLACE VIEW ALL_WORKERS_ELAPSED AS
SELECT last_name, first_name, age, start_date, TRUNC(sysdate - start_date) AS days_elapsed
FROM ALL_WORKERS;

-- Vue BEST_SUPPLIERS
CREATE OR REPLACE VIEW BEST_SUPPLIERS AS
SELECT s.name AS supplier_name, SUM(sb.quantity) AS total_quantity
FROM SUPPLIERS_BRING_TO_FACTORY_2 sb
JOIN SUPPLIERS s ON sb.supplier_id = s.supplier_id
GROUP BY s.name
HAVING SUM(sb.quantity) > 1000
ORDER BY total_quantity DESC;

-- Vue ROBOTS_FACTORIES
CREATE OR REPLACE VIEW ROBOTS_FACTORIES AS
SELECT r.id AS robot_id, f.main_location AS factory_location
FROM ROBOTS_FROM_FACTORY rf
JOIN ROBOTS r ON rf.robot_id = r.id
JOIN FACTORIES f ON rf.factory_id = f.id;
