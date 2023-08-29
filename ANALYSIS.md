## Analysis of `russia_losses` Database
- [README.md](README.md)
- [DESIGN.md](DESIGN.md)
- [IMPLEMENTATION.md](IMPLEMENTATION.md)
- [ANALYSIS.md](ANALYSIS.md)
- [FRONTEND.md](FRONTEND.md)

#### Questions The Dataset Is Capable Of Answering
1) Does the amount of personal loss sustained by Russia vary with the seasons e.g. summer more losses than winter?
2) Which day in the war so far has resulted in the greatest loss in Russian lives?
3) Did the type of equipment sustaining the most losses change from the first month to this last month?
4) Is there a correlation between POW's taken and losses of aircrafts, helicopters, or tanks?


### SQL Query #1
##### Does the amount of personal loss sustained by Russia vary with the seasons e.g. summer more losses than winter?

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
According to the data, the months with the greatest average personnel lost per day goes as follows in decreasing order, ranging from 845 to 228 personnel lost per day:  
##### --most-- Feb (w), Jan (w), March (s), Nov (f), Dec (w), Jun (x), Nov (f), May (s), April (s), Sept (f), July (x), Aug (x) --least--
^ (seasons determined according to the meterological calendar)  

Therefore, to answer our question above, there exists a trend where more personnel are lost during the winter months (and months closest to the winter) as opposed to the summer months (and months closest to the summer). More analysis would be needed in the future to determine whether this finding is statistically significant, but as now, the trend is strong enough to be immediately apparent.

*Yes, the amount of Russian personnel losses appears to vary with the season, with more losses being concentrated in the winter as opposed to the summer.*

### SQL Query #2
##### Which day in the war so far has resulted in the greatest loss in Russian lives?
```sql
```
### Results
### Analysis

### SQL Query #3
##### Did the type of equipment sustaining the most losses change from the first month to this last month?
```sql
```
### Results
### Analysis

### SQL Query #4
##### Is there a correlation between POW's taken and losses of aircrafts, helicopters, or tanks?
```sql
```
### Results
### Analysis
