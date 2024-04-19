
--Creating a new database--
use [Bank Loan DB];


select * from bank_loan_data;


--Finding out the total loan applications--
select COUNT(id) as Total_Loan_Applications from bank_loan_data;


--Finding out the total loan applications for last month--
select COUNT(id) as Total_Loan_Applications from bank_loan_data 
    where month(issue_date) = 12 and year(issue_date) = 2021;


--Finding out the total loan applications for 2nd last month--
select COUNT(id) as PMTD_Total_Loan_Applications from bank_loan_data 
    where month(issue_date) = 11 and year(issue_date) = 2021;


--Finding out the total amount of loan given by the bank--
select sum(loan_amount) as Total_Funded_Amount from bank_loan_data;


--Finding out the total amount of loan given by the bank for last month--
select sum(loan_amount) as MTD_Total_Funded_Amount from bank_loan_data 
    where month(issue_date) = 12 and year(issue_date) = 2021;


--Finding out the total amount of loan given by the bank for 2nd last month--
select sum(loan_amount) as PMTD_Total_Funded_Amount from bank_loan_data 
    where month(issue_date) = 11 and year(issue_date) = 2021;


--Finding out the total amount of loan received back by the bank--
select sum(total_payment) as Total_Received_Amount from bank_loan_data;


--Finding out the total amount of loan received back by the bank for last month--
select sum(total_payment) as MTD_Total_Received_Amount from bank_loan_data 
   where month(issue_date) = 12 and year(issue_date) = 2021;


--Finding out the total amount of loan received back by the bank for 2nd last month--
select sum(total_payment) as PMTD_Total_Received_Amount from bank_loan_data 
    where month(issue_date) = 11 and year(issue_date) = 2021;


--Finding out the average rate of interest--
select round(avg(int_rate), 4) * 100 as Average_Interest_Rate from bank_loan_data;


--Finding out the average rate of interest for the last month--
select round(avg(int_rate), 4) * 100 as MTD_Average_Interest_Rate from bank_loan_data 
    where month(issue_date) = 12 and year(issue_date) = 2021;


--Finding out the average rate of interest for the 2nd last month--
select round(avg(int_rate), 4) * 100 as PMTD_Average_Interest_Rate from bank_loan_data 
    where month(issue_date) = 11 and year(issue_date) = 2021;


--Finding out the average DTI(Debt to Income Ratio)--
select round(avg(dti), 4) * 100 as Average_DTI from bank_loan_data;


--Finding out the average DTI(Debt to Income Ratio) for the last month--
select round(avg(dti), 4) * 100 as MTD_Average_DTI from bank_loan_data 
    where month(issue_date) = 12 and year(issue_date) = 2021;


--Finding out the average DTI(Debt to Income Ratio) for the 2nd last month--
select round(avg(dti), 4) * 100 as PMTD_Average_DTI from bank_loan_data 
    where month(issue_date) = 11 and year(issue_date) = 2021;


--Finding the percentge of good loans--
select 
    (count(case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end) * 100)
     /
    count(id) as Good_Loan_Percentage
from bank_loan_data;


--Finding the percentge of bad loans--
select 
    (count(case when loan_status = 'Charged Off' then id end) * 100)
     /
    count(id) as Bad_Loan_Percentage
from bank_loan_data;


--Finding the total no. of good loans--
select count(id) as Good_Loan_Applications from bank_loan_data 
    where loan_status = 'Fully Paid' or loan_status = 'Current';


--Finding the total no. of bad loans--
select count(id) as Bad_Loans_Applications from bank_loan_data 
    where loan_status = 'Charged Off';


--Finding the total amount given out by the bank for good loans--
select sum(loan_amount) as Good_Loan_Funded_Amount from bank_loan_data 
    where loan_status = 'Fully Paid' or loan_status = 'Current';


--Finding the total amount given out by the bank for bad loans--
select sum(loan_amount) as Bad_Loan_Funded_Amount from bank_loan_data 
    where loan_status = 'Charged Off';


--Finding the total amount received back by the bank for good loans--
select sum(total_payment) as Good_Loan_Received_Amount from bank_loan_data 
    where loan_status = 'Fully Paid' or loan_status = 'Current';


--Finding the total amount received back by the bank for bad loans--
select sum(total_payment) as Bad_Loan_Received_Amount from bank_loan_data 
    where loan_status = 'Charged Off';


--Finding out the loan details grouped by loan status--
Select
    loan_status,
	  count(id) as Loan_Count,
	  sum(total_payment) as Total_Amount_Received,
	  sum(loan_amount) as Total_Funded_Amount,
	  round(avg(int_rate * 100), 2) as Interest_Rate,
	  round(avg(dti * 100), 2) as DTI_Rate
From
    bank_loan_data
group by
    loan_status;


--Finding out the total amount the payment given out & received back by the bank for the last month grouped by the loan status--
select
    loan_status,
	  sum(total_payment) as MTD_Total_Amount_Received,
	  sum(loan_amount) as MTD_Total_Funded_Amount
From
    bank_loan_data
where
    month(issue_date) = 12
group by
    loan_status;


--Finding out the loans details month wise--
select
    month(issue_date) as Month_Number,
    datename(month, issue_date)as Month_Name,
    count(id) as Total_Loan_Applications,
    sum(total_payment) as PMTD_Total_Amount_Received,
    sum(loan_amount) as PMTD_Total_Funded_Amount
From
    bank_loan_data
group by
    month(issue_date), datename(month, issue_date)
order by
    month(issue_date);


--Finding out the loans details region wise--
select
    address_state,
	count(id) as Total_Loan_Applications,
	sum(total_payment) as Total_Amount_Received,
	sum(loan_amount) as Total_Funded_Amount
From
    bank_loan_data
group by
    address_state
order by
    sum(loan_amount) desc;


--Finding out the loans details term wise--
select
    term,
	  count(id) as Total_Loan_Applications,
	  sum(total_payment) as Total_Amount_Received,
	  sum(loan_amount) as Total_Funded_Amount
From
    bank_loan_data
group by
    term
order by
    term;


--Finding out the loans details Emp_lengh wise--
select
    emp_length,
	  count(id) as Total_Loan_Applications,
	  sum(total_payment) as Total_Amount_Received,
	  sum(loan_amount) as Total_Funded_Amount
From
    bank_loan_data
group by
    emp_length
order by
    emp_length;


--Finding out the loans details grouped by loan purpose--
select
    purpose,
	  count(id) as Total_Loan_Applications,
	  sum(total_payment) as Total_Amount_Received,
	  sum(loan_amount) as Total_Funded_Amount
From
    bank_loan_data
group by
    purpose
order by
    count(id) desc;


--Finding out the loans details home_onwership wise--
select
    home_ownership,
	  count(id) as Total_Loan_Applications,
	  sum(total_payment) as Total_Amount_Received,
	  sum(loan_amount) as Total_Funded_Amount
From
    bank_loan_data
group by
    home_ownership
order by
    count(id) desc;

