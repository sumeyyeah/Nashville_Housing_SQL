/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [PortfolioProject].[dbo].[Nashville_Housing ]

 select SaleDate, CONVERT(Date,SaleDate) as Saledate
	from [PortfolioProject].[dbo].[Nashville_Housing ]

	SELECT * FROM [PortfolioProject].[dbo].[Nashville_Housing ]
	order by ParcelID;

 

 update a
 set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
 from [PortfolioProject].[dbo].[Nashville_Housing ] a
 join [PortfolioProject].[dbo].[Nashville_Housing ] b
 on a.ParcelID = b.ParcelID
 and a.UniqueID <> b.UniqueID
 where a.PropertyAddress is null

 SELECT PropertyAddress FROM [PortfolioProject].[dbo].[Nashville_Housing ]

 select
 SUBSTRING(PropertyAddress, 1, charindex(',',PropertyAddress) -1) as Address,
 SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress)) as Address
 from [PortfolioProject].[dbo].[Nashville_Housing ] 


alter table Nashville_Housing
Add PropertySplitAddress varchar(255)

update [PortfolioProject].[dbo].[Nashville_Housing ] 
set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, charindex(',',PropertyAddress) -1) 

alter table Nashville_Housing
Add PropertySplitCity varchar(255)

update [PortfolioProject].[dbo].[Nashville_Housing ] 
set PropertySplitCity = SUBSTRING(PropertyAddress, charindex(',',PropertyAddress) +1, LEN(PropertyAddress) )

select
PARSENAME(replace(OwnerAddress,',','.'),3),
PARSENAME(replace(OwnerAddress,',','.'),2),
PARSENAME(replace(OwnerAddress,',','.'),1)
from [PortfolioProject].[dbo].[Nashville_Housing ]; 

alter table [PortfolioProject].[dbo].[Nashville_Housing ] 
Add OwnerSplitAddress varchar(255)

update [PortfolioProject].[dbo].[Nashville_Housing ] 
set OwnerSplitAddress = PARSENAME(replace(OwnerAddress,',','.'),3)

alter table [PortfolioProject].[dbo].[Nashville_Housing ] 
Add OwnerSplitCity varchar(255)

update [PortfolioProject].[dbo].[Nashville_Housing ] 
set OwnerSplitCity = PARSENAME(replace(OwnerAddress,',','.'),2)

alter table [PortfolioProject].[dbo].[Nashville_Housing ] 
Add OwnerSplitState varchar(255)

update [PortfolioProject].[dbo].[Nashville_Housing ] 
set OwnerSplitState = PARSENAME(replace(OwnerAddress,',','.'),1)

select SoldAsVacant from [PortfolioProject].[dbo].[Nashville_Housing ]

select distinct(SoldAsVacant), count(SoldAsVacant) 
from [PortfolioProject].[dbo].[Nashville_Housing ]
group by SoldAsVacant
order by 2

select SoldAsVacant,
case when SoldAsVacant = 'Y' then 'Yes'
	 when SoldAsVacant = 'N' then 'No'
	 else SoldAsVacant
	 end
from [PortfolioProject].[dbo].[Nashville_Housing ]

update [PortfolioProject].[dbo].[Nashville_Housing ]
set SoldAsVacant = case when SoldAsVacant = 'Y' then 'Yes'
	 when SoldAsVacant = 'N' then 'No'
	 else SoldAsVacant
	 end


--Remove Duplicates

with RowNumCTE as (
select *,
	row_number() over(
	partition by ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 order by
				 UniqueID
				 ) row_num

from  [PortfolioProject].[dbo].[Nashville_Housing ]
)
select * from RowNumCTE
where row_num>1
order by PropertyAddress

SELECT *
  FROM [PortfolioProject].[dbo].[Nashville_Housing ]

alter table [PortfolioProject].[dbo].[Nashville_Housing ]
drop column OwnerAddress,TaxDistrict,PropertyAddress,Acreage

select Acreage,round(Acreage,2) from [PortfolioProject].[dbo].[Nashville_Housing ]


alter table [PortfolioProject].[dbo].[Nashville_Housing ] 
add acre float

update [PortfolioProject].[dbo].[Nashville_Housing ] 
set acre = round(Acreage,2)

alter table [PortfolioProject].[dbo].[Nashville_Housing ] 
drop column Acreage







