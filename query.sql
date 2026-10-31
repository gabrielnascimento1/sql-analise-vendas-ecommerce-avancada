SELECT 
    produtos.category AS categoria_produto,
    COUNT(DISTINCT pedidos.order_id) AS total_pedidos,
    SUM(itensp.sale_price) AS faturamento_total,
    ROUND(AVG(itensp.sale_price), 2) AS ticket_medio
FROM 
    bigquery-public-data.thelook_ecommerce.orders AS pedidos

INNER JOIN 
    bigquery-public-data.thelook_ecommerce.order_items AS itensp
    ON pedidos.order_id = itensp.order_id

INNER JOIN 
    bigquery-public-data.thelook_ecommerce.products AS produtos
    ON itensp.product_id = produtos.id
    
WHERE 
    pedidos.status = 'Complete'
GROUP BY 
    produtos.category
HAVING 
    SUM(itensp.sale_price) > 50000 
ORDER BY 
    faturamento_total DESC;
