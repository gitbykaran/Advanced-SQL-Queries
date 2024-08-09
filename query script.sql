# 1) All films with PG-13 RATING with rental rate of 2.99 or lower

SELECT * 
FROM sakila.film f
where f.rental_rate <=2.99
and f.rating = 'PG-13';

# 2) All films that have deleted scenes

select 
	f.title,
	f.special_features,
	f.release_year
from sakila.film f
where f.special_features like '%Deleted Scenes%'
and title like 'c%';

# 3) All active customers

select * 
from sakila.customer
where active=1;

# 4) Names of customers who rented a movie on 26th July 2005

select 	
	r.rental_id, 
    r.rental_date,
    r.customer_id,
concat(c.first_name,’ ‘, c.last_name) as Full_name 
from sakila.rental r
join customer c 
on c.customer_id = r.customer_id
where date(r.rental_date) = '2005-07-26';

# 5) Distinct names of customers who rented a movie on 26th July 2005
select 
	distinct r.customer_id,
	concat(c.first_name,’ ‘, c.last_name) as Full_name 
    from sakila.rental r
join customer c 
on c.customer_id = r.customer_id
where date(r.rental_date) = '2005-07-26';


# 6) How many rentals we do on each day?

select 
	date(rental_date) as d,
	count(*) from sakila.rental
group by date(rental_date);


#7 All SCI-Fi Films in our Catelog 

SELECT
	s.title,
    f.film_id,
    c.name as category  
FROM sakila.film_category f
JOIN sakila.category c
ON f.category_id = c.category_id
JOIN sakila.film s 
on s.film_id = f.film_id
WHERE c.name = 'Sci-Fi';

#8 Customers and how many movies they rented so far 

SELECT 
	r.customer_id,
    c.first_name,
    c.last_name,
    count(*) as count
FROM sakila.rental r 
JOIN sakila.customer c 
ON c.customer_id = r.customer_id
GROUP BY r.customer_id 
ORDER BY count(*) DESC;


#9 Which Movies we should discontinue

WITH low_rental as
	(SELECT r.inventory_id,count(*) 
	FROM sakila.rental r
	GROUP BY r.inventory_id
	HAVING count(*) <=1)
SELECT i.film_id,l.inventory_id FROM low_rentals l 
join sakila.inventory i  
on i.inventory_id = l.inventory_id 
join sakila.film f 
on f.film_id = i.film_id;   

#10 Which Movies is yet to be returned 

with no_returns as 
	(select r.inventory_id,i.film_id
	from sakila.rental r 
	join inventory i 
	on i.inventory_id = r.inventory_id
	where r.return_date is null)
select f.film_id,title,n.inventory_id 
from no_returns n
join film f 
on f.film_id = n.film_id;










