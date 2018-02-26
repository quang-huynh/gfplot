SELECT TRIP_START_DATE,
  GEAR_CODE AS GEAR,
  YEAR(TRIP_START_DATE) AS YEAR,
  S.SURVEY_SERIES_ID,
  S.SURVEY_ID,
  SM.MAJOR_STAT_AREA_CODE,
  SM.MINOR_STAT_AREA_CODE,
  SP.SPECIMEN_ID,
  SM.SAMPLE_ID,
  SPECIMEN_SEX_CODE AS SEX,
  SPECIMEN_AGE AS AGE,
  SP.AGEING_METHOD_CODE AS AGEING_METHOD,
  CAST(ROUND(Best_Length / 10.0, 1) AS DECIMAL(8,1)) AS LENGTH,
  SP.MATURITY_CODE,
  SM.MATURITY_CONVENTION_CODE,
  MC.MATURITY_CONVENTION_DESC,
  MC.MATURITY_CONVENTION_MAXVALUE,
  ROUND_WEIGHT AS WEIGHT,
  SM.SPECIES_CODE, 
  SPP.SPECIES_COMMON_NAME, 
  SPP.SPECIES_SCIENCE_NAME,
  SM.SPECIES_CATEGORY_CODE,
  SM.SAMPLE_TYPE_CODE,
  SM.SAMPLE_SOURCE_CODE,
  TRIP_SUB_TYPE_CODE,
  G.GROUPING_CODE,
  G.GROUPING_DESC,
  G.AREA_KM2,
  CASE (CASE SM.GEAR_CODE WHEN 1 THEN TRSP.USABILITY_CODE
    WHEN 6 THEN TRSP.USABILITY_CODE
	WHEN 8 THEN TRSP.USABILITY_CODE
	WHEN 11 THEN TRSP.USABILITY_CODE
	WHEN 14 THEN TRSP.USABILITY_CODE
	WHEN 16 THEN TRSP.USABILITY_CODE
    WHEN 2 THEN TPSP.USABILITY_CODE
	WHEN 4 THEN LLSP.USABILITY_CODE
	WHEN 5 THEN LLSP.USABILITY_CODE
	WHEN 7 THEN LLSP.USABILITY_CODE
	WHEN 10 THEN LLSP.USABILITY_CODE
	WHEN 12 THEN LLSP.USABILITY_CODE
	ELSE 0 END) 
	WHEN 0 THEN 1 
	WHEN 1 THEN 1 
	WHEN 2 THEN 1
	WHEN 6 THEN 1
	ELSE 0 END AS USABILITY
FROM GFBioSQL.dbo.SURVEY S
  INNER JOIN GFBioSQL.dbo.TRIP_SURVEY TS ON
  S.SURVEY_ID = TS.SURVEY_ID
  INNER JOIN GFBioSQL.dbo.B21_Samples SM ON TS.TRIP_ID = SM.TRIP_ID
  INNER JOIN GFBioSQL.dbo.B22_Specimens SP ON SM.SAMPLE_ID = SP.SAMPLE_ID
  INNER JOIN GFBioSQL.dbo.SPECIES SPP ON SPP.SPECIES_CODE = SM.SPECIES_CODE
  INNER JOIN GFBioSQL.dbo.Maturity_Convention MC ON
    SM.MATURITY_CONVENTION_CODE = MC.MATURITY_CONVENTION_CODE
  LEFT JOIN GFBioSQL.dbo.GROUPING AS G ON G.GROUPING_CODE = SM.GROUPING_CODE
  LEFT OUTER JOIN GFBioSQL.dbo.TRAWL_SPECS AS TRSP ON SM.FISHING_EVENT_ID = TRSP.FISHING_EVENT_ID
  LEFT OUTER JOIN GFBioSQL.dbo.LONGLINE_SPECS AS LLSP ON SM.FISHING_EVENT_ID = LLSP.FISHING_EVENT_ID
  LEFT OUTER JOIN GFBioSQL.dbo.TRAP_SPECS AS TPSP ON SM.FISHING_EVENT_ID = TPSP.FISHING_EVENT_ID
WHERE TRIP_SUB_TYPE_CODE IN (2, 3) AND
  SAMPLE_TYPE_CODE IN (1,2) AND
  SPECIES_CATEGORY_CODE IN (1, 5, 6, 7) AND
  (SAMPLE_SOURCE_CODE IS NULL OR
  SAMPLE_SOURCE_CODE = 1)
-- insert species here
-- insert ssid here
ORDER BY SPECIES_CATEGORY_CODE, SAMPLE_SOURCE_CODE, SURVEY_SERIES_ID--, GEAR_CODE, TRIP_START_DATE

