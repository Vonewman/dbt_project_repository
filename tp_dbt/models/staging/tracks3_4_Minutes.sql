{{ config(
    materialized="table"
         )
}}

WITH data_source AS(
SELECT TrackId, Name, AlbumId, MediaTypeId, GenreId, Milliseconds, Bytes
FROM {{ source("staging","tracks") }}
),
final AS (
    SELECT * FROM data_source
    WHERE Milliseconds >= 180000 AND Milliseconds <= 240000 AND Bytes > 6600000

)

SELECT * FROM final