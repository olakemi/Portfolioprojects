/*
Cleaning Data in SQL Queries
*/


Select *
From Nashville_Housing


--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format

Select saleDate
From Nashville_Housing



Select saleDateConverted, TO_DATE(Date,SaleDate)
From Nashville_Housing


Update Nashville_Housing
SET SaleDate = TO_DATE(Date,SaleDate)

-- If it doesn't Update properly

ALTER TABLE Nashville_Housing
Add SaleDateConverted Date;

Update Nashville_Housing
SET SaleDateConverted = TO_DATE(Date,SaleDate)










 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

Select *
From Nashville_Housing
--Where PropertyAddress is nulL
order by ParcelID

----checking for nulls
Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, NVL(a.PropertyAddress,b.PropertyAddress)
From Nashville_Housing a
JOIN Nashville_Housing b
	on a.ParcelID = b.ParcelID
	AND a.UniqueID_  <> b.UniqueID_ 
Where a.PropertyAddress is null


select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
     , coalesce(a.PropertyAddress, b.PropertyAddress)
from Nashville_Housing a
join Nashville_Housing b
on a.ParcelID = b.ParcelID
where a.PropertyAddress is null
AND a.UniqueID_  <> b.UniqueID_ 

----updating nulls with duplicate info on the same table
--MERGE INTO Nashville_Housing ar
--USING Nashville_Housing br
--ON (
   -- ar.parcelid = br.parcelid
--AND ar.uniqueid_ <> br.uniqueid_
-)
--WHEN MATCHED THEN
 -- UPDATE
  --SET    propertyaddress = br.propertyaddress
  --WHERE  ar.propertyaddress IS NULL;
  
  
  UPDATE Nashville_Housing dst
SET propertyaddress = (
  SELECT src.propertyaddress
  FROM   Nashville_Housing src
  WHERE  dst.parcelid = src.parcelid
  AND    dst.uniqueid_ <> src.uniqueid_
  AND    src.propertyaddress IS NOT NULL
  AND    ROWNUM = 1
)
WHERE propertyaddress IS NULL
--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)


Select PropertyAddress 
From Nashville_Housing
--Where PropertyAddress is null
--order by ParcelID

----EXTRACTING THE FIRST COLUMN
SELECT PropertyAddress,
SUBSTR(PropertyAddress, 1, INSTR(PropertyAddress, ',')) as Address
From Nashville_Housing


---CHECKING FOR THE POSITION OF THE ','
SELECT PropertyAddress,
SUBSTR(PropertyAddress, 1, INSTR(PropertyAddress, ',')) as Address,
INSTR(PropertyAddress, ',')
From Nashville_Housing

---EXTRACTING AND SPLITTING THE FIRST & SECOND COLUMNS
SELECT PropertyAddress,
SUBSTR(PropertyAddress , 1, INSTR( PropertyAddress, ',') -1 ) as Address
, SUBSTR(PropertyAddress, INSTR(PropertyAddress, ',') + 1 , LENGTH(PropertyAddress)) as Address
From Nashville_Housing



---ADDING NEW COLOUMNS
ALTER TABLE Nashville_Housing
Add PropertySplitAddress varchar2(255);

ALTER TABLE Nashville_Housing
Add PropertySplitCity varchar2(255);

----UPDATING ROWS FOR THE NEW COLUMNS CREATED

Update Nashville_Housing
SET PropertySplitAddress = SUBSTR(PropertyAddress, 1, INSTR( PropertyAddress, ',') -1 )

Update Nashville_Housing
SET PropertySplitCity = SUBSTR(PropertyAddress, INSTR(PropertyAddress, ',') + 1 , LENGTH(PropertyAddress))




Select *
From Nashville_Housing





Select OwnerAddress
From Nashville_Housing

SELECT OwnerAddress,
REGEXP_SUBSTR(OwnerAddress, '[^,]+') as OwnerSplitAddress,
REGEXP_SUBSTR(OwnerAddress, 'G[^,]+' ) as OwnerSplitCity,
REGEXP_SUBSTR(OwnerAddress,'[^,]+$') as OwnerSplitState             
             
From Nashville_Housing
  




ALTER TABLE Nashville_Housing
Add OwnerSplitAddress varchar2(255);

Update Nashville_Housing
SET OwnerSplitAddress = REGEXP_SUBSTR(OwnerAddress, '[^,]+') 


ALTER TABLE Nashville_Housing
Add OwnerSplitCity varchar2(255);

Update Nashville_Housing
SET OwnerSplitCity = REGEXP_SUBSTR(OwnerAddress, 'G[^,]+' ) 



ALTER TABLE Nashville_Housing
Add OwnerSplitState varchar2(255);

Update Nashville_Housing
SET OwnerSplitState = REGEXP_SUBSTR(OwnerAddress,'[^,]+$') 



Select *
From Nashville_Housing




--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From Nashville_Housing
Group by SoldAsVacant
order by 2


----Using search case expression

Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From Nashville_Housing


Update Nashville_Housing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END






-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

----use Common Table Expression (CTE)(which is a window function or sql function) to find duplicates


--sTEP 1:
Select a.*,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID_
					) row_num

From Nashville_Housing a
order by ParcelID



---STEP 2 ADD THE CTE

WITH RowNumCTE AS(
Select a.*,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID_
					) row_num

From Nashville_Housing a
--order by ParcelID
)

----step 3, add the select statement
WITH RowNumCTE AS(
Select a.*,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID_
					) row_num

From Nashville_Housing a
--order by ParcelID
)
Select *
From RowNumCTE
--Where row_num > 1
---Order by PropertyAddress


----Step 3, add the where keyword to check for duplicates.

WITH RowNumCTE AS(
Select a.*,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID_
					) row_num

From Nashville_Housing a
--order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress


----Removing duplicates using ROWID, ROWNUMBER() AND CTE (ANALYTIC FUNCTION)

DELETE FROM Nashville_Housing a
WHERE a.ROWID IN
 (SELECT ROWID FROM
   (SELECT
    ROWID,
    ROW_NUMBER() OVER
    (PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
                 ORDER BY ROWID) row_num
    FROM Nashville_Housing a)
  WHERE row_num > 1)





Select *
From NashvilleHousing




---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns



Select *
From Nashville_Housing


ALTER TABLE Nashville_Housing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate















-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--- Importing Data using OPENROWSET and BULK INSERT	

--  More advanced and looks cooler, but have to configure server appropriately to do correctly
--  Wanted to provide this in case you wanted to try it


--sp_configure 'show advanced options', 1;
--RECONFIGURE;
--GO
--sp_configure 'Ad Hoc Distributed Queries', 1;
--RECONFIGURE;
--GO


--USE PortfolioProject 

--GO 

--EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1 

--GO 

--EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1 

--GO 


---- Using BULK INSERT

--USE PortfolioProject;
--GO
--BULK INSERT nashvilleHousing FROM 'C:\Temp\SQL Server Management Studio\Nashville Housing Data for Data Cleaning Project.csv'
--   WITH (
--      FIELDTERMINATOR = ',',
--      ROWTERMINATOR = '\n'
--);
--GO


---- Using OPENROWSET
--USE PortfolioProject;
--GO
--SELECT * INTO nashvilleHousing
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
--    'Excel 12.0; Database=C:\Users\alexf\OneDrive\Documents\SQL Server Management Studio\Nashville Housing Data for Data Cleaning Project.csv', [Sheet1$]);
--GO















