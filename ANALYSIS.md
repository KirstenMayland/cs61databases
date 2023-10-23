## Analysis of 'russia_losses' Database
- [README.md](README.md)
- [DESIGN.md](DESIGN.md)
- [IMPLEMENTATION.md](IMPLEMENTATION.md)
- [ANALYSIS.md](ANALYSIS.md)
- [FRONTEND.md](FRONTEND.md)

#### Questions The Dataset Is Capable Of Answering
1) Does the amount of personal loss sustained by Russia vary with the seasons e.g. summer more losses than winter?
2) Which dates have resulted in the top 10 greatest losses in Russian armored personal carriers (APC) in the war thus far?
3) What areas have seen the heaviest losses of vehicles and fuel tanks?

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
<img width="181" alt="Screenshot 2023-08-15 104229" src="https://github.com/KirstenMayland/cs61databases/assets/102620915/68777bc8-0b7e-45e3-8609-5245150fbae4">

### Analysis
According to the data, the months with the greatest average personnel lost per day goes as follows in decreasing order, ranging from 845 to 228 personnel lost per day:  
##### --most-- Feb (w), Jan (w), March (s), Nov (f), Dec (w), Jun (x), Nov (f), May (s), April (s), Sept (f), July (x), Aug (x) --least--
^ (seasons determined according to the meterological calendar)  

Therefore, to answer our question above, there exists a trend where more personnel are lost during the winter months (and months closest to the winter) as opposed to the summer months (and months closest to the summer). More analysis would be needed in the future to determine whether this finding is statistically significant, but as now, the trend is strong enough to be immediately apparent.

*Yes, the amount of Russian personnel losses appears to vary with the season, with more losses being concentrated in the winter as opposed to the summer.*

### SQL Query #2
##### Which dates have resulted in the top 10 greatest losses in Russian armored personal carriers (APC) in the war thus far?
```sql
SELECT rwt.date, e.APC - LAG(e.APC) OVER (ORDER BY e.day) AS per_day_loss
FROM equip_loss e
JOIN rus_war_timeline rwt
ON e.day = rwt.day
ORDER BY per_day_loss DESC
LIMIT 10;
```
### Results
<img width="142" alt="Screenshot 2023-08-29 023050" src="https://github.com/KirstenMayland/cs61databases/assets/102620915/b3f6c12e-3d8a-4720-b11b-c1a8af79625a">

### Analysis
The first thing that jumps out is that all the dates are all in 2022, primarily in the first 1-2 months of the war. More data would be needed to fully understand what this means, but a possible theory is that fighting styles changed as the war went on, so in the later months, Armoured Personal Carriers were in less intense fighting zone. Another factor to note is that, 2/25/2023, the top result, is the second day of the war and the first day for which data was collected, so the high value has the potential to be a combination between days 1 and 2.

### SQL Query #3
##### What areas have seen the heaviest losses of vehicles and fuel tanks?
```sql
SELECT `greatest losses direction`, COUNT(`greatest losses direction`) AS amount
FROM vehicles_and_ft_analysis
GROUP BY `greatest losses direction`
ORDER BY amount DESC;
```
### Results
<img width="169" alt="Screenshot 2023-08-29 024804" src="https://github.com/KirstenMayland/cs61databases/assets/102620915/13893dec-48f5-4ab9-95bb-93474dc9cc6b">

### Analysis
*Note:* This may seem like a simple query, but in order to do it, it was preceded by two hours of normalizing and formating the table and actually took longer than any other query on this page  
\
Not exactly a surprising result that Bakhmut and Donetsk are revealed to be centers of vehicle and fuel tank loss as they have the areas that have been most heavily in the news.
