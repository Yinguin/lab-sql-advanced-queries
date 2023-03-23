USE sakila;

# For each film, list actor that has acted in more films.
SELECT f.title, a.first_name, a.last_name, 
       (SELECT COUNT(*) FROM film_actor fa WHERE fa.actor_id = a.actor_id) AS total_films_acted
FROM film f
JOIN film_actor fa USING (film_id)
JOIN actor a USING (actor_id)
GROUP BY fa.film_id, a.actor_id
HAVING COUNT(*) = (
  SELECT MAX(film_count)
  FROM (SELECT COUNT(*) AS film_count
        FROM film_actor fa2
        WHERE fa2.film_id = fa.film_id
        GROUP BY fa2.actor_id
       ) fc
)
ORDER BY film_id, total_films_acted DESC;