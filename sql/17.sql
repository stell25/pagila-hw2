/*
 * Compute the total revenue for each film.
 * The output should include another new column "total revenue" that shows the sum of all the revenue of all previous films.
 *
 * HINT:
 * My solution starts with the solution to problem 16 as a subquery.
 * Then I combine the SUM function with the OVER keyword to create a window function that computes the total.
 * You might find the following stackoverflow answer useful for figuring out the syntax:
 * <https://stackoverflow.com/a/5700744>.
 */

SELECT a.rank, a.title, a.revenue, SUM(a.revenue) OVER (ORDER BY a.revenue DESC, a.rank) as "total revenue"
FROM (
    SELECT RANK() OVER(ORDER BY COALESCE(SUM(amount), 0.00) DESC) rank, film.title, COALESCE(SUM(amount), 0.00) AS revenue
    FROM film
    LEFT JOIN inventory USING (film_id)                         LEFT JOIN rental USING (inventory_id)                       LEFT JOIN payment USING (rental_id)                         GROUP BY film_id                                            ORDER BY revenue DESC
) as a
GROUP BY a.rank, a.title, a.revenue
ORDER BY a.rank, a.title;
