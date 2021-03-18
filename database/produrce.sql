CREATE DEFINER=`root`@`localhost` PROCEDURE `GetRevenueDaily`(
	in fromDate VARCHAR(10),
	in toDate VARCHAR(10)
)
BEGIN
	select
                CAST(b.created_at AS DATE) as Date,
                sum(bd.quantity*bd.product_price) as Revenue,
                sum((bd.quantity*bd.product_price)-(bd.quantity * p.sale_price)) as Profit
                from bills b
                inner join bill_details bd
                on b.id = bd.order_id
                inner join product_attributes p
                on bd.product_id  = p.product_id && bd.product_attribute_id = p.id
                where b.created_at <= cast(@toDate as date) 
				AND b.created_at >= cast(@fromDate as date)
                group by b.created_at;
END