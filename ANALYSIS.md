## Analysis of Russian Losses Database

The question I seek to answer in Milestone 3 is:  
###### Does the amount of personal loss sustained by Russia vary with the seasons e.g. summer more losses than winter?

### SQL Query
```sql
SELECT n.month, AVG(n.per_day_loss) AS avg_pd_loss_during_months
FROM (SELECT pl.day,
		pl.personnel - LAG(pl.personnel) OVER (ORDER BY pl.day) AS per_day_loss,
		LEFT(rwt.date, LOCATE('/', rwt.date) - 1) AS month
	FROM personnel_loss pl
    JOIN rus_war_timeline rwt
	ON pl.day = rwt.day
    ) AS n
GROUP BY n.month
ORDER BY avg_pd_loss_during_months DESC;
```
### Result
<img width="181" alt="image" src="https://github.com/KirstenMayland/cs61databases/assets/102620915/95c5c854-bda5-4cdf-93c7-14a96dd38bec">  

### Analysis
According to the data, the average amount of personnel lost per day in each month goes as follows in decreasing order:  
Feb, Jan, March, Nov, Dec, Jun, Nov, May, April, Sept, July, Aug
