/*
 * List the title of all movies that have both the 'Behind the Scenes' and the 'Trailers' special_feature
 *
 * HINT:
 * Create a select statement that lists the titles of all tables with the 'Behind the Scenes' special_feature.
 * Create a select statement that lists the titles of all tables with the 'Trailers' special_feature.
 * Inner join the queries above.
 */

SELECT title
FROM (
    SELECT title
    FROM film
    CROSS JOIN unnest(special_features) as special_feature
    WHERE special_feature = 'Behind the Scenes'
) AS table1
INNER JOIN(
    SELECT title
    FROM film
    CROSS JOIN unnest(special_features) as special_feature
    WHERE special_feature = 'Trailers'
) AS table2 USING (title)
ORDER BY title;
