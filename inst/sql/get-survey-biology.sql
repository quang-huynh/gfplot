SELECT TRIP_START_DATE,
  S.SURVEY_SERIES_ID,
  S.SURVEY_ID,
  SP.SPECIMEN_ID,
  SPECIMEN_SEX_CODE AS SEX,
  SPECIMEN_AGE AS AGE,
  CAST(ROUND(Best_Length / 10.0, 1) AS DECIMAL(8,1)) AS LENGTH,
  MATURITY_CODE,
  MATURITY_CONVENTION_DESC,
  MATURITY_CONVENTION_MAXVALUE,
  ROUND_WEIGHT AS WEIGHT,
  SM.SPECIES_CODE, SPP.SPECIES_COMMON_NAME, SPP.SPECIES_SCIENCE_NAME,
  SM.SPECIES_CATEGORY_CODE,
  TRIP_SUB_TYPE_CODE,
  G.GROUPING_CODE,
  G.GROUPING_DESC
FROM GFBioSQL.dbo.SURVEY S
  INNER JOIN GFBioSQL.dbo.SURVEY_GROUPING SG ON S.SURVEY_ID = SG.SURVEY_ID
  INNER JOIN GFBioSQL.dbo.FISHING_EVENT_GROUPING FEG ON SG.GROUPING_CODE = FEG.GROUPING_CODE
  INNER JOIN GFBioSQL.dbo.B21_Samples SM ON FEG.FISHING_EVENT_ID = SM.FISHING_EVENT_ID
  INNER JOIN GFBioSQL.dbo.TRIP_SURVEY TS ON S.SURVEY_ID = TS.SURVEY_ID
  INNER JOIN GFBioSQL.dbo.FISHING_EVENT FE ON 
    TS.TRIP_ID = FE.TRIP_ID AND FE.FISHING_EVENT_ID = SM.FISHING_EVENT_ID
  INNER JOIN GFBioSQL.dbo.B22_Specimens SP ON SM.SAMPLE_ID = SP.SAMPLE_ID
  INNER JOIN GFBioSQL.dbo.SPECIES SPP ON SPP.SPECIES_CODE = SM.SPECIES_CODE
  INNER JOIN GFBioSQL.dbo.Maturity_Convention MC ON 
    SM.MATURITY_CONVENTION_CODE = MC.MATURITY_CONVENTION_CODE
  INNER JOIN        GFBioSQL.dbo.GROUPING AS G ON SG.GROUPING_CODE = G.GROUPING_CODE
WHERE SPECIMEN_SEX_CODE IN (1, 2) AND TRIP_SUB_TYPE_CODE IN (2, 3) AND (FE.FE_PARENT_EVENT_ID IS NULL) AND (SM.SPECIES_CODE = '437' OR
                  SM.SPECIES_CODE = '442')
ORDER BY SM.SPECIES_CODE, S.SURVEY_SERIES_ID, TRIP_START_DATE
