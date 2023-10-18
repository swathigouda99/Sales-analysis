#1 Question Toatal sales where order status is shipped.
select o.ordernumber, sum(quantityordered) totalSales
from orderdetails o join orders o1
on o.ordernumber = o1.ordernumber
group by 1;

#2. which product has the highest sales
with cte as (select productCode,sum(quantityOrdered) as total_sales from orderdetails
group by 1
order by 2 asc 
limit 5)
select cte.productCode,products.productName,cte.total_sales from products 
join cte 
on cte.productCode=products.productCode;

#3. Average shipped_rate of Product
SELECT *,round(100*sum(case when status='Shipped' then 1 else 0 end)/count(*),2) as shipped_rate FROM classicmodels.orders;

#4 Total Profit Earned by the Sales
SELECT sum(quantityOrdered*priceEach)-sum(buyPrice*quantityOrdered) as profit  FROM classicmodels.orderdetails
join products 
on orderdetails.productCode=products.productCode;

# Top 5 countries which has highest sales;
with cte as (select orderNumber,sum(quantityOrdered) as total_quantity_sold from orderdetails
group by 1
order by 2 desc
limit 5)
select country,cte.total_quantity_sold from cte 
join orders
on cte.orderNumber=orders.orderNumber
join customers
on customers.customerNumber=orders.customerNumber;

#6. average days taken to ship the product

select round(avg(shippedDate-orderDate),1) as avg_ship_days  from orders


