<?php

print "ETL Staring<br>";

try{
	$con = new PDO("mysql:host=localhost;dbname=nobrainers","nobrainers", "sesame");
	$con->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
}catch(PDOException $ex) {
	echo 'connection failed1';
	echo 'ERROR: '.$ex->getMessage();
}catch(Exception $ex) {
	echo 'connection failed2';
	echo 'ERROR: '.$ex->getMessage();
}

$query = "insert into nobrainers_analytical.product(productkey,productid,productname,productprice,productcategory,productcertification) 
		  select null,ProductID,Name,Price,CategoryID,Certification from nobrainers.product 
		  on duplicate key UPDATE productname=Name,productprice=Price,productcategory=CategoryID,productcertification=Certification";

$ps = $con->prepare($query);
$ps->execute();

print "product loaded<br>";


$query = "insert into nobrainers_analytical.farmer(farmerkey,farmerid,farmerfirstname,farmerlastname,farmeremail,farmerpassword,farmeraptnum,farmerstreet,farmercity,farmerstate,farmercountry,farmerzip)
		  select null,FarmerID,FirstName,LastName,Email,Password,AptNum,StreetName,City,State,Country,Zip from nobrainers.farmer
		  on duplicate key UPDATE farmerfirstname=FirstName,farmerlastname=LastName,farmeremail=Email,farmerpassword=Password,farmeraptnum=AptNum,farmerstreet=StreetName,farmercity=City,farmerstate=State,farmercountry=Country,farmerzip=Zip";

$ps = $con->prepare($query);
$ps->execute();

print "farmer loaded<br>";


$query = "insert into nobrainers_analytical.customer(customerkey,customerid,customerfirstname,customerlastname,customeremail,customerpassword,customerstreet,customeraptnum,customercity,customerstate,customerzip,customercountry)
		  select null,CustomerID,FirstName,LastName,Email,Password,StreetName,AptNum,City,State,Zip,Country from nobrainers.customer
		  on duplicate key UPDATE customerfirstname=FirstName,customerlastname=LastName,customeremail=Email,customerpassword=Password,customeraptnum=AptNum,customerstreet=StreetName,customercity=City,customerstate=State,customercountry=Country,customerzip=Zip";

$ps = $con->prepare($query);
$ps->execute();

print "customer loaded<br>";

$query = "drop procedure if exists nobrainers_analytical.LoadCalendar";
$ps = $con->prepare($query);
$ps->execute();

$query = "create procedure nobrainers_analytical.fillDates(dateStart DATE, dateEnd DATE)
  begin
    while dateStart <= dateEnd do
      insert ignore into nobrainers_analytical.calendar (calendarkey, date, month, quarter, dayofweek, year)
      values (null, dateStart, month(dateStart), quarter(dateStart), dayofweek(dateStart), year(dateStart));
      set dateStart = date_add(dateStart, interval 1 day);
    end while;
  end;";
$ps = $con->prepare($query);
$ps->execute();


$now = new DateTime();
$today = $now->format('Y-m-d');
$query = "call nobrainers_analytical.fillDates('2015-01-01','$today')";
$ps = $con->prepare($query);
$ps->execute();


print "calendar loaded<br>";
