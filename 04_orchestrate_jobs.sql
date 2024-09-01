use role accountadmin;
use schema nom.dbo;


-- declarative target table of pipeline
create or alter table vacation_spots (
    city varchar
  , airport varchar
  , co2_emissions_kg_per_person float
  , punctual_pct float
  , avg_temperature_air_f float
  , avg_relative_humidity_pct float
  , avg_cloud_cover_pct float
  , precipitation_probability_pct float
  -- STEP 5: INSERT CHANGES HERE
) data_retention_time_in_days = 1;
