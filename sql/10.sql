/*
 * Management is planning on purchasing new inventory.
 * Films with special features cost more to purchase than films without special features,
 * and so management wants to know if the addition of special features impacts revenue from movies.
 *
 * Write a query that for each special_feature, calculates the total profit of all movies rented with that special feature.
 *
 * HINT:
 * Start with the query you created in pagila-hw1 problem 16, but add the special_features column to the output.
 * Use this query as a subquery in a select statement similar to answer to the previous problem.
 */

SELECT special_feature, sum(profit) as profit
FROM (
    SELECT film.title, sum(payment.amount) as profit, special_features.special_feature
    FROM film
    JOIN inventory on film.film_id = inventory.film_id
    JOIN rental on inventory.inventory_id = rental.inventory_id
    JOIN payment on rental.rental_id = payment.rental_id
    CROSS JOIN unnest(special_features) AS special_features(special_feature)
    GROUP BY film.title, special_features.special_feature
    ORDER BY profit DESC
) as profit
GROUP BY special_feature
ORDER BY special_feature;
