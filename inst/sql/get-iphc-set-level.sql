-- If any of this first call changes then update table in text (currently
--  (in Andy's yeye15reproduce repo, will get moved to gfsynopsis), and make
--  sure you change it in get-iphc-set-info.sql also
SELECT YEAR(TRIP_START_DATE) AS year,
	T.TRIP_ID AS tripID,
	FE.FISHING_EVENT_ID AS setID,
        BLOCK_DESIGNATION AS block,
	FE_MAJOR_LEVEL_ID AS setInTrip,
	C.SPECIES_CODE AS speciesCode,
	SPECIES_COMMON_NAME AS species,
	CATCH_WEIGHT AS catchWeight,
	CATCH_COUNT AS catchCount,
	LGLSP_HOOKS_SET_COUNT AS hooksCount,
	SKATE_COUNT AS skatesCount,
	EFFECTIVE_SKATE AS effectSkate,
	SPECIES_CATEGORY_CODE AS speciesCat,
  -(FE.FE_START_LONGITUDE_DEGREE + FE_START_LONGITUDE_MINUTE/60) AS long,
  FE.FE_START_LATTITUDE_DEGREE + FE.FE_START_LATTITUDE_MINUTE/60 AS lat,
  U.USABILITY_CODE AS iphcUsabilityCode,
  USABILITY_DESC AS iphcUsabilityDesc
  
FROM FISHING_EVENT FE
	INNER JOIN TRIP T ON FE.TRIP_ID = T.TRIP_ID 
	INNER JOIN TRIP_SURVEY TS ON TS.TRIP_ID = T.TRIP_ID
	INNER JOIN SURVEY S ON S.SURVEY_ID = TS.SURVEY_ID
	INNER JOIN FISHING_EVENT_CATCH FEC ON FEC.FISHING_EVENT_ID = FE.FISHING_EVENT_ID AND FEC.TRIP_ID = T.TRIP_ID
	INNER JOIN CATCH C ON C.CATCH_ID = FEC.CATCH_ID
	INNER JOIN LONGLINE_SPECS LGLSP ON LGLSP.FISHING_EVENT_ID = FE.FISHING_EVENT_ID
	INNER JOIN IPHC_EFFECTIVE_SKATE ES ON ES.FISHING_EVENT_ID = FE.FISHING_EVENT_ID
	INNER JOIN USABILITY U ON U.USABILITY_CODE = LGLSP.USABILITY_CODE
	INNER JOIN SPECIES SP ON SP.SPECIES_CODE = C.SPECIES_CODE
	
WHERE SURVEY_SERIES_ID = '14' AND FE_PARENT_EVENT_ID IS NULL

-- insert species here

ORDER BY year, T.TRIP_ID, FE.FISHING_EVENT_ID

