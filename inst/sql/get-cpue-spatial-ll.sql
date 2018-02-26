SELECT
	YEAR(GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.BEST_DATE) AS YEAR,
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.FISHERY_SECTOR,
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.VESSEL_REGISTRATION_NUMBER,
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.GEAR,
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.TRIP_ID,  
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.FISHING_EVENT_ID,
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.LAT,
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.LON,
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.SPECIES_CODE,
	SP.SPECIES_SCIENTIFIC_NAME,
	SP.SPECIES_COMMON_NAME,
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.LANDED_ROUND_KG AS cpue,
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.SUBLEGAL_RELEASED_COUNT + GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.LEGAL_RELEASED_COUNT AS RELEASED_PCS,
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.MAJOR_STAT_AREA_CODE
FROM     
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH INNER JOIN
    GFFOS.dbo.SPECIES SP ON GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.SPECIES_CODE = SP.SPECIES_CODE 
GROUP BY 
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.GEAR, GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.BEST_DATE,
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.FISHERY_SECTOR, 
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.VESSEL_REGISTRATION_NUMBER,
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.TRIP_ID,
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.FISHING_EVENT_ID,
    GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.LAT,
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.LON, 
    SP.SPECIES_SCIENTIFIC_NAME,
	SP.SPECIES_COMMON_NAME, 
    GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.SUBLEGAL_RELEASED_COUNT + GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.LEGAL_RELEASED_COUNT,
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.LANDED_ROUND_KG,
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.SPECIES_CODE,
	SP.SPECIES_CODE,
	GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.MAJOR_STAT_AREA_CODE

	
HAVING 
	(GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.GEAR IN ('HOOK AND LINE','LONGLINE','LONGLINE OR HOOK AND LINE')) AND 
    (GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.LAT IS NOT NULL) AND 
	(GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.LON IS NOT NULL) AND 
	YEAR(GFFOS.dbo.GF_D_OFFICIAL_FE_CATCH.BEST_DATE) >= 2008
-- insert species here
ORDER BY 
	YEAR,
	TRIP_ID,
	FISHING_EVENT_ID
