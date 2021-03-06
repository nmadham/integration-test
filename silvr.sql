SELECT DISTINCT 
 ULM.ULM_NO policy_number
,ULM.ULM_CFIRST_NAME FIRST_NAME
,ULM.ULM_CMIDDLE_NAME MIDDLE_NAME
,ULM.ULM_CLAST_NAME LAST_NAME
,ULM.ULM_CADDR_1 street_address
,ULM.ULM_CPIN_CODE zipcode
,ULM.ULM_CCITY city
,ULM.ULM_CSTATE "STATE"
,ULM.ULM_PRV_INSURED_YN "Prior Insurance (Y/N)"
,RDRV.ULRD_SEX "Gender"
,RDRV.ULRD_MARI_STAT "Marital Status"
,ULM.ULM_PD_FUL_DISC_YN "Paid in Full (Y/N)"
,ULM.ULM_INSR_HO_YN "Homeowner (Y/N)"
,RDRV.ULRD_DOB "Date of Birth"
,RDRV.ULRD_LCN_NO "License Number"
,RDRV.ULRD_LIC_STATE "License State"
,RDRV.ULRD_LCN_STD "License Start Date"

,ULR.ULR_ID "VEC NUMBER ON POLICY"
,ULR.ULR_FLEX_01 "MODEL YR"
,ULR.ULR_FLEX_02 "VEC COMPANY"
,ULR.ULR_FLEX_03 "VEC MODEL"
,ULR.ULR_FLEX_04 "VEC VIN"
,ULCS_ULC_MST_ID
,ULCS_SI
,ULRV.ULRDV_POINTS "DRIVER POINTS"
,(SELECT DISTINCT UDV.UDV_ACC_VIO_DESC FROM UDS_DRV_VIOLATION UDV WHERE UDV_ACC_VIO_ID=ULRDV_VIOLATION_ID) "VIOLATION DESC"


--,r.*
--,rdrv.*
--,ulm.*

FROM UPDS_LEVEL_M ULM

JOIN UPDS_LEVEL_R ULR
ON ULM_SGS_ID=ULR_ULM_SGS_ID
--
LEFT JOIN UPDS_LEVEL_RDRV RDRV
ON ULM_SGS_ID=ULRD_ULM_SGS_ID
--
LEFT JOIN UPDS_LEVEL_RDRV_VIO ULRV
ON ULRDV_ULRD_ID=ULRD_ID
AND ULRDV_ULR_ID=ULR_ID
AND ULRDV_ULM_SGS_ID=ULM_SGS_ID

JOIN UPDS_LEVEL_CS ULCS
ON ULCS_ULM_SGS_ID=ULM_SGS_ID
AND ULCS.ULCS_ULR_ID=ULR.ULR_ID
WHERE 
RDRV.ULRD_ULR_ID='*' AND ULCS.ULCS_ULC_MST_ID!='*'
--AND ULRDV_ULR_ID='*'
AND  ULM.ULM_SGS_ID=31363

ORDER BY ULM.ULM_NO ASC,FIRST_NAME


;
